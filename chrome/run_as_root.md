# Run chrome as root
```
sed -i -e '/exec -a "$0" "$HERE/chrome" "$@"/exec -a "$0" "$HERE/chrome" "$@" --user-data-dir --no-sandbox' /usr/bin/google-chrome-stable
```
# Have fun with nu11secur1ty =)
