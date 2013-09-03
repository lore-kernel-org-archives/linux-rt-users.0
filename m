From: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>
Subject: RE: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free
  already-free IRQ 1"
Date: Tue, 3 Sep 2013 09:09:51 +0000
Message-ID: <EBD2DE4ADA47B94E831AED12A4B0CADA67E9605D@edb1.wapice.localdomain>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
 <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "linux-rt-users@langfinger.org" <linux-rt-users@langfinger.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wapice.fi ([81.209.51.2]:39633 "EHLO brando.wapice.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755399Ab3ICJJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Sep 2013 05:09:57 -0400
In-Reply-To: <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Michael,

Thank you for the boot logs. The warnings seem very similar to the ones=
 we are seeing, so it is probably the same issue.

I am sorry to hear that the patch I sent earlier did not solve your pro=
blem. But as a matter of fact, it did not solve our problems completely=
 either. Now that I enabled CONFIG_HIGH_RES_TIMERS the boot hang issue =
is back. So, the 3.10.10-rt7 kernel boots with CONFIG_ATMEL_TCB_CLKSRC =
set, but if I also enabled the high resolution timers the boot hangs (I=
 did not change any other setting in menuconfig). The 3.6.9-rt21 kernel=
 works with similar config just fine apart from the two boot warnings. =
I also did rt-tests with the 3.6.9-rt21 kernel, and I did not find anyt=
hing abnormal.

I have attached boot logs for both the working 3.6.9-rt21 and the broke=
n 3.10.10-rt7 kernels (I removed some unrelated product specific detail=
s from log). The 3.10.10-rt7 has the patch I sent earlier applied. I al=
so noticed that when the clock source is changed to tcb_clksrc the prin=
tk timestamps are not incremented anymore (see 3.10.10-rt7 bootlog).

If anyone has any ideas about what could be causing these issues, I wou=
ld be happy to hear all the ideas.

BR,
Sami Pietik=E4inen


3.10.10-rt7 broken kernel - bootlog
--------------------------------------------
## Booting kernel from Legacy Image at 22000000 ...
   Image Name:   Linux-3.10.10-rt7-custom
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2566432 Bytes =3D 2.4 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.10.10-rt7-custom (gcc version 4.7.2 (GCC=
) ) #4 PREEMPT RT Mon Sep 2 14:20:21 EEST 2013
[    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
[    0.000000] Machine: Atmel SAMA5 (Device Tree), model: Atmel SAMA5D3=
5-EK
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AT91: Detected soc type: sama5d3
[    0.000000] AT91: Detected soc subtype: sama5d35
[    0.000000] AT91: sram at 0x300000 of 0x20000 mapped at 0xfef58000
[    0.000000] DT missing boot CPU MPIDR[23:0], fall back to default cp=
u_logical_map
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] Clocks: CPU 528 MHz, master 132 MHz, main 12.000 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 130048
[    0.000000] Kernel command line: console=3DttyS0,115200 loglevel=3D7=
 rootfstype=3Dubifs ubi.mtd=3D4 root=3Dubi0:rootfs mtdparts=3D(removed)
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 512MB =3D 512MB total
[    0.000000] Memory: 514692k/514692k available, 9596k reserved, 0K hi=
ghmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0469da0   (4488 kB)
[    0.000000]       .init : 0xc046a000 - 0xc048ca04   ( 139 kB)
[    0.000000]       .data : 0xc048e000 - 0xc04bd160   ( 189 kB)
[    0.000000]        .bss : 0xc04bd160 - 0xc04dd518   ( 129 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at linux-yocto-rt/3.10.10-rt7-r0/linux/kernel/i=
rq/manage.c:1341 __free_irq+0x98/0x1bc()
[    0.000000] Trying to free already-free IRQ 1
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.10-rt7-cust=
om #4
[    0.000000] [<c0011b18>] (unwind_backtrace+0x0/0xf8) from [<c0010610=
>] (show_stack+0x10/0x14)
[    0.000000] [<c0010610>] (show_stack+0x10/0x14) from [<c00198b4>] (w=
arn_slowpath_common+0x4c/0x68)
[    0.000000] [<c00198b4>] (warn_slowpath_common+0x4c/0x68) from [<c00=
19964>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c0019964>] (warn_slowpath_fmt+0x30/0x40) from [<c0053f=
fc>] (__free_irq+0x98/0x1bc)
[    0.000000] [<c0053ffc>] (__free_irq+0x98/0x1bc) from [<c0048ed0>] (=
clockevents_set_mode+0x28/0x5c)
[    0.000000] [<c0048ed0>] (clockevents_set_mode+0x28/0x5c) from [<c00=
48f14>] (clockevents_shutdown+0x10/0x20)
[    0.000000] [<c0048f14>] (clockevents_shutdown+0x10/0x20) from [<c00=
49228>] (clockevents_exchange_device+0x6c/0x7c)
[    0.000000] [<c0049228>] (clockevents_exchange_device+0x6c/0x7c) fro=
m [<c0049658>] (tick_notify+0x158/0x308)
[    0.000000] [<c0049658>] (tick_notify+0x158/0x308) from [<c003a790>]=
 (notifier_call_chain+0x44/0x84)
[    0.000000] [<c003a790>] (notifier_call_chain+0x44/0x84) from [<c003=
a88c>] (raw_notifier_call_chain+0x18/0x20)
[    0.000000] [<c003a88c>] (raw_notifier_call_chain+0x18/0x20) from [<=
c0048de4>] (clockevents_register_device+0x60/0x124)
[    0.000000] [<c0048de4>] (clockevents_register_device+0x60/0x124) fr=
om [<c046caa4>] (time_init+0x1c/0x28)
[    0.000000] [<c046caa4>] (time_init+0x1c/0x28) from [<c046a8b4>] (st=
art_kernel+0x19c/0x28c)
[    0.000000] [<c046a8b4>] (start_kernel+0x19c/0x28c) from [<20008070>=
] (0x20008070)
[    0.000000] ---[ end trace 0000000000000001 ]---
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, w=
raps every 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[    0.070000] Calibrating delay loop... 262.96 BogoMIPS (lpj=3D1314816=
)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.070000] CPU: Testing write buffer coherency: ok
[    0.080000] Setting up static identity map for 0xc034d6e0 - 0xc034d7=
14
[    0.080000] devtmpfs: initialized
[    0.080000] pinctrl core: initialized pinctrl subsystem
[    0.080000] NET: Registered protocol family 16
[    0.080000] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.110000] gpio-at91 fffff200.gpio: at address fefff200
[    0.110000] gpio-at91 fffff400.gpio: at address fefff400
[    0.110000] gpio-at91 fffff600.gpio: at address fefff600
[    0.120000] gpio-at91 fffff800.gpio: at address fefff800
[    0.120000] gpio-at91 fffffa00.gpio: at address fefffa00
[    0.120000] pinctrl-at91 pinctrl.2: initialized AT91 pinctrl driver
[    0.120000] ------------[ cut here ]------------
[    0.120000] WARNING: at linux-yocto-rt/3.10.10-rt7-r0/linux/kernel/i=
rq/manage.c:1341 __free_irq+0x98/0x1bc()
[    0.120000] Trying to free already-free IRQ 1
[    0.120000] Modules linked in:
[    0.120000] CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.10.=
10-rt7-custom #4
[    0.120000] [<c0011b18>] (unwind_backtrace+0x0/0xf8) from [<c0010610=
>] (show_stack+0x10/0x14)
[    0.120000] [<c0010610>] (show_stack+0x10/0x14) from [<c00198b4>] (w=
arn_slowpath_common+0x4c/0x68)
[    0.120000] [<c00198b4>] (warn_slowpath_common+0x4c/0x68) from [<c00=
19964>] (warn_slowpath_fmt+0x30/0x40)
[    0.120000] [<c0019964>] (warn_slowpath_fmt+0x30/0x40) from [<c0053f=
fc>] (__free_irq+0x98/0x1bc)
[    0.120000] [<c0053ffc>] (__free_irq+0x98/0x1bc) from [<c0048ed0>] (=
clockevents_set_mode+0x28/0x5c)
[    0.120000] [<c0048ed0>] (clockevents_set_mode+0x28/0x5c) from [<c00=
491e0>] (clockevents_exchange_device+0x24/0x7c)
[    0.120000] [<c00491e0>] (clockevents_exchange_device+0x24/0x7c) fro=
m [<c0049658>] (tick_notify+0x158/0x308)
[    0.120000] [<c0049658>] (tick_notify+0x158/0x308) from [<c003a790>]=
 (notifier_call_chain+0x44/0x84)
