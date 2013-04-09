From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Debugging kernel lockups
Date: Tue, 9 Apr 2013 09:51:43 +0100
Message-ID: <CAFSh4UzFpuOqOFGRxxkBSxtj0r6U8MSmVjRH=6PG-XWGTajzJA@mail.gmail.com>
References: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
	<20120625154825.GA17960@opentech.at>
	<CAFSh4UxuQRbjxGmZKo-G2ufEqpB7D6PfKXS7k5vYOsvu5ZHqSA@mail.gmail.com>
	<CAFSh4Uz2Vjxg1yTZSuDbJfr8mw+xB3du89QPEXFd=Wo51RpXMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:35128 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab3DIIvo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Apr 2013 04:51:44 -0400
Received: by mail-vb0-f44.google.com with SMTP id e12so4599000vbg.3
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Apr 2013 01:51:43 -0700 (PDT)
In-Reply-To: <CAFSh4Uz2Vjxg1yTZSuDbJfr8mw+xB3du89QPEXFd=Wo51RpXMA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Another step along - disabling the MMC subsystem allows the boot to
complete normally.  I guess the next step is to build the MMC/SDHCI
drivers as modules so they can be added in.

Then what?  Can anyone point me toward a good resource for how to
tackle this sort of problem?

Thanks,
Tom

