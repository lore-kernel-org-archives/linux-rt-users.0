From: Michael Langfinger <linux-rt-users@langfinger.org>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free  already-free IRQ 1"
Date: Sun, 01 Sep 2013 12:40:07 +0200
Message-ID: <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
Reply-To: linux-rt-users@langfinger.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: =?UTF-8?Q?Sami_Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from server03.mc0.hosteurope.de ([92.51.170.74]:54179 "EHLO
	server03.mc0.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757439Ab3IAKkN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Sep 2013 06:40:13 -0400
In-Reply-To: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hello Sami,

 first of all, thanks for your support and thanks for the patch.=20
 Unfortunately, the boot process still hangs, although there seems to b=
e=20
 some kind of progress (the SD/MMC card is detected, which was not the=20
 case before - so the kernel seems to crash later).

 I attached the output of the serial console. The first output is from =
a=20
 kernel that was configured with full RT support=20
 (CONFIG_PREEMPT_RT_FULL), the second one with basic RT support=20
 (CONFIG_PREEMPT_RTB).

 Further information that might be interesting:

 - kernel configuration: I use the default configuration for the ARIA=20
 G25 (http://www.acmesystems.it/aria), which is available under=20
 https://github.com/tanzilli/linux-3.10, as basis for my custom kernel=20
 configuration. The only change that I made was to add support for the=20
 rtl8187 chipset (as a module).
 - Device tree structure files: I have to use at91-ariag25.dts /=20
 at91sam9x5.dtsi from the kernel from the github repository mentioned=20
 above, because otherwise even the regular kernel 3.10.9 crashes with a=
=20
 kernel panic. I haven't looked deeper into this problem, because the=20
 release candidate versions of kernel 3.11 boot fine with the DTS files=
=20
 that are delivered with them and I plan to switch to kernel 3.11 as so=
on=20
 as it is released, anyway.

 I attached the output of the boot process (with your patch applied)=20
 below. The first one is from kernel 3.10.9-rt5 with=20
 CONFIG_PREEMPT_RT_FULL set, the second one is from kernel 3.10.9-rt5=20
 with CONFIG_PREEMPT_RTB.

 If you need any further information, please let me know!

 Kind regards,
 Michael Langfinger


 CONFIG_PREEMPT_RT_FULL:
 Starting linux kernel ..., machid: 0x1035
=20
 Uncompressing Linux... done, booting the kernel.
 Booting Linux on physical CPU 0x0
 Linux version 3.10.9-rt5 (mitarbeiter@ariag25-dev) (gcc version 4.7.3=20
 (Ubuntu/L3
 CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
 CPU: VIVT data cache, VIVT instruction cache
 Machine: Atmel AT91SAM (Device Tree), model: Acme Systems Aria G25
 Memory policy: ECC disabled, Data cache writeback
 AT91: Detected soc type: at91sam9x5
 AT91: Detected soc subtype: at91sam9g25
 AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
 DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
 Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
 Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=20
 65024
 Kernel command line: mem=3D256M console=3DttyS0,115200 root=3D/dev/mmc=
blk0p2=20
 rootfsty1
 PID hash table entries: 1024 (order: 0, 4096 bytes)
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
 Memory: 256MB =3D 256MB total
 Memory: 254852k/254852k available, 7292k reserved, 0K highmem
 Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc044f5e8   (4382 kB)
       .init : 0xc0450000 - 0xc04768fc   ( 155 kB)
       .data : 0xc0478000 - 0xc04a9740   ( 198 kB)
        .bss : 0xc04a9740 - 0xc04d5858   ( 177 kB)
 SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
 Preemptible hierarchical RCU implementation.
 NR_IRQS:16 nr_irqs:16 16
 ------------[ cut here ]------------
 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.9-rt5 #4
 [<c000cffc>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c001550c>]=20
 (warn_slowpath_common+0x4)
 [<c001550c>] (warn_slowpath_common+0x4c/0x68) from [<c00155a8>]=20
 (warn_slowpath_)
 [<c00155a8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004f84c>]=20
 (__free_irq+0x90/0)
 [<c004f84c>] (__free_irq+0x90/0x1a8) from [<c0043d18>]=20
 (clockevents_set_mode+0x)
 [<c0043d18>] (clockevents_set_mode+0x28/0x5c) from [<c0043d5c>]=20
 (clockevents_sh)
 [<c0043d5c>] (clockevents_shutdown+0x10/0x20) from [<c004403c>]=20
 (clockevents_ex)
 [<c004403c>] (clockevents_exchange_device+0x74/0x80) from [<c0044410>]=
=20
 (tick_no)
 [<c0044410>] (tick_notify+0xec/0x2d8) from [<c0035768>]=20
 (notifier_call_chain+0x)
 [<c0035768>] (notifier_call_chain+0x38/0x68) from [<c00357b8>]=20
 (raw_notifier_ca)
 [<c00357b8>] (raw_notifier_call_chain+0x14/0x18) from [<c0043c58>]=20
 (clockevents)
 [<c0043c58>] (clockevents_register_device+0x90/0x128) from [<c0453abc>=
]=20
 (time_i)
 [<c0453abc>] (time_init+0x1c/0x28) from [<c04508c4>]=20
 (start_kernel+0x1b0/0x304)
 [<c04508c4>] (start_kernel+0x1b0/0x304) from [<20008040>] (0x20008040)
 ---[ end trace 0000000000000001 ]---
 sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every=20
 3489660920ms
 Console: colour dummy device 80x30
 Calibrating delay loop... 198.76 BogoMIPS (lpj=3D775168)
 pid_max: default: 32768 minimum: 301
 Mount-cache hash table entries: 512
 CPU: Testing write buffer coherency: ok
 Setting up static identity map for 0xc032aac0 - 0xc032ab18
 devtmpfs: initialized
 pinctrl core: initialized pinctrl subsystem
 NET: Registered protocol family 16
 DMA: preallocated 256 KiB pool for atomic coherent allocations
 AT91: Power Management
 AT91: Starting after power-restored wakeup
 gpio-at91 fffff400.gpio: at address fefff400
 gpio-at91 fffff600.gpio: at address fefff600
 gpio-at91 fffff800.gpio: at address fefff800
 gpio-at91 fffffa00.gpio: at address fefffa00
 pinctrl-at91 pinctrl.2: initialized AT91 pinctrl driver
 ------------[ cut here ]------------
 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.10.9-rt5 #4
 [<c000cffc>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c001550c>]=20
 (warn_slowpath_common+0x4)
 [<c001550c>] (warn_slowpath_common+0x4c/0x68) from [<c00155a8>]=20
 (warn_slowpath_)
 [<c00155a8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004f84c>]=20
 (__free_irq+0x90/0)
 [<c004f84c>] (__free_irq+0x90/0x1a8) from [<c0043d18>]=20
 (clockevents_set_mode+0x)
 [<c0043d18>] (clockevents_set_mode+0x28/0x5c) from [<c0043ff0>]=20
 (clockevents_ex)
 [<c0043ff0>] (clockevents_exchange_device+0x28/0x80) from [<c0044410>]=
=20
 (tick_no)
 [<c0044410>] (tick_notify+0xec/0x2d8) from [<c0035768>]=20
 (notifier_call_chain+0x)
 [<c0035768>] (notifier_call_chain+0x38/0x68) from [<c00357b8>]=20
 (raw_notifier_ca)
 [<c00357b8>] (raw_notifier_call_chain+0x14/0x18) from [<c0043c58>]=20
 (clockevents)
 [<c0043c58>] (clockevents_register_device+0x90/0x128) from [<c0469510>=
]=20
 (tcb_cl)
 [<c0469510>] (tcb_clksrc_init+0x1f0/0x238) from [<c0008890>]=20
 (do_one_initcall+0)
 [<c0008890>] (do_one_initcall+0x90/0x148) from [<c0450b00>]=20
 (kernel_init_freeab)
 [<c0450b00>] (kernel_init_freeable+0xe8/0x1ac) from [<c0323138>]=20
 (kernel_init+0)
 [<c0323138>] (kernel_init+0x8/0xe4) from [<c0009450>]=20
 (ret_from_fork+0x14/0x24)
 ---[ end trace 0000000000000002 ]---
 bio: create slab <bio-0> at 0
 at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave=
=20
 ), 8 chas
 at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave=
=20
 ), 8 chas
 SCSI subsystem initialized
 usbcore: registered new interface driver usbfs
 usbcore: registered new interface driver hub
 usbcore: registered new device driver usb
 cfg80211: Calling CRDA to update world regulatory domain
 Switching to clocksource tcb_clksrc
 NET: Registered protocol family 2
 TCP established hash table entries: 2048 (order: 2, 16384 bytes)
 TCP bind hash table entries: 2048 (order: 3, 49152 bytes)
 TCP: Hash tables configured (established 2048 bind 2048)
 TCP: reno registered
 UDP hash table entries: 256 (order: 2, 16384 bytes)
 UDP-Lite hash table entries: 256 (order: 2, 16384 bytes)
 NET: Registered protocol family 1
 msgmni has been set to 497
 Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
 io scheduler noop registered (default)
 io scheduler deadline registered
 io scheduler cfq registered
 fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq =3D 16) is a ATMEL_SERI=
AL
 console [ttyS0] enabled
 f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq =3D 23) is a ATMEL_SERI=
