#!/bin/bash

assert () {
    if [ ! $1 ]; then
        echo >&2 "Assertion failed: \"$1\""
        echo >&2 "File \"$0\", line $2"
        exit 1
    fi
}

assert "`./bowling XXXXXXXXXXXX` -eq 300" $LINENO
assert "`./bowling 9-9-9-9-9-9-9-9-9-9-` -eq 90" $LINENO
assert "`./bowling 5/5/5/5/5/5/5/5/5/5/5` -eq 150" $LINENO
assert "`./bowling 5/X8/817/XXX72X7/` -eq 192" $LINENO
