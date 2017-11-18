#!/usr/bin/bash
sed -i '$d' /usr/bin/google-chrome-stable
echo -e 'exec -a "$0" "$HERE/chrome" "$@" --user-data-dir --no-sandbox' >> /usr/bin/google-chrome-stable
exit;