AL
 f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq =3D 24) is a ATMEL_SERI=
AL
 brd: module loaded
 loop: module loaded
 atmel_spi f0000000.spi: version: 0x212
 atmel_spi f0000000.spi: DMA channel not available, SPI unable to use=20
 DMA
 atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
 atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
 atmel_spi f0000000.spi: master is unqueued, this is deprecated
 macb f802c000.ethernet (unregistered net_device): invalid hw address,=20
 using ranm
 libphy: MACB_mii_bus: probed
 macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 25=20
 (ea:20:33:bb:87:)
 macb f802c000.ethernet eth0: attached PHY driver [SMSC LAN8710/LAN8720=
]=20
 (mii_bu)
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 ehci-atmel: EHCI Atmel driver
 atmel-ehci 700000.ehci: EHCI Host Controller
 atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
 atmel-ehci 700000.ehci: irq 29, io mem 0x00700000
 atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
 usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
 usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
 usb usb1: Product: EHCI Host Controller
 usb usb1: Manufacturer: Linux 3.10.9-rt5 ehci_hcd
 usb usb1: SerialNumber: 700000.ehci
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 3 ports detected
 usbcore: registered new interface driver usbserial
 usbcore: registered new interface driver usbserial_generic
 usbserial: USB Serial support registered for generic
 usbcore: registered new interface driver ftdi_sio
 usbserial: USB Serial support registered for FTDI USB Serial Device
 usbcore: registered new interface driver pl2303
 usbserial: USB Serial support registered for pl2303
 mousedev: PS/2 mouse device common for all mice
 genirq: Flags mismatch irq 16. 00002080 (at91_rtc) vs. 000152a0=20
 (at91_tick)
 at91_rtc fffffeb0.rtc: IRQ 16 already in use.
 at91_rtc: probe of fffffeb0.rtc failed with error -16
 i2c /dev entries driver
 Driver for 1-wire Dallas network protocol.
 leds-gpio leds.3: pins are not configured from the driver
 ledtrig-cpu: registered to indicate activity on CPUs
 usbcore: registered new interface driver usbhid
 usbhid: USB HID core driver
 TCP: cubic registered
 NET: Registered protocol family 10
 sit: IPv6 over IPv4 tunneling driver
 NET: Registered protocol family 17
 Key type dns_resolver registered
 drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
 atmel_mci f0008000.mmc: version: 0x504
 atmel_mci f0008000.mmc: using dma0chan0 for DMA transfers
 atmel_mci f0008000.mmc: Atmel MCI controller at 0xf0008000 irq 22, 1=20
 slots
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 Waiting 1sec before mounting root device...
 mmc0: host does not support reading read-only switch. assuming=20
 write-enable.
 mmc0: new high speed SDHC card at address 0002
 mmcblk0: mmc0:0002 00000 14.9 GiB
  mmcblk0: p1 p2 p3
 EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts:=20
 (null)
 VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
 devtmpfs: mounted
 Freeing unused kernel memory: 152K (c0450000 - c0476000)
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 udevd[620]: starting version 175
 ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
 at91_ohci 600000.ohci: AT91 OHCI
 at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
 at91_ohci 600000.ohci: irq 29, io mem 0x00600000
 usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0001
 usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
 at91_i2c f8010000.i2c: using dma0chan1 (tx) and dma0chan2 (rx) for DMA=
=20
 transfers
 at91_i2c f8010000.i2c: AT91 i2c bus driver.
 usb usb2: Product: AT91 OHCI
 usb usb2: Manufacturer: Linux 3.10.9-rt5 ohci_hcd
 usb usb2: SerialNumber: at91
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 3 ports detected
 EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
 EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
 EXT4-fs (mmcblk0p3): mounted filesystem with ordered data mode. Opts:=20
 (null)
 IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
 macb f802c000.ethernet eth0: link up (100/Full)
 IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq

 [ the last two lines are repeated several times, then the system hangs=
=20
 ]

 CONFIG_PREEMPT_RTB:
 Starting linux kernel ..., machid: 0x1035
