set -e

for file in "$@"; do
    conf=$(cat "$file")
    FILE="$FILE
$conf"
done

NAME='conf'
printf "%s\n" "$FILE" > ./"$NAME"
printf "%s\n" "> $PWD/$NAME"
