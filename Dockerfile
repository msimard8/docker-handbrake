FROM ubuntu:trusty 
MAINTAINER msimard <msimard8@gmail.com>

RUN apt-get update -qq
RUN apt-get install -y software-properties-common python-software-properties 
RUN apt-add-repository -y ppa:stebbins/handbrake-snapshots
RUN apt-get update -qq
RUN apt-get install -y handbrake-cli inotify-tools lsof

VOLUME ["/destination"]
VOLUME ["/watched"]
COPY ./watch.sh /
ENTRYPOINT ["/watch.sh"]
