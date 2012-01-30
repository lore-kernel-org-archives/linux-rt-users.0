From: Christian Kapeller <christian.kapeller@cmotion.eu>
Subject: Unreliable Wireless network with 3.0.9-rt26
Date: Mon, 30 Jan 2012 18:45:12 +0100
Message-ID: <4F26D728.2090008@cmotion.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080309060803060502020209"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54134 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab2A3RpQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jan 2012 12:45:16 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080309060803060502020209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm having trouble running wifi in combination with a rt enabled kernel
3.0.9-rt26 on an imx51 arm platform. The distro is openwrt-trunk.

The device has 2 usb wifi interfaces (AR9271 chipset; driver: based on
compat-wireless-testing 2011-12-01). I am running an iperf load on both
interfaces, one interface is in AP mode, the other in STA mode.

When I configure the kernel without RT preemption, the device runs
stable for >10 hours.

With RT preemption enabled, after a couple of minutes some interface
will stop transmitting data. Sometimes ifconfig wlan[0,1] down will
hang, sometimes ifconfig wlan[0,1] down will work, but then ping will

return the following:

# ping 192.168.2.170
PING 192.168.2.170 (192.168.2.170): 56 data bytes
ping: sendto: Operation not permitted

Right after loading the wireless drivers I get the following kernel
warning:

[   36.917065] ------------[ cut here ]------------
[   36.917202] WARNING: at /home/chrkap/Development/cworld/openwrt/build_dir/linux-cmotion_generic/compat-wireless-2011-12-01/net/mac80211/rx.c:3011 ieee80211_rx+0x34/0xb2c [mac80211]()
[   36.917222] Modules linked in: mmc_spi gpio_buttons ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs button_hotplug rt2800usb rt2800lib ath9k_common ath9k_hw rt2x00usb ath rt2x00lib mac80211 crc7 crc_itu_t crc_ccitt cfg80211 lib80211_crypt_ccmp lib80211_crypt_wep lib80211 compat
[   36.917402] Backtrace: 
[   36.917449] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
[   36.917463]  r6:00000bc3 r5:bf079bd9 r4:00000000 r3:00000000
[   36.917503] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c00414f8>] (warn_slowpath_common+0x54/0x6c)
[   36.917526] [<c00414a4>] (warn_slowpath_common+0x0/0x6c) from [<c0041534>] (warn_slowpath_null+0x24/0x2c)
[   36.917539]  r8:c667ce60 r7:00000080 r6:c667ce60 r5:bf07c273 r4:c6731800
[   36.917561] r3:00000009
[   36.917607] [<c0041510>] (warn_slowpath_null+0x0/0x2c) from [<bf066d78>] (ieee80211_rx+0x34/0xb2c [mac80211])
[   36.917669] [<bf066d44>] (ieee80211_rx+0x0/0xb2c [mac80211]) from [<bf1d9590>] (ath9k_rx_tasklet+0x48c/0x4e8 [ath9k_htc])
[   36.917701] [<bf1d9104>] (ath9k_rx_tasklet+0x0/0x4e8 [ath9k_htc]) from [<c00469d4>] (tasklet_action+0x84/0xd8)
[   36.917722] [<c0046950>] (tasklet_action+0x0/0xd8) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
[   36.917734]  r7:00000000 r6:00000001 r5:c0619ed8 r4:c6324000
[   36.917763] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0047254>] (__do_softirq+0x14/0x18)
[   36.917784] [<c0047240>] (__do_softirq+0x0/0x18) from [<c0047340>] (local_bh_enable+0xe8/0x1b0)
[   36.917809] [<c0047258>] (local_bh_enable+0x0/0x1b0) from [<c007cd3c>] (irq_forced_thread_fn+0x40/0x48)
[   36.917822]  r5:c05c35cc r4:c62d8480
[   36.917842] [<c007ccfc>] (irq_forced_thread_fn+0x0/0x48) from [<c007cbb8>] (irq_thread+0x88/0x18c)
[   36.917855]  r6:c62d8480 r5:c05c35cc r4:c6324000 r3:00020000
[   36.917885] [<c007cb30>] (irq_thread+0x0/0x18c) from [<c005c1d4>] (kthread+0x90/0x98)
[   36.917908] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
[   36.917919]  r6:c0044b44 r5:c005c144 r4:c6027d14
[   36.917937] ---[ end trace 0000000000000002 ]---

as well as a lockdep warning:

[   91.890473] =======================================================
[   91.890484] [ INFO: possible circular locking dependency detected ]
[   91.890499] 3.0.9-rt26 #6
[   91.890507] -------------------------------------------------------
[   91.890519] ksoftirqd/0/3 is trying to acquire lock:
[   91.890530]  (&port_lock_key){+.+...}, at: [<c01f61c4>] imx_timeout+0x24/0x1f0
[   91.890572] 
[   91.890575] but task is already holding lock:
[   91.890583]  (&sport->timer){+.+...}, at: [<c004d724>] run_timer_softirq+0x118/0x264
[   91.890617] 
[   91.890620] which lock already depends on the new lock.

For a while the network interfaces will transmit data normally though.

The configuration I use is far from optimal, both wireless drivers, as well as 
the kernel contain the openwrt patches. If requested, I'll provide traces from
the vanilla sources.

I could reproduce the same behavior with kernel 3.0.14-rt32.

Could anyone help me to figure out a solution to this problem?

Kind regards,
Christian Kapeller

--------------080309060803060502020209
Content-Type: text/plain;
 name="dmesg-3.0.9-rt26-wifi-oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.0.9-rt26-wifi-oops"

