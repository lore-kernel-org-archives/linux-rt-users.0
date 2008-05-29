From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Test results 2.6.25.4-rt3 on Freescale MPC8315E @ 400 MHz
Date: Thu, 29 May 2008 13:51:00 +0200
Message-ID: <c384c5ea0805290451i192213e7k9529c4279b94bf67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:34848 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYE2LvF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 07:51:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so58955and.103
        for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 04:51:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hell,

in appreciation of the work that has been done by the -rt team I would
like to share my (first) test results on a PowerPC e300c3 core @ 400
MHz, using the Freescale MPC8315E SoC (boot log at the end).

The test is suboptimal because I am testing through a 100 Mbit/s
Ethernet switch. I will follow-up with results from a 1 Gbp/s flood
ping stress later.

Linux version 2.6.25.4-rt3 (leon@witty) (gcc version 4.2.2) #1 PREEMPT
RT Thu May 29 00:25:19 CEST 2008

Ping flood from host (active during test):

sudo ping -l100 -f 192.168.1.100

Wakeup latency test using cyclictest:

root@mpc8315e-rdb:~# cyclictest -t 7 -n -p 70 -l 10000 -q
T: 0 ( 2254) P:70 I:1000 C:  10000 Min:     22 Act:   54 Avg:   51 Max:     101

The host reports zero packet loss. Note this is through a 100
MBit/seconds pipe, so we are not really stressing the target.

leon@witty:~/sandbox/mpc8313e/openembedded/org.openembedded.dev$ sudo
ping -l100 -f 192.168.1.100
PING 192.168.1.100 (192.168.1.100) 56(84) bytes of data.
.....................................................
--- 192.168.1.100 ping statistics ---
2693186 packets transmitted, 2692763 received, 0% packet loss, time 125501ms
rtt min/avg/max/mdev = 0.087/4.083/21.424/2.426 ms, pipe 100, ipg/ewma
0.046/1.667 ms

Regards,
-- 
Leon


U-Boot 1.3.2 (May 28 2008 - 16:19:30) MPC83XX

Reset Status:

CPU:   e300c3, MPC8315E, Rev: 10 at 400 MHz, CSB:  133 MHz
Board: Freescale MPC8315ERDB Rev 0.0
I2C:   ready
DRAM:  128 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   eTSEC0, eTSEC1
Hit any key to stop autoboot:  0
Speed: 100, full duplex
Using eTSEC0 device
TFTP from server 192.168.1.24; our IP address is 192.168.1.100
Filename 'uImage-mpc8315e-rdb.bin'.
Load address: 0x200000
Loading: #################################################################
         #######################################################
done
Bytes transferred = 1760923 (1ade9b hex)
Speed: 100, full duplex
Using eTSEC0 device
TFTP from server 192.168.1.24; our IP address is 192.168.1.100
Filename 'uImage-mpc8315e-rdb.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting image at 00200000 ...
   Image Name:   Angstrom/2.6.25/mpc8315e-rdb
   Created:      2008-05-28  22:27:11 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1760859 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
[    0.000000] Using MPC831x RDB machine description
[    0.000000] Linux version 2.6.25.4-rt3 (leon@witty) (gcc version
4.2.2) #1 PREEMPT RT Thu May 29 00:25:19 CEST 2008
[    0.000000] console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
[    0.000000] Found MPC83xx PCI host bridge at 0x00000000e0008500.
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@e0008500 (primary) ranges:
[    0.000000]  MEM 0x0000000090000000..0x000000009fffffff ->
0x0000000090000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff ->
0x0000000080000000 Prefetch
[    0.000000]   IO 0x00000000e0300000..0x00000000e03fffff -> 0x0000000000000000
arch: exit
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32768
[    0.000000]   Normal      32768 ->    32768
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    32768
[    0.000000] Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32512
[    0.000000] Kernel command line: root=/dev/nfs rw
nfsroot=192.168.1.24:/nfsroot
ip=192.168.1.100:192.168.1.24::::eth0:off console=ttyS0,115200
[    0.000000] Preemptible RCU implementation.
[    0.000000] IPIC (128 IRQ sources) at fdefa700
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000012] clocksource: timebase mult[7800001] shift[22] registered
[    0.006754] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.014306] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.035477] Memory: 125780k/131072k available (3492k kernel code,
5136k reserved, 160k data, 295k bss, 164k init)
[    0.130782] Mount-cache hash table entries: 512
[    0.141168] net_namespace: 624 bytes
[    0.145836] NET: Registered protocol family 16

