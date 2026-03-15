set -e

case "${1:-x}" in
    '-h' | '--help' | 'x')
        printf "%s\n" '$1 = FUNCTION TO RUN'

        exit 0
    ;;
esac

[ "$#" -eq 1 ] || { echo "Expected exactly 1 argument; got $#."; exit 2; }
[ "$1" ] || { echo '$1/FUNC is empty.'; exit 2; }

cd lib/syscfg
MAIN_DIR="$OLDPWD"
./src/syscfg "$MAIN_DIR"/src/"$1"
