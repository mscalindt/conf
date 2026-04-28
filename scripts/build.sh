set -e

for unit in "$1"/*; do
    unit=$(cat "$unit")
    FILE="$FILE
$unit"
done

shift

for file in "$@"; do
    conf=$(cat "$file")
    FILE="$FILE
$conf"
done

NAME='conf'
printf "%s\n" "$FILE" > ./"$NAME"
printf "%s\n" "> $PWD/$NAME"