[    0.000000] Linux version 3.0.9-rt26 (chrkap@christian-kapeller) (gcc version 4.6.2 20110813 (prerelease) (Linaro GCC 4.6-2011.08) ) #6 PREEMPT RT Mon Jan 30 17:20:16 CET 2012
[    0.000000] CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: TX51 cworld
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c05f84f8, node_mem_map c0b6a000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/nfs rw nfsroot=10.41.14.159:/srv/root_openwrt  ip=dhcp console=ttymxc0,115200 lpj=3977216 debug
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 118208k/118208k available, 12864k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf4000000   ( 696 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc002c000   ( 144 kB)
[    0.000000]       .text : 0xc002c000 - 0xc044e000   (4232 kB)
[    0.000000]       .data : 0xc044e000 - 0xc05f90a0   (1709 kB)
[    0.000000]        .bss : 0xc05f90c4 - 0xc0b691b1   (5569 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:272
[    0.000000] TrustZone Interrupt Controller (TZIC) initialized
[    0.000000] sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 64585ms
[    0.000000] CPU identified as i.MX51, silicon rev 3.0
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3951 kB
[    0.000000]  per task-struct memory footprint: 2304 bytes
[    0.001936] Calibrating delay loop (skipped) preset value.. 795.44 BogoMIPS (lpj=3977216)
[    0.001956] pid_max: default: 32768 minimum: 301
[    0.003450] Mount-cache hash table entries: 512
[    0.009121] CPU: Testing write buffer coherency: ok
[    0.046595] NET: Registered protocol family 16
[    0.131601] Copying MAC address from fuse bank 83f98c24
[    0.320589] bio: create slab <bio-0> at 0
[    0.336406] SCSI subsystem initialized
[    0.345306] usbcore: registered new interface driver usbfs
[    0.348258] usbcore: registered new interface driver hub
[    0.350279] usbcore: registered new device driver usb
[    0.358961] i2c-gpio i2c-gpio.0: using pins 113 (SDA) and 112 (SCL)
[    0.379901] Switching to clocksource mxc_timer1
[    0.526039] NET: Registered protocol family 2
[    0.529435] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.541381] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.542087] TCP bind hash table entries: 4096 (order: 6, 458752 bytes)
[    0.547776] TCP: Hash tables configured (established 4096 bind 4096)
[    0.547887] TCP reno registered
[    0.547926] UDP hash table entries: 64 (order: 1, 15360 bytes)
[    0.548762] UDP-Lite hash table entries: 64 (order: 1, 15360 bytes)
[    0.552007] NET: Registered protocol family 1
[    0.557856] RPC: Registered named UNIX socket transport module.
[    0.557885] RPC: Registered udp transport module.
[    0.557904] RPC: Registered tcp transport module.
[    0.557922] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.582366] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.587595] JFFS2 version 2.2 (NAND) (SUMMARY) (ZLIB) (LZO) (RTIME) (RUBIN) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.590943] msgmni has been set to 230
[    0.603715] io scheduler noop registered
[    0.603742] io scheduler deadline registered
[    0.604087] io scheduler cfq registered (default)
[    0.604098] start plist test
[    0.609578] end plist test
[    0.613642] imx-sdma imx-sdma: loaded firmware 1.1
[    0.673364] imx-sdma imx-sdma: initialized
[    0.735293] Serial: IMX driver
[    0.737411] imx-uart.0: ttymxc0 at MMIO 0x73fbc000 (irq = 31) is a IMX
[    1.201691] console [ttymxc0] enabled
[    1.221496] imx-uart.1: ttymxc1 at MMIO 0x73fc0000 (irq = 32) is a IMX
[    1.241259] imx-uart.2: ttymxc2 at MMIO 0x7000c000 (irq = 33) is a IMX
[    1.352219] brd: module loaded
[    1.372265] NAND device: Manufacturer ID: 0xec, Chip ID: 0xa1 (Samsung NAND 128MiB 1,8V 8-bit)
[    1.373842] Bad block table found at page 65472, version 0x03
[    1.374837] Bad block table found at page 65408, version 0x03
[    1.375332] nand_read_bbt: Bad block at 0x000000060000
[    1.375343] nand_read_bbt: Bad block at 0x000000200000
[    1.375363] nand_read_bbt: Bad block at 0x000006180000
[    1.376339] Searching for RedBoot partition table in mxc_nand at offset 0x7f60000
[    1.398218] 7 RedBoot partitions found on MTD device mxc_nand
[    1.398233] Creating 7 MTD partitions on "mxc_nand":
[    1.398273] 0x000000000000-0x000000040000 : "RedBoot"
[    1.414034] 0x000000040000-0x000000440000 : "linux"
[    1.425395] 0x000000440000-0x000004440000 : "rootfs"
[    1.435691] 0x000004440000-0x000007f60000 : "rootfs_data"
[    1.448545] 0x000007f60000-0x000007f7f000 : "FIS directory"
[    1.459211] 0x000007f7f000-0x000007f80000 : "RedBoot config"
[    1.471179] 0x000007f80000-0x000008000000 : "boardconfig"
[    1.502414] spi_imx imx51-ecspi.0: probed
[    1.510262] vcan: Virtual CAN interface driver
[    1.510302] CAN device driver interface
[    1.526563] mcp251x spi0.0: CANSTAT 0x80 CANCTRL 0x07
[    1.541380] mcp251x spi0.0: probed
[    1.542669] FEC Ethernet Driver
[    1.560134] fec_enet_mii_bus: probed
[    1.577432] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.577821] mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
[    1.579777] tx51_usb_port_init: Enabling USB AHB CLK
[    1.620088] mxc-ehci mxc-ehci.0: Freescale On-Chip EHCI Host Controller
[    1.622621] mxc-ehci mxc-ehci.0: new USB bus registered, assigned bus number 1
[    1.650680] mxc-ehci mxc-ehci.0: irq 18, io mem 0x73f80000
[    1.670112] mxc-ehci mxc-ehci.0: USB 2.0 started, EHCI 1.00
[    1.672026] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.672042] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.672056] usb usb1: Product: Freescale On-Chip EHCI Host Controller
[    1.672068] usb usb1: Manufacturer: Linux 3.0.9-rt26 ehci_hcd
[    1.672079] usb usb1: SerialNumber: mxc-ehci.0
[    1.681557] hub 1-0:1.0: USB hub found
[    1.681866] hub 1-0:1.0: 1 port detected
[    1.688513] mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
[    1.688718] tx51_usb_port_init: Enabling USB AHB CLK
[    1.710155] mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
[    1.710521] mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 2
[    1.740650] mxc-ehci mxc-ehci.1: irq 14, io mem 0x73f80200
[    1.760071] mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
[    1.761131] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.761147] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.761160] usb usb2: Product: Freescale On-Chip EHCI Host Controller
[    1.761172] usb usb2: Manufacturer: Linux 3.0.9-rt26 ehci_hcd
[    1.761183] usb usb2: SerialNumber: mxc-ehci.1
[    1.766752] hub 2-0:1.0: USB hub found
[    1.766950] hub 2-0:1.0: 1 port detected
[    1.772973] Initializing USB Mass Storage driver...
[    1.774799] usbcore: registered new interface driver usb-storage
[    1.774814] USB Mass Storage support registered.
[    1.779320] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.805524] input: imx-keypad as /devices/platform/imx-keypad/input/input1
[    1.853628] rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
[    1.864837] imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled. timeout=60s (nowayout=1)
[    1.871375] sdhci: Secure Digital Host Controller Interface driver
[    1.871391] sdhci: Copyright(c) Pierre Ossman
[    1.881595] Registered led device: mmc0::
[    1.886258] mmc0: SDHCI controller on platform [sdhci-esdhc-imx.0] using DMA
[    1.913930] Registered led device: cworld:green:life
[    1.915618] Registered led device: cworld:red:ready
[    1.917335] Registered led device: cworld:green:ready
[    1.919108] Registered led device: cworld:green:rf
[    1.940655] Registered led device: cworld:red:rf
[    1.942334] Registered led device: cworld:red:net
[    1.944023] Registered led device: cworld:green:net
[    1.954041] NET: Registered protocol family 26
[    1.954535] nf_conntrack version 0.5.0 (1847 buckets, 7388 max)
[    2.102148] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.102614] TCP cubic registered
[    2.102660] NET: Registered protocol family 17
[    2.105343] Bridge firewalling registered
[    2.105705] can: controller area network core (rev 20090105 abi 8)
[    2.106650] NET: Registered protocol family 29
[    2.107077] can: raw protocol (rev 20090105)
[    2.108180] 802.1Q VLAN Support v1.8
[    2.108634] Registering the dns_resolver key type
[    2.109629] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
[    2.130803] usb 1-1: new high speed USB device number 2 using mxc-ehci
[    2.171349] rtc-ds1307 0-0068: setting system clock to 2000-02-16 07:47:06 UTC (950687226)
[    2.198166] eth0: Freescale FEC PHY driver [SMSC LAN8700] (mii_bus:phy_addr=1:0f, irq=-1)
[    2.303013] usb 1-1: New USB device found, idVendor=0cf3, idProduct=9271
[    2.303032] usb 1-1: New USB device strings: Mfr=16, Product=32, SerialNumber=48
[    2.303046] usb 1-1: Product: WLAN 
[    2.303055] usb 1-1: Manufacturer: MVA1000
[    2.303065] usb 1-1: SerialNumber: 12345
[    2.890258] usb 2-1: new high speed USB device number 2 using mxc-ehci
[    3.062845] usb 2-1: New USB device found, idVendor=0cf3, idProduct=9271
[    3.062862] usb 2-1: New USB device strings: Mfr=16, Product=32, SerialNumber=48
[    3.062876] usb 2-1: Product: WLAN 
[    3.062885] usb 2-1: Manufacturer: MVA1001
[    3.062894] usb 2-1: SerialNumber: 12345
[    4.191454] PHY: 1:0f - Link is Up - 100/Full
[    4.210090] Sending DHCP requests ., OK
[    5.240070] IP-Config: Got DHCP answer from 10.41.14.20, my address is 10.41.14.237
[    5.244364] IP-Config: Complete:
[    5.244382]      device=eth0, addr=10.41.14.237, mask=255.255.255.0, gw=10.41.14.20,
[    5.244409]      host=static-host, domain=cmotion.local, nis-domain=(none),
[    5.244419]      bootserver=10.41.14.20, rootserver=10.41.14.159, rootpath=
[    5.390448] VFS: Mounted root (nfs filesystem) on device 0:14.
[    5.391196] Freeing init memory: 144K
[   16.972525] Compat-wireless backport release: compat-wireless-2011-11-29
[   16.972545] Backport based on wireless-testing.git master-2011-12-01
[   17.051303] lib80211: common routines for IEEE802.11 drivers
[   17.052213] lib80211_crypt: registered algorithm 'NULL'
[   17.126130] lib80211_crypt: registered algorithm 'WEP'
[   17.204931] lib80211_crypt: registered algorithm 'CCMP'
[   17.277596] lib80211_crypt_tkip: Unknown symbol wireless_send_event (err 0)
[   17.492143] cfg80211: Calling CRDA to update world regulatory domain
[   18.228718] cfg80211: World regulatory domain updated:
[   18.228742] cfg80211:     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[   18.228759] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   18.228774] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   18.228788] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   18.228801] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   18.228815] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   18.953657] usbcore: registered new interface driver rt2800usb
[   19.032004] Button Hotplug driver version 0.4.1
[   19.147223] NTFS driver 2.1.30 [Flags: R/O MODULE].
[   21.665699] xt_time: kernel timezone is -0000
[   22.552236] usb 1-1: ath9k_htc: Transferred FW: htc_9271.fw, size: 51272
[   22.795480] ath9k_htc 1-1:1.0: ath9k_htc: HTC initialized with 33 credits
[   23.120267] ath9k_htc 1-1:1.0: ath9k_htc: FW Version: 1.3
[   23.120284] ath: EEPROM regdomain: 0x30
[   23.120293] ath: EEPROM indicates we should expect a direct regpair map
[   23.120307] ath: Country alpha2 being used: AM
[   23.120316] ath: Regpair used: 0x30
[   23.201259] cfg80211: Calling CRDA for country: AM
[   23.207928] ieee80211 phy0: Atheros AR9271 Rev:1
[   23.215814] Registered led device: ath9k_htc-phy0
[   23.215842] usb 1-1: ath9k_htc: USB layer initialized
[   23.754907] usb 2-1: ath9k_htc: Transferred FW: htc_9271.fw, size: 51272
[   23.988017] cfg80211: Regulatory domain changed to country: AM
[   23.988039] cfg80211:     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[   23.988057] cfg80211:     (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm)
[   23.988070] cfg80211:     (5170000 KHz - 5250000 KHz @ 20000 KHz), (N/A, 1800 mBm)
[   23.988083] cfg80211:     (5250000 KHz - 5330000 KHz @ 20000 KHz), (N/A, 1800 mBm)
[   23.995608] ath9k_htc 2-1:1.0: ath9k_htc: HTC initialized with 33 credits
[   24.318494] ath9k_htc 2-1:1.0: ath9k_htc: FW Version: 1.3
[   24.318511] ath: EEPROM regdomain: 0x30
[   24.318519] ath: EEPROM indicates we should expect a direct regpair map
[   24.318534] ath: Country alpha2 being used: AM
[   24.318542] ath: Regpair used: 0x30
[   24.385376] ieee80211 phy1: Atheros AR9271 Rev:1
[   24.395724] Registered led device: ath9k_htc-phy1
[   24.395756] usb 2-1: ath9k_htc: USB layer initialized
[   24.397778] usbcore: registered new interface driver ath9k_htc
[   31.967639] cfg80211: Calling CRDA for country: AT
[   32.533304] cfg80211: Regulatory domain changed to country: AT
[   32.533326] cfg80211:     (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[   32.533344] cfg80211:     (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm)
[   32.533357] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz), (N/A, 2000 mBm)
[   32.533371] cfg80211:     (5250000 KHz - 5330000 KHz @ 40000 KHz), (N/A, 2000 mBm)
[   32.533384] cfg80211:     (5490000 KHz - 5710000 KHz @ 40000 KHz), (N/A, 2700 mBm)
[   36.917065] ------------[ cut here ]------------
[   36.917202] WARNING: at /home/chrkap/Development/cworld/openwrt/build_dir/linux-cmotion_generic/compat-wireless-2011-12-01/net/mac80211/rx.c:3011 ieee80211_rx+0x34/0xb2c [mac80211]()
[   36.917222] Modules linked in: mmc_spi gpio_buttons ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs button_hotplug rt2800usb rt2800lib ath9k_common ath9k_hw rt2x00usb ath rt2x00lib mac80211 crc7 crc_itu_t crc_ccitt cfg80211 lib80211_crypt_ccmp lib80211_crypt_wep lib80211 compat
[   36.917402] Backtrace: 
[   36.917449] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
[   36.917463]  r6:00000bc3 r5:bf079bd9 r4:00000000 r3:00000000
[   36.917503] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c00414f8>] (warn_slowpath_common+0x54/0x6c)
[   36.917526] [<c00414a4>] (warn_slowpath_common+0x0/0x6c) from [<c0041534>] (warn_slowpath_null+0x24/0x2c)
[   36.917539]  r8:c667ce60 r7:00000080 r6:c667ce60 r5:bf07c273 r4:c6731800
[   36.917561] r3:00000009
[   36.917607] [<c0041510>] (warn_slowpath_null+0x0/0x2c) from [<bf066d78>] (ieee80211_rx+0x34/0xb2c [mac80211])
[   36.917669] [<bf066d44>] (ieee80211_rx+0x0/0xb2c [mac80211]) from [<bf1d9590>] (ath9k_rx_tasklet+0x48c/0x4e8 [ath9k_htc])
[   36.917701] [<bf1d9104>] (ath9k_rx_tasklet+0x0/0x4e8 [ath9k_htc]) from [<c00469d4>] (tasklet_action+0x84/0xd8)
[   36.917722] [<c0046950>] (tasklet_action+0x0/0xd8) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
[   36.917734]  r7:00000000 r6:00000001 r5:c0619ed8 r4:c6324000
[   36.917763] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0047254>] (__do_softirq+0x14/0x18)
[   36.917784] [<c0047240>] (__do_softirq+0x0/0x18) from [<c0047340>] (local_bh_enable+0xe8/0x1b0)
[   36.917809] [<c0047258>] (local_bh_enable+0x0/0x1b0) from [<c007cd3c>] (irq_forced_thread_fn+0x40/0x48)
[   36.917822]  r5:c05c35cc r4:c62d8480
[   36.917842] [<c007ccfc>] (irq_forced_thread_fn+0x0/0x48) from [<c007cbb8>] (irq_thread+0x88/0x18c)
[   36.917855]  r6:c62d8480 r5:c05c35cc r4:c6324000 r3:00020000
[   36.917885] [<c007cb30>] (irq_thread+0x0/0x18c) from [<c005c1d4>] (kthread+0x90/0x98)
[   36.917908] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
[   36.917919]  r6:c0044b44 r5:c005c144 r4:c6027d14
[   36.917937] ---[ end trace 0000000000000002 ]---
[   51.705013] wlan1: authenticate with XX:XX:XX:XX:XX:XX (try 1)
[   51.708273] wlan1: authenticated
[   51.730933] wlan1: associate with XX:XX:XX:XX:XX:XX (try 1)
[   51.735645] wlan1: RX AssocResp from XX:XX:XX:XX:XX:XX (capab=0x431 status=0 aid=1)
[   51.735669] wlan1: associated
[   91.890456] 
[   91.890473] =======================================================
[   91.890484] [ INFO: possible circular locking dependency detected ]
[   91.890499] 3.0.9-rt26 #6
[   91.890507] -------------------------------------------------------
[   91.890519] ksoftirqd/0/3 is trying to acquire lock:
[   91.890530]  (&port_lock_key){+.+...}, at: [<c01f61c4>] imx_timeout+0x24/0x1f0
[   91.890572] 
[   91.890575] but task is already holding lock:
[   91.890583]  (&sport->timer){+.+...}, at: [<c004d724>] run_timer_softirq+0x118/0x264
[   91.890617] 
[   91.890620] which lock already depends on the new lock.
[   91.890626] 
[   91.890632] 
[   91.890635] the existing dependency chain (in reverse order) is:
[   91.890644] 
[   91.890647] -> #1 (&sport->timer){+.+...}:
[   91.890661]        [<c006f2f4>] __lock_acquire+0x12ac/0x1750
[   91.890680]        [<c006fc50>] lock_acquire+0x68/0x7c
[   91.890694]        [<c004d1b4>] del_timer_sync+0x4c/0x154
[   91.890710]        [<c01f5ddc>] imx_set_termios+0x144/0x304
[   91.890725]        [<c01f36e8>] uart_set_options+0x128/0x168
[   91.890751]        [<c001a330>] imx_console_setup+0x1b0/0x1c0
[   91.890777]        [<c0042af4>] register_console+0x17c/0x338
[   91.890804]        [<c01f304c>] uart_add_one_port+0x2ec/0x3c8
[   91.890821]        [<c01f6118>] serial_imx_probe+0x17c/0x204
[   91.890836]        [<c01ff2c0>] platform_drv_probe+0x1c/0x20
[   91.890855]        [<c01fdfcc>] driver_probe_device+0xb0/0x164
[   91.890871]        [<c01fe0e8>] __driver_attach+0x68/0x8c
[   91.890885]        [<c01fd1d4>] bus_for_each_dev+0x58/0x94
[   91.890909]        [<c01fdc90>] driver_attach+0x20/0x28
[   91.890923]        [<c01fd8b4>] bus_add_driver+0xa4/0x22c
[   91.890937]        [<c01fe614>] driver_register+0xb0/0x140
[   91.890951]        [<c01ff6cc>] platform_driver_register+0x4c/0x60
[   91.890968]        [<c001a15c>] imx_serial_init+0x2c/0x50
[   91.890984]        [<c002c404>] do_one_initcall+0x98/0x16c
[   91.891008]        [<c00089dc>] kernel_init+0x7c/0x118
[   91.891024]        [<c0044b44>] do_exit+0x0/0x67c
[   91.891043] 
[   91.891046] -> #0 (&port_lock_key){+.+...}:
[   91.891059]        [<c0343140>] print_circular_bug+0x5c/0x2b4
[   91.891087]        [<c006f034>] __lock_acquire+0xfec/0x1750
[   91.891103]        [<c006fc50>] lock_acquire+0x68/0x7c
[   91.891117]        [<c0347bec>] rt_spin_lock+0x3c/0x44
[   91.891138]        [<c01f61c4>] imx_timeout+0x24/0x1f0
[   91.891152]        [<c004d79c>] run_timer_softirq+0x190/0x264
[   91.891169]        [<c0046c34>] __do_softirq_common+0xa8/0x164
[   91.891184]        [<c0046dc8>] __thread_do_softirq+0xd8/0x16c
[   91.891199]        [<c0046ed8>] run_ksoftirqd+0x7c/0x178
[   91.891214]        [<c005c1d4>] kthread+0x90/0x98
[   91.891230]        [<c0044b44>] do_exit+0x0/0x67c
[   91.891247] 
[   91.891250] other info that might help us debug this:
[   91.891256] 
[   91.891262]  Possible unsafe locking scenario:
[   91.891268] 
[   91.891273]        CPU0                    CPU1
[   91.891281]        ----                    ----
[   91.891289]   lock(&sport->timer);
[   91.891300]                                lock(&port_lock_key);
[   91.891312]                                lock(&sport->timer);
[   91.891324]   lock(&port_lock_key);
[   91.891334] 
[   91.891337]  *** DEADLOCK ***
[   91.891342] 
[   91.891350] 2 locks held by ksoftirqd/0/3:
[   91.891358]  #0:  (&per_cpu(local_softirq_lock, __cpu).lock){+.+...}, at: [<c0046d48>] __thread_do_softirq+0x58/0x16c
[   91.891384]  #1:  (&sport->timer){+.+...}, at: [<c004d724>] run_timer_softirq+0x118/0x264
[   91.891408] 
[   91.891412] stack backtrace:
[   91.891418] Backtrace: 
[   91.891444] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
[   91.891457]  r6:c06d4100 r5:c06d4360 r4:c06d4100 r3:00000000
[   91.891488] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c034334c>] (print_circular_bug+0x268/0x2b4)
[   91.891510] [<c03430e4>] (print_circular_bug+0x0/0x2b4) from [<c006f034>] (__lock_acquire+0xfec/0x1750)
[   91.891530] [<c006e048>] (__lock_acquire+0x0/0x1750) from [<c006fc50>] (lock_acquire+0x68/0x7c)
[   91.891550] [<c006fbe8>] (lock_acquire+0x0/0x7c) from [<c0347bec>] (rt_spin_lock+0x3c/0x44)
[   91.891562]  r6:c602e000 r5:c6160000 r4:c01f61c4
[   91.891587] [<c0347bb0>] (rt_spin_lock+0x0/0x44) from [<c01f61c4>] (imx_timeout+0x24/0x1f0)
[   91.891599]  r5:c6160134 r4:c6160000
[   91.891620] [<c01f61a0>] (imx_timeout+0x0/0x1f0) from [<c004d79c>] (run_timer_softirq+0x190/0x264)
[   91.891642] [<c004d60c>] (run_timer_softirq+0x0/0x264) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
[   91.891662] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0046dc8>] (__thread_do_softirq+0xd8/0x16c)
[   91.891683] [<c0046cf0>] (__thread_do_softirq+0x0/0x16c) from [<c0046ed8>] (run_ksoftirqd+0x7c/0x178)
[   91.891696]  r5:c0619e80 r4:c602e000
[   91.891716] [<c0046e5c>] (run_ksoftirqd+0x0/0x178) from [<c005c1d4>] (kthread+0x90/0x98)
[   91.891727]  r7:00000013 r6:c0046e5c r5:00000000 r4:c6027ebc
[   91.891757] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
[   91.891768]  r6:c0044b44 r5:c005c144 r4:c6027ebc
[  171.565554] ------------[ cut here ]------------
[  171.565611] WARNING: at /home/chrkap/Development/cworld/openwrt/build_dir/linux-cmotion_generic/compat-wireless-2011-12-01/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c:501 ath9k_htc_tx_clear_slot+0x364/0x528 [ath9k_htc]()
[  171.565674] Modules linked in: mmc_spi gpio_buttons ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs button_hotplug rt2800usb rt2800lib ath9k_common ath9k_hw rt2x00usb ath rt2x00lib mac80211 crc7 crc_itu_t crc_ccitt cfg80211 lib80211_crypt_ccmp lib80211_crypt_wep lib80211 compat
[  171.565944] Backtrace: 
[  171.565995] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
[  171.566047]  r6:000001f5 r5:bf1e30ea r4:00000000 r3:00000000
[  171.566089] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c00414f8>] (warn_slowpath_common+0x54/0x6c)
[  171.566150] [<c00414a4>] (warn_slowpath_common+0x0/0x6c) from [<c0041534>] (warn_slowpath_null+0x24/0x2c)
[  171.566164]  r8:c67e30a8 r7:00000000 r6:c67e26a0 r5:c6b0c2f0 r4:00000000
[  171.566229] r3:00000009
[  171.566256] [<c0041510>] (warn_slowpath_null+0x0/0x2c) from [<bf1d8180>] (ath9k_htc_tx_clear_slot+0x364/0x528 [ath9k_htc])
[  171.566290] [<bf1d7e94>] (ath9k_htc_tx_clear_slot+0x78/0x528 [ath9k_htc]) from [<bf1d8a28>] (ath9k_htc_txstatus+0xc0/0xe4 [ath9k_htc])
[  171.566359] [<bf1d8968>] (ath9k_htc_txstatus+0x0/0xe4 [ath9k_htc]) from [<bf1d763c>] (ath9k_wmi_event_tasklet+0x12c/0x138 [ath9k_htc])
[  171.566392] [<bf1d7510>] (ath9k_wmi_event_tasklet+0x0/0x138 [ath9k_htc]) from [<c00469d4>] (tasklet_action+0x84/0xd8)
[  171.566450] [<c0046950>] (tasklet_action+0x0/0xd8) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
[  171.566463]  r7:00000000 r6:00000001 r5:c0619ed8 r4:c632a000
[  171.566528] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0047254>] (__do_softirq+0x14/0x18)
[  171.566550] [<c0047240>] (__do_softirq+0x0/0x18) from [<c0047340>] (local_bh_enable+0xe8/0x1b0)
[  171.566574] [<c0047258>] (local_bh_enable+0x0/0x1b0) from [<c007cd3c>] (irq_forced_thread_fn+0x40/0x48)
[  171.566621]  r5:c05c31fc r4:c62d8140
[  171.566643] [<c007ccfc>] (irq_forced_thread_fn+0x0/0x48) from [<c007cbb8>] (irq_thread+0x88/0x18c)
[  171.566656]  r6:c62d8140 r5:c05c31fc r4:c632a000 r3:00020000
[  171.566722] [<c007cb30>] (irq_thread+0x0/0x18c) from [<c005c1d4>] (kthread+0x90/0x98)
[  171.566747] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
[  171.566759]  r6:c0044b44 r5:c005c144 r4:c6027d14
[  171.566813] ---[ end trace 0000000000000003 ]---
[  327.153252] ------------[ cut here ]------------
[  327.153315] WARNING: at /home/chrkap/Development/cworld/openwrt/build_dir/linux-cmotion_generic/compat-wireless-2011-12-01/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c:501 ath9k_htc_tx_clear_slot+0x364/0x528 [ath9k_htc]()
[  327.153409] Modules linked in: mmc_spi gpio_buttons ath9k_htc xt_HL xt_hl ipt_ECN xt_CLASSIFY xt_time xt_tcpmss xt_statistic xt_mark xt_length ipt_ecn xt_DSCP xt_dscp xt_quota xt_pkttype xt_physdev xt_owner ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE xt_recent xt_helper xt_connmark xt_connbytes xt_conntrack xt_NOTRACK iptable_raw xt_state ipt_REJECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ntfs button_hotplug rt2800usb rt2800lib ath9k_common ath9k_hw rt2x00usb ath rt2x00lib mac80211 crc7 crc_itu_t crc_ccitt cfg80211 lib80211_crypt_ccmp lib80211_crypt_wep lib80211 compat
[  327.153654] Backtrace: 
[  327.153701] [<c0034a50>] (dump_backtrace+0x0/0x110) from [<c03428f8>] (dump_stack+0x18/0x1c)
[  327.153754]  r6:000001f5 r5:bf1e30ea r4:00000000 r3:00000000
[  327.153833] [<c03428e0>] (dump_stack+0x0/0x1c) from [<c00414f8>] (warn_slowpath_common+0x54/0x6c)
[  327.153857] [<c00414a4>] (warn_slowpath_common+0x0/0x6c) from [<c0041534>] (warn_slowpath_null+0x24/0x2c)
[  327.153871]  r8:c667f0a8 r7:00000000 r6:c667e6a0 r5:c6b13d30 r4:00000000
[  327.153931] r3:00000009
[  327.153957] [<c0041510>] (warn_slowpath_null+0x0/0x2c) from [<bf1d8180>] (ath9k_htc_tx_clear_slot+0x364/0x528 [ath9k_htc])
[  327.153991] [<bf1d7e94>] (ath9k_htc_tx_clear_slot+0x78/0x528 [ath9k_htc]) from [<bf1d8a28>] (ath9k_htc_txstatus+0xc0/0xe4 [ath9k_htc])
[  327.154064] [<bf1d8968>] (ath9k_htc_txstatus+0x0/0xe4 [ath9k_htc]) from [<bf1d763c>] (ath9k_wmi_event_tasklet+0x12c/0x138 [ath9k_htc])
[  327.154132] [<bf1d7510>] (ath9k_wmi_event_tasklet+0x0/0x138 [ath9k_htc]) from [<c00469d4>] (tasklet_action+0x84/0xd8)
[  327.154155] [<c0046950>] (tasklet_action+0x0/0xd8) from [<c0046c34>] (__do_softirq_common+0xa8/0x164)
[  327.154168]  r7:00000000 r6:00000001 r5:c0619ed8 r4:c6324000
[  327.154234] [<c0046b8c>] (__do_softirq_common+0x0/0x164) from [<c0047254>] (__do_softirq+0x14/0x18)
[  327.154255] [<c0047240>] (__do_softirq+0x0/0x18) from [<c0047340>] (local_bh_enable+0xe8/0x1b0)
[  327.154280] [<c0047258>] (local_bh_enable+0x0/0x1b0) from [<c007cd3c>] (irq_forced_thread_fn+0x40/0x48)
[  327.154329]  r5:c05c35cc r4:c62d8480
[  327.154352] [<c007ccfc>] (irq_forced_thread_fn+0x0/0x48) from [<c007cbb8>] (irq_thread+0x88/0x18c)
[  327.154364]  r6:c62d8480 r5:c05c35cc r4:c6324000 r3:00020000
[  327.154431] [<c007cb30>] (irq_thread+0x0/0x18c) from [<c005c1d4>] (kthread+0x90/0x98)
[  327.154455] [<c005c144>] (kthread+0x0/0x98) from [<c0044b44>] (do_exit+0x0/0x67c)
[  327.154467]  r6:c0044b44 r5:c005c144 r4:c6027d14
[  327.154527] ---[ end trace 0000000000000004 ]---
[  899.189777] wlan1: authenticate with XX:XX:XX:XX:XX:XX (try 1)
[  899.195585] wlan1: authenticated
[  900.177948] wlan1: associate with XX:XX:XX:XX:XX:XX (try 1)
[  900.184785] wlan1: RX ReassocResp from XX:XX:XX:XX:XX:XX (capab=0x431 status=0 aid=1)
[  900.185628] wlan1: associated

