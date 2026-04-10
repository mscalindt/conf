set -e

if [ "$2" ]; then
    sh ./syscfg -So "$2" -s ./conf -- "$1"
else
    sh ./syscfg -s ./conf -- "$1"
fi
