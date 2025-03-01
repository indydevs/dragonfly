#!/bin/sh

set -e

# first arg is `-some-option`
if [ "${1#-}" != "$1" ]; then
    # override arguments by prepending "dragonfly --logtostderr" to them.
	set -- dragonfly --logtostderr "$@"
fi

# allow the docker container to be started with `--user`
if [ "$1" = 'dragonfly' -a "$(id -u)" = '0' ]; then
	exec su-exec dfly "$0" "$@"   # runs this script under user dfly
fi

exec "$@"
