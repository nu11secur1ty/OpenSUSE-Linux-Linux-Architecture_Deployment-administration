# Cleanup journal logs

Journal logs can grow fast and use up several GB disk space. Unless you want to troubleshoot your system, these logs are not very useful.

You can safely cleanup journal logs and keep only logs from yesterday: 

```bash
sudo journalctl --vacuum-time=1d
```

------------------------------------------------------------------------
# Cleanup downloaded RPM packages

This command will delete all downloaded RPM packages.

```bas
sudo zypper clean
```

-----------------------------------------------------------------------

# Cleanup Btrfs snapshots

Tell snapper to delete old snapshots based on configuration at /etc/snapper/configs/root

sudo snapper cleanup number

By default, snapper allows:

  1.  Maximum 50% of root file system space for snapshots. (20 GB of 40 GB root file system)
  2.  Minimum 2 and maximum 10 normal snapshots.
  3.  Minimum 4 and maximum 10 important snapshots.

You can reduce it using the following command:

```
snapper set-config SPACE_LIMIT=0.2 NUMBER_LIMIT=2-6 NUMBER_LIMIT_IMPORTANT=4`
```

  1.  Maximum 20% of root file system space for snapshots. (8 GB of 40 GB root file system)
  2.  Minimum 2 and maximum 6 normal snapshots.
  3.  4 important snapshots.

Which means 

-----------------------------------------------------------------------

# Cleanup /tmp

```diff
- Warning: Cleanup /tmp directory may cause lost of unsaved data or application crashes. Be sure to save all your work and quit all applications.
```
