[    0.157933] PCI: Probing PCI hardware
[    0.178651] SCSI subsystem initialized
[    0.185186] usbcore: registered new interface driver usbfs
[    0.191667] usbcore: registered new interface driver hub
[    0.197548] usbcore: registered new device driver usb
[    0.305192] tracer: 643 pages allocated for 65536<6> entries of 40 bytes
[    0.311698]    actual entries 65586
[    0.322289] NET: Registered protocol family 2
[    0.464267] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.472386] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.479652] TCP bind hash table entries: 4096 (order: 4, 114688 bytes)
[    0.486886] TCP: Hash tables configured (established 4096 bind 4096)
[    0.493054] TCP reno registered
[    0.558242] krcupreemptd setsched 0
[    0.561559]   prio = 98
[    0.565700] JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
[    0.572280] io scheduler noop registered
[    0.576127] io scheduler cfq registered (default)
[    0.919259] Serial: 8250/16550 driver $Revision: 1.13 $ 4 ports,
IRQ sharing disabled
[    0.932128] serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 17) is a 16550A

     [    0.938756] console handover: boot [udbg0] -> real [ttyS0]
[    0.945850] serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 18) is a 16550A
[    0.963831] brd: module loaded
[    0.971698] loop: module loaded
[    0.984256] Gianfar MII Bus: probed
[    0.989983] eth0: Gianfar Ethernet Controller Version 1.2, 04:00:00:00:00:0a
[    0.997214] eth0: Running with NAPI enabled
[    1.001402] eth0: 256/256 RX/TX BD ring size
[    1.007452] eth1: Gianfar Ethernet Controller Version 1.2, 04:00:00:00:00:0b
[    1.014630] eth1: Running with NAPI enabled
[    1.018817] eth1: 256/256 RX/TX BD ring size
[    1.023612] e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
[    1.029725] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.038320] Driver 'sd' needs updating - please use bus_type methods
[    1.045824] fsl-sata e0018000.sata: Sata FSL Platform/CSB Driver init
[    1.053406] scsi0 : sata_fsl
[    1.057037] ata1: SATA max UDMA/133 irq 44
[    1.883926] ata1: No Device OR PHYRDY change,Hstatus = 0xa0000000
[    1.890024] ata1: reset failed (errno=-5), retrying in 10 secs
[   11.699935] ata1: SATA link down (SStatus 0 SControl 300)
[   11.705463] fsl-sata e0019000.sata: Sata FSL Platform/CSB Driver init
[   11.712983] scsi1 : sata_fsl
[   11.716614] ata2: SATA max UDMA/133 irq 45
[   12.543927] ata2: No Device OR PHYRDY change,Hstatus = 0xa0000000
[   12.550026] ata2: reset failed (errno=-5), retrying in 10 secs
[   22.359936] ata2: SATA link down (SStatus 0 SControl 300)
[   22.382484] physmap platform flash device: 00800000 at fe000000
[   22.388891] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
[   22.395429]  Amd/Fujitsu Extended Query Table at 0x0040
[   22.400667] physmap-flash.0: Swapping erase regions for broken CFI table.
[   22.407453] number of CFI chips: 1
[   22.410856] cfi_cmdset_0002: Disabling erase-suspend-program due to
code brokenness.
[   22.419125] RedBoot partition parsing not available
[   22.427727] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[   22.435659] fsl-ehci fsl-ehci.0: new USB bus registered, assigned
bus number 1
[   22.464234] fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
[   22.479925] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[   22.489240] usb usb1: configuration #1 chosen from 1 choice
[   22.495423] hub 1-0:1.0: USB hub found
[   22.499262] hub 1-0:1.0: 1 port detected
[   22.608170] USB Universal Host Controller Interface driver v3.0
[   22.614707] Initializing USB Mass Storage driver...
[   22.843961] usb 1-1: new high speed USB device using fsl-ehci and address 2
[   22.963953] usb 1-1: device descriptor read/64, error -71
[   23.183954] usb 1-1: device descriptor read/64, error -71
[   23.403956] usb 1-1: new high speed USB device using fsl-ehci and address 3
[   23.523953] usb 1-1: device descriptor read/64, error -71
[   23.743952] usb 1-1: device descriptor read/64, error -71
[   23.963957] usb 1-1: new high speed USB device using fsl-ehci and address 4
[   24.375923] usb 1-1: device not accepting address 4, error -71
[   24.491955] usb 1-1: new high speed USB device using fsl-ehci and address 5
[   24.903920] usb 1-1: device not accepting address 5, error -71
[   24.909796] hub 1-0:1.0: unable to enumerate USB device on port 1
[   24.916487] usbcore: registered new interface driver usb-storage
[   24.922514] USB Mass Storage support registered.
[   24.928225] i2c /dev entries driver
[   24.939034] rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
[   24.946252] Driver for 1-wire Dallas network protocol.
[   24.953771] WDT driver for MPC83xx initialized. mode:reset
timeout=65535 (32 seconds)
[   24.964871] TCP cubic registered
[   24.968189] NET: Registered protocol family 1
[   24.972645] NET: Registered protocol family 17
[   24.977949] RPC: Registered udp transport module.
[   24.982678] RPC: Registered tcp transport module.
[   24.991828] rtc-ds1307 0-0068: setting system clock to 2000-04-08
21:03:39 UTC (955227819)
[   26.507927] IP-Config: Guessing netmask 255.255.255.0
[   26.513314] IP-Config: Complete:
[   26.516378]      device=eth0, addr=192.168.1.100,
mask=255.255.255.0, gw=255.255.255.255,
[   26.524501]      host=192.168.1.100, domain=, nis-domain=(none),
[   26.530508]      bootserver=192.168.1.24, rootserver=192.168.1.24, rootpath=
[   26.538131] Looking up port of RPC 100003/2 on 192.168.1.24
[   28.504636] PHY: e0024520:00 - Link is Up - 100/Full
[   28.548933] Looking up port of RPC 100005/1 on 192.168.1.24
[   28.568670] VFS: Mounted root (nfs filesystem).
[   28.573387] Freeing unused kernel memory: 164k init
INIT: version 2.86 booting