--------------080309060803060502020209
Content-Type: text/plain;
 name="config-3.0.9-rt26"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-3.0.9-rt26"

#
# Automatically generated make config: don't edit
# Linux/arm 3.0.9 Kernel Configuration
#
CONFIG_ARM=y
CONFIG_HAVE_PWM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_HAVE_SCHED_CLOCK=y
CONFIG_GENERIC_GPIO=y
# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_KTIME_SCALAR=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ARCH_HAS_CPUFREQ=y
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_VECTORS_BASE=0xffff0000
# CONFIG_ARM_PATCH_PHYS_VIRT is not set
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_HOSTNAME="cworld"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_FHANDLE is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_GENERIC_HARDIRQS=y

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_HAVE_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_FORCED_THREADING=y
# CONFIG_SPARSE_IRQ is not set

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_BOOST is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_CGROUPS is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# CONFIG_PERF_COUNTERS is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
# CONFIG_INLINE_SPIN_UNLOCK is not set
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
# CONFIG_INLINE_READ_UNLOCK is not set
# CONFIG_INLINE_READ_UNLOCK_BH is not set
# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
# CONFIG_INLINE_WRITE_UNLOCK is not set
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
# CONFIG_MUTEX_SPIN_ON_OWNER is not set
CONFIG_FREEZER=y