=20
 Uncompressing Linux... done, booting the kernel.
 Booting Linux on physical CPU 0x0
 Linux version 3.10.9-rt5 (mitarbeiter@ariag25-dev) (gcc version 4.7.3=20
 (Ubuntu/L3
 CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
 CPU: VIVT data cache, VIVT instruction cache
 Machine: Atmel AT91SAM (Device Tree), model: Acme Systems Aria G25
 Memory policy: ECC disabled, Data cache writeback
 AT91: Detected soc type: at91sam9x5
 AT91: Detected soc subtype: at91sam9g25
 AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
 DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
 Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
 Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=20
 65024
 Kernel command line: mem=3D256M console=3DttyS0,115200 root=3D/dev/mmc=
blk0p2=20
 rootfsty1
 PID hash table entries: 1024 (order: 0, 4096 bytes)
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
 Memory: 256MB =3D 256MB total
 Memory: 254864k/254864k available, 7280k reserved, 0K highmem
 Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc045b484   (4430 kB)
       .init : 0xc045c000 - 0xc048239c   ( 153 kB)
       .data : 0xc0484000 - 0xc04b2a80   ( 187 kB)
        .bss : 0xc04b2a80 - 0xc04d3a08   ( 132 kB)
 SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
 Preemptible hierarchical RCU implementation.
 NR_IRQS:16 nr_irqs:16 16
 ------------[ cut here ]------------
 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x190()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.9-rt5 #5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0015768>]=20
 (warn_slowpath_common+0x4)
 [<c0015768>] (warn_slowpath_common+0x4c/0x68) from [<c0015804>]=20
 (warn_slowpath_)
 [<c0015804>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0050b5c>]=20
 (__free_irq+0x90/0)
 [<c0050b5c>] (__free_irq+0x90/0x190) from [<c0045408>]=20
 (clockevents_set_mode+0x)
 [<c0045408>] (clockevents_set_mode+0x28/0x5c) from [<c004544c>]=20
 (clockevents_sh)
 [<c004544c>] (clockevents_shutdown+0x10/0x20) from [<c0045720>]=20
 (clockevents_ex)
 [<c0045720>] (clockevents_exchange_device+0x74/0x80) from [<c0045ab0>]=
=20
 (tick_no)
 [<c0045ab0>] (tick_notify+0xec/0x2c0) from [<c0036ff8>]=20
 (notifier_call_chain+0x)
 [<c0036ff8>] (notifier_call_chain+0x38/0x68) from [<c0037048>]=20
 (raw_notifier_ca)
 [<c0037048>] (raw_notifier_call_chain+0x14/0x18) from [<c0045354>]=20
 (clockevents)
 [<c0045354>] (clockevents_register_device+0x90/0x11c) from [<c045fabc>=
]=20
 (time_i)
 [<c045fabc>] (time_init+0x1c/0x28) from [<c045c8c0>]=20
 (start_kernel+0x1ac/0x300)
 [<c045c8c0>] (start_kernel+0x1ac/0x300) from [<20008040>] (0x20008040)
 ---[ end trace 1b75b31a2719ed1c ]---
 sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every=20
 3489660920ms
 Console: colour dummy device 80x30
 Calibrating delay loop... 198.76 BogoMIPS (lpj=3D775168)
 pid_max: default: 32768 minimum: 301
 Mount-cache hash table entries: 512
 CPU: Testing write buffer coherency: ok
 Setting up static identity map for 0xc033b200 - 0xc033b258
 devtmpfs: initialized
 pinctrl core: initialized pinctrl subsystem
 NET: Registered protocol family 16
 DMA: preallocated 256 KiB pool for atomic coherent allocations
 AT91: Power Management
 AT91: Starting after power-restored wakeup
 gpio-at91 fffff400.gpio: at address fefff400
 gpio-at91 fffff600.gpio: at address fefff600
 gpio-at91 fffff800.gpio: at address fefff800
 gpio-at91 fffffa00.gpio: at address fefffa00
 pinctrl-at91 pinctrl.2: initialized AT91 pinctrl driver
 ------------[ cut here ]------------
 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x190()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.10.9-rt5 #5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0015768>]=20
 (warn_slowpath_common+0x4)
 [<c0015768>] (warn_slowpath_common+0x4c/0x68) from [<c0015804>]=20
 (warn_slowpath_)
 [<c0015804>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0050b5c>]=20
 (__free_irq+0x90/0)
 [<c0050b5c>] (__free_irq+0x90/0x190) from [<c0045408>]=20
 (clockevents_set_mode+0x)
 [<c0045408>] (clockevents_set_mode+0x28/0x5c) from [<c00456d4>]=20
 (clockevents_ex)
 [<c00456d4>] (clockevents_exchange_device+0x28/0x80) from [<c0045ab0>]=
=20
 (tick_no)
 [<c0045ab0>] (tick_notify+0xec/0x2c0) from [<c0036ff8>]=20
 (notifier_call_chain+0x)
 [<c0036ff8>] (notifier_call_chain+0x38/0x68) from [<c0037048>]=20
 (raw_notifier_ca)
 [<c0037048>] (raw_notifier_call_chain+0x14/0x18) from [<c0045354>]=20
 (clockevents)
 [<c0045354>] (clockevents_register_device+0x90/0x11c) from [<c0475220>=
]=20
 (tcb_cl)
 [<c0475220>] (tcb_clksrc_init+0x1f0/0x238) from [<c0008880>]=20
 (do_one_initcall+0)
 [<c0008880>] (do_one_initcall+0x90/0x148) from [<c045cafc>]=20
 (kernel_init_freeab)
 [<c045cafc>] (kernel_init_freeable+0xe8/0x1ac) from [<c03337ec>]=20
 (kernel_init+0)
 [<c03337ec>] (kernel_init+0x8/0xe4) from [<c0009450>]=20
 (ret_from_fork+0x14/0x24)
 ---[ end trace 1b75b31a2719ed1d ]---
 bio: create slab <bio-0> at 0
 at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave=
=20
 ), 8 chas
 at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave=
=20
 ), 8 chas
 SCSI subsystem initialized
 usbcore: registered new interface driver usbfs
 usbcore: registered new interface driver hub
 usbcore: registered new device driver usb
 Switching to clocksource tcb_clksrc
 cfg80211: Calling CRDA to update world regulatory domain
 NET: Registered protocol family 2
 TCP established hash table entries: 2048 (order: 2, 16384 bytes)
 TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
 TCP: Hash tables configured (established 2048 bind 2048)
 TCP: reno registered
 UDP hash table entries: 256 (order: 0, 4096 bytes)
 UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
 NET: Registered protocol family 1
 msgmni has been set to 497
 Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
 io scheduler noop registered (default)
 io scheduler deadline registered
 io scheduler cfq registered
 fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq =3D 16) is a ATMEL_SERI=
AL
 console [ttyS0] enabled
 f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq =3D 23) is a ATMEL_SERI=
