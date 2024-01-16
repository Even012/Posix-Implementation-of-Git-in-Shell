#! /usr/bin/env dash

echo '=== Test subset0 if not initialised ==='

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
echo line 1 > a
echo hello world >b
pigs-add a b >> "$OUR_OUT" 2>> "$OUR_ERR"
pigs-commit -m 'first commit' >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo  line 2 >>a
pigs-add a >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-commit -m 'second commit' >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-log >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo line 3 >>a
pigs-add a >> "$OUR_OUT" 2>> "$OUR_ERR" 
echo line 4 >>a
pigs-show 0:a >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-show 1:a >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-show :a >> "$OUR_OUT" 2>> "$OUR_ERR" 
cat a >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-show 0:b >> "$OUR_OUT" 2>> "$OUR_ERR" 
pigs-show 1:b >> "$OUR_OUT" 2>> "$OUR_ERR" 


cd "$REF_DIR" || exit      # if cd fails, stop it 
echo line 1 > a
echo hello world >b
2041 pigs-add a b >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-commit -m 'first commit' >> "$REF_OUT" 2>> "$REF_ERR" 
echo line 2 >>a
2041 pigs-add a >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-commit -m 'second commit' >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-log >> "$REF_OUT" 2>> "$REF_ERR" 
echo line 3 >>a
2041 pigs-add a >> "$REF_OUT" 2>> "$REF_ERR" 
echo line 4 >>a
2041 pigs-show 0:a >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-show 1:a >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-show :a >> "$REF_OUT" 2>> "$REF_ERR" 
cat a >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-show 0:b >> "$REF_OUT" 2>> "$REF_ERR" 
2041 pigs-show 1:b >> "$REF_OUT" 2>> "$REF_ERR" 
# cat "$OUR_OUT" 
# cat "$REF_OUT"
# cat "$OUR_OUT"
# # cat "===================="
# cat "$OUR_ERR"
# cat $REF_ERR
if  diff "$OUR_OUT" "$REF_OUT" > /dev/null &&
    diff "$OUR_ERR" "$REF_ERR" > /dev/null &&
    diff "$OUR_EXIT" "$REF_EXIT" >/dev/null
then
    echo "  Congrats!! Test passed :>"
else
    echo "  Test failed :<"
fi