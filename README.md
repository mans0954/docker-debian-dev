Docker image for developing Debian packages. Currently supports:

* Python
* Perl

```
export DEBFULLNAME="John Smith"
export DEBEMAIL="jsmith@debian.org"
export DEBSIGN_KEYID=12345678

docker-compose build

docker-compose run unstable
```
