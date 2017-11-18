#!/usr/bin/bash
echo -e 'exec -a "$0" "$HERE/chrome" "$@" --no-sandbox' >> /usr/bin/google-chrome-stable
sleep 3;
sed -i '$d' /usr/bin/google-chrome-stable
exit;