Please wait: booting...
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
Remounting root file system...
mount: according to mtab, proc is already mounted on /proc

Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... eth0      no wireless extensions.

udhcpc (v1.9.2) started
Sending discover...
Sending select for 192.168.1.11...
Lease of 192.168.1.11 obtained, lease time 28800
done.
Starting portmap daemon: portmap.
Wed May 28 17:37:00 Local time zone must be set--see zic manual page 2008
Checking for built-in Bluetooth: no
Configuring avahi-autoipd
Configuring avahi-daemon
 Adding system startup for /etc/init.d/avahi-daemon.
Configuring dbus-1
 Adding system startup for /etc/init.d/dbus-1.
Configuring libnss-mdns
Configuring madwifi-ng-modules
Configuring madwifi-ng-tools
Configuring ppp
Configuring ppp-dialin
Configuring update-modules
Configuration for powerpc.generic not found, trying powerpc
Starting to configure packages...
Nothing to be done
Finished to configure packages.
INIT: Entering runlevel: 5
Creating Dropbear SSH server RSA host key.
Will output 1024 bit rsa secret key to '/etc/dropbear/dropbear_rsa_host_key'
Generating key, this may take a while...
Public key portion is:
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgwCOr+cru0K5lSTDVmkv9fEzjW/4rX0C0tqpEI7xRBjrAI45ugJz8XaImwlviD9HeVve2jIdK/GIkPzepEHZi8O19uAi7OutTW/RIT+YxA6RekVtXWpPa56fvNfJ3it6PUdSc0YZ1qSVaqNeH8VCVHX8MoV9KAGN44UY4j1f0Xcnirsl
root@mpc8315e-rdb
Fingerprint: md5 a8:d6:b6:ae:90:24:5d:ca:c8:5a:71:47:66:48:0e:c3
Starting Dropbear SSH server: dropbear.
Starting system message bus: dbus.
Starting syslogd/klogd: start-stop-daemon: lseek: Invalid argument
 * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
[ ok ]
Starting Bluetooth subsystem: hcid hid2hci.

.-------.
|       |                  .-.
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution mpc8315e-rdb ttyS0

Angstrom 2008.1-test-20080528
 ttyS0

mpc8315e-rdb login:

root@mpc8315e-rdb:~# ps -eo pid,class,rtprio,comm k rtprio
  PID CLS RTPRIO COMMAND
    1 TS       - init
    2 TS       - kthreadd
   13 TS       - desched/0
   15 TS       - khelper
   57 TS       - kblockd/0
   64 TS       - ata/0
   65 TS       - ata_aux
   73 TS       - khubd
  120 TS       - pdflush
  121 TS       - pdflush
  122 TS       - kswapd0
  123 TS       - aio/0
  690 TS       - scsi_eh_0
  693 TS       - scsi_eh_1
  697 TS       - mtdblockd
  738 TS       - w1_control
  741 TS       - rpciod/0
  802 TS       - udevd
 1904 TS       - udhcpc
 1915 TS       - portmap
 2188 TS       - dropbear
 2197 TS       - dbus-daemon
 2211 TS       - avahi-daemon
 2236 TS       - sh
 2240 TS       - ps
   14 FF       1 events/0
  119 FF       1 krcupreemptd
    4 FF      50 sirq-high/0
    5 FF      50 sirq-timer/0
    6 FF      50 sirq-net-tx/0
    7 FF      50 sirq-net-rx/0
    8 FF      50 sirq-block/0
    9 FF      50 sirq-tasklet/0
   10 FF      50 sirq-sched/0
   11 FF      50 sirq-hrtimer/0
   12 FF      50 sirq-rcu/0
  689 FF      50 IRQ-44
  692 FF      50 IRQ-45
  711 FF      50 IRQ-38
  729 FF      50 IRQ-16
  745 FF      50 IRQ-34
  746 FF      50 IRQ-32
  747 FF      50 IRQ-33
  748 FF      50 IRQ-17
    3 FF      99 posix_cpu_timer
