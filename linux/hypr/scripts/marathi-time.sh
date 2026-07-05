#!/usr/bin/env bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
date +"%H:%M" | python3 -c "
import sys
t = sys.stdin.read().strip()
digits = str.maketrans('0123456789', '०१२३४५६७८९')
print(t.translate(digits))
"