#
# System Type
#
CONFIG_MMU=y
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_VEXPRESS is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_BCMRING is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CNS3XXX is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
CONFIG_ARCH_MXC=y
# CONFIG_ARCH_MXS is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_DOVE is not set
# CONFIG_ARCH_KIRKWOOD is not set
# CONFIG_ARCH_LOKI is not set
# CONFIG_ARCH_LPC32XX is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_W90X900 is not set
# CONFIG_ARCH_NUC93X is not set
# CONFIG_ARCH_TEGRA is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_MSM is not set
# CONFIG_ARCH_SHMOBILE is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_S5P64X0 is not set
# CONFIG_ARCH_S5PC100 is not set
# CONFIG_ARCH_S5PV210 is not set
# CONFIG_ARCH_EXYNOS4 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_TCC_926 is not set
# CONFIG_ARCH_U300 is not set
# CONFIG_ARCH_U8500 is not set
# CONFIG_ARCH_NOMADIK is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP is not set
# CONFIG_PLAT_SPEAR is not set
# CONFIG_ARCH_VT8500 is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_IMX_HAVE_PLATFORM_FEC=y
CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC=y
CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS=y
CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT=y
CONFIG_IMX_HAVE_PLATFORM_IMX_I2C=y
CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD=y
CONFIG_IMX_HAVE_PLATFORM_IMX_UART=y
CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI=y
CONFIG_IMX_HAVE_PLATFORM_MXC_NAND=y
CONFIG_IMX_HAVE_PLATFORM_MXC_PWM=y
CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX=y
CONFIG_IMX_HAVE_PLATFORM_SPI_IMX=y

