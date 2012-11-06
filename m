From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
Date: Tue, 6 Nov 2012 10:40:54 +0800
Message-ID: <20121106024052.GA27643@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:21160
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933421Ab2KFCP0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2012 21:15:26 -0500
Content-Disposition: inline
In-Reply-To: <20121105222859.GI28327@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 05, 2012 at 10:28:59PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 05:09:13PM +0100, Stanislav Meduna wrote:
> > On 05.11.2012 14:46, Shawn Guo wrote:
> > 
> > >>> From my quick testing on imx23 with printk timestamp, it's not OK,
> > >>> so we may need to leave imx23 out there.
> > >>
> > > I should say it's practically not OK since it wraps in such a short
> > > period.  But it actually works as expected.
> > > 
> > >> Hmm, does it wrap after 2 seconds?
> > > 
> > > Yes, it does wrap after ~2 seconds.
> > 
> > This is weird. AFAIK the printk should be using sched_clock(),
> > which is a weak symbol overridden in arch/arm/kernel/sched_clock.c
> > and it should take care of the extension to never-ever-wrapping
> > 64-bit timestamp. Looks that it does not and if it does not,
> > I think there is more to be worried of than just printk timestamps.
> 
> It most certainly does handle the wrapping correctly - it was designed
> to from the very start.
> 
> > BTW this patch deserves IMHO looking at
> >   https://patchwork.kernel.org/patch/1193631/
> > but it is probably not the problem here.
> 
> Yes, that patch is probably required... if an update to the sched_clock
> epoch happens on a different CPU, then the epoch cycles can be in advance
> of the read clock cycle value.  That needs to get into my patch system.

Here is the boot log on my imx23 board after applying both Stanislav's
and Katsuki's patches.

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc1-00012-ga31941d (r65073@S2101-09) (gcc ver
sion 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #756 Tue Nov 6 10:04:30 CST 2012
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Freescale i.MX23 (Device Tree), model: Freescale i.MX23
Evaluation Kit
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c051ada8, node_mem_map c0a7000
0
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pag
es: 32512
[    0.000000] Kernel command line: console=ttyAMA0,115200 debug earlyprintk roo
t=/dev/mmcblk0p3 rw rootwait no_console_suspend
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 119200k/119200k available, 11872k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04bf150   (4829 kB)
[    0.000000]       .init : 0xc04c0000 - 0xc04e29cc   ( 139 kB)
[    0.000000]       .data : 0xc04e4000 - 0xc051d5c0   ( 230 kB)
[    0.000000]        .bss : 0xc051d5e4 - 0xc0a6ce38   (5439 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, N
odes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] of_irq_init: children remain, but no parents
[    0.000000] sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 20
47ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo
 Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.002593] Calibrating delay loop... 113.04 BogoMIPS (lpj=565248)
