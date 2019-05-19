# Cleanup journal logs

Journal logs can grow fast and use up several GB disk space. Unless you want to troubleshoot your system, these logs are not very useful.

You can safely cleanup journal logs and keep only logs from yesterday: 

```bash
sudo journalctl --vacuum-time=1d
```
