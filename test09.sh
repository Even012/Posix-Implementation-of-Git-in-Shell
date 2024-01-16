#! /usr/bin/env dash

echo '=== Test edge cases of pigs-log ==='

PATH="$PATH:"$(dirname "$(realpath "$0")")""

OUR_DIR=$(mktemp -d) 
OUR_OUT=$(mktemp)
OUR_ERR=$(mktemp)
OUR_EXIT=$(mktemp)

REF_DIR=$(mktemp -d) 
REF_OUT=$(mktemp)
REF_ERR=$(mktemp)
REF_EXIT=$(mktemp)

trap 'rm -rf “$OUR_DIR” "$REF_DIR"' EXIT	

cd "$OUR_DIR" || exit      # if cd fails, stop it 
pigs-init > "$OUR_OUT" 2> "$OUR_ERR"
echo $? > "$OUR_EXIT"
ls -d .pig >> "$OUR_OUT" 2>> "$OUR_ERR"
pigs-log a >> "$OUR_OUT" 2>> "$OUR_ERR"




cd "$REF_DIR" || exit      # if cd fails, stop it 
2041 pigs-init > "$REF_OUT" 2> "$REF_ERR"
echo $? > "$REF_EXIT"
ls -d .pig >> "$REF_OUT" 2>> "$REF_ERR"
2041 pigs-log a >> "$REF_OUT" 2>> "$REF_ERR"


# cat "$OUR_OUT"
# echo "===================="
# cat "$REF_OUT"
# echo "==================================="
# cat "$OUR_ERR" 
# echo "===================="
# cat "$REF_ERR" 

if  diff "$OUR_OUT" "$REF_OUT" > /dev/null &&
    diff "$OUR_ERR" "$REF_ERR" > /dev/null &&
    diff "$OUR_EXIT" "$REF_EXIT" >/dev/null
then
    echo "  Congrats!! Test passed :>"
else
    echo "  Test failed :<"
fi