#
# Freescale MXC Implementations
#
# CONFIG_ARCH_MX1 is not set
# CONFIG_ARCH_MX2 is not set
# CONFIG_ARCH_MX25 is not set
# CONFIG_ARCH_MX3 is not set
# CONFIG_ARCH_MX503 is not set
CONFIG_ARCH_MX51=y
CONFIG_ARCH_MX5=y
CONFIG_SOC_IMX51=y

#
# i.MX51 machines:
#
# CONFIG_MACH_MX51_BABBAGE is not set
# CONFIG_MACH_MX51_3DS is not set
# CONFIG_MACH_EUKREA_CPUIMX51 is not set
# CONFIG_MACH_EUKREA_CPUIMX51SD is not set
# CONFIG_MACH_MX51_EFIKAMX is not set
# CONFIG_MACH_MX51_EFIKASB is not set
# CONFIG_MACH_TX51 is not set
CONFIG_MACH_TX51_CWORLD=y
CONFIG_MXC_IRQ_PRIOR=y
CONFIG_MXC_TZIC=y
CONFIG_MXC_PWM=y
# CONFIG_MXC_DEBUG_BOARD is not set
CONFIG_ARCH_MXC_IOMUX_V3=y
CONFIG_ARCH_MXC_AUDMUX_V2=y