AL
 f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq =3D 24) is a ATMEL_SERI=
AL
 brd: module loaded
 loop: module loaded
 atmel_spi f0000000.spi: version: 0x212
 atmel_spi f0000000.spi: DMA channel not available, SPI unable to use=20
 DMA
 atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
 atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
 atmel_spi f0000000.spi: master is unqueued, this is deprecated
 macb f802c000.ethernet (unregistered net_device): invalid hw address,=20
 using ranm
 libphy: MACB_mii_bus: probed
 macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 25=20
 (02:47:d1:42:ed:)
 macb f802c000.ethernet eth0: attached PHY driver [SMSC LAN8710/LAN8720=
]=20
 (mii_bu)
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 ehci-atmel: EHCI Atmel driver
 atmel-ehci 700000.ehci: EHCI Host Controller
 atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
 atmel-ehci 700000.ehci: irq 29, io mem 0x00700000
 atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
 usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
 usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
 usb usb1: Product: EHCI Host Controller
 usb usb1: Manufacturer: Linux 3.10.9-rt5 ehci_hcd
 usb usb1: SerialNumber: 700000.ehci
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 3 ports detected
 usbcore: registered new interface driver usbserial
 usbcore: registered new interface driver usbserial_generic
 usbserial: USB Serial support registered for generic
 usbcore: registered new interface driver ftdi_sio
 usbserial: USB Serial support registered for FTDI USB Serial Device
 usbcore: registered new interface driver pl2303
 usbserial: USB Serial support registered for pl2303
 mousedev: PS/2 mouse device common for all mice
 genirq: Flags mismatch irq 16. 00002080 (at91_rtc) vs. 000152a0=20
 (at91_tick)
 at91_rtc fffffeb0.rtc: IRQ 16 already in use.
 at91_rtc: probe of fffffeb0.rtc failed with error -16
 i2c /dev entries driver
 Driver for 1-wire Dallas network protocol.
 leds-gpio leds.3: pins are not configured from the driver
 ledtrig-cpu: registered to indicate activity on CPUs
 usbcore: registered new interface driver usbhid
 usbhid: USB HID core driver
 TCP: cubic registered
 NET: Registered protocol family 10
 sit: IPv6 over IPv4 tunneling driver
 NET: Registered protocol family 17
 Key type dns_resolver registered
 drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
 atmel_mci f0008000.mmc: version: 0x504
 atmel_mci f0008000.mmc: using dma0chan0 for DMA transfers
 atmel_mci f0008000.mmc: Atmel MCI controller at 0xf0008000 irq 22, 1=20
 slots
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 Waiting 1sec before mounting root device...
 mmc0: host does not support reading read-only switch. assuming=20
 write-enable.
 mmc0: new high speed SDHC card at address 0002
 mmcblk0: mmc0:0002 00000 14.9 GiB
  mmcblk0: p1 p2 p3
 EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts:=20
 (null)
 VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
 devtmpfs: mounted
 Freeing unused kernel memory: 152K (c045c000 - c0482000)
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0=20
 (at91_tick)
 atmel_serial: atmel_startup - Can't get irq
 udevd[614]: starting version 175
 ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
 at91_ohci 600000.ohci: AT91 OHCI
 at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
 at91_ohci 600000.ohci: irq 29, io mem 0x00600000
 at91_i2c f8010000.i2c: using dma0chan1 (tx) and dma0chan2 (rx) for DMA=
=20
 transfers
 usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0001
 usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
 at91_i2c f8010000.i2c: AT91 i2c bus driver.
 usb usb2: Product: AT91 OHCI
 usb usb2: Manufacturer: Linux 3.10.9-rt5 ohci_hcd
 usb usb2: SerialNumber: at91
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 3 ports detected
 EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
 EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
 ------------[ cut here ]------------
 Kernel BUG at c011cd20 [verbose debug info unavailable]
 Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
 Modules linked in: i2c_at91 ohci_hcd
 CPU: 0 PID: 853 Comm: checkroot.sh Tainted: G        W    3.10.9-rt5 #=
