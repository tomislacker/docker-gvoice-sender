FROM        ubuntu:12.04
MAINTAINER  Ben Tomasik <b.tomasik@gmail.com>

###
# Basic container setup
###
RUN         apt-get update
RUN         apt-get upgrade -qq

###
# Install Python dependencies
###
RUN         apt-get install -qq --no-install-recommends git python
RUN         apt-get install -qq --no-install-recommends python-dev python-distribute python-pip

###
# Install the pyGoogleVoice project
###
WORKDIR     /tmp
RUN         git clone https://github.com/pettazz/pygooglevoice.git
WORKDIR     /tmp/pygooglevoice
RUN         python setup.py build
RUN         python setup.py install

###
# Install Flask for processing requests
###
RUN         pip install Flask-API

###
# Install our own little bit of code
###
ADD         files/ /

###
# Setup our initial program
###
CMD         ["/init.sh"]

