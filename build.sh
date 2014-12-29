#! /bin/bash
if [ -z "$NAME" ]; then
	export NAME=$1
fi

cd /src/$NAME && go get -d
cd /build && go build $NAME

if [ -z "$VERSION" ]; then
	if [ -z "$2" ]; then
		export VERSION=`/build/$NAME --version | sed 's/.* //g'`
	else
		export VERSION=$2
	fi
fi

export ADDITION_ARGS=""
export ROOT=/src/$NAME

if [ -d "$ROOT/debian"]; then
    if [ -f "$ROOT/debian/after-install"]; then
        export ADDITION_ARGS="$ADDITION_ARGS --after-install $ROOT/debian/after-install"
    fi
    if [ -f "$ROOT/debian/before-remove"]; then
        export ADDITION_ARGS="$ADDITION_ARGS --before-remove $ROOT/debian/before-remove"
    fi
    if [ -f "$ROOT/debian/$NAME.init"]; then
        export ADDITION_ARGS="$ADDITION_ARGS --deb-init $ROOT/debian/$NAME.init"
    fi
fi

if [ -d "$ROOT/etc" ]; then
	export ADDITION_ARGS="$ADDITION_ARGS /src/$NAME/etc=/"
fi

fpm -s dir -t deb -n $NAME -v $VERSION -a amd64 /build/$NAME=/usr/local/bin/$NAME `echo $ADDITION_ARGS`