5
 task: cf892b80 ti: cecd2000 task.ti: cecd2000
 PC is at do_get_write_access+0x320/0x474
 LR is at do_get_write_access+0x320/0x474
 pc : [<c011cd20>]    lr : [<c011cd20>]    psr: 20000013
 sp : cecd3d00  ip : 000002a4  fp : c0496328
 r10: cf898c00  r9 : ffff6f0d  r8 : cf499460
 r7 : 00000000  r6 : cf4ed000  r5 : cf40b100  r4 : cf4e8b80
 r3 : cecd2000  r2 : 00000002  r1 : 00000002  r0 : 00000001
 Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 Control: 0005317f  Table: 2ed6c000  DAC: 00000015
 Process checkroot.sh (pid: 853, stack limit =3D 0xcecd21b8)
 Stack: (0xcecd3d00 to 0xcecd4000)
 3d00: 00000000 cecd3d10 cecd3d40 cfff5000 cf801580 cf499460 c0340024=20
 c008a29c
 3d20: 00000029 cf40b100 cf499460 cf4e8b80 cf499460 cf40b100 c0343620=20
 000000f7
 3d40: cecd3dc6 cfbae960 c0340024 c011cfb8 cf40b100 cf4f0948 cf499460=20
 c010762c
 3d60: c0343620 000000f7 cf4f0948 cf499460 cf898800 00000000 cf996600=20
 c00e7290
 3d80: cf8188d0 cf402a18 00000000 00000000 00000000 00000000 00000000=20
 00000000
 3da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000=20
 00000000
 3dc0: 00000000 002f0000 cfbae960 cf4f0948 cfbae960 c00e71e8 cfbae968=20
 cecd3e7c
 3de0: c0340024 c008d574 cecd3e7c 00000000 cfbae960 cecd3e80 cfbae960=20
 c008d64c
 3e00: cecd3ec0 c009b7d4 cecd3ec0 cf423438 cecd2000 ced47015 00000000=20
 00020020
 3e20: 00000000 00000000 cf8188d0 cf4135d8 00000000 00000021 73e14981=20
 cf4f0948
 3e40: 00000000 00000000 ffffff9c cecd3ec0 00000000 cfbae960 cecd2000=20
 cecd3f38
 3e60: 0002fbc4 c0340024 00000001 c009ba84 cecd3e7c 00000001 00000000=20
 00000000
 3e80: cf8188d0 cf442d48 00000000 b6e68000 000005b7 c0340024 00000001=20
 cecd3f38
 3ea0: ffffff9c 00000001 0002fbc4 0002fbb8 00000001 c009c090 00000041=20
 ceca14b8
 3ec0: cf8188d0 cf442d48 73e14981 00000008 ced47015 c0099628 00000000=20
 cf402a18
 3ee0: cf4f0948 00000101 00000002 00000000 00000000 b6e688da cecd3fb0=20
 00000003
 3f00: cf801d80 cf892b80 0002fbb8 c008a29c c04c5f78 cf892b80 00000000=20
 ced47010
 3f20: cecd2000 cf892b80 ced47010 c0093bf0 cf892b80 cecd2000 ced47010=20
 00000000
 3f40: 00000000 00000000 cfacea00 cecd2000 cf892b80 ced47010 00000001=20
 c0094fe4
 3f60: 00000ff0 0002fbf4 00000000 cf892cbc 00000000 ced47000 0002fbc4=20
 0002fbb8
 3f80: 0000000b c0009524 cecd2000 00000000 0002fbb8 c0095518 0002fbb8=20
 0002fbf4
 3fa0: 0002fbc4 c00093c0 0002fbb8 0002fbf4 0002fbf4 0002fbb8 0002fbc4=20
 00000000
 3fc0: 0002fbb8 0002fbf4 0002fbc4 0000000b 0002fbc4 000277bc 00025764=20
 0002fbb8
 3fe0: b6ef1160 be8602b0 0000ce34 b6ef116c 60000010 0002fbf4 00004000=20
 001a0a42
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00e7290>] (ext)
 [<c00e7290>] (ext4_file_open+0xa8/0x1f4) from [<c008d574>]=20
 (do_dentry_open.isra)
 [<c008d574>] (do_dentry_open.isra.14+0x1b8/0x26c) from [<c008d64c>]=20
 (finish_ope)
 [<c008d64c>] (finish_open+0x24/0x38) from [<c009b7d4>]=20
 (do_last.isra.46+0x91c/0)
 [<c009b7d4>] (do_last.isra.46+0x91c/0xb24) from [<c009ba84>]=20
 (path_openat+0xa8/)
 [<c009ba84>] (path_openat+0xa8/0x404) from [<c009c090>]=20
 (do_filp_open+0x2c/0x78)
 [<c009c090>] (do_filp_open+0x2c/0x78) from [<c0093bf0>]=20
 (open_exec+0x34/0x11c)
 [<c0093bf0>] (open_exec+0x34/0x11c) from [<c0094fe4>]=20
 (do_execve+0x1a0/0x49c)
 [<c0094fe4>] (do_execve+0x1a0/0x49c) from [<c0095518>]=20
 (SyS_execve+0x30/0x44)
 [<c0095518>] (SyS_execve+0x30/0x44) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0x2)
 Code: 1a000003 ea000032 e3a00001 ebfc72f8 (e7f001f2)
 ---[ end trace 1b75b31a2719ed1f ]---
 note: checkroot.sh[853] exited with preempt_count 2
 BUG: scheduling while atomic: checkroot.sh/853/0x40000003
 Modules linked in: i2c_at91 ohci_hcd
 Preemption disabled at:[<  (null)>]   (null)
=20
 CPU: 0 PID: 853 Comm: checkroot.sh Tainted: G      D W    3.10.9-rt5 #=
5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0335760>]=20
 (__schedule_bug+0x7c/0xa0)
 [<c0335760>] (__schedule_bug+0x7c/0xa0) from [<c0339868>]=20
 (__schedule+0x58/0x2e)
 [<c0339868>] (__schedule+0x58/0x2e0) from [<c0039c6c>]=20
 (__cond_resched+0x20/0x3)
 [<c0039c6c>] (__cond_resched+0x20/0x38) from [<c0339b84>]=20
 (_cond_resched+0x3c/0)
 [<c0339b84>] (_cond_resched+0x3c/0x44) from [<c00a7280>]=20
 (put_files_struct+0x80)
 [<c00a7280>] (put_files_struct+0x80/0xd0) from [<c001a450>]=20
 (do_exit+0x32c/0x86)
 [<c001a450>] (do_exit+0x32c/0x86c) from [<c000b7a8>] (die+0x218/0x254)
 [<c000b7a8>] (die+0x218/0x254) from [<c00085b0>]=20
 (do_undefinstr+0x1ac/0x1cc)
 [<c00085b0>] (do_undefinstr+0x1ac/0x1cc) from [<c00090cc>]=20
 (__und_svc_finish+0x)
 Exception stack(0xcecd3cb8 to 0xcecd3d00)
 3ca0:                                                       00000001=20
 00000002
 3cc0: 00000002 cecd2000 cf4e8b80 cf40b100 cf4ed000 00000000 cf499460=20
 ffff6f0d
 3ce0: cf898c00 c0496328 000002a4 cecd3d00 c011cd20 c011cd20 20000013=20
 ffffffff
 [<c00090cc>] (__und_svc_finish+0x0/0x14) from [<c011cd20>]=20
 (do_get_write_access)
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00e7290>] (ext)
 [<c00e7290>] (ext4_file_open+0xa8/0x1f4) from [<c008d574>]=20
 (do_dentry_open.isra)
 [<c008d574>] (do_dentry_open.isra.14+0x1b8/0x26c) from [<c008d64c>]=20
 (finish_ope)
 [<c008d64c>] (finish_open+0x24/0x38) from [<c009b7d4>]=20
 (do_last.isra.46+0x91c/0)
 [<c009b7d4>] (do_last.isra.46+0x91c/0xb24) from [<c009ba84>]=20
 (path_openat+0xa8/)
 [<c009ba84>] (path_openat+0xa8/0x404) from [<c009c090>]=20
 (do_filp_open+0x2c/0x78)
 [<c009c090>] (do_filp_open+0x2c/0x78) from [<c0093bf0>]=20
 (open_exec+0x34/0x11c)
 [<c0093bf0>] (open_exec+0x34/0x11c) from [<c0094fe4>]=20
 (do_execve+0x1a0/0x49c)
 [<c0094fe4>] (do_execve+0x1a0/0x49c) from [<c0095518>]=20
 (SyS_execve+0x30/0x44)
 [<c0095518>] (SyS_execve+0x30/0x44) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0x2)
 BUG: scheduling while atomic: checkroot.sh/853/0x40000003
 Modules linked in: i2c_at91 ohci_hcd
 Preemption disabled at:[<  (null)>]   (null)
=20
 CPU: 0 PID: 853 Comm: checkroot.sh Tainted: G      D W    3.10.9-rt5 #=
