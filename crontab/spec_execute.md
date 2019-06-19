# Cron passes a minimal set of environment variables to your jobs. To see the difference, add a dummy job like this:
- example
```bash
* * * * * env > /tmp/env.output
```
Wait for `tmp/env.output`to be created, then remove the job again. Now compare the contents of `tmp/env.output`with the output of env run in your regular terminal.

A common "gotcha" here is the `PATH` environment variable being different. Maybe your cron script uses the command `omecommand`found in `opt/someApp/bin` which you've added to `PATH`in `etc/environment?`cron ignores `PATH` from that file, so runnning `omecommand`from your script will fail when run with cron, but work when run in a terminal. It's worth noting that variables from /etc/environment will be passed on to cron jobs, just not the variables cron specifically sets itself, such as `PATH`




- To get around that, just set your own PATH variable at the top of the script. 
```bash
#!/bin/bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# rest of script follows
```
