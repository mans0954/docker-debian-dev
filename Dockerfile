FROM debian:sid

RUN apt-get update  && apt-get install -y build-essential git-buildpackage sudo mr vim quilt cme 

RUN apt-get install -y sbuild
RUN sbuild-createchroot --include=eatmydata,ccache,gnupg unstable /srv/chroot/unstable-amd64-sbuild http://mirror.ox.ac.uk/debian

# Python
RUN apt-get install -y python3-stdeb
# Perl
RUN apt-get install -y dh-make-perl

RUN useradd -m -G sudo user

RUN sbuild-adduser user

# Allow users in the sudo group to run sudo without password
RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

VOLUME /src

COPY init.sh /init.sh
RUN chmod a+x /init.sh

USER user

RUN mkdir -p /home/user/.gnupg
RUN chmod 700 ~/.gnupg
RUN ln -s /gpg-agent ~/.gnupg/S.gpg-agent

RUN echo ".pc" >> /home/user/.gitignore
COPY .gitconfig /home/user/.gitconfig
COPY .lintianrc /home/user/.lintianrc
COPY .vimrc /home/user/
COPY .sbuildrc /home/user/

ENTRYPOINT /init.sh
