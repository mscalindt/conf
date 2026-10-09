set -e

case "${1:-x}" in
    '-h' | '--help' | 'x')
        printf "%s\n" '$1 = RELEASE NAME'
        printf "%s\n" '$2 = PREVIOUS TAG'
        printf "%s\n" '$3 = COMMIT / HEAD'
        printf "%s\n" '$4 = EDIT BOOL'

        exit 0
    ;;
esac

case "$#" in
    3|4) ;;
    *) echo "Expected 3 or 4 arguments; got $#."; exit 2 ;;
esac
[ "$1" ] || { echo '$1/REL is empty.'; exit 2; }
[ "$2" ] || { echo '$2/PRE is empty.'; exit 2; }
[ "$3" ] || { echo '$3/CUR is empty.'; exit 2; }
case "${4:-0}" in
    0|1) ;;
    *) echo 'Bad $4/EDIT bool.'; exit 2 ;;
esac

LOG="$(git log --pretty=format:'%h %s' --no-decorate "$2..$3")"

SRC_LOG=$(
    printf "%s\n" "$LOG" | {
        while IFS= read -r LINE; do
            case "$LINE" in
                *': [doc]'* | *': [fmt]'*)
                    continue
                ;;
                *'conf: '* | *'.gitmodules: '* | *'configs: '* | *'fs: '* | \
                *'hw: '* | *'sw: '* | *'sys: '*)
                    printf "%s\n" "$LINE"
                ;;
                *)
                    continue
                ;;
            esac
        done
    }
)

case "$4" in
    0) EDIT= ;;
    1) EDIT='-e' ;;
esac

if [ "$SRC_LOG" ] && [ ! "$SRC_LOG" = "$LOG" ]; then
    git tag "$EDIT" -m \
"conf $1

- Filtered log of core changes:
$SRC_LOG

- Complete log between $2 and $1 (${3%"${3#???????}"}):
$LOG" -as "$1" "$3"
elif [ "$LOG" ]; then
    git tag "$EDIT" -m \
"conf $1

- Complete log between $2 and $1 (${3%"${3#???????}"}):
$LOG" -as "$1" "$3"
else
    git tag "$EDIT" -m "conf $1" -as "$1" "$3"
fi
