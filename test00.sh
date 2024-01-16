#! /usr/bin/env dash

echo '=== Test edge cases of pigs-init ==='

PATH="$PATH:"$(dirname "$(realpath "$0")")""

OUR_DIR=$(mktemp -d) 
OUR_OUT=$(mktemp)
OUR_ERR=$(mktemp)

REF_DIR=$(mktemp -d) 
REF_OUT=$(mktemp)
REF_ERR=$(mktemp)

trap 'rm -rf “$OUR_DIR” "$REF_DIR"' EXIT	

cd "$OUR_DIR" || exit      # if cd fails, stop it 
pigs-init > "$OUR_OUT" 2> "$OUR_ERR"
OUR_EXIT="$?"
ls -d .pig >> "$OUR_OUT" 2>> "$OUR_ERR"


cd "$REF_DIR" || exit      # if cd fails, stop it 
2041 pigs-init > "$REF_OUT" 2> "$REF_ERR"
REF_EXIT="$?"
ls -d .pig >> "$REF_OUT" 2>> "$REF_ERR"

if  diff "$OUR_OUT" "$REF_OUT" > /dev/null &&
    diff "$OUR_ERR" "$REF_ERR" > /dev/null &&
    [ "$OUR_EXIT" = "$REF_EXIT" ] 
then
    echo "   Test passed.  "
else
    echo "   Test failed   "
fi


cd "$OUR_DIR" || exit      # if cd fails, stop it 
pigs-init > "$OUR_OUT" 2> "$OUR_ERR"
OUR_EXIT="$?"
ls -d .pig >> "$OUR_OUT" 2>> "$OUR_ERR"


cd "$REF_DIR" || exit      # if cd fails, stop it 
2041 pigs-init > "$REF_OUT" 2> "$REF_ERR"
REF_EXIT="$?"
ls -d .pig >> "$REF_OUT" 2>> "$REF_ERR"

if  diff "$OUR_OUT" "$REF_OUT" > /dev/null &&
    diff "$OUR_ERR" "$REF_ERR" > /dev/null &&
    [ "$OUR_EXIT" = "$REF_EXIT" ] 
then
    echo "   Test passed.  "
else
    echo "   Test failed   "
fi