[    0.091312] pid_max: default: 32768 minimum: 301
[    0.092812] Mount-cache hash table entries: 512
[    0.109875] CPU: Testing write buffer coherency: ok
[    0.114000] Setting up static identity map for 0x4035d718 - 0x4035d770
[    0.135625] devtmpfs: initialized
[    0.147843] pinctrl core: initialized pinctrl subsystem
[    0.159093] regulator-dummy: no parameters
[    0.165000] NET: Registered protocol family 16
[    0.168000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.204156] gpiochip_add: registered GPIOs 0 to 31 on device: gpio.0
[    0.210968] gpiochip_add: registered GPIOs 32 to 63 on device: gpio.1
[    0.217812] gpiochip_add: registered GPIOs 64 to 95 on device: gpio.2
[    0.240750] Serial: AMBA PL011 UART driver
[    0.244781] 80070000.serial: ttyAMA0 at MMIO 0x80070000 (irq = 129) is a PL01
1 rev2
[    0.592281] console [ttyAMA0] enabled
[    0.656187] bio: create slab <bio-0> at 0
[    0.681406] mxs-dma 80004000.dma-apbh: initialized
[    0.700843] mxs-dma 80024000.dma-apbx: initialized
[    0.707500] of_get_named_gpio_flags exited with status 61
[    0.714750] vddio-sd0: 3300 mV
[    0.722156] SCSI subsystem initialized
[    0.729187] usbcore: registered new interface driver usbfs
[    0.735468] usbcore: registered new interface driver hub
[    0.742250] usbcore: registered new device driver usb
[    0.755250] Advanced Linux Sound Architecture Driver Initialized.
[    0.771875] Switching to clocksource mxs_timer
[    1.108937] NET: Registered protocol family 2
[    1.119687] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    1.128125] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    1.143437] TCP: Hash tables configured (established 4096 bind 4096)
[    1.151031] TCP: reno registered
[    1.154437] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.161843] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.172031] NET: Registered protocol family 1
[    1.183812] RPC: Registered named UNIX socket transport module.
[    1.190093] RPC: Registered udp transport module.
[    1.194906] RPC: Registered tcp transport module.
[    1.200656] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.211156] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.360156] NFS: Registering the id_resolver key type
[    1.367843] Key type id_resolver registered
[    1.372156] Key type id_legacy registered
[    1.377000] msgmni has been set to 232
[    1.392187] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2
52)
[    1.400312] io scheduler noop registered (default)
[    1.415281] of_get_named_gpio_flags exited with status 50
[    1.451406] Console: switching to colour frame buffer device 60x17
[    1.468312] mxsfb 80030000.lcdif: initialized
[    1.475156] uart-pl011 80070000.serial: no DMA platform data
[    1.483500] 8006c000.serial: ttyAPP0 at MMIO 0x8006c000 (irq = 126) is a 8006
c000.serial
[    1.494343] mxs-auart 8006c000.serial: Found APPUART 3.0.0
[    1.514343] gpmi-nand 8000c000.gpmi-nand: driver registration failed: -12
[    1.521781] gpmi-nand: probe of 8000c000.gpmi-nand failed with error -12
[    1.531500] Initializing USB Mass Storage driver...
[    1.537593] usbcore: registered new interface driver usb-storage
[    1.543687] USB Mass Storage support registered.
[    1.554500] mousedev: PS/2 mouse device common for all mice
[    1.567562] stmp3xxx-rtc 8005c000.rtc: rtc core: registered 8005c000.rtc as r
tc0
[    1.575875] i2c /dev entries driver
[    1.586375] of_get_named_gpio_flags exited with status 62
[    1.627437] mxs-mmc 80010000.ssp: initialized
[    1.647250] usbcore: registered new interface driver usbhid
[    1.653125] usbhid: USB HID core driver
[    1.675562] TCP: cubic registered
[    1.679500] NET: Registered protocol family 17
[    1.688500] Key type dns_resolver registered
[    1.707781] registered taskstats version 1
[    1.714531] stmp3xxx-rtc 8005c000.rtc: setting system clock to 1970-01-01 00:
02:53 UTC (173)
[    1.767593] ALSA device list:
[    1.770625]   No soundcards found.
[    1.790343] Waiting for root device /dev/mmcblk0p3...
[    1.798468] mmc0: new SD card at address d555
[    1.809625] mmcblk0: mmc0:d555 SD02G 1.89 GiB
[    1.834218]  mmcblk0: p1 p2 p3
[    0.458156] kjournald starting.  Commit interval 5 seconds
[    0.465187] EXT3-fs (mmcblk0p3): warning: maximal mount count reached, runnin
g e2fsck is recommended
[    0.607000] EXT3-fs (mmcblk0p3): using internal journal
[    0.620187] EXT3-fs (mmcblk0p3): recovery complete
[    0.625093] EXT3-fs (mmcblk0p3): mounted filesystem with ordered data mode
[    0.632781] VFS: Mounted root (ext3 filesystem) on device 179:3.
[    0.640718] Freeing init memory: 136K