#
# System MMU
#

#
# Processor Type
#
CONFIG_CPU_V7=y
CONFIG_CPU_32v6K=y
CONFIG_CPU_32v7=y
CONFIG_CPU_ABRT_EV7=y
CONFIG_CPU_PABRT_V7=y
CONFIG_CPU_CACHE_V7=y
CONFIG_CPU_CACHE_VIPT=y
CONFIG_CPU_COPY_V6=y
CONFIG_CPU_TLB_V7=y
CONFIG_CPU_HAS_ASID=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
CONFIG_ARM_THUMB=y
# CONFIG_ARM_THUMBEE is not set
# CONFIG_SWP_EMULATE is not set
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_ARM_L1_CACHE_SHIFT_6=y
CONFIG_ARM_L1_CACHE_SHIFT=6
CONFIG_ARM_DMA_MEM_BUFFERABLE=y
CONFIG_CPU_HAS_PMU=y
# CONFIG_ARM_ERRATA_430973 is not set
# CONFIG_ARM_ERRATA_458693 is not set
# CONFIG_ARM_ERRATA_460075 is not set
# CONFIG_ARM_ERRATA_743622 is not set
CONFIG_ARM_ERRATA_754322=y

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set

#
# Kernel Features
#
CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_LL is not set
# CONFIG_PREEMPT_RTB is not set
CONFIG_PREEMPT_RT_FULL=y
CONFIG_HZ=100
# CONFIG_THUMB2_KERNEL is not set
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
CONFIG_HAVE_ARCH_PFN_VALID=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
# CONFIG_COMPACTION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_FORCE_MAX_ZONEORDER=13
CONFIG_ALIGNMENT_TRAP=y
# CONFIG_UACCESS_WITH_MEMCPY is not set
# CONFIG_SECCOMP is not set
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_DEPRECATED_PARAM_STRUCT is not set

