#!/bin/sh

# test the zip command ?
# use p7zip ?

ZIPNAME="$(jq -r < info.json '.name + "_" + .version')"
if [ -e "$ZIPNAME.zip" ]; then
	echo >&2 "ERROR: zip $ZIPNAME.zip already exists"
	exit 1
fi
[ -e "$ZIPNAME" ] || ln -s . "$ZIPNAME"

find "$ZIPNAME/" -type f ! -path '*/.*' ! -name '*.zip' |sort | zip "$ZIPNAME.zip" -@
rm "$ZIPNAME"
#zip --help
