#!/usr/bin/bash
chmod a+x /usr/bin/google-chrome
chmod a+x /usr/bin/google-chrome-stable
sed -i '$d' /usr/bin/google-chrome-stable
echo -e 'exec -a "$0" "$HERE/chrome" "$@" --user-data-dir --no-sandbox' >> /usr/bin/google-chrome-stable
exit;

