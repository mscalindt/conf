set -e

for unit in "$1"/*; do
    unit=$(cat "$unit")
    FILE="$FILE
$unit"
done

conf=$(cat "$2")
FILE="$FILE
$conf"

conf=$(cat "$3")
FILE="$FILE
$conf"

NAME='conf'
printf "%s\n" "$FILE" > ./"$NAME"
printf "%s\n" "> $PWD/$NAME"
