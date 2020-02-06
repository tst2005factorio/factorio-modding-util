#!/bin/sh

if [ $# -eq 0 ]; then
	echo >&2 "Usage: $0"' 0.17|0.18'
	exit 1
fi

# test the zip command ?
# use p7zip ?

pkgdir="Packaging/$1"
infojson=info.json

ZIPNAME="$(jq -r < "$pkgdir/$infojson" '.name + "_" + .version')"
if [ -z "$ZIPNAME" ]; then
	echo >&2 "ERROR: Unable to get the mod's name and version. Something wrong with the content of 'info.json'."
	exit 1
fi
if [ -e "$ZIPNAME.zip" ]; then
	echo >&2 "ERROR: zip $ZIPNAME.zip already exists"
	exit 1
fi
[ -e "$ZIPNAME" ] || ln -s . "$ZIPNAME"

cp -a "Packaging/$1/$infojson" "./info.json"
find "$ZIPNAME/" -type f ! -path '*/.*' ! -name '*.zip' ! -name '[A-Z_]*' ! -path '*/[A-Z]*' ! -name 'info???*.json' |egrep -v '(\.old|\.new|changelog\.md)' |sort | zip "$ZIPNAME.zip" -@
rm "$ZIPNAME" "./info.json"
