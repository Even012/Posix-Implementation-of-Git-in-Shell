#! /usr/bin/env dash

echo '=== Subset1 Example Test ==='
echo '----------------------------'

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
touch a b c d e f g h
pigs-add a b c d e f >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-commit -m 'first commit' >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo hello >a
echo hello >b
pigs-commit -a -m 'second commit' >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo world >>a
echo world >>b
echo hello world >c
pigs-add a >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo world >>b
rm d
pigs-rm e >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-add g >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-status >> "$OUR_OUT" 2>> "$OUR_ERR" 



cd "$REF_DIR" || exit      # if cd fails, stop it 
2041 pigs-init > "$REF_OUT" 2> "$REF_ERR"
echo $? > "$REF_EXIT"
ls -d .pig >> "$REF_OUT" 2>> "$REF_ERR"
touch a b c d e f g h
2041 pigs-add a b c d e f >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-commit -m 'first commit' >> "$REF_OUT" 2>> "$REF_ERR" 
echo hello >a
echo hello >b
2041 pigs-commit -a -m 'second commit' >> "$REF_OUT" 2>> "$REF_ERR" 
echo world >>a
echo world >>b
echo hello world >c
2041 pigs-add a >> "$REF_OUT" 2>> "$REF_ERR" 
echo world >>b
rm d 
2041 pigs-rm e >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-add g >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-status >> "$REF_OUT" 2>> "$REF_ERR" 


# cat "$REF_OUT"
# cat "$OUR_OUT"
# echo "===================="
# cat "$OUR_ERR"
# cat $REF_ERR

if  diff "$OUR_OUT" "$REF_OUT" > /dev/null &&
    diff "$OUR_ERR" "$REF_ERR" > /dev/null &&
    diff "$OUR_EXIT" "$REF_EXIT" >/dev/null
then
    echo "  Congrats!! Test passed :> "
    echo '----------------------------'
else
    echo "             Test failed :< "
    echo '----------------------------'
fi