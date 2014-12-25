FROM ubuntu:12.04
ENV DEBIAN_FRONTEND noninteractive

# Install system-level dependencies.
RUN apt-get update && \
	apt-get -y install build-essential python-software-properties bzip2 unzip curl \
		git subversion mercurial bzr \
		libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Install Go.
ENV GOROOT /go
ENV GOPATH /
ENV PATH $PATH:$GOROOT/bin
RUN curl -L https://github.com/golang/go/archive/master.zip -o /tmp/go.zip && \
	unzip /tmp/go.zip && \
	rm /tmp/go.zip && \
	mv /go-master $GOROOT && \
	echo devel > $GOROOT/VERSION && \
	cd $GOROOT/src && \
	./all.bash

$ Install Ruby and Gem
RUN apt-get update && \
    apt-get -y install ruby ruby-dev rubygems
RUN gem install fpm