5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0335760>]=20
 (__schedule_bug+0x7c/0xa0)
 [<c0335760>] (__schedule_bug+0x7c/0xa0) from [<c0339868>]=20
 (__schedule+0x58/0x2e)
 [<c0339868>] (__schedule+0x58/0x2e0) from [<c0039c6c>]=20
 (__cond_resched+0x20/0x3)
 [<c0039c6c>] (__cond_resched+0x20/0x38) from [<c0339b84>]=20
 (_cond_resched+0x3c/0)
 [<c0339b84>] (_cond_resched+0x3c/0x44) from [<c002fd98>]=20
 (task_work_run+0x94/0x)
 [<c002fd98>] (task_work_run+0x94/0xa4) from [<c001a464>]=20
 (do_exit+0x340/0x86c)
 [<c001a464>] (do_exit+0x340/0x86c) from [<c000b7a8>] (die+0x218/0x254)
 [<c000b7a8>] (die+0x218/0x254) from [<c00085b0>]=20
 (do_undefinstr+0x1ac/0x1cc)
 [<c00085b0>] (do_undefinstr+0x1ac/0x1cc) from [<c00090cc>]=20
 (__und_svc_finish+0x)
 Exception stack(0xcecd3cb8 to 0xcecd3d00)
 3ca0:                                                       00000001=20
 00000002
 3cc0: 00000002 cecd2000 cf4e8b80 cf40b100 cf4ed000 00000000 cf499460=20
 ffff6f0d
 3ce0: cf898c00 c0496328 000002a4 cecd3d00 c011cd20 c011cd20 20000013=20
 ffffffff
 [<c00090cc>] (__und_svc_finish+0x0/0x14) from [<c011cd20>]=20
 (do_get_write_access)
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00e7290>] (ext)
 [<c00e7290>] (ext4_file_open+0xa8/0x1f4) from [<c008d574>]=20
 (do_dentry_open.isra)
 [<c008d574>] (do_dentry_open.isra.14+0x1b8/0x26c) from [<c008d64c>]=20
 (finish_ope)
 [<c008d64c>] (finish_open+0x24/0x38) from [<c009b7d4>]=20
 (do_last.isra.46+0x91c/0)
 [<c009b7d4>] (do_last.isra.46+0x91c/0xb24) from [<c009ba84>]=20
 (path_openat+0xa8/)
 [<c009ba84>] (path_openat+0xa8/0x404) from [<c009c090>]=20
 (do_filp_open+0x2c/0x78)
 [<c009c090>] (do_filp_open+0x2c/0x78) from [<c0093bf0>]=20
 (open_exec+0x34/0x11c)
 [<c0093bf0>] (open_exec+0x34/0x11c) from [<c0094fe4>]=20
 (do_execve+0x1a0/0x49c)
 [<c0094fe4>] (do_execve+0x1a0/0x49c) from [<c0095518>]=20
 (SyS_execve+0x30/0x44)
 [<c0095518>] (SyS_execve+0x30/0x44) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0x2)
 ------------[ cut here ]------------
 Kernel BUG at c011cd20 [verbose debug info unavailable]
 Internal error: Oops - BUG: 0 [#2] PREEMPT ARM
 Modules linked in: i2c_at91 ohci_hcd
 CPU: 0 PID: 856 Comm: rm Tainted: G      D W    3.10.9-rt5 #5
 task: cf893cc0 ti: cecac000 task.ti: cecac000
 PC is at do_get_write_access+0x320/0x474
 LR is at do_get_write_access+0x320/0x474
 pc : [<c011cd20>]    lr : [<c011cd20>]    psr: 20000013
 sp : cecade20  ip : 000002a4  fp : c0496328
 r10: cf898c00  r9 : ffff6f49  r8 : cf4994a0
 r7 : 00000000  r6 : cf4ed000  r5 : cf40f340  r4 : cf4e8bc0
 r3 : cecac000  r2 : 00000002  r1 : 00000002  r0 : 00000001
 Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 Control: 0005317f  Table: 2ec84000  DAC: 00000015
 Process rm (pid: 856, stack limit =3D 0xcecac1b8)
 Stack: (0xcecade20 to 0xcecae000)
 de20: 00000000 cecade30 c1034000 00001000 cf801580 cf4994a0 00000000=20
 c008a29c
 de40: 02000029 cf40f340 cf4994a0 cf4e8bc0 cf4994a0 cf40f340 c0343d3b=20
 00000871
 de60: 0001e0a0 c10345c4 00000000 c011cfb8 cf40f340 cf411668 cf4994a0=20
 c010762c
 de80: c0343d3b 00000871 cf411668 cf42d438 cf40f340 cf4994a0 00000000=20
 c00f6d7c
 dea0: 00000abd 00000018 ced46000 0001e0a0 cf40f340 c0107490 00000abd=20
 cf4994a0
 dec0: cf42d438 cf411668 00000000 ced46000 cf40f340 c00f7ed0 0001e0a0=20
 ffffff9c
 dee0: 00000000 c10345c4 cf442c38 cf442c38 cf411668 00000000 ced46000=20
 cf442c38
 df00: 00000000 cf411668 00000000 ced46000 ffffff9c c009a4e4 cf411668=20
 cf442c38
 df20: 00000000 cf42d438 cf442c38 c009a640 cf8188d0 cf406440 01afef23=20
 00000004
 df40: ced46015 c0099628 00000000 cf402a18 cf411668 00000000 00000002=20
 00000000
 df60: 00000000 00000000 00000000 00000000 0000000c 00000000 52209f99=20
 14a171c4
 df80: 45984f0e 34f15674 0001f268 beb4bcdc 00000000 00000148 c0009524=20
 cecac000
 dfa0: 00000000 c00093c0 0001f268 beb4bcdc ffffff9c 0001e0a0 00000000=20
 00000000
 dfc0: 0001f268 beb4bcdc 00000000 00000148 0001e038 00000002 00000000=20
 00000000
 dfe0: b6f2b760 beb4bb98 00009e50 b6f2b76c 60000010 ffffff9c 4a001a48=20
 501c1010
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00f6d7c>] (ext)
 [<c00f6d7c>] (ext4_delete_entry+0x88/0x10c) from [<c00f7ed0>]=20
 (ext4_unlink+0xe8)
 [<c00f7ed0>] (ext4_unlink+0xe8/0x24c) from [<c009a4e4>]=20
 (vfs_unlink+0x5c/0xf4)
 [<c009a4e4>] (vfs_unlink+0x5c/0xf4) from [<c009a640>]=20
 (do_unlinkat+0xc4/0x170)
 [<c009a640>] (do_unlinkat+0xc4/0x170) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0)
 Code: 1a000003 ea000032 e3a00001 ebfc72f8 (e7f001f2)
 ---[ end trace 1b75b31a2719ed20 ]---
 note: rm[856] exited with preempt_count 2
 BUG: scheduling while atomic: rm/856/0x40000003
 Modules linked in: i2c_at91 ohci_hcd
 Preemption disabled at:[<  (null)>]   (null)
