#! /bin/bash
if [ -z "$NAME" ]; then
	export NAME=$1
fi

cd $GOPATH/src/$NAME && go get -d
cd /build && go build $NAME

if [ -z "$VERSION" ]; then
	if [ -z "$2" ]; then
		export VERSION=`/build/$NAME --version | sed 's/.* //g'`
	else
		export VERSION=$2
	fi
fi

if [ -d "$GOPATH/src/$NAME/etc" ]; then
	fpm -s dir -t deb -n $NAME -v $VERSION -a amd64 /build/$NAME=/usr/local/bin/$NAME $GOPATH/src/$NAME/etc=/
else
	fpm -s dir -t deb -n $NAME -v $VERSION -a amd64 /build/$NAME=/usr/local/bin/$NAME
fi