On Mon, Apr 8, 2013 at 10:14 AM, Tom Cook <tom.k.cook@gmail.com> wrote:
> Sorry it's taken me months to get back to this.  Here's the updated situation:
>
> I've got a serial console sorted out.  I've moved on to 3.6.11-rt31,
> as the upstream kernel has moved on to 3.6.11.  I've also moved the
> root filesystem to a USB stick, and it is now mounted correctly.
>
> I'm now not clear where the problem is.  The trace stops after
> starting udevd.  The complete boot log is below, with the default log
> level changed to 7.  I've also enable both soft- and hard-lockup
> detection in the kernel configuration, but it doesn't seem to have
> made any difference.
>
> The WARNING and BUG lines in the log are worrying, though the mmc
> controller seems to continue on from it - though in what state?  I
> guess that it's still trying to mount /boot from the SD card, which
> leads to the lockup, but it's only a guess.  Is the next step to
> disable the MMC controller driver altogether and see if that gets it
> any further through the boot?
>
> It is (unfortunately) dead enough that SysRq doesn't have any effect.
>
> Any advice is much appreciated!
>
> Thanks,
> Tom
>
> --- start boot log ---
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.6.11-rt31+ (tkcook@toad) (gcc version
> 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #3 PREEMPT RT Sun Apr 7
> 19:18:12 BST 2013
> [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7
> (ARMv7), cr=00c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT
> nonaliasing instruction cache
> [    0.000000] Machine: BCM2708
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 48768
> [    0.000000] Kernel command line: dma.dmachans=0x7f35
> bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=416 bcm2708.boardrev=0x2
> bcm2708.serial=0xfab9f5f8 smsc95xx.macaddr=B8:27:EB:B9:F5:F8
> sdhci-bcm2708.emmc_clock_freq=100000000 vc_mem.mem_base=0xec00000
> vc_mem.mem_size=0x10000000  dwc_otg.lpm_enable=0
> console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty1
> root=/dev/sda2 rootfstype=ext4 elevator=deadline rootwait oops=panic
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Memory: 192MB = 192MB total
> [    0.000000] Memory: 188836k/188836k available, 7772k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xcc800000 - 0xff000000   ( 808 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xcc000000   ( 192 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc04ccaf0   (4883 kB)
> [    0.000000]       .init : 0xc04cd000 - 0xc04eec00   ( 135 kB)
> [    0.000000]       .data : 0xc04f0000 - 0xc052c900   ( 243 kB)
> [    0.000000]        .bss : 0xc052c924 - 0xc05d5e54   ( 678 kB)
> [    0.000000] NR_IRQS:330
> [    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns,
> wraps every 4294967ms
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] console [tty1] enabled
> [    0.060102] Calibrating delay loop... 697.95 BogoMIPS (lpj=3489792)
> [    0.060110] pid_max: default: 32768 minimum: 301
> [    0.060572] Mount-cache hash table entries: 512
> [    0.061655] Initializing cgroup subsys cpuacct
> [    0.061663] Initializing cgroup subsys devices
> [    0.061672] Initializing cgroup subsys freezer
> [    0.061677] Initializing cgroup subsys blkio
> [    0.061848] CPU: Testing write buffer coherency: ok
> [    0.062168] hw perfevents: enabled with v6 PMU driver, 3 counters available
> [    0.062540] Setting up static identity map for 0x383230 - 0x38328c
> [    0.064867] devtmpfs: initialized
> [    0.080252] NET: Registered protocol family 16
> [    0.085082] DMA: preallocated 4096 KiB pool for atomic coherent allocations
> [    0.086362] bcm2708.uart_clock = 0
> [    0.088517] hw-breakpoint: found 6 breakpoint and 1 watchpoint registers.
> [    0.088576] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.088613] mailbox: Broadcom VideoCore Mailbox driver
> [    0.089055] bcm2708_vcio: mailbox at f200b880
> [    0.089241] bcm_power: Broadcom power driver
> [    0.089286] bcm_power_open() -> 0
> [    0.089314] bcm_power_request(0, 8)
> [    0.590019] bcm_mailbox_read -> 00000080, 0
> [    0.590066] bcm_power_request -> 0
> [    0.590095] Serial: AMBA PL011 UART driver
> [    0.590300] dev:f1: ttyAMA0 at MMIO 0x20201000 (irq = 83) is a PL011 rev3
> [    0.905460] console [ttyAMA0] enabled
> [    0.943430] bio: create slab <bio-0> at 0
> [    0.948818] SCSI subsystem initialized
> [    0.952900] usbcore: registered new interface driver usbfs
> [    0.958524] usbcore: registered new interface driver hub
> [    0.964156] usbcore: registered new device driver usb
> [    0.970993] Switching to clocksource stc
> [    0.975254] FS-Cache: Loaded
> [    0.978495] CacheFiles: Loaded
> [    0.998575] NET: Registered protocol family 2
> [    1.004058] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> [    1.011458] TCP bind hash table entries: 8192 (order: 6, 327680 bytes)
> [    1.018473] TCP: Hash tables configured (established 8192 bind 8192)
> [    1.024901] TCP: reno registered
> [    1.028170] UDP hash table entries: 256 (order: 2, 24576 bytes)
> [    1.034166] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
> [    1.040959] NET: Registered protocol family 1
> [    1.046245] RPC: Registered named UNIX socket transport module.
> [    1.052213] RPC: Registered udp transport module.
> [    1.056936] RPC: Registered tcp transport module.
> [    1.061670] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    1.068859] bcm2708_dma: DMA manager at f2007000
> [    1.073646] bcm2708_gpio: bcm2708_gpio_probe c04fe108
> [    1.079301] vc-mem: phys_addr:0x00000000 mem_base=0x0ec00000
> mem_size:0x10000000(256 MiB)
> [    1.088802] audit: initializing netlink socket (disabled)
> [    1.094323] type=2000 audit(1.080:1): initialized
> [    1.218727] VFS: Disk quotas dquot_6.5.2
> [    1.222782] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    1.230041] FS-Cache: Netfs 'nfs' registered for caching
> [    1.235972] NFS: Registering the id_resolver key type
> [    1.241160] Key type id_resolver registered
> [    1.245373] Key type id_legacy registered
> [    1.249854] msgmni has been set to 368
> [    1.256348] io scheduler noop registered
> [    1.260323] io scheduler deadline registered (default)
> [    1.265549] io scheduler cfq registered
> [    1.269412] start plist test
> [    1.276827] end plist test
> [    1.300385] Console: switching to colour frame buffer device 82x26
> [    1.312130] kgdb: Registered I/O driver kgdboc.
> [    1.333007] brd: module loaded
> [    1.345550] loop: module loaded
> [    1.351041] vchiq: vchiq_init_state: slot_zero = 0xcc804000, is_master = 0
> [    1.361136] usbcore: registered new interface driver smsc95xx
> [    1.369061] usbcore: registered new interface driver cdc_ncm
> [    1.376522] dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
> [    1.589221] Core Release: 2.80a
> [    1.594107] Setting default values for core params
> [    1.600730] Finished setting default values for core params
> [    1.813369] Using Buffer DMA mode
> [    1.818457] Periodic Transfer Interrupt Enhancement - disabled
> [    1.825987] Multiprocessor Interrupt Enhancement - disabled
> [    1.833302] OTG VER PARAM: 0, OTG VER FLAG: 0
> [    1.839476] Dedicated Tx FIFOs mode
> [    1.845354] dwc_otg bcm2708_usb: DWC OTG Controller
> [    1.852112] dwc_otg bcm2708_usb: new USB bus registered, assigned
> bus number 1
> [    1.861477] dwc_otg bcm2708_usb: irq 32, io mem 0x00000000
> [    1.868918] Init: Port Power? op_state=1
> [    1.874714] Init: Power Port (0)
> [    1.880050] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    1.888720] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.897849] usb usb1: Product: DWC OTG Controller
> [    1.904453] usb usb1: Manufacturer: Linux 3.6.11-rt31+ dwc_otg_hcd
> [    1.912623] usb usb1: SerialNumber: bcm2708_usb
> [    1.920027] hub 1-0:1.0: USB hub found
> [    1.925743] hub 1-0:1.0: 1 port detected
> [    1.932416] Initializing USB Mass Storage driver...
> [    1.939402] usbcore: registered new interface driver usb-storage
> [    1.947294] USB Mass Storage support registered.
> [    1.953961] usbcore: registered new interface driver libusual
> [    1.962142] mousedev: PS/2 mouse device common for all mice
> [    1.970553] bcm2835-cpufreq: min=700000 max=700000 cur=700000
> [    1.978391] bcm2835-cpufreq: switching to governor powersave
> [    1.985903] bcm2835-cpufreq: switching to governor powersave
> [    1.993377] cpuidle: using governor ladder
> [    1.999322] cpuidle: using governor menu
> [    2.005132] sdhci: Secure Digital Host Controller Interface driver
> [    2.013078] sdhci: Copyright(c) Pierre Ossman
> [    2.019283] sdhci: Enable low-latency mode
> [    2.045216] ------------[ cut here ]------------
> [    2.051655] WARNING: at kernel/sched/core.c:3375
> sdhci_spin_enable_schedule.isra.20.part.21+0x14/0x44()
> [    2.064608] Modules linked in:
> [    2.069472] [<c0013a78>] (unwind_backtrace+0x0/0xf0) from
> [<c001de18>] (warn_slowpath_common+0x4c/0x64)
> [    2.082468] [<c001de18>] (warn_slowpath_common+0x4c/0x64) from
> [<c001de4c>] (warn_slowpath_null+0x1c/0x24)
> [    2.096176] [<c001de4c>] (warn_slowpath_null+0x1c/0x24) from
> [<c02b077c>] (sdhci_spin_enable_schedule.isra.20.part.21+0x14/0x44)
> [    2.111876] [<c02b077c>]
> (sdhci_spin_enable_schedule.isra.20.part.21+0x14/0x44) from
> [<c02b225c>] (sdhci_set_clock+0x240/0x350)
> [    2.125214] Indeed it is in host mode hprt0 = 00021501
> [    2.143723] [<c02b225c>] (sdhci_set_clock+0x240/0x350) from
> [<c02b3608>] (sdhci_do_set_ios+0x3c/0x584)
> [    2.176289] [<c02b3608>] (sdhci_do_set_ios+0x3c/0x584) from
> [<c02a3124>] (mmc_power_up+0xb0/0xbc)
> [    2.198618] [<c02a3124>] (mmc_power_up+0xb0/0xbc) from [<c02a3dac>]
> (mmc_start_host+0x28/0x3c)
> [    2.220867] [<c02a3dac>] (mmc_start_host+0x28/0x3c) from
> [<c02a475c>] (mmc_add_host+0x58/0x7c)
> [    2.244875] [<c02a475c>] (mmc_add_host+0x58/0x7c) from [<c02b42ac>]
> (sdhci_add_host+0x6f0/0xa04)
> [    2.259287] [<c02b42ac>] (sdhci_add_host+0x6f0/0xa04) from
> [<c03794f0>] (sdhci_bcm2708_probe+0x290/0x414)
> [    2.274435] [<c03794f0>] (sdhci_bcm2708_probe+0x290/0x414) from
> [<c0223984>] (platform_drv_probe+0x18/0x1c)
> [    2.289905] [<c0223984>] (platform_drv_probe+0x18/0x1c) from
> [<c0222750>] (driver_probe_device+0x70/0x1f4)
> [    2.305265] [<c0222750>] (driver_probe_device+0x70/0x1f4) from
> [<c0222960>] (__driver_attach+0x8c/0x90)
> [    2.320242] [<c0222960>] (__driver_attach+0x8c/0x90) from
> [<c02210b0>] (bus_for_each_dev+0x50/0x7c)
> [    2.335058] [<c02210b0>] (bus_for_each_dev+0x50/0x7c) from
> [<c0221fc0>] (bus_add_driver+0x168/0x230)
> [    2.349857] [<c0221fc0>] (bus_add_driver+0x168/0x230) from
> [<c0222e18>] (driver_register+0x78/0x144)
> [    2.364756] [<c0222e18>] (driver_register+0x78/0x144) from
> [<c0008498>] (do_one_initcall+0x34/0x174)
> [    2.365100] usb 1-1: new high-speed USB device number 2 using dwc_otg
> [    2.365421] Indeed it is in host mode hprt0 = 00001101
> [    2.424138] [<c0008498>] (do_one_initcall+0x34/0x174) from
> [<c04cd864>] (kernel_init+0xe8/0x1a8)
> [    2.457157] [<c04cd864>] (kernel_init+0xe8/0x1a8) from [<c000e91c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.480099] ---[ end trace 0000000000000001 ]---
> [    2.488525] BUG: scheduling while atomic: swapper/1/0x00000002
> [    2.488533] Modules linked in:
> [    2.488589] [<c0013a78>] (unwind_backtrace+0x0/0xf0) from
> [<c037a95c>] (__schedule_bug+0x44/0x58)
> [    2.488618] [<c037a95c>] (__schedule_bug+0x44/0x58) from
> [<c037dfdc>] (__schedule+0x54c/0x63c)
> [    2.488641] [<c037dfdc>] (__schedule+0x54c/0x63c) from [<c037cf98>]
> (schedule_timeout+0x118/0x1d8)
> [    2.488669] [<c037cf98>] (schedule_timeout+0x118/0x1d8) from
> [<c002ac24>] (msleep+0x14/0x20)
> [    2.488701] [<c002ac24>] (msleep+0x14/0x20) from [<c02a3dac>]
> (mmc_start_host+0x28/0x3c)
> [    2.488725] [<c02a3dac>] (mmc_start_host+0x28/0x3c) from
> [<c02a475c>] (mmc_add_host+0x58/0x7c)
> [    2.488758] [<c02a475c>] (mmc_add_host+0x58/0x7c) from [<c02b42ac>]
> (sdhci_add_host+0x6f0/0xa04)
> [    2.488784] [<c02b42ac>] (sdhci_add_host+0x6f0/0xa04) from
> [<c03794f0>] (sdhci_bcm2708_probe+0x290/0x414)
> [    2.488814] [<c03794f0>] (sdhci_bcm2708_probe+0x290/0x414) from
> [<c0223984>] (platform_drv_probe+0x18/0x1c)
> [    2.488838] [<c0223984>] (platform_drv_probe+0x18/0x1c) from
> [<c0222750>] (driver_probe_device+0x70/0x1f4)
> [    2.488858] [<c0222750>] (driver_probe_device+0x70/0x1f4) from
> [<c0222960>] (__driver_attach+0x8c/0x90)
> [    2.488876] [<c0222960>] (__driver_attach+0x8c/0x90) from
> [<c02210b0>] (bus_for_each_dev+0x50/0x7c)
> [    2.488894] [<c02210b0>] (bus_for_each_dev+0x50/0x7c) from
> [<c0221fc0>] (bus_add_driver+0x168/0x230)
> [    2.488912] [<c0221fc0>] (bus_add_driver+0x168/0x230) from
> [<c0222e18>] (driver_register+0x78/0x144)
> [    2.488931] [<c0222e18>] (driver_register+0x78/0x144) from
> [<c0008498>] (do_one_initcall+0x34/0x174)
> [    2.488964] [<c0008498>] (do_one_initcall+0x34/0x174) from
> [<c04cd864>] (kernel_init+0xe8/0x1a8)
> [    2.488993] [<c04cd864>] (kernel_init+0xe8/0x1a8) from [<c000e91c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.505090] mmc0: SDHCI controller on BCM2708_Arasan [platform]
> using platform's DMA
> [    2.505152] mmc0: BCM2708 SDHC host at 0x20300000 DMA 2 IRQ 77
> [    2.505274] initcall sdhci_drv_init+0x0/0xc returned with
> preemption imbalance
> [    2.625811] usb 1-1: New USB device found, idVendor=0424, idProduct=9512
> [    2.625825] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    2.627065] hub 1-1:1.0: USB hub found
> [    2.627344] hub 1-1:1.0: 3 ports detected
> [    2.834522] sdhci-pltfm: SDHCI platform and OF driver helper
> [    2.843192] Registered led device: led0
> [    2.850518] usbcore: registered new interface driver usbhid
> [    2.858631] usbhid: USB HID core driver
> [    2.865575] TCP: cubic registered
> [    2.871259] Initializing XFRM netlink socket
> [    2.877870] NET: Registered protocol family 17
> [    2.884797] Key type dns_resolver registered
> [    2.891728] VFP support v0.3: implementor 41 architecture 1 part 20
> variant b rev 5
> [    2.904764] registered taskstats version 1
> [    2.905413] usb 1-1.1: new high-speed USB device number 3 using dwc_otg
> [    2.921367] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    2.930369] Waiting for root device /dev/sda2...
> [    3.006203] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
> [    3.015227] usb 1-1.1: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [    3.028003] smsc95xx v1.0.4
> [    3.097438] smsc95xx 1-1.1:1.0: eth0: register 'smsc95xx' at
> usb-bcm2708_usb-1.1, smsc95xx USB 2.0 Ethernet, b8:27:eb:b9:f5:f8
> [    3.205279] usb 1-1.2: new high-speed USB device number 4 using dwc_otg
> [    3.319424] usb 1-1.2: New USB device found, idVendor=07ab, idProduct=fcf6
> [    3.328555] usb 1-1.2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    3.338062] usb 1-1.2: Product: DataBar USB2.0
> [    3.344668] usb 1-1.2: Manufacturer: Freecom
> [    3.351151] usb 1-1.2: SerialNumber: 907708280033
> [    3.359863] scsi0 : usb-storage 1-1.2:1.0
> [    4.367260] scsi 0:0:0:0: Direct-Access     Freecom  DataBar USB2.0
>   1100 PQ: 0 ANSI: 0 CCS
> [    4.383919] sd 0:0:0:0: [sda] 7831552 512-byte logical blocks:
> (4.00 GB/3.73 GiB)
> [    4.399896] sd 0:0:0:0: [sda] Write Protect is off
> [    4.407013] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
> [    4.415792] sd 0:0:0:0: [sda] No Caching mode page present
> [    4.423482] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [    4.439408] sd 0:0:0:0: [sda] No Caching mode page present
> [    4.447066] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [    4.456961]  sda: sda1 sda2
> [    4.467394] sd 0:0:0:0: [sda] No Caching mode page present
> [    4.475228] sd 0:0:0:0: [sda] Assuming drive cache: write through
> [    4.483324] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [    4.511803] EXT4-fs (sda2): mounted filesystem with ordered data
> mode. Opts: (null)
> [    4.523574] VFS: Mounted root (ext4 filesystem) on device 8:2.
> [    4.545786] devtmpfs: mounted
> [    4.551326] Freeing init memory: 132K
> [    6.451092] udevd[152]: starting version 175
>
>
> On Mon, Jun 25, 2012 at 11:10 PM, Tom Cook <tom.k.cook@gmail.com> wrote:
>>
>> On Mon, Jun 25, 2012 at 4:48 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
>> > On Mon, 25 Jun 2012, Tom Cook wrote:
>> [snip]
>> > I would start out with putting the rootfs into a ramdisk or on nfs and then
>> > you have the freedom to check in more detail what is going wrong with the
>> > SD/MMC/FS there as its then just a module to debug. In a system that halts
>> > at this point I doubt that kgdb or the like would be of much use.
>> >
>> > hofrat
>> >
>>
>> A good suggestion, thanks.  I'll try that when I get back to my desk tomorrow.
>>
>> Cheers,
>> Tom
