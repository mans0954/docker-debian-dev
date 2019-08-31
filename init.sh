#!/bin/bash
mkdir -p ~/.ssh
wget --ca-directory /dev/null --ca-certificate /usr/share/ca-certificates/mozilla/DST_Root_CA_X3.crt -O ~/.ssh/debian_known_hosts https://db.debian.org/debian_known_hosts
cat >> ~/.ssh/config <<"EOF"
Host *.debian.org
 UserKnownHostsFile ~/.ssh/debian_known_hosts
EOF

gpg --keyserver keyring.debian.org --recv-keys $DEBSIGN_KEYID

DIR=/src/python/python-modules
cd /src/python
if [ -d "$DIR" ]; then
  cd python-modules
  git checkout master
  git pull
else
  git clone git@salsa.debian.org:python-team/tools/python-modules
  cd python-modules
fi
echo $PWD/.mrconfig >> ~/.mrtrust
cd /src
/bin/bash
