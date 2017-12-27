# Find Out Graphics Card Memory Size
- Open a terminal and type the lspci command
```
$ lspci
```
- Output:
```
00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 03)
```
# 00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
```
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
01:00.0 Network controller: RaLink RT2561/RT61 rev B 802.11g
01:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
```
# You need to use string called devices in the specified domain – 00:02.0 VGA (highlighted in red color to display memory info):
```
$ lspci -v -s 00:02.0
```
- Sample outputs:
```
00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology Unknown device 2562
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Memory at d8200000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: 
```
This listing shows an Intel video card with 128 MB of video RAM. If you cannot find devices in the specified domain use following command and look for your display card name and memory field:

```
$ lspci -v | less
```

# Xorg Log File

Open a command-line terminal (select Applications > Accessories > Terminal), and then type:

```
$ grep -i --color memory /var/log/Xorg.0.log
```
 - Sample outputs:
 
 ```
(--) Aug 02 12:16:20 NVIDIA(0): Memory: 1048576 kBytes
(II) Aug 02 12:16:21 NVIDIA: Using 768.00 MB of virtual memory for indirect memory access.
(==) NVIDIA(0): Disabling shared memory pixmaps
```
The above output indicate that my Nvidia card has 1024MB ram. The following is taken from my Macbook, which has Intel GM965 Video card. It shares memory from main RAM:
```
$ grep -i memory /var/log/Xorg.0.log 
```
- Sample outputs:

```
[2318869.434] (II) intel(0): detected 15868 kB stolen memory.
[2318869.472] (II) intel(0): I830CheckAvailableMemory: 1966080 kB available
[2318869.486] (II) intel(0): Attempting memory allocation with tiled buffers.
[2318870.197] (II) intel(0): Fixed memory allocation layout:
[2318870.197] (II) intel(0): 0x00f7f000:            end of stolen memory
[2318870.197] (II) intel(0): 0x00f7f000-0x0fffffff: DRI memory manager (246276 kB)
[2318870.197] (II) intel(0): BO memory allocation layout:
[2318870.197] (II) intel(0): 0x00f7f000:            start of memory manager
[2318870.197] (II) intel(0): 0x10000000:            end of memory manager
```


