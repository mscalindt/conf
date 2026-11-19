set -e

# Since git 2.35.2, knowing the build user is mandatory to prevent error
# 'fatal: detected dubious ownership in repository' in `run.sh`.
printf "%s\n" "$(id -u)" > ./.build_user.tmp

for file in "$@"; do
    conf=$(cat "$file")
    FILE="$FILE
$conf"
done

NAME='.conf'
printf "%s\n" "$FILE" > ./"$NAME"
printf "%s\n" "> $PWD/$NAME"