[    0.120000] [<c003a790>] (notifier_call_chain+0x44/0x84) from [<c003=
a88c>] (raw_notifier_call_chain+0x18/0x20)
[    0.120000] [<c003a88c>] (raw_notifier_call_chain+0x18/0x20) from [<=
c0048de4>] (clockevents_register_device+0x60/0x124)
[    0.120000] [<c0048de4>] (clockevents_register_device+0x60/0x124) fr=
om [<c047f524>] (tcb_clksrc_init+0x20c/0x248)
[    0.120000] [<c047f524>] (tcb_clksrc_init+0x20c/0x248) from [<c00087=
14>] (do_one_initcall+0xec/0x14c)
[    0.120000] [<c0008714>] (do_one_initcall+0xec/0x14c) from [<c046aa8=
c>] (kernel_init_freeable+0xe8/0x1ac)
[    0.120000] [<c046aa8c>] (kernel_init_freeable+0xe8/0x1ac) from [<c0=
34643c>] (kernel_init+0x8/0xe4)
[    0.120000] [<c034643c>] (kernel_init+0x8/0xe4) from [<c000e198>] (r=
et_from_fork+0x14/0x3c)
[    0.120000] ---[ end trace 0000000000000002 ]---
[    0.160000] bio: create slab <bio-0> at 0
[    0.160000] at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controll=
er ( cpy slave ), 8 channels
[    0.170000] at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controll=
er ( cpy slave ), 8 channels
[    0.180000] SCSI subsystem initialized
[    0.180000] usbcore: registered new interface driver usbfs
[    0.180000] usbcore: registered new interface driver hub
[    0.180000] usbcore: registered new device driver usb
[    0.180000] at91_i2c f0018000.i2c: using dma0chan0 (tx) and dma0chan=
1 (rx) for DMA transfers
[    0.180000] at91_i2c f0018000.i2c: AT91 i2c bus driver.
[    0.190000] cfg80211: Calling CRDA to update world regulatory domain
[    0.190000] Switching to clocksource tcb_clksrc
[    0.200000] NET: Registered protocol family 2
[    0.200000] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.200000] TCP bind hash table entries: 4096 (order: 4, 98304 bytes=
)
[    0.200000] TCP: Hash tables configured (established 4096 bind 4096)
[    0.200000] TCP: reno registered
[    0.200000] UDP hash table entries: 256 (order: 2, 16384 bytes)
[    0.200000] UDP-Lite hash table entries: 256 (order: 2, 16384 bytes)
[    0.200000] NET: Registered protocol family 1
[    0.200000] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red =
Hat, Inc.
[    0.200000] msgmni has been set to 1005
[    0.200000] io scheduler noop registered (default)
[    0.200000] f0020000.serial: ttyS2 at MMIO 0xf0020000 (irq =3D 22) i=
s a ATMEL_SERIAL
[    0.200000] ffffee00.serial: ttyS0 at MMIO 0xffffee00 (irq =3D 35) i=
s a ATMEL_SERIAL
[    0.200000] console [ttyS0] enabled
[    0.200000] brd: module loaded
[    0.200000] loop: module loaded
[    0.200000] atmel_nand: Use On Flash BBT
[    0.200000] atmel_nand 60000000.nand: No DMA support for NAND access=
=2E
[    0.200000] ONFI param page 0 valid
[    0.200000] ONFI flash detected
[    0.200000] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micro=
n MT29F2G08ABAEAWP), 256MiB, page size: 2048, OOB size: 64
[    0.200000] atmel_nand 60000000.nand: ONFI params, minimum required =
ECC: 4 bits in 512 bytes
[    0.200000] atmel_nand 60000000.nand: Initialize PMECC params, cap: =
4, sector: 512
[    0.200000] Bad block table found at page 131008, version 0x01
[    0.200000] Bad block table found at page 130944, version 0x01
[    0.200000] 8 cmdlinepart partitions found on MTD device atmel_nand
[    0.200000] Creating 8 MTD partitions on "atmel_nand":
(mtd parts removed)
[    0.200000] CAN device driver interface
[    0.200000] at91_can f000c000.can: device registered (reg_base=3De08=
c6000, irq=3D19)
[    0.200000] at91_can f8010000.can: device registered (reg_base=3De08=
c8000, irq=3D26)
[    0.200000] macb f0028000.ethernet (unregistered net_device): invali=
d hw address, using random
[    0.200000] libphy: MACB_mii_bus: probed
[    0.200000] macb f0028000.ethernet eth0: Cadence GEM at 0xf0028000 i=
rq 23 (fe:bc:54:42:20:93)
[    0.200000] macb f0028000.ethernet eth0: attached PHY driver [Micrel=
 KSZ9021 Gigabit PHY] (mii_bus:phy_addr=3Df0028000.etherne:01, irq=3D-1=
)
[    0.200000] libphy: MACB_mii_bus: probed
[    0.200000] macb f802c000.ethernet eth1: Cadence MACB at 0xf802c000 =
irq 29 (76:db:c9:81:54:98)
[    0.200000] macb f802c000.ethernet eth1: attached PHY driver [Micrel=
 KSZ8031] (mii_bus:phy_addr=3Df802c000.etherne:00, irq=3D-1)
