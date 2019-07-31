# Checking of type of HDD
- check 

```bash
:~ # lsblk -o name,rota
```
- Output
```bash
NAME   ROTA
sda       1
├─sda1    1
├─sda2    1
├─sda3    1
└─sda4    1
sdb       0
└─sdb1    0
sr0       1
```
# Legend:
`1` =  HDD
`0` = SSD