#
# Boot options
#
# CONFIG_USE_OF is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="init=/etc/preinit console=ttymxc0,115200"
CONFIG_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_AUTO_ZRELADDR is not set

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG_VFP=y
CONFIG_VFPv3=y
CONFIG_NEON=y

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Power management options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_RUNTIME is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_APM_EMULATION=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
# CONFIG_NF_CT_PROTO_DCCP is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
CONFIG_NF_CT_PROTO_UDPLITE=m
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
# CONFIG_NF_CONNTRACK_SNMP is not set
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CONNTRACK_RTSP is not set
# CONFIG_NF_CT_NETLINK is not set
# CONFIG_NETFILTER_TPROXY is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
# CONFIG_NETFILTER_XT_TARGET_CT is not set
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
CONFIG_NETFILTER_XT_MATCH_DSCP=m
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_LAYER7 is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
CONFIG_NETFILTER_XT_MATCH_RECENT=m
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_CONNTRACK_IPV4=y
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_AH is not set
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_NF_NAT_PROTO_UDPLITE=m
# CONFIG_NF_NAT_FTP is not set
# CONFIG_NF_NAT_IRC is not set
# CONFIG_NF_NAT_RTSP is not set
# CONFIG_NF_NAT_TFTP is not set
# CONFIG_NF_NAT_AMANDA is not set
# CONFIG_NF_NAT_PPTP is not set
# CONFIG_NF_NAT_H323 is not set
# CONFIG_NF_NAT_SIP is not set
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_MCP251X=y
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_C_CAN is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_SOFTING is not set
CONFIG_CAN_DEBUG_DEVICES=y
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE="sdma-imx51.bin"
CONFIG_EXTRA_FIRMWARE_DIR="imx-sdma-firmware"
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_ROOTFS_ROOT_DEV is not set
# CONFIG_MTD_ROOTFS_SPLIT is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-5
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_AFS_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_M25P80 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_MUSEUM_IDS is not set
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_MTD_NAND_IDS=y
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_ALAUDA is not set
CONFIG_MTD_NAND_MXC=y
# CONFIG_MTD_ONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_RESERVE=1
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_DEBUG=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MG_DISK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_MISC_DEVICES=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_BMP085 is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_IWMC3200TOP is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_SPI is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
CONFIG_MII=y
CONFIG_PHYLIB=y
# CONFIG_SWCONFIG is not set

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_ADM6996_PHY is not set
# CONFIG_MVSWITCH_PHY is not set
# CONFIG_IP17XX_PHY is not set
# CONFIG_AR8216_PHY is not set
# CONFIG_RTL8306_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_RTL8366_SMI is not set
CONFIG_NET_ETHERNET=y
# CONFIG_AX88796 is not set
# CONFIG_SMC91X is not set
# CONFIG_DM9000 is not set
# CONFIG_ENC28J60 is not set
# CONFIG_ETHOC is not set
# CONFIG_SMC911X is not set
# CONFIG_SMSC911X is not set
# CONFIG_DNET is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_B44 is not set
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
CONFIG_FEC=y
# CONFIG_FTMAC100 is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_WAN is not set

