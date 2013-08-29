From: Michael Langfinger <linux-rt-users@langfinger.org>
Subject: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free  already-free IRQ 1"
Date: Thu, 29 Aug 2013 23:54:07 +0200
Message-ID: <e7967c50c065cae070065e2283398b9e-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3XFoWXV1+H1RVQ11fSCoDXF1eSFlWWgxY-webmailer2@server04.webmailer.hosteurope.de>
Reply-To: linux-rt-users@langfinger.org
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from server03.mc0.hosteurope.de ([92.51.170.74]:50543 "EHLO
	server03.mc0.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191Ab3H2WCt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 18:02:49 -0400
Received: from server04.webmailer.hosteurope.de ([10.9.0.183]);
	by mailout.hosteurope.de (server03.mc0.hosteurope.de) running EXperimental Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1VFAAJ-0004Gh-Bd
	for linux-rt-users@vger.kernel.org; Thu, 29 Aug 2013 23:54:07 +0200
Received: from nobody by server04.webmailer.hosteurope.de with local (Exim 4.72)
	(envelope-from <linux-rt-users@langfinger.org>)
	id 1VFAAJ-0005Ph-AD
	for linux-rt-users@vger.kernel.org; Thu, 29 Aug 2013 23:54:07 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi,

 when I try to boot kernel 3.10.9-rt5 (or lower) on the Atmel 
 AT91SAM9G25, I get the following error:

 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.9-rt5 #1
 [<c000cffc>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>] 
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c001550c>] 
 (warn_slowpath_common+0x4)
 [<c001550c>] (warn_slowpath_common+0x4c/0x68) from [<c00155a8>] 
 (warn_slowpath_)
 [<c00155a8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004f84c>] 
 (__free_irq+0x90/0)
 [<c004f84c>] (__free_irq+0x90/0x1a8) from [<c0043d18>] 
 (clockevents_set_mode+0x)
 [<c0043d18>] (clockevents_set_mode+0x28/0x5c) from [<c0043d5c>] 
 (clockevents_sh)
 [<c0043d5c>] (clockevents_shutdown+0x10/0x20) from [<c004403c>] 
 (clockevents_ex)
 [<c004403c>] (clockevents_exchange_device+0x74/0x80) from [<c0044410>] 
 (tick_no)
 [<c0044410>] (tick_notify+0xec/0x2d8) from [<c0035768>] 
 (notifier_call_chain+0x)
 [<c0035768>] (notifier_call_chain+0x38/0x68) from [<c00357b8>] 
 (raw_notifier_ca)
 [<c00357b8>] (raw_notifier_call_chain+0x14/0x18) from [<c0043c58>] 
 (clockevents)
 [<c0043c58>] (clockevents_register_device+0x90/0x128) from [<c0453abc>] 
 (time_i)
 [<c0453abc>] (time_init+0x1c/0x28) from [<c04508c4>] 
 (start_kernel+0x1b0/0x304)
 [<c04508c4>] (start_kernel+0x1b0/0x304) from [<20008040>] (0x20008040)
 ---[ end trace 0000000000000001 ]---

 This happens twice and the system hangs afterwards. I tried with  with 
 CONFIG_PREEMPT_RT_FULL as well as with CONFIG_PREEMPT_RTB, in both cases 
 I get the same error.

 I am no expert in this matter, so I would be grateful for any 
 assistance that might help me to solve the problem. Thank you!

 Kind regards,

 Michael Langfinger

 P.S.: Below you can find the complete output of the boot sequence, if 
 it helps.

 Uncompressing Linux... done, booting the kernel.
 Booting Linux on physical CPU 0x0
 Linux version 3.10.9-rt5 (mitarbeiter@ariag25-dev) (gcc version 4.7.3 
 (Ubuntu/L3
 CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
 CPU: VIVT data cache, VIVT instruction cache
 Machine: Atmel AT91SAM (Device Tree), model: Acme Systems Aria G25
 Memory policy: ECC disabled, Data cache writeback
 AT91: Detected soc type: at91sam9x5
 AT91: Detected soc subtype: at91sam9g25
 AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
 DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
 Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
 Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
 65024
 Kernel command line: mem=256M console=ttyS0,115200 root=/dev/mmcblk0p2 
 rootfsty1
 PID hash table entries: 1024 (order: 0, 4096 bytes)
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
 Memory: 256MB = 256MB total
 Memory: 254852k/254852k available, 7292k reserved, 0K highmem
 Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc044f5e8   (4382 kB)
       .init : 0xc0450000 - 0xc04768dc   ( 155 kB)
       .data : 0xc0478000 - 0xc04a9740   ( 198 kB)
        .bss : 0xc04a9740 - 0xc04d5858   ( 177 kB)
 SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
 Preemptible hierarchical RCU implementation.
 NR_IRQS:16 nr_irqs:16 16
 ------------[ cut here ]------------
 WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
 Trying to free already-free IRQ 1
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.9-rt5 #1
 [<c000cffc>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>] 
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c001550c>] 
 (warn_slowpath_common+0x4)
 [<c001550c>] (warn_slowpath_common+0x4c/0x68) from [<c00155a8>] 
 (warn_slowpath_)
 [<c00155a8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004f84c>] 
 (__free_irq+0x90/0)
 [<c004f84c>] (__free_irq+0x90/0x1a8) from [<c0043d18>] 
 (clockevents_set_mode+0x)
 [<c0043d18>] (clockevents_set_mode+0x28/0x5c) from [<c0043d5c>] 
 (clockevents_sh)
 [<c0043d5c>] (clockevents_shutdown+0x10/0x20) from [<c004403c>] 
 (clockevents_ex)
 [<c004403c>] (clockevents_exchange_device+0x74/0x80) from [<c0044410>] 
 (tick_no)
 [<c0044410>] (tick_notify+0xec/0x2d8) from [<c0035768>] 
 (notifier_call_chain+0x)
 [<c0035768>] (notifier_call_chain+0x38/0x68) from [<c00357b8>] 
 (raw_notifier_ca)
 [<c00357b8>] (raw_notifier_call_chain+0x14/0x18) from [<c0043c58>] 
 (clockevents)
 [<c0043c58>] (clockevents_register_device+0x90/0x128) from [<c0453abc>] 
 (time_i)
 [<c0453abc>] (time_init+0x1c/0x28) from [<c04508c4>] 
 (start_kernel+0x1b0/0x304)
 [<c04508c4>] (start_kernel+0x1b0/0x304) from [<20008040>] (0x20008040)
 ---[ end trace 0000000000000001 ]---
 sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 
 3489660920ms
 Console: colour dummy device 80x30
 Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
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
 CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.10.9-rt5 #1
 [<c000cffc>] (unwind_backtrace+0x0/0xe0) from [<c000b58c>] 
 (show_stack+0x10/0x1)
 [<c000b58c>] (show_stack+0x10/0x14) from [<c001550c>] 
 (warn_slowpath_common+0x4)
 [<c001550c>] (warn_slowpath_common+0x4c/0x68) from [<c00155a8>] 
 (warn_slowpath_)
 [<c00155a8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004f84c>] 
 (__free_irq+0x90/0)
 [<c004f84c>] (__free_irq+0x90/0x1a8) from [<c0043d18>] 
 (clockevents_set_mode+0x)
 [<c0043d18>] (clockevents_set_mode+0x28/0x5c) from [<c0043ff0>] 
 (clockevents_ex)
 [<c0043ff0>] (clockevents_exchange_device+0x28/0x80) from [<c0044410>] 
 (tick_no)
 [<c0044410>] (tick_notify+0xec/0x2d8) from [<c0035768>] 
 (notifier_call_chain+0x)
 [<c0035768>] (notifier_call_chain+0x38/0x68) from [<c00357b8>] 
 (raw_notifier_ca)
 [<c00357b8>] (raw_notifier_call_chain+0x14/0x18) from [<c0043c58>] 
 (clockevents)
 [<c0043c58>] (clockevents_register_device+0x90/0x128) from [<c04694e4>] 
 (tcb_cl)
 [<c04694e4>] (tcb_clksrc_init+0x1c4/0x204) from [<c0008890>] 
 (do_one_initcall+0)
 [<c0008890>] (do_one_initcall+0x90/0x148) from [<c0450b00>] 
 (kernel_init_freeab)
 [<c0450b00>] (kernel_init_freeable+0xe8/0x1ac) from [<c0323138>] 
 (kernel_init+0)
 [<c0323138>] (kernel_init+0x8/0xe4) from [<c0009450>] 
 (ret_from_fork+0x14/0x24)
 ---[ end trace 0000000000000002 ]---
 bio: create slab <bio-0> at 0
 at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave 
 ), 8 chas
 at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave 
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
 fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 16) is a ATMEL_SERIAL
 console [ttyS0] enabled
 f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 23) is a ATMEL_SERIAL
 f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq = 24) is a ATMEL_SERIAL
 brd: module loaded
 loop: module loaded
 atmel_spi f0000000.spi: version: 0x212
 atmel_spi f0000000.spi: DMA channel not available, SPI unable to use 
 DMA
 atmel_spi f0000000.spi: Atmel SPI Controller using PIO only
 atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 28)
 atmel_spi f0000000.spi: master is unqueued, this is deprecated
 macb f802c000.ethernet (unregistered net_device): invalid hw address, 
 using ranm
 libphy: MACB_mii_bus: probed
 macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 25 
 (2a:4d:fa:f3:37:)
 macb f802c000.ethernet eth0: attached PHY driver [SMSC LAN8710/LAN8720] 
 (mii_bu)
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 ehci-atmel: EHCI Atmel driver
 atmel-ehci 700000.ehci: EHCI Host Controller
 atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
 atmel-ehci 700000.ehci: irq 29, io mem 0x00700000

