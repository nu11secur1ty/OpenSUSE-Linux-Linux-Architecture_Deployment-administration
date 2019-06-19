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

Some prefer to just use absolute paths to all the commands instead. I recommend against that. Consider what happens if you want to run your script on a different system, and on that system, the command is in `/opt/someAppv2.2/bin` instead. You'd have to go through the whole script replacing `/opt/someApp/bin` with `/opt/someAppv2.2/bin` instead of just doing a small edit on the first line of the script.

You can also set the PATH variable in the crontab file, which will apply to all cron jobs

```bash
PATH=/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

15 1 * * * backupscript --incremental /home /root
```