#
# CAIF transport drivers
#
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m
# CONFIG_INPUT_APMPOWER is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_IMX=y
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_GPIO_BUTTONS=m

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=16
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX3107 is not set
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_HVC_DCC is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_R3964 is not set
# CONFIG_GPIO_DEVICE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_RAMOOPS is not set
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_IMX=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_IMX_VER_0_7=y
CONFIG_SPI_IMX_VER_2_3=y
# CONFIG_SPI_GPIO_OLD is not set
CONFIG_SPI_IMX=y
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable Device Drivers -> PPS to see the PTP clock options.
#
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers:
#
CONFIG_GPIO_BASIC_MMIO_CORE=y
# CONFIG_GPIO_BASIC_MMIO is not set
# CONFIG_GPIO_IT8761E is not set
CONFIG_GPIO_MXC=y

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set
# CONFIG_GPIO_ADP5588 is not set

#
# PCI GPIO expanders:
#

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_74X164 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_IMX2_WDT=y

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set
# CONFIG_MFD_SUPPORT is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_DRM is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
# CONFIG_HID is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB_ARCH_HAS_OHCI is not set
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=m
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_MXC=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set
# CONFIG_USB_MUSB_HDRC is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ULPI is not set
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_UNSAFE_RESUME=y
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_ESDHC_IMX=y
CONFIG_MMC_SPI=m
# CONFIG_MMC_DW is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MEMSTICK is not set
CONFIG_LEDS_GPIO_REGISTER=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_GPIO_PLATFORM=y
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_TRIGGERS=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_MORSE is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_USBDEV is not set
# CONFIG_NFC_DEVICES is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_MXC is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_RTC7301 is not set

#
# on-CPU RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_DW_DMAC is not set
# CONFIG_TIMB_DMA is not set
CONFIG_IMX_SDMA=y
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
# CONFIG_NET_DMA is not set
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_PDRV is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_STAGING=y
# CONFIG_USBIP_CORE is not set
# CONFIG_ECHO is not set
# CONFIG_BRCMUTIL is not set
# CONFIG_ASUS_OLED is not set
# CONFIG_TRANZPORT is not set
# CONFIG_POHMELFS is not set
CONFIG_IIO=y
# CONFIG_IIO_RING_BUFFER is not set
# CONFIG_IIO_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16204 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADIS16220 is not set
# CONFIG_ADIS16240 is not set
# CONFIG_KXSD9 is not set
# CONFIG_LIS3L02DQ is not set

#
# Analog to digital convertors
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7314 is not set
# CONFIG_AD7606 is not set
# CONFIG_AD799X is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7745 is not set
# CONFIG_AD7816 is not set
# CONFIG_ADT75 is not set
# CONFIG_ADT7310 is not set
# CONFIG_ADT7410 is not set
# CONFIG_MAX1363 is not set
CONFIG_ADC128S022=y

#
# Analog digital bi-direction convertors
#
# CONFIG_ADT7316 is not set

#
# Digital to analog convertors
#
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5791 is not set
# CONFIG_MAX517 is not set

#
# Direct Digital Synthesis
#
# CONFIG_AD5930 is not set
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# CONFIG_AD9850 is not set
# CONFIG_AD9852 is not set
# CONFIG_AD9910 is not set
# CONFIG_AD9951 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set

#
# Light sensors
#
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set

#
# Magnetometer sensors
#
# CONFIG_SENSORS_AK8975 is not set
# CONFIG_SENSORS_HMC5843 is not set

#
# Active energy metering IC
#
# CONFIG_ADE7753 is not set
# CONFIG_ADE7754 is not set
# CONFIG_ADE7758 is not set
# CONFIG_ADE7759 is not set
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S120X is not set
# CONFIG_AD2S1210 is not set

#
# Triggers - standalone
#
# CONFIG_XVMALLOC is not set
# CONFIG_ZRAM is not set
CONFIG_MACH_NO_WESTBRIDGE=y
# CONFIG_USB_ENESTORAGE is not set
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_CLEARPAD_TM1217 is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_USE_COMMON_STRUCT_CLK=y
# CONFIG_CLK_DEBUG is not set
CONFIG_USE_COMMON_CLK_DIVIDER=y
CONFIG_USE_COMMON_CLK_MUX=y
CONFIG_USE_COMMON_CLK_GATE=y
CONFIG_CLKSRC_MMIO=y

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAYFS_FS=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_YAFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_LZMA is not set
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_RUBIN=y
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=y
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_DEBUG=y
# CONFIG_LOGFS is not set
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_V4_1 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFS_USE_NEW_IDMAPPER is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=7
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
# CONFIG_MAGIC_SYSRQ_FORCE_PRINTK is not set
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
CONFIG_SPARSE_RCU_POINTER=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
CONFIG_FRAME_POINTER=y
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_CPU_STALL_VERBOSE=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_STRICT_DEVMEM is not set
# CONFIG_ARM_UNWIND is not set
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_LL is not set
# CONFIG_OC_ETM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
# CONFIG_CRYPTO_AEAD is not set
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_ZLIB is not set
CONFIG_CRYPTO_LZO=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_HW=y

#
# OCF Configuration
#
# CONFIG_OCF_OCF is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC7=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_DECOMPRESS_GZIP=y
# CONFIG_TEXTSEARCH is not set
# CONFIG_TEXTSEARCH_KMP is not set
# CONFIG_TEXTSEARCH_BM is not set
# CONFIG_TEXTSEARCH_FSM is not set
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
CONFIG_AVERAGE=y

--------------080309060803060502020209--
