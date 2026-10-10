#!/usr/bin/env bash
# Prints a post to PDF with headless Chrome.
#
# Usage:
#   _scripts/post-pdf.sh <post-url> [output.pdf]
#
#   _scripts/post-pdf.sh https://aic-lab.com/rtl/learn-fpga/
#     -> assets/pdf/learn-fpga.pdf
#
# Render the live URL for a PDF you publish, so that relative links in the post
# point to aic-lab.com. A render of http://localhost:4000/... is only a draft
# for checking the layout. Page size, margins and the footer come from the print
# styles in assets/css/main.scss and _includes/head/custom.html.

set -euo pipefail

url="${1:?usage: $0 <post-url> [output.pdf]}"
slug="$(basename "${url%/}")"
root="$(cd "$(dirname "$0")/.." && pwd)"
out="${2:-$root/assets/pdf/$slug.pdf}"

chrome="$(command -v google-chrome || command -v chromium || command -v chromium-browser || true)"
if [ -z "$chrome" ]; then
  echo "Chrome or Chromium not found" >&2
  exit 1
fi

mkdir -p "$(dirname "$out")"
rm -f "$out"
"$chrome" --headless --no-pdf-header-footer --generate-pdf-document-outline \
  --virtual-time-budget=15000 --print-to-pdf="$out" "$url"

if [ ! -s "$out" ]; then
  echo "Chrome did not write $out" >&2
  exit 1
fi

if command -v pdfinfo >/dev/null; then
  pdfinfo "$out" | grep -E '^(Title|Pages|Page size|File size):'
  if pdfinfo -url "$out" 2>/dev/null | grep -E '//(localhost|127\.0\.0\.1)' >/dev/null; then
    echo "Note: links point to a local server. Render the live URL before publishing." >&2
  fi
fi
