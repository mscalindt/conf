set -e

{ read -r CONF < "$1"; } 2> /dev/null || CONF=
if [ "$CONF" != "$2" ]; then
    printf "%s\n" "$2" > "$1"
else
    printf "%s\n" "Nothing to be done for ./conf ($2)"
fi