[    0.200000] PPP generic driver version 2.4.2
[    0.200000] PPP BSD Compression module registered
[    0.200000] PPP Deflate Compression module registered
[    0.200000] NET: Registered protocol family 24
[    0.200000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    0.200000] ehci-atmel: EHCI Atmel driver
[    0.200000] atmel-ehci 700000.ehci: EHCI Host Controller
[    0.200000] atmel-ehci 700000.ehci: new USB bus registered, assigned=
 bus number 1
[    0.200000] atmel-ehci 700000.ehci: irq 43, io mem 0x00700000
Boot hangs here (the ehci is not the problem, boot hangs even if I disa=
ble the USB completely)...


3.6.9-rt21 working kernel - bootlog
--------------------------------------------
## Booting kernel from Legacy Image at 22000000 ...
   Image Name:   Linux-3.6.9-rt21-custom
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2428382 Bytes =3D 2.3 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.9-rt21-custom (gcc version 4.7.2 (GCC)=
 ) #1 PREEMPT RT Mon Sep 2 15:09:34 EEST 2013
[    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
[    0.000000] Machine: Atmel SAMA5 (Device Tree)
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AT91: Detected soc type: sama5d3
[    0.000000] AT91: Detected soc subtype: sama5d35
[    0.000000] AT91: sram at 0x300000 of 0x20000 mapped at 0xfef58000
[    0.000000] Clocks: CPU 528 MHz, master 132 MHz, main 12.000 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 130048
[    0.000000] Kernel command line: console=3DttyS0,115200 loglevel=3D7=
 rootfstype=3Dubifs ubi.mtd=3D4 root=3Drootfs mtdparts=3D(removed)
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 512MB =3D 512MB total
[    0.000000] Memory: 515008k/515008k available, 9280k reserved, 0K hi=
ghmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc042c8a8   (4243 kB)
[    0.000000]       .init : 0xc042d000 - 0xc0450544   ( 142 kB)
[    0.000000]       .data : 0xc0452000 - 0xc047de98   ( 176 kB)
[    0.000000]        .bss : 0xc047debc - 0xc048fb00   (  72 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at linux-yocto-rt/3.6.9-rt21+linux4sam_4.0-r1/l=
inux/kernel/irq/manage.c:1230 __free_irq+0x9c/0x1c8()
[    0.000000] Trying to free already-free IRQ 1
[    0.000000] Modules linked in:
[    0.000000] [<c0012114>] (unwind_backtrace+0x0/0xf8) from [<c0019518=
>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c0019518>] (warn_slowpath_common+0x4c/0x64) from [<c00=
195c4>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c00195c4>] (warn_slowpath_fmt+0x30/0x40) from [<c00510=
60>] (__free_irq+0x9c/0x1c8)
[    0.000000] [<c0051060>] (__free_irq+0x9c/0x1c8) from [<c00464b0>] (=
clockevents_set_mode+0x28/0x5c)
[    0.000000] [<c00464b0>] (clockevents_set_mode+0x28/0x5c) from [<c00=
464f4>] (clockevents_shutdown+0x10/0x20)
[    0.000000] [<c00464f4>] (clockevents_shutdown+0x10/0x20) from [<c00=
46814>] (clockevents_exchange_device+0x6c/0x7c)
[    0.000000] [<c0046814>] (clockevents_exchange_device+0x6c/0x7c) fro=
m [<c0046ba4>] (tick_notify+0x140/0x2fc)
[    0.000000] [<c0046ba4>] (tick_notify+0x140/0x2fc) from [<c0038fd0>]=
 (notifier_call_chain+0x44/0x84)
[    0.000000] [<c0038fd0>] (notifier_call_chain+0x44/0x84) from [<c003=
90cc>] (raw_notifier_call_chain+0x18/0x20)
[    0.000000] [<c00390cc>] (raw_notifier_call_chain+0x18/0x20) from [<=
c00463f0>] (clockevents_register_device+0x74/0x10c)
[    0.000000] [<c00463f0>] (clockevents_register_device+0x74/0x10c) fr=
om [<c0431038>] (time_init+0x20/0x30)
[    0.000000] [<c0431038>] (time_init+0x20/0x30) from [<c042d65c>] (st=
art_kernel+0x1a4/0x2dc)
[    0.000000] [<c042d65c>] (start_kernel+0x1a4/0x2dc) from [<20008040>=
] (0x20008040)
[    0.000000] ---[ end trace 0000000000000001 ]---
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, w=
raps every 4294967286ms
[    0.000000] Console: colour dummy device 80x30
[    0.070000] Calibrating delay loop... 262.96 BogoMIPS (lpj=3D1314816=
)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 512
[    0.070000] CPU: Testing write buffer coherency: ok
[    0.070000] Setting up static identity map for 0x2031d910 - 0x2031d9=
44
[    0.080000] devtmpfs: initialized
[    0.080000] pinctrl core: initialized pinctrl subsystem
[    0.080000] NET: Registered protocol family 16
[    0.080000] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.080000] AT91: error -22 while looking for mb-rev property, let a=
ssume we are using the latest one
[    0.110000] gpio-at91 fffff200.gpio: at address fefff200
[    0.110000] gpio-at91 fffff400.gpio: at address fefff400
[    0.110000] gpio-at91 fffff600.gpio: at address fefff600
[    0.110000] gpio-at91 fffff800.gpio: at address fefff800
[    0.110000] gpio-at91 fffffa00.gpio: at address fefffa00
[    0.110000] pinctrl-at91 pinctrl.2: initialized AT91 pinctrl driver
[    0.120000] ------------[ cut here ]------------
[    0.120000] WARNING: at linux-yocto-rt/3.6.9-rt21+linux4sam_4.0-r1/l=
inux/kernel/irq/manage.c:1230 __free_irq+0x9c/0x1c8()
[    0.120000] Trying to free already-free IRQ 1
[    0.120000] Modules linked in:
[    0.120000] [<c0012114>] (unwind_backtrace+0x0/0xf8) from [<c0019518=
>] (warn_slowpath_common+0x4c/0x64)
[    0.120000] [<c0019518>] (warn_slowpath_common+0x4c/0x64) from [<c00=
195c4>] (warn_slowpath_fmt+0x30/0x40)
[    0.120000] [<c00195c4>] (warn_slowpath_fmt+0x30/0x40) from [<c00510=
60>] (__free_irq+0x9c/0x1c8)
[    0.120000] [<c0051060>] (__free_irq+0x9c/0x1c8) from [<c00464b0>] (=
clockevents_set_mode+0x28/0x5c)
[    0.120000] [<c00464b0>] (clockevents_set_mode+0x28/0x5c) from [<c00=
467cc>] (clockevents_exchange_device+0x24/0x7c)
[    0.120000] [<c00467cc>] (clockevents_exchange_device+0x24/0x7c) fro=
m [<c0046ba4>] (tick_notify+0x140/0x2fc)
[    0.120000] [<c0046ba4>] (tick_notify+0x140/0x2fc) from [<c0038fd0>]=
 (notifier_call_chain+0x44/0x84)
[    0.120000] [<c0038fd0>] (notifier_call_chain+0x44/0x84) from [<c003=
90cc>] (raw_notifier_call_chain+0x18/0x20)
[    0.120000] [<c00390cc>] (raw_notifier_call_chain+0x18/0x20) from [<=
c00463f0>] (clockevents_register_device+0x74/0x10c)
[    0.120000] [<c00463f0>] (clockevents_register_device+0x74/0x10c) fr=
om [<c04435f4>] (tcb_clksrc_init+0x290/0x2cc)
[    0.120000] [<c04435f4>] (tcb_clksrc_init+0x290/0x2cc) from [<c00086=
d0>] (do_one_initcall+0x10c/0x170)
[    0.120000] [<c00086d0>] (do_one_initcall+0x10c/0x170) from [<c042d8=
7c>] (kernel_init+0xe8/0x1a4)
[    0.120000] [<c042d87c>] (kernel_init+0xe8/0x1a4) from [<c000ea30>] =
(kernel_thread_exit+0x0/0x8)
[    0.120000] ---[ end trace 0000000000000002 ]---
[    0.150000] bio: create slab <bio-0> at 0
[    0.150000] at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controll=
er ( cpy slave ), 8 channels
[    0.160000] at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controll=
er ( cpy slave ), 8 channels
[    0.160000] SCSI subsystem initialized
[    0.170000] usbcore: registered new interface driver usbfs
[    0.170000] usbcore: registered new interface driver hub
[    0.170000] usbcore: registered new device driver usb
[    0.170000] at91_i2c f0018000.i2c: using dma0chan0 (tx) and dma0chan=
1 (rx) for DMA transfers
[    0.170000] at91_i2c f0018000.i2c: AT91 i2c bus driver.
[    0.180000] cfg80211: Calling CRDA to update world regulatory domain
[    0.180000] Switching to clocksource tcb_clksrc
[    0.230000] NET: Registered protocol family 2
[    0.230000] TCP established hash table entries: 16384 (order: 5, 131=
072 bytes)
[    0.230000] TCP bind hash table entries: 16384 (order: 6, 393216 byt=
es)
[    0.230000] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.230000] TCP: reno registered
[    0.230000] UDP hash table entries: 256 (order: 2, 16384 bytes)
[    0.230000] UDP-Lite hash table entries: 256 (order: 2, 16384 bytes)
[    0.230000] NET: Registered protocol family 1
[    0.240000] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red =
Hat, Inc.
[    0.240000] msgmni has been set to 1005
[    0.240000] io scheduler noop registered (default)
[    0.250000] f0020000.serial: ttyS2 at MMIO 0xf0020000 (irq =3D 22) i=
s a ATMEL_SERIAL
[    0.250000] ffffee00.serial: ttyS0 at MMIO 0xffffee00 (irq =3D 35) i=
s a ATMEL_SERIAL
[    1.000000] console [ttyS0] enabled
[    1.020000] brd: module loaded
[    1.030000] loop: module loaded
[    1.040000] atmel_nand 60000000.nand: Using NFC
[    1.050000] atmel_nand: Use On Flash BBT
[    1.050000] atmel_nand 60000000.nand: Using dma0chan2 for DMA transf=
ers.
[    1.060000] ONFI param page 0 valid
[    1.060000] ONFI flash detected
[    1.070000] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micro=
n MT29F2G08ABAEAWP), page size: 2048, OOB size: 64
[    1.080000] ONFI params, minimum required ECC: 4
[    1.080000] atmel_nand 60000000.nand: Initialize PMECC params, cap: =
4, sector: 512
[    1.090000] atmel_nand 60000000.nand: Using NFC Sram
[    1.090000] Bad block table found at page 131008, version 0x01
[    1.100000] Bad block table found at page 130944, version 0x01
[    1.110000] 8 cmdlinepart partitions found on MTD device atmel_nand
[    1.110000] Creating 8 MTD partitions on "atmel_nand":
(mtd parts removed)
[    1.190000] UBI: attaching mtd4 to ubi0
[    1.190000] UBI: physical eraseblock size:   131072 bytes (128 KiB)
[    1.200000] UBI: logical eraseblock size:    126976 bytes
[    1.200000] UBI: smallest flash I/O unit:    2048
[    1.210000] UBI: VID header offset:          2048 (aligned 2048)
[    1.210000] UBI: data offset:                4096
[    1.320000] UBI: max. sequence number:       2
[    1.330000] UBI: attached mtd4 to ubi0
[    1.340000] UBI: MTD device name:            "root"
[    1.340000] UBI: MTD device size:            25 MiB
[    1.350000] UBI: number of good PEBs:        200
[    1.350000] UBI: number of bad PEBs:         0
[    1.360000] UBI: number of corrupted PEBs:   0
[    1.360000] UBI: max. allowed volumes:       128
[    1.370000] UBI: wear-leveling threshold:    4096
[    1.370000] UBI: number of internal volumes: 1
[    1.380000] UBI: number of user volumes:     1
[    1.380000] UBI: available PEBs:             0
[    1.380000] UBI: total number of reserved PEBs: 200
[    1.390000] UBI: number of PEBs reserved for bad PEB handling: 4
[    1.400000] UBI: max/mean erase counter: 1/0
[    1.400000] UBI: image sequence number:  435869262
[    1.400000] UBI: background thread "ubi_bgt0d" started, PID 398
[    1.410000] atmel_spi f0004000.spi: Using dma0chan3 (tx) and  dma0ch=
an4 (rx) for DMA transfers
[    1.410000] atmel_spi f0004000.spi: Atmel SPI Controller at 0xf00040=
00 (irq 18)
[    1.410000] atmel_spi f0004000.spi: master is unqueued, this is depr=
ecated
[    1.410000] m25p80 spi32766.0: at25df321a (4096 Kbytes)
[    1.420000] macb f0028000.ethernet: (unregistered net_device): inval=
id hw address, using random
[    1.430000] libphy: MACB_mii_bus: probed
[    1.430000] macb f0028000.ethernet: eth0: Cadence GEM at 0xf0028000 =
irq 23 (86:e5:f2:bd:a1:7d)
[    1.430000] macb f0028000.ethernet: eth0: attached PHY driver [Micre=
l KSZ9021 Gigabit PHY] (mii_bus:phy_addr=3Df0028000.etherne:01, irq=3D-=
1)
[    1.450000] libphy: MACB_mii_bus: probed
[    1.450000] macb f802c000.ethernet: eth1: Cadence MACB at 0xf802c000=
 irq 29 (76:db:c9:81:54:98)