=20
 CPU: 0 PID: 856 Comm: rm Tainted: G      D W    3.10.9-rt5 #5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0335760>]=20
 (__schedule_bug+0x7c/0xa0)
 [<c0335760>] (__schedule_bug+0x7c/0xa0) from [<c0339868>]=20
 (__schedule+0x58/0x2e)
 [<c0339868>] (__schedule+0x58/0x2e0) from [<c0039c6c>]=20
 (__cond_resched+0x20/0x3)
 [<c0039c6c>] (__cond_resched+0x20/0x38) from [<c0339b84>]=20
 (_cond_resched+0x3c/0)
 [<c0339b84>] (_cond_resched+0x3c/0x44) from [<c00a7280>]=20
 (put_files_struct+0x80)
 [<c00a7280>] (put_files_struct+0x80/0xd0) from [<c001a450>]=20
 (do_exit+0x32c/0x86)
 [<c001a450>] (do_exit+0x32c/0x86c) from [<c000b7a8>] (die+0x218/0x254)
 [<c000b7a8>] (die+0x218/0x254) from [<c00085b0>]=20
 (do_undefinstr+0x1ac/0x1cc)
 [<c00085b0>] (do_undefinstr+0x1ac/0x1cc) from [<c00090cc>]=20
 (__und_svc_finish+0x)
 Exception stack(0xcecaddd8 to 0xcecade20)
 ddc0:                                                       00000001=20
 00000002
 dde0: 00000002 cecac000 cf4e8bc0 cf40f340 cf4ed000 00000000 cf4994a0=20
 ffff6f49
 de00: cf898c00 c0496328 000002a4 cecade20 c011cd20 c011cd20 20000013=20
 ffffffff
 [<c00090cc>] (__und_svc_finish+0x0/0x14) from [<c011cd20>]=20
 (do_get_write_access)
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00f6d7c>] (ext)
 [<c00f6d7c>] (ext4_delete_entry+0x88/0x10c) from [<c00f7ed0>]=20
 (ext4_unlink+0xe8)
 [<c00f7ed0>] (ext4_unlink+0xe8/0x24c) from [<c009a4e4>]=20
 (vfs_unlink+0x5c/0xf4)
 [<c009a4e4>] (vfs_unlink+0x5c/0xf4) from [<c009a640>]=20
 (do_unlinkat+0xc4/0x170)
 [<c009a640>] (do_unlinkat+0xc4/0x170) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0)
 ------------[ cut here ]------------
 Kernel BUG at c011cd20 [verbose debug info unavailable]
 Internal error: Oops - BUG: 0 [#3] PREEMPT ARM
 Modules linked in: i2c_at91 ohci_hcd
 CPU: 0 PID: 850 Comm: logsave Tainted: G      D W    3.10.9-rt5 #5
 task: cf893140 ti: ced3c000 task.ti: ced3c000
 PC is at do_get_write_access+0x320/0x474
 LR is at do_get_write_access+0x320/0x474
 pc : [<c011cd20>]    lr : [<c011cd20>]    psr: 20000013
 sp : ced3dcd8  ip : 000002a4  fp : c0496328
 r10: cf898c00  r9 : ffff6f61  r8 : cf499500
 r7 : 00000000  r6 : cf4ed000  r5 : cf40b100  r4 : cf4e8b80
 r3 : ced3c000  r2 : 00000002  r1 : 00000002  r0 : 00000001
 Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 Control: 0005317f  Table: 2ec18000  DAC: 00000015
 Process logsave (pid: 850, stack limit =3D 0xced3c1b8)
 Stack: (0xced3dcd8 to 0xced3e000)
 dcc0:                                                       00000000=20
 ced3dce8
 dce0: cf898c00 00000000 ced3df78 c011c2cc ced3ddec c00a4dec 00000050=20
 cf996600
 dd00: cf4eefd8 cf4e8b80 cf499500 cf40b100 c0343ddd 000009e8 cf4eefd8=20
 00000000
 dd20: ced3df78 c011cfb8 cf40b100 cf4eefd8 cf499500 c010762c c0343ddd=20
 000009e8
 dd40: cf4eefd8 cf499500 cf996600 cf499500 cf4eefb4 c00f72e0 00000000=20
 cf4eefd8
 dd60: 00000000 c0107490 00001274 00000000 cf499500 cf4eefd8 ced3de00=20
 00000000
 dd80: 00000000 c00efabc cf442700 00000000 cf801600 cf8188d0 ced3df78=20
 c008a29c
 dda0: 0000a068 18ada959 ced3ddd8 ced3ddd8 00000000 cf4426e8 000081a0=20
 0000a068
 ddc0: cf4eefd8 ced3de00 ced3df78 c00a61d8 cf4426e8 ced3de00 0000000b=20
 18ada959
 dde0: cf4426e8 00000001 cf4eefd8 ced3dec0 cf818d20 ced3debc cf4eeda8=20
 c008d6d4
 de00: 0000a068 c049994c cf818d20 cf4eefd8 00000000 00000000 0000000b=20
 18ada959
 de20: 0000000b 18ada959 0000000b 18ada959 cf818d20 ced3dec0 cf818d20=20
 ced3df00
 de40: 00000001 c009b884 00008060 cf818d20 ced3c000 ced4301e 00000000=20
 00000241
 de60: 00000001 00000001 cf8188d0 cf442770 00000000 00000022 015547fe=20
 cf4eefd8
 de80: cf8188d0 cf442770 ffffff9c ced3df00 00000000 cf818d20 ced3c000=20
 ced43000
 dea0: ced3c000 ced3df78 bea85f18 c009ba84 ced3debc c003a1c0 00000000=20
 00000002
 dec0: cf8188d0 cf4426e8 ced3defc c0339aa0 8ff9c445 ced3df78 00000001=20
 ced43000
 dee0: ffffff9c c0009524 ced3c000 00000000 bea85f18 c009c090 00000041=20
 ced3df40
 df00: cf8188d0 cf4426e8 595547fe 00000009 ced4301e c0099628 cf8188d0=20
 cf402a18
 df20: cf4eefd8 00000301 00000002 00000000 00000000 00000001 00000003=20
 cfa793c8
 df40: cfa793c0 ffffff9c bea85f18 c00a7480 00000241 00000001 ced43000=20
 00000003
 df60: 00000001 ced43000 ffffff9c c008e520 ced3df6c 00000001 00000241=20
 000081a4
 df80: 00000022 00000300 bea85ae0 00000001 00000241 000120ac 00000005=20
 c0009524
 dfa0: 00000000 c00093c0 00000001 00000241 bea85f18 00000241 000001a4=20
 00000000
 dfc0: 00000001 00000241 000120ac 00000005 00000003 bea85c34 00000000=20
 bea85f18
 dfe0: 00012098 bea85b90 00008dac b6f0fcdc 60000010 bea85f18 41000048=20
 50081000
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00f72e0>] (ext)
 [<c00f72e0>] (ext4_orphan_add+0x84/0x198) from [<c00efabc>]=20
 (ext4_setattr+0x510)
 [<c00efabc>] (ext4_setattr+0x510/0x54c) from [<c00a61d8>]=20
 (notify_change+0x210/)
 [<c00a61d8>] (notify_change+0x210/0x2fc) from [<c008d6d4>]=20
 (do_truncate+0x74/0x)
 [<c008d6d4>] (do_truncate+0x74/0x98) from [<c009b884>]=20
 (do_last.isra.46+0x9cc/0)
 [<c009b884>] (do_last.isra.46+0x9cc/0xb24) from [<c009ba84>]=20
 (path_openat+0xa8/)
 [<c009ba84>] (path_openat+0xa8/0x404) from [<c009c090>]=20
 (do_filp_open+0x2c/0x78)
 [<c009c090>] (do_filp_open+0x2c/0x78) from [<c008e520>]=20
 (do_sys_open+0xe8/0x174)
 [<c008e520>] (do_sys_open+0xe8/0x174) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0)
 Code: 1a000003 ea000032 e3a00001 ebfc72f8 (e7f001f2)
 ---[ end trace 1b75b31a2719ed21 ]---
 note: logsave[850] exited with preempt_count 2
 BUG: scheduling while atomic: logsave/850/0x40000003
 Modules linked in: i2c_at91 ohci_hcd
 Preemption disabled at:[<  (null)>]   (null)
