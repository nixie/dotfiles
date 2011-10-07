#!/bin/sh

INFILE=$1
OUTFILE=`mktemp ${TMPDIR:-/tmp}/vimspell.sh.XXXXXX`
[ -z "$OUTFILE" ] && exit 1

ispell -l -d czech < $INFILE | sort -u | awk ' BEGIN { printf "if hlexists(\"SpellErrors\")\n   syntax clear SpellErrors\nendif\nsyntax case match\n" ; } { printf "syntax match SpellErrors \"\\<%s\\>\"\n", $0 ; } END { printf "highlight link SpellErrors ErrorMsg\n\n" ; } ' > $OUTFILE
echo "!\\rm $OUTFILE" >> $OUTFILE

echo $OUTFILE
