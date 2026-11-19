#!/bin/sh

# For bookkeeping reasons, using the SHA of the last commit + file mtime,
# record at which local point any (re-)configuration last took place.
read -r _uid < ./.build_user.tmp
if [ "$_uid" = "$(id -u)" ]; then
    printf "%s\n" "$(git rev-parse --short HEAD)" > ./.run.tmp
else
    su "$_uid" -c 'printf "%s\n" "$(git rev-parse --short HEAD)" > ./.run.tmp'
fi

./syscfg -s ./.conf "$@"