=20
 CPU: 0 PID: 850 Comm: logsave Tainted: G      D W    3.10.9-rt5 #5
 [<c000d000>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>]=20
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c0335760>]=20
 (__schedule_bug+0x7c/0xa0)
 [<c0335760>] (__schedule_bug+0x7c/0xa0) from [<c0339868>]=20
 (__schedule+0x58/0x2e)
 [<c0339868>] (__schedule+0x58/0x2e0) from [<c0039c6c>]=20
 (__cond_resched+0x20/0x3)
 [<c0039c6c>] (__cond_resched+0x20/0x38) from [<c0339b84>]=20
 (_cond_resched+0x3c/0)
 [<c0339b84>] (_cond_resched+0x3c/0x44) from [<c00a7280>]=20
 (put_files_struct+0x80)
 [<c00a7280>] (put_files_struct+0x80/0xd0) from [<c001a450>]=20
 (do_exit+0x32c/0x86)
 [<c001a450>] (do_exit+0x32c/0x86c) from [<c000b7a8>] (die+0x218/0x254)
 [<c000b7a8>] (die+0x218/0x254) from [<c00085b0>]=20
 (do_undefinstr+0x1ac/0x1cc)
 [<c00085b0>] (do_undefinstr+0x1ac/0x1cc) from [<c00090cc>]=20
 (__und_svc_finish+0x)
 Exception stack(0xced3dc90 to 0xced3dcd8)
 dc80:                                     00000001 00000002 00000002=20
 ced3c000
 dca0: cf4e8b80 cf40b100 cf4ed000 00000000 cf499500 ffff6f61 cf898c00=20
 c0496328
 dcc0: 000002a4 ced3dcd8 c011cd20 c011cd20 20000013 ffffffff
 [<c00090cc>] (__und_svc_finish+0x0/0x14) from [<c011cd20>]=20
 (do_get_write_access)
 [<c011cd20>] (do_get_write_access+0x320/0x474) from [<c011cfb8>]=20
 (jbd2_journal_)
 [<c011cfb8>] (jbd2_journal_get_write_access+0x24/0x38) from=20
 [<c010762c>] (__ext)
 [<c010762c>] (__ext4_journal_get_write_access+0x50/0x68) from=20
 [<c00f72e0>] (ext)
 [<c00f72e0>] (ext4_orphan_add+0x84/0x198) from [<c00efabc>]=20
 (ext4_setattr+0x510)
 [<c00efabc>] (ext4_setattr+0x510/0x54c) from [<c00a61d8>]=20
 (notify_change+0x210/)
 [<c00a61d8>] (notify_change+0x210/0x2fc) from [<c008d6d4>]=20
 (do_truncate+0x74/0x)
 [<c008d6d4>] (do_truncate+0x74/0x98) from [<c009b884>]=20
 (do_last.isra.46+0x9cc/0)
 [<c009b884>] (do_last.isra.46+0x9cc/0xb24) from [<c009ba84>]=20
 (path_openat+0xa8/)
 [<c009ba84>] (path_openat+0xa8/0x404) from [<c009c090>]=20
 (do_filp_open+0x2c/0x78)
 [<c009c090>] (do_filp_open+0x2c/0x78) from [<c008e520>]=20
 (do_sys_open+0xe8/0x174)
 [<c008e520>] (do_sys_open+0xe8/0x174) from [<c00093c0>]=20
 (ret_fast_syscall+0x0/0)



> Hello Michael
>
> We have encountered the same warnings with the Atmel SAMA5D35
> processor when using the RT_PREEMPT patch. We get the same warnings
> with both 3.6.9-rt21 and 3.10.9-rt5 kernels. However, the 3.6.9-rt21
> kernel boots just fine, and we also had problems booting the
> 3.10.9-rt5 kernel. Therefore these warnings and boot hanging might be
> unrelated.
>
> What's causing these warnings is still unknown, but at least we got
> the 3.10.9-rt5 kernel to boot. The boot problem seems to be caused by
> the TCB clock source (tcb_clksrc). You could try to unset the
> CONFIG_ATMEL_TCB_CLKSRC option, but this is not optimal configuration
> for rt.
>
> I have attached a patch which goes on top of the rt5 patch that seems
> to fix the boot hang issue. Could you please report the results if=20
> you
> have time to test this patch? Please note that I have not yet done=20
> any
> rt-tests with this patch.
>
> BR,
> Sami Pietik=C3=A4inen
> Software Developer
> Wapice Ltd.
>
> --- a/drivers/clocksource/tcb_clksrc.c	2013-08-29 16:14:14.611335823=20
> +0300
> +++ b/drivers/clocksource/tcb_clksrc.c	2013-08-29 16:16:28.129657272=20
> +0300
> @@ -192,9 +192,13 @@
>  	clkevt.clk =3D t2_clk;
>  	tc_irqaction.dev_id =3D &clkevt;
>
> -	timer_clock =3D clk32k_divisor_idx;
> +	timer_clock =3D divisor_idx;
>
> -	clkevt.clkevt.cpumask =3D cpumask_of(0);
> +	if (!divisor)
> +		clkevt.freq =3D 32768;
> +	else
> +		clkevt.freq =3D clk_get_rate(t2_clk)/divisor;
> +	clkevt.clkevt.cpumask =3D cpumask_of(0);
>
>  	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