[    1.450000] macb f802c000.ethernet: eth1: attached PHY driver [Micre=
l KSZ8051] (mii_bus:phy_addr=3Df802c000.etherne:00, irq=3D-1)
[    1.450000] PPP generic driver version 2.4.2
[    1.450000] PPP BSD Compression module registered
[    1.450000] PPP Deflate Compression module registered
[    1.450000] NET: Registered protocol family 24
[    1.450000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    1.450000] atmel-ehci 700000.ehci: Atmel EHCI UHP HS
[    1.450000] atmel-ehci 700000.ehci: new USB bus registered, assigned=
 bus number 1
[    1.450000] atmel-ehci 700000.ehci: irq 43, io mem 0x00700000
[    1.470000] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    1.470000] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    1.470000] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.470000] usb usb1: Product: Atmel EHCI UHP HS
[    1.470000] usb usb1: Manufacturer: Linux 3.6.9-rt21-custom ehci_hcd
[    1.470000] usb usb1: SerialNumber: 700000.ehci
[    1.480000] hub 1-0:1.0: USB hub found
[    1.480000] hub 1-0:1.0: 3 ports detected
[    1.480000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.480000] at91_ohci 600000.ohci: AT91 OHCI
[    1.480000] at91_ohci 600000.ohci: new USB bus registered, assigned =
bus number 2
[    1.480000] at91_ohci 600000.ohci: irq 43, io mem 0x00600000
[    1.540000] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0001
[    1.540000] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.540000] usb usb2: Product: AT91 OHCI
[    1.540000] usb usb2: Manufacturer: Linux 3.6.9-rt21-custom ohci_hcd
[    1.540000] usb usb2: SerialNumber: at91
[    1.550000] hub 2-0:1.0: USB hub found
[    1.550000] hub 2-0:1.0: 3 ports detected
[    1.550000] usbcore: registered new interface driver cdc_acm
[    1.550000] cdc_acm: USB Abstract Control Model driver for USB modem=
s and ISDN adapters
[    1.550000] Initializing USB Mass Storage driver...
[    1.550000] usbcore: registered new interface driver usb-storage
[    1.550000] USB Mass Storage support registered.
[    1.550000] at91_rtc fffffeb0.rtc: rtc core: registered fffffeb0.rtc=
 as rtc0
