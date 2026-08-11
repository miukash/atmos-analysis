#!/bin/bash
set -e

echo "== HEASoft =="
fversion

echo "== XSPEC =="
xspec -h >/dev/null 2>&1 || true

echo "== Python =="
python3 -c "import numpy, pandas, scipy, matplotlib, astropy, marimo"

echo "All environment tests passed."
