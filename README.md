# Go2Deb
Package go project to deb.

## usage
> git clone https://github.com/mgbaozi/go2deb
> cd go2deb
> docker build -t go2deb .

Make sure your project is in $GOPATH/src

> docker run -e NAME=projectname -e VERSION=version -v $GOPATH/src:/src -v $GOPATH/bin:/build go2deb

OR

> docker run -v $GOPATH/src:/src -v $GOPATH/bin:/build go2deb /bin/build.sh projectname version

If your app can show version by --version argument, you don't need to assign $VERSION.

Then .deb file will in $GOPATH/bin