[    1.550000] AT91 Real Time Clock driver.
[    1.550000] i2c /dev entries driver
[    1.560000] at91sam9_wdt: enabled (heartbeat=3D30 sec, nowayout=3D0)
[    1.560000] usbcore: registered new interface driver usbhid
[    1.560000] usbhid: USB HID core driver
[    1.560000] iio iio:device0: Resolution used: 12 bits
[    1.560000] TCP: cubic registered
[    1.560000] NET: Registered protocol family 10
[    1.580000] sit: IPv6 over IPv4 tunneling driver
[    1.580000] NET: Registered protocol family 17
[    1.580000] lib80211: common routines for IEEE802.11 drivers
[    1.580000] VFP support v0.3: implementor 41 architecture 2 part 30 =
variant 5 rev 1
[    1.580000] input: gpio_keys.4 as /devices/gpio_keys.4/input/input0
[    1.580000] at91_rtc fffffeb0.rtc: setting system clock to 2013-09-0=
3 07:24:34 UTC (1378193074)
[    1.580000] atmel_mci f0000000.mmc: version: 0x505
[    1.580000] atmel_mci f0000000.mmc: using dma0chan5 for DMA transfer=
s
[    1.650000] atmel_mci f0000000.mmc: Atmel MCI controller at 0xf00000=
00 irq 17, 1 slots
[    1.650000] atmel_mci f8000000.mmc: version: 0x505
[    1.650000] atmel_mci f8000000.mmc: using dma1chan0 for DMA transfer=
s
[    1.700000] atmel_mci f8000000.mmc: Atmel MCI controller at 0xf80000=
00 irq 25, 1 slots
[    1.700000] atmel_aes f8038000.aes: version: 0x135
[    1.710000] atmel_aes f8038000.aes: Atmel AES
[    1.710000] atmel_tdes f803c000.tdes: version: 0x701
[    1.720000] atmel_tdes f803c000.tdes: Atmel DES/TDES
[    1.720000] atmel_sha f8034000.sha: version: 0x410
[    1.720000] atmel_sha f8034000.sha: Atmel SHA1/SHA256
[    1.950000] UBIFS: mounted UBI device 0, volume 0, name "rootfs"
[    1.960000] UBIFS: mounted read-only
[    1.960000] UBIFS: file system size:   22982656 bytes (22444 KiB, 21=
 MiB, 181 LEBs)
[    1.970000] UBIFS: journal size:       9023488 bytes (8812 KiB, 8 Mi=
B, 72 LEBs)
[    1.980000] UBIFS: media format:       w4/r0 (latest is w4/r0)
[    1.980000] UBIFS: default compressor: lzo
[    1.990000] UBIFS: reserved for root:  0 bytes (0 KiB)
[    1.990000] VFS: Mounted root (ubifs filesystem) readonly on device =
0:11.
[    2.000000] devtmpfs: mounted
[    2.010000] Freeing init memory: 140K

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
