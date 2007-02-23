From: Andrew Burgess <aab@cichlid.com>
Subject: Re: patch-2.6.20-rt5: time warp detected! (and rt8)
Date: Fri, 23 Feb 2007 08:16:57 -0800
Message-ID: <200702231616.l1NGGvPJ006884@cichlid.com>
To: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dsl3-63-249-91-56.cruzio.com ([63.249.91.56]:50893 "EHLO
	cichlid.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127AbXBWQRd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Feb 2007 11:17:33 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>On Wed, 2007-02-21 at 19:41 +0100, Wolfgang Grandegger wrote:
>> Thomas Gleixner wrote:
>> > On Tue, 2007-02-20 at 13:10 -0500, Alex Khripin wrote:
>> >> I have seen a similar event as well on -rt5; SMP kernel but on a P4 with 
>> >> hyperthreading disabled.
>> > 
>> > Alex, Wolfgang,
>> > 
>> > does this happen with -rt9 too ?
>> 
>> Where can I find -rt9? At least it's not yet available on 
>> http://people.redhat.com/mingo/realtime-preempt/.

>oops. -rt8 is the latest.

I got it with rt8 and I had to alt-sysreq-b to recover. The
system seemed somewhat responsive but I couldn't get X back
nor did ctl-alt-del work.

I see that I got a "tasklet action" BUG at midday too.

Here's the boot log:

(how far does a boot log go anyway - up to rc.local or...?)

------------------------------------------------------------------

Feb 21 07:15:51 cichlid syslogd 1.4.1: restart (remote reception).
Feb 21 07:15:51 cichlid syslog: syslogd startup succeeded
Feb 21 07:15:51 cichlid kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 21 07:15:51 cichlid syslog: klogd startup succeeded
Feb 21 07:15:51 cichlid kernel: Inspecting /boot/System.map-2.6.20-raid-rt8-1
Feb 21 07:15:51 cichlid kernel: Loaded 27864 symbols from /boot/System.map-2.6.20-raid-rt8-1.
Feb 21 07:15:51 cichlid kernel: Symbols match kernel version 2.6.20.
Feb 21 07:15:51 cichlid kernel: No module symbols loaded - kernel modules not enabled. 
Feb 21 07:15:51 cichlid kernel: Linux version 2.6.20-raid-rt8-1 (root@athlon) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP PREEMPT Mon Feb 19 10:10:11 PST 2007
Feb 21 07:15:51 cichlid kernel: BIOS-provided physical RAM map:
Feb 21 07:15:51 cichlid kernel: sanitize start
Feb 21 07:15:51 cichlid kernel: sanitize end
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
Feb 21 07:15:51 cichlid kernel: copy_e820_map() type is E820_RAM
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end: 0000000000100000 type: 2
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 0000000000100000 size: 00000000bfeb0000 end: 00000000bffb0000 type: 1
Feb 21 07:15:51 cichlid kernel: copy_e820_map() type is E820_RAM
Feb 21 07:15:51 cichlid irqbalance: irqbalance startup succeeded
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 00000000bffb0000 size: 0000000000010000 end: 00000000bffc0000 type: 3
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 00000000bffc0000 size: 0000000000030000 end: 00000000bfff0000 type: 4
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 00000000bfff0000 size: 0000000000010000 end: 00000000c0000000 type: 2
Feb 21 07:15:51 cichlid kernel: copy_e820_map() start: 00000000ff780000 size: 0000000000880000 end: 0000000100000000 type: 2
Feb 21 07:15:51 cichlid portmap[5917]: Only binding to LOOPBACK address!
Feb 21 07:15:51 cichlid portmap: portmap startup succeeded
Feb 21 07:15:51 cichlid kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 21 07:15:51 cichlid kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 00000000bffb0000 - 00000000bffc0000 (ACPI data)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 00000000bffc0000 - 00000000bfff0000 (ACPI NVS)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
Feb 21 07:15:52 cichlid kernel:  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Feb 21 07:15:52 cichlid kernel: 2175MB HIGHMEM available.
Feb 21 07:15:52 cichlid rpc.statd[5936]: Version 1.0.6 Starting
Feb 21 07:15:52 cichlid kernel: 896MB LOWMEM available.
Feb 21 07:15:52 cichlid kernel: found SMP MP-table at 000ff780
Feb 21 07:15:52 cichlid nfslock: rpc.statd startup succeeded
Feb 21 07:15:52 cichlid kernel: Zone PFN ranges:
Feb 21 07:15:52 cichlid kernel:   DMA             0 ->     4096
Feb 21 07:15:52 cichlid kernel:   Normal       4096 ->   229376
Feb 21 07:15:52 cichlid kernel:   HighMem    229376 ->   786352
Feb 21 07:15:52 cichlid kernel: early_node_map[1] active PFN ranges
Feb 21 07:15:52 cichlid kernel:     0:        0 ->   786352
Feb 21 07:15:52 cichlid kernel: DMI 2.3 present.
Feb 21 07:15:52 cichlid kernel: ACPI: PM-Timer IO Port: 0x808
Feb 21 07:15:52 cichlid kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Feb 21 07:15:52 cichlid kernel: Processor #0 15:3 APIC version 16
Feb 21 07:15:52 cichlid kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Feb 21 07:15:52 cichlid kernel: Processor #1 15:3 APIC version 16
Feb 21 07:15:52 cichlid kernel: ACPI: Skipping IOAPIC probe due to 'noapic' option.
Feb 21 07:15:52 cichlid kernel: Using ACPI for processor (LAPIC) configuration information
Feb 21 07:15:52 cichlid kernel: Intel MultiProcessor Specification v1.1
Feb 21 07:15:52 cichlid kernel:     Virtual Wire compatibility mode.
Feb 21 07:15:52 cichlid kernel: OEM ID: ASUSTeK  Product ID: Deluxe       APIC at: 0xFEE00000
Feb 21 07:15:52 cichlid kernel: I/O APIC #2 Version 3 at 0xFEC00000.
Feb 21 07:15:52 cichlid kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 21 07:15:52 cichlid kernel: Processors: 2
Feb 21 07:15:52 cichlid kernel: Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
Feb 21 07:15:52 cichlid kernel: Detected 2002.736 MHz processor.
Feb 21 07:15:52 cichlid kernel: Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Feb 21 07:15:52 cichlid rpcidmapd: rpc.idmapd startup succeeded
Feb 21 07:15:52 cichlid kernel: Built 1 zonelists.  Total pages: 780209
Feb 21 07:15:52 cichlid kernel: Kernel command line: ro root=LABEL=/ rhgb vga=791 raid=noautodetect noapic
Feb 21 07:15:52 cichlid kernel: Enabling fast FPU save and restore... done.
Feb 21 07:15:52 cichlid kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 21 07:15:52 cichlid kernel: Initializing CPU#0
Feb 21 07:15:53 cichlid kernel: WARNING: experimental RCU implementation.
Feb 21 07:15:53 cichlid kernel: CPU 0 irqstacks, hard=c04e4000 soft=c04e2000
Feb 21 07:15:53 cichlid kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb 21 07:15:53 cichlid kernel: Console: colour dummy device 80x25
Feb 21 07:15:53 cichlid kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb 21 07:15:53 cichlid kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 21 07:15:53 cichlid kernel: Memory: 3112400k/3145408k available (2263k kernel code, 31712k reserved, 1442k data, 232k init, 2227904k highmem)
Feb 21 07:15:53 cichlid kernel: virtual kernel memory layout:
Feb 21 07:15:53 cichlid kernel:     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
Feb 21 07:15:53 cichlid kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Feb 21 07:15:53 cichlid kernel:     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
Feb 21 07:15:53 cichlid kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Feb 21 07:15:53 cichlid kernel:       .init : 0xc04a3000 - 0xc04dd000   ( 232 kB)
Feb 21 07:15:53 cichlid kernel:       .data : 0xc0335cdd - 0xc049e6d4   (1442 kB)
Feb 21 07:15:53 cichlid kernel:       .text : 0xc0100000 - 0xc0335cdd   (2263 kB)
Feb 21 07:15:53 cichlid kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 21 07:15:53 cichlid kernel: Calibrating delay using timer specific routine.. 4008.03 BogoMIPS (lpj=2004015)
Feb 21 07:15:53 cichlid kernel: Security Framework v1.0.0 initialized
Feb 21 07:15:53 cichlid kernel: Capability LSM initialized
Feb 21 07:15:53 cichlid kernel: Mount-cache hash table entries: 512
Feb 21 07:15:53 cichlid kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 21 07:15:53 cichlid kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb 21 07:15:53 cichlid kernel: CPU 0(2) -> Core 0
Feb 21 07:15:53 cichlid kernel: Intel machine check architecture supported.
Feb 21 07:15:53 cichlid kernel: Intel machine check reporting enabled on CPU#0.
Feb 21 07:15:53 cichlid kernel: Compat vDSO mapped to ffffe000.
Feb 21 07:15:53 cichlid kernel: Checking 'hlt' instruction... OK.
Feb 21 07:15:53 cichlid kernel: Freeing SMP alternatives: 10k freed
Feb 21 07:15:53 cichlid kernel: ACPI: Core revision 20060707
Feb 21 07:15:53 cichlid kernel: ACPI: setting ELCR to 0200 (from 0c20)
Feb 21 07:15:53 cichlid kernel: CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Feb 21 07:15:53 cichlid kernel: Booting processor 1/1 eip 2000
Feb 21 07:15:53 cichlid kernel: CPU 1 irqstacks, hard=c04e5000 soft=c04e3000
Feb 21 07:15:53 cichlid kernel: Initializing CPU#1
Feb 21 07:15:53 cichlid kernel: Calibrating delay using timer specific routine.. 4004.53 BogoMIPS (lpj=2002267)
Feb 21 07:15:53 cichlid kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 21 07:15:53 cichlid kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb 21 07:15:53 cichlid kernel: CPU 1(2) -> Core 1
Feb 21 07:15:53 cichlid kernel: Intel machine check architecture supported.
Feb 21 07:15:53 cichlid kernel: Intel machine check reporting enabled on CPU#1.
Feb 21 07:15:53 cichlid kernel: CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Feb 21 07:15:53 cichlid kernel: Total of 2 processors activated (8012.56 BogoMIPS).
Feb 21 07:15:53 cichlid kernel: Brought up 2 CPUs
Feb 21 07:15:53 cichlid kernel: migration_cost=409
Feb 21 07:15:53 cichlid rc: Starting pcmcia:  succeeded
Feb 20 23:15:23 cichlid rc.sysinit: -e 
Feb 21 07:15:53 cichlid kernel: NET: Registered protocol family 16
Feb 20 23:15:26 cichlid start_udev: Starting udev:  succeeded 
Feb 21 07:15:53 cichlid kernel: ACPI: bus type pci registered
Feb 20 23:15:35 cichlid rc.sysinit: -e 
Feb 21 07:15:53 cichlid kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
Feb 20 23:15:35 cichlid sysctl: net.ipv4.ip_forward = 1 
Feb 21 07:15:53 cichlid kernel: PCI: Using configuration type 1
Feb 20 23:15:35 cichlid sysctl: net.ipv4.conf.all.rp_filter = 1 
Feb 21 07:15:53 cichlid kernel: Setting up standard PCI resources
Feb 20 23:15:35 cichlid sysctl: kernel.sysrq = 1 
Feb 21 07:15:53 cichlid kernel: ACPI: Interpreter enabled
Feb 20 23:15:35 cichlid sysctl: kernel.core_uses_pid = 1 
Feb 21 07:15:53 cichlid kernel: ACPI: Using PIC for interrupt routing
Feb 20 23:15:35 cichlid rc.sysinit: Configuring kernel parameters:  succeeded 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb 21 07:15:37 cichlid date: Wed Feb 21 07:15:37 PST 2007 
Feb 21 07:15:37 cichlid rc.sysinit: Setting clock  (localtime): Wed Feb 21 07:15:37 PST 2007 succeeded 
Feb 21 07:15:53 cichlid kernel: PCI: enabled onboard AC97/MC97 devices
Feb 21 07:15:37 cichlid rc.sysinit: Loading default keymap succeeded 
Feb 21 07:15:37 cichlid rc.sysinit: Setting hostname athlon:  succeeded 
Feb 21 07:15:38 cichlid fsck: /: clean, 450019/2501856 files, 4129741/5002239 blocks 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
Feb 21 07:15:38 cichlid rc.sysinit: Checking root filesystem succeeded 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
Feb 21 07:15:38 cichlid rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
Feb 21 07:15:39 cichlid fsck: /boot: clean, 237/26104 files, 54849/104388 blocks 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
Feb 21 07:15:39 cichlid fsck: md: clean, 279033/4255744 files, 64859411/68089494 blocks 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Feb 21 07:15:39 cichlid fsck: news: clean, 1921348/3670016 files, 5632309/7338744 blocks 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Feb 21 07:15:39 cichlid fsck: mq: clean, 33930/2424832 files, 19393024/19393024 blocks 
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Feb 21 07:15:39 cichlid fsck: ms: clean, 602288/2134016 files, 15816455/17061888 blocks 
Feb 21 07:15:53 cichlid mount: /src/cdroms/FC-5-i386-DVD-Unity-20060523.iso: No such file or directory
Feb 21 07:15:53 cichlid kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Feb 21 07:15:39 cichlid fsck: mr: clean, 92755/2424832 files, 7842469/19393024 blocks 
Feb 21 07:15:53 cichlid kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 21 07:15:53 cichlid netfs: Mounting other filesystems:  failed
Feb 21 07:15:39 cichlid fsck: boot1: clean, 237/6144 files, 57241/196592 blocks 
Feb 21 07:15:53 cichlid kernel: pnp: PnP ACPI init
Feb 21 07:15:39 cichlid fsck: mt: clean, 516138/5005312 files, 34469902/40021500 blocks 
Feb 21 07:15:53 cichlid kernel: pnp: PnP ACPI: found 14 devices
Feb 21 07:15:39 cichlid fsck: mu: clean, 439485/2420736 files, 17712905/19362341 blocks 
Feb 21 07:15:53 cichlid kernel: usbcore: registered new interface driver usbfs
Feb 21 07:15:39 cichlid fsck: new: clean, 821706/2408448 files, 15574176/19249886 blocks 
Feb 21 07:15:53 cichlid kernel: usbcore: registered new interface driver hub
Feb 21 07:15:39 cichlid fsck: boot2: clean, 237/24576 files, 55407/98288 blocks 
Feb 21 07:15:53 cichlid kernel: usbcore: registered new device driver usb
Feb 21 07:15:39 cichlid fsck: root1: clean, 434650/917504 files, 4118842/7324416 blocks 
Feb 21 07:15:53 cichlid kernel: PCI: Using ACPI for IRQ routing
Feb 21 07:15:39 cichlid fsck: boot3: clean, 237/50200 files, 58636/200780 blocks 
Feb 21 07:15:53 cichlid kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb 21 07:15:39 cichlid rc.sysinit: Checking filesystems succeeded 
Feb 21 07:15:53 cichlid kernel: pnp: 00:08: ioport range 0x680-0x6ff has been reserved
Feb 21 07:15:41 cichlid mount: /src/cdroms/FC-5-i386-DVD-Unity-20060523.iso: No such file or directory 
Feb 21 07:15:54 cichlid kernel: pnp: 00:08: ioport range 0x290-0x297 has been reserved
Feb 21 07:15:54 cichlid lm_sensors: Starting lm_sensors: 
Feb 21 07:15:41 cichlid rc.sysinit: Mounting local filesystems:  failed 
Feb 21 07:15:54 cichlid kernel: PCI: Bridge: 0000:00:01.0
Feb 21 07:15:41 cichlid rc.sysinit: Enabling local filesystem quotas:  succeeded 
Feb 21 07:15:54 cichlid kernel:   IO window: disabled.
Feb 21 07:15:43 cichlid rc.sysinit: Enabling swap space:  succeeded 
Feb 21 07:15:54 cichlid kernel:   MEM window: faf00000-fbffffff
Feb 21 07:15:43 cichlid hdparm: /dev/hda: 
Feb 21 07:15:54 cichlid kernel:   PREFETCH window: e0000000-f7ffffff
Feb 21 07:15:43 cichlid hdparm:  setting unmaskirq to 1 (on) 
Feb 21 07:15:43 cichlid hdparm:  unmaskirq    =  1 (on) 
Feb 21 07:15:54 cichlid kernel: NET: Registered protocol family 2
Feb 21 07:15:43 cichlid rc.sysinit: Setting hard drive parameters for hda:  succeeded 
Feb 21 07:15:54 cichlid kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 21 07:15:54 cichlid kernel: TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
Feb 21 07:15:44 cichlid sysstat: Calling the system activity data collector (sadc):  
Feb 21 07:15:54 cichlid kernel: TCP bind hash table entries: 32768 (order: 8, 1179648 bytes)
Feb 21 07:15:44 cichlid sysstat:  
Feb 21 07:15:54 cichlid kernel: TCP: Hash tables configured (established 65536 bind 32768)
Feb 21 07:15:44 cichlid rc: Starting sysstat:  succeeded 
Feb 21 07:15:54 cichlid kernel: TCP reno registered
Feb 21 07:15:44 cichlid readahead_early: Starting background readahead:  
Feb 21 07:15:54 cichlid kernel: checking if image is initramfs... it is
Feb 21 07:15:44 cichlid rc: Starting readahead_early:  succeeded 
Feb 21 07:15:54 cichlid kernel: Freeing initrd memory: 644k freed
Feb 21 07:15:45 cichlid rc: Starting iptables:  succeeded 
Feb 21 07:15:54 cichlid kernel: Machine check exception polling timer started.
Feb 21 07:15:45 cichlid sysctl: net.ipv4.ip_forward = 1 
Feb 21 07:15:54 cichlid kernel: highmem bounce pool size: 64 pages
Feb 21 07:15:45 cichlid sysctl: net.ipv4.conf.all.rp_filter = 1 
Feb 21 07:15:54 cichlid kernel: Total HugeTLB memory allocated, 0
Feb 21 07:15:45 cichlid sysctl: kernel.sysrq = 1 
Feb 21 07:15:54 cichlid kernel: io scheduler noop registered
Feb 21 07:15:45 cichlid sysctl: kernel.core_uses_pid = 1 
Feb 21 07:15:54 cichlid kernel: io scheduler anticipatory registered (default)
Feb 21 07:15:45 cichlid network: Setting network parameters:  succeeded 
Feb 21 07:15:54 cichlid kernel: io scheduler deadline registered
Feb 21 07:15:46 cichlid network: Bringing up loopback interface:  succeeded 
Feb 21 07:15:54 cichlid kernel: io scheduler cfq registered
Feb 21 07:15:47 cichlid ifup:  
Feb 21 07:15:54 cichlid kernel: 0000:00:10.4 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
Feb 21 07:15:47 cichlid ifup: Determining IP information for eth0... 
Feb 21 07:15:54 cichlid kernel: vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 3072k, total 131072k
Feb 21 07:15:54 cichlid kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=1
Feb 21 07:15:54 cichlid kernel: vesafb: protected mode interface info at c000:e2e0
Feb 21 07:15:54 cichlid kernel: vesafb: pmi: set display start = c00ce316, set palette = c00ce380
Feb 21 07:15:50 cichlid ifup:  done. 
Feb 21 07:15:54 cichlid kernel: vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
Feb 21 07:15:50 cichlid network: Bringing up interface eth0:  succeeded 
Feb 21 07:15:54 cichlid kernel: vesafb: scrolling: redraw
Feb 21 07:15:50 cichlid logger: ./ifup 
Feb 21 07:15:54 cichlid kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Feb 21 07:15:50 cichlid ifup: Device eth1 has different MAC address than expected, ignoring. 
Feb 21 07:15:54 cichlid kernel: Console: switching to colour frame buffer device 128x48
Feb 21 07:15:50 cichlid network: Bringing up interface eth1:  failed 
Feb 21 07:15:54 cichlid kernel: fb0: VESA VGA frame buffer device
Feb 21 07:15:54 cichlid kernel: Real Time Clock Driver v1.12ac
Feb 21 07:15:54 cichlid kernel: platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver Initializing
Feb 21 07:15:54 cichlid kernel: platform pc8736x_gpio.0: no device found
Feb 21 07:15:54 cichlid kernel: Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Feb 21 07:15:54 cichlid kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Feb 21 07:15:54 cichlid kernel: Hangcheck: Using get_cycles().
Feb 21 07:15:54 cichlid kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb 21 07:15:54 cichlid kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Feb 21 07:15:54 cichlid kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
Feb 21 07:15:54 cichlid kernel: 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 21 07:15:54 cichlid kernel: 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 21 07:15:54 cichlid kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Feb 21 07:15:54 cichlid kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 21 07:15:54 cichlid kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 21 07:15:54 cichlid kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Feb 21 07:15:54 cichlid kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Feb 21 07:15:54 cichlid kernel: ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Feb 21 07:15:54 cichlid kernel: PCI: VIA VLink IRQ fixup for 0000:00:0f.1, from 255 to 11
Feb 21 07:15:54 cichlid kernel: VP_IDE: chipset revision 6
Feb 21 07:15:54 cichlid kernel: VP_IDE: not 100% native mode: will probe irqs later
Feb 21 07:15:54 cichlid kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Feb 21 07:15:54 cichlid kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Feb 21 07:15:54 cichlid kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
Feb 21 07:15:54 cichlid kernel: hda: Maxtor 5A300J0, ATA DISK drive
Feb 21 07:15:54 cichlid kernel: hda: IRQ probe failed (0xfffffcfa)
Feb 21 07:15:54 cichlid kernel: hdb: IRQ probe failed (0xfffffcfa)
Feb 21 07:15:54 cichlid kernel: hdb: IRQ probe failed (0xfffffcfa)
Feb 21 07:15:54 cichlid kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 21 07:15:54 cichlid kernel: hdd: IRQ probe failed (0xffffbcfa)
Feb 21 07:15:54 cichlid kernel: hdd: IRQ probe failed (0xffffbcfa)
Feb 21 07:15:54 cichlid kernel: hdd: LITE-ON DVD SOHD-16P9S, ATAPI CD/DVD-ROM drive
Feb 21 07:15:54 cichlid kernel: hdd: IRQ probe failed (0xffffbcfa)
Feb 21 07:15:54 cichlid kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 21 07:15:54 cichlid kernel: hda: max request size: 512KiB
Feb 21 07:15:54 cichlid kernel: hda: 585940320 sectors (300001 MB) w/2048KiB Cache, CHS=36473/255/63, UDMA(133)
Feb 21 07:15:54 cichlid kernel: hda: cache flushes supported
Feb 21 07:15:54 cichlid kernel:  hda: hda1 hda2 hda3 hda4
Feb 21 07:15:54 cichlid kernel: hdd: ATAPI 48X DVD-ROM drive, 254kB Cache, UDMA(33)
Feb 21 07:15:54 cichlid kernel: Uniform CD-ROM driver Revision: 3.20
Feb 21 07:15:54 cichlid kernel: usbcore: registered new interface driver hiddev
Feb 21 07:15:54 cichlid kernel: usbcore: registered new interface driver usbhid
Feb 21 07:15:55 cichlid lm_sensors: [60G
Feb 21 07:15:55 cichlid kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Feb 21 07:15:55 cichlid lm_sensors: 
Feb 21 07:15:55 cichlid kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
Feb 21 07:15:55 cichlid rc: Starting lm_sensors:  succeeded
Feb 21 07:15:55 cichlid kernel: PNP: PS/2 controller doesn't have AUX irq; using default 12
Feb 21 07:15:55 cichlid kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 21 07:15:55 cichlid kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 21 07:15:55 cichlid kernel: mice: PS/2 mouse device common for all mice
Feb 21 07:15:55 cichlid kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb 21 07:15:55 cichlid kernel: padlock: No VIA PadLock drivers have been loaded.
Feb 21 07:15:55 cichlid kernel: padlock: VIA PadLock not detected.
Feb 21 07:15:55 cichlid kernel: TCP cubic registered
Feb 21 07:15:55 cichlid kernel: Initializing XFRM netlink socket
Feb 21 07:15:55 cichlid kernel: NET: Registered protocol family 1
Feb 21 07:15:55 cichlid kernel: NET: Registered protocol family 17
Feb 21 07:15:55 cichlid kernel: Starting balanced_irq
Feb 21 07:15:55 cichlid kernel: Using IPI Shortcut mode
Feb 21 07:15:55 cichlid kernel: Time: acpi_pm clocksource has been installed.
Feb 21 07:15:55 cichlid kernel: Freeing unused kernel memory: 232k freed
Feb 21 07:15:55 cichlid kernel: Switched to high resolution mode on CPU 1
Feb 21 07:15:55 cichlid kernel: Switched to high resolution mode on CPU 0
Feb 21 07:15:55 cichlid kernel: SCSI subsystem initialized
Feb 21 07:15:55 cichlid autofs: automount startup succeeded
Feb 21 07:15:55 cichlid kernel: 3ware Storage Controller device driver for Linux v1.26.02.002.
Feb 21 07:15:55 cichlid kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Feb 21 07:15:55 cichlid kernel: 3w-xxxx: scsi0: AEN drain failed, retrying.
Feb 21 07:15:55 cichlid kernel: scsi0 : 3ware Storage Controller
Feb 21 07:15:55 cichlid kernel: 3w-xxxx: scsi0: Found a 3ware Storage Controller at 0x9400, IRQ: 11.
Feb 21 07:15:55 cichlid kernel: scsi 0:0:0:0: Direct-Access     3ware    Logical Disk 0   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Feb 21 07:15:55 cichlid kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:15:55 cichlid kernel: scsi 0:0:1:0: Direct-Access     3ware    Logical Disk 1   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: scsi 0:0:2:0: Direct-Access     3ware    Logical Disk 2   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: scsi 0:0:4:0: Direct-Access     3ware    Logical Disk 4   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: scsi 0:0:8:0: Direct-Access     3ware    Logical Disk 8   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: scsi 0:0:9:0: Direct-Access     3ware    Logical Disk 9   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:55 cichlid kernel: scsi 0:0:10:0: Direct-Access     3ware    Logical Disk 10  1.2  PQ: 0 ANSI: 0
Feb 21 07:15:56 cichlid kernel: SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:15:56 cichlid kernel: sda: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sda: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:56 cichlid kernel: SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:15:56 cichlid kernel: sda: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sda: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:56 cichlid kernel:  sda: sda1
Feb 21 07:15:56 cichlid kernel: sd 0:0:0:0: Attached scsi disk sda
Feb 21 07:15:56 cichlid kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:15:56 cichlid kernel: sdb: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sdb: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:56 cichlid kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:15:56 cichlid kernel: sdb: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sdb: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:56 cichlid kernel:  sdb: sdb1
Feb 21 07:15:56 cichlid kernel: sd 0:0:1:0: Attached scsi disk sdb
Feb 21 07:15:56 cichlid kernel: SCSI device sdc: 195371568 512-byte hdwr sectors (100030 MB)
Feb 21 07:15:56 cichlid kernel: sdc: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sdc: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:56 cichlid kernel: SCSI device sdc: 195371568 512-byte hdwr sectors (100030 MB)
Feb 21 07:15:56 cichlid kernel: sdc: Write Protect is off
Feb 21 07:15:56 cichlid kernel: SCSI device sdc: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdc: sdc1 sdc2
Feb 21 07:15:57 cichlid kernel: sd 0:0:2:0: Attached scsi disk sdc
Feb 21 07:15:57 cichlid kernel: SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
Feb 21 07:15:57 cichlid kernel: sdd: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdd: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
Feb 21 07:15:57 cichlid kernel: sdd: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdd: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdd: sdd1
Feb 21 07:15:57 cichlid kernel: sd 0:0:4:0: Attached scsi disk sdd
Feb 21 07:15:57 cichlid kernel: SCSI device sde: 490234752 512-byte hdwr sectors (251000 MB)
Feb 21 07:15:57 cichlid kernel: sde: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sde: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sde: 490234752 512-byte hdwr sectors (251000 MB)
Feb 21 07:15:57 cichlid kernel: sde: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sde: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sde: sde1
Feb 21 07:15:57 cichlid kernel: sd 0:0:8:0: Attached scsi disk sde
Feb 21 07:15:57 cichlid kernel: SCSI device sdf: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:57 cichlid kernel: sdf: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdf: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sdf: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:57 cichlid kernel: sdf: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdf: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdf: sdf1
Feb 21 07:15:57 cichlid kernel: sd 0:0:9:0: Attached scsi disk sdf
Feb 21 07:15:57 cichlid kernel: SCSI device sdg: 195711264 512-byte hdwr sectors (100204 MB)
Feb 21 07:15:57 cichlid kernel: sdg: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdg: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sdg: 195711264 512-byte hdwr sectors (100204 MB)
Feb 21 07:15:57 cichlid kernel: sdg: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdg: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdg: sdg1
Feb 21 07:15:57 cichlid kernel: sd 0:0:10:0: Attached scsi disk sdg
Feb 21 07:15:57 cichlid kernel: scsi1 : 3ware Storage Controller
Feb 21 07:15:57 cichlid kernel: 3w-xxxx: scsi1: Found a 3ware Storage Controller at 0xb000, IRQ: 5.
Feb 21 07:15:57 cichlid kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Feb 21 07:15:57 cichlid kernel: scsi 1:0:1:0: Direct-Access     3ware    Logical Disk 1   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: scsi 1:0:2:0: Direct-Access     3ware    Logical Disk 2   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: scsi 1:0:3:0: Direct-Access     3ware    Logical Disk 3   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: scsi 1:0:4:0: Direct-Access     3ware    Logical Disk 4   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: scsi 1:0:5:0: Direct-Access     3ware    Logical Disk 5   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: scsi 1:0:6:0: Direct-Access     3ware    Logical Disk 6   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:57 cichlid kernel: SCSI device sdh: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:57 cichlid kernel: sdh: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdh: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sdh: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:57 cichlid kernel: sdh: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdh: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdh: sdh1
Feb 21 07:15:57 cichlid kernel: sd 1:0:1:0: Attached scsi disk sdh
Feb 21 07:15:57 cichlid kernel: SCSI device sdi: 585940320 512-byte hdwr sectors (300001 MB)
Feb 21 07:15:57 cichlid kernel: sdi: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdi: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel: SCSI device sdi: 585940320 512-byte hdwr sectors (300001 MB)
Feb 21 07:15:57 cichlid kernel: sdi: Write Protect is off
Feb 21 07:15:57 cichlid kernel: SCSI device sdi: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:57 cichlid kernel:  sdi: sdi1
Feb 21 07:15:57 cichlid kernel: sd 1:0:2:0: Attached scsi disk sdi
Feb 21 07:15:57 cichlid kernel: SCSI device sdj: 585940320 512-byte hdwr sectors (300001 MB)
Feb 21 07:15:57 cichlid kernel: sdj: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdj: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel: SCSI device sdj: 585940320 512-byte hdwr sectors (300001 MB)
Feb 21 07:15:58 cichlid kernel: sdj: Write Protect is off
Feb 21 07:15:58 cichlid smartd: smartd startup succeeded
Feb 21 07:15:58 cichlid kernel: SCSI device sdj: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel:  sdj: sdj1
Feb 21 07:15:58 cichlid kernel: sd 1:0:3:0: Attached scsi disk sdj
Feb 21 07:15:58 cichlid kernel: SCSI device sdk: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:58 cichlid kernel: sdk: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdk: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel: SCSI device sdk: 320173056 512-byte hdwr sectors (163929 MB)
Feb 21 07:15:58 cichlid kernel: sdk: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdk: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel:  sdk: sdk1
Feb 21 07:15:58 cichlid kernel: sd 1:0:4:0: Attached scsi disk sdk
Feb 21 07:15:58 cichlid kernel: SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
Feb 21 07:15:58 cichlid kernel: sdl: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdl: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel: SCSI device sdl: 586114704 512-byte hdwr sectors (300091 MB)
Feb 21 07:15:58 cichlid kernel: sdl: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdl: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel:  sdl: sdl1
Feb 21 07:15:58 cichlid kernel: sd 1:0:5:0: Attached scsi disk sdl
Feb 21 07:15:58 cichlid kernel: SCSI device sdm: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:15:58 cichlid kernel: sdm: Write Protect is off
Feb 21 07:15:58 cichlid kernel: SCSI device sdm: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:58 cichlid kernel: SCSI device sdm: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:15:58 cichlid kernel: sdm: Write Protect is off
Feb 21 07:15:59 cichlid kernel: SCSI device sdm: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:59 cichlid kernel:  sdm: sdm1 sdm2 sdm3 sdm4
Feb 21 07:15:59 cichlid kernel: sd 1:0:6:0: Attached scsi disk sdm
Feb 21 07:15:59 cichlid kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:15:59 cichlid kernel: scsi2 : 3ware Storage Controller
Feb 21 07:15:59 cichlid kernel: 3w-xxxx: scsi2: Found a 3ware Storage Controller at 0xb400, IRQ: 5.
Feb 21 07:15:59 cichlid kernel: scsi 2:0:0:0: Direct-Access     3ware    Logical Disk 0   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: scsi 2:0:2:0: Direct-Access     3ware    Logical Disk 2   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: scsi 2:0:3:0: Direct-Access     3ware    Logical Disk 3   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid tdm2: 3dm2 startup succeeded
Feb 21 07:15:59 cichlid kernel: scsi 2:0:4:0: Direct-Access     3ware    Logical Disk 4   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: scsi 2:0:7:0: Direct-Access     3ware    Logical Disk 7   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: scsi 2:0:9:0: Direct-Access     3ware    Logical Disk 9   1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: scsi 2:0:11:0: Direct-Access     3ware    Logical Disk 11  1.2  PQ: 0 ANSI: 0
Feb 21 07:15:59 cichlid kernel: SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
Feb 21 07:15:59 cichlid kernel: sdn: Write Protect is off
Feb 21 07:15:59 cichlid acpid: acpid startup succeeded
Feb 21 07:15:59 cichlid kernel: SCSI device sdn: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:59 cichlid kernel: SCSI device sdn: 586114704 512-byte hdwr sectors (300091 MB)
Feb 21 07:15:59 cichlid kernel: sdn: Write Protect is off
Feb 21 07:15:59 cichlid kernel: SCSI device sdn: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:15:59 cichlid kernel:  sdn: sdn1
Feb 21 07:15:59 cichlid kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Feb 21 07:15:59 cichlid kernel: sd 2:0:0:0: Attached scsi disk sdn
Feb 21 07:16:00 cichlid kernel: SCSI device sdo: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:00 cichlid kernel: sdo: Write Protect is off
Feb 21 07:16:00 cichlid kernel: SCSI device sdo: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel: SCSI device sdo: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:00 cichlid kernel: md: linear personality registered for level -1
Feb 21 07:16:00 cichlid kernel: sdo: Write Protect is off
Feb 21 07:16:00 cichlid kernel: SCSI device sdo: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel:  sdo: sdo1 sdo2 sdo3
Feb 21 07:16:00 cichlid kernel: sd 2:0:2:0: Attached scsi disk sdo
Feb 21 07:16:00 cichlid kernel: SCSI device sdp: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:00 cichlid rc: Starting hpoj:  succeeded
Feb 21 07:16:00 cichlid kernel: sdp: Write Protect is off
Feb 21 07:16:00 cichlid kernel: SCSI device sdp: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel: SCSI device sdp: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:00 cichlid kernel: sdp: Write Protect is off
Feb 21 07:16:00 cichlid kernel: SCSI device sdp: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel:  sdp: sdp1 sdp2 sdp3 sdp4
Feb 21 07:16:00 cichlid xinetd: xinetd startup succeeded
Feb 21 07:16:00 cichlid kernel: sd 2:0:3:0: Attached scsi disk sdp
Feb 21 07:16:00 cichlid kernel: SCSI device sdq: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:16:00 cichlid kernel: sdq: Write Protect is off
Feb 21 07:16:00 cichlid rstatd: rpc.rstatd startup succeeded
Feb 21 07:16:00 cichlid kernel: SCSI device sdq: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel: SCSI device sdq: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:16:00 cichlid kernel: sdq: Write Protect is off
Feb 21 07:16:00 cichlid kernel: SCSI device sdq: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:00 cichlid kernel:  sdq: sdq1
Feb 21 07:16:01 cichlid kernel: sd 2:0:4:0: Attached scsi disk sdq
Feb 21 07:16:01 cichlid kernel: SCSI device sdr: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:16:01 cichlid kernel: sdr: Write Protect is off
Feb 21 07:16:01 cichlid kernel: SCSI device sdr: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:01 cichlid kernel: SCSI device sdr: 625142448 512-byte hdwr sectors (320073 MB)
Feb 21 07:16:02 cichlid kernel: sdr: Write Protect is off
Feb 21 07:16:02 cichlid kernel: SCSI device sdr: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:02 cichlid kernel:  sdr: sdr1
Feb 21 07:16:02 cichlid kernel: sd 2:0:7:0: Attached scsi disk sdr
Feb 21 07:16:02 cichlid kernel: SCSI device sds: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:02 cichlid kernel: sds: Write Protect is off
Feb 21 07:16:02 cichlid mysqld: Starting MySQL:  succeeded
Feb 21 07:16:02 cichlid kernel: SCSI device sds: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:02 cichlid kernel: SCSI device sds: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:02 cichlid kernel: sds: Write Protect is off
Feb 21 07:16:02 cichlid kernel: SCSI device sds: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:02 cichlid xinetd[6341]: Server /usr/sbin/imapd is not executable [file=/etc/xinetd.d/imap] [line=10]
Feb 21 07:16:03 cichlid kernel:  sds: sds1 sds2 sds3 sds4
Feb 21 07:16:03 cichlid xinetd[6341]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/imap] [line=10]
Feb 21 07:16:03 cichlid kernel: sd 2:0:9:0: Attached scsi disk sds
Feb 21 07:16:03 cichlid kernel: SCSI device sdt: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:03 cichlid kernel: sdt: Write Protect is off
Feb 21 07:16:03 cichlid ddclient: ddclient startup succeeded
Feb 21 07:16:03 cichlid kernel: SCSI device sdt: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:03 cichlid kernel: SCSI device sdt: 781422768 512-byte hdwr sectors (400088 MB)
Feb 21 07:16:03 cichlid kernel: sdt: Write Protect is off
Feb 21 07:16:03 cichlid dhcpd: Internet Systems Consortium DHCP Server V3.0.1
Feb 21 07:16:03 cichlid kernel: SCSI device sdt: write cache: enabled, read cache: disabled, supports DPO and FUA
Feb 21 07:16:03 cichlid kernel:  sdt: sdt1 sdt2 sdt3 sdt4
Feb 21 07:16:03 cichlid kernel: sd 2:0:11:0: Attached scsi disk sdt
Feb 21 07:16:03 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:03 cichlid kernel: EXT3 FS on hda2, internal journal
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:03 cichlid dhcpd: Copyright 2004 Internet Systems Consortium.
Feb 21 07:16:03 cichlid kernel: Floppy drive(s): fd0 is 1.44M
Feb 21 07:16:03 cichlid dhcpd: All rights reserved.
Feb 21 07:16:03 cichlid kernel: FDC 0 is a post-1991 82077
Feb 21 07:16:03 cichlid dhcpd: For info, please visit http://www.isc.org/sw/dhcp/
Feb 21 07:16:03 cichlid kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Feb 21 07:16:03 cichlid xinetd[6341]: Server /usr/sbin/in.ftpd is not executable [file=/etc/xinetd.d/wu-ftpd] [line=10]
Feb 21 07:16:03 cichlid xinetd[6341]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/wu-ftpd] [line=10]
Feb 21 07:16:03 cichlid dhcpd: Wrote 0 deleted host decls to leases file.
Feb 21 07:16:03 cichlid kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Feb 21 07:16:03 cichlid dhcpd: No subnet declaration for eth0 (63.249.91.56).
Feb 21 07:16:03 cichlid kernel:       PrefPort:A  RlmtMode:Check Link State
Feb 21 07:16:03 cichlid kernel: usbcore: registered new interface driver snd-usb-audio
Feb 21 07:16:03 cichlid dhcpd: Wrote 0 new dynamic host decls to leases file.
Feb 21 07:16:03 cichlid kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 21 07:16:03 cichlid dhcpd: Wrote 0 leases to leases file.
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid kernel: PCI: Enabling device 0000:00:11.5 (0000 -> 0001)
Feb 21 07:16:03 cichlid dhcpd: No subnet declaration for eth0 (63.249.91.56).
Feb 21 07:16:03 cichlid dhcpd: ** Ignoring requests on eth0.  If this is not what
Feb 21 07:16:03 cichlid kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:16:03 cichlid dhcpd:    you want, please write a subnet declaration
Feb 21 07:16:03 cichlid kernel: PCI: VIA VLink IRQ fixup for 0000:00:11.5, from 0 to 5
Feb 21 07:16:03 cichlid dhcpd: ** Ignoring requests on eth0.  If this is not what
Feb 21 07:16:03 cichlid dhcpd:    in your dhcpd.conf file for the network segment
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid dhcpd:    to which interface eth0 is attached. **
Feb 21 07:16:03 cichlid kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid kernel: agpgart: Detected AGP bridge 0
Feb 21 07:16:03 cichlid dhcpd:    you want, please write a subnet declaration
Feb 21 07:16:03 cichlid kernel: agpgart: AGP aperture is 64M @ 0xdc000000
Feb 21 07:16:03 cichlid kernel: PCI: Enabling device 0000:00:11.6 (0000 -> 0001)
Feb 21 07:16:03 cichlid dhcpd:    in your dhcpd.conf file for the network segment
Feb 21 07:16:03 cichlid kernel: ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:16:03 cichlid dhcpd:    to which interface eth0 is attached. **
Feb 21 07:16:03 cichlid kernel: PCI: VIA VLink IRQ fixup for 0000:00:11.6, from 0 to 5
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid dhcpd: 
Feb 21 07:16:03 cichlid dhcpd: Not configured to listen on any interfaces!
Feb 21 07:16:03 cichlid kernel: ACPI: PCI interrupt for device 0000:00:11.6 disabled
Feb 21 07:16:04 cichlid dhcpd: Not configured to listen on any interfaces!
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid kernel: VIA 82xx Modem: probe of 0000:00:11.6 failed with error -13
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 21 07:16:04 cichlid kernel: sata_via 0000:00:0f.0: routed to hard irq line 10
Feb 21 07:16:04 cichlid kernel: ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC000 irq 10
Feb 21 07:16:04 cichlid kernel: ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xC008 irq 10
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid dhcpd: If you did not get this software from ftp.isc.org, please
Feb 21 07:16:04 cichlid kernel: scsi3 : sata_via
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid dhcpd: get the latest from ftp.isc.org and install that before
Feb 21 07:16:04 cichlid kernel: ata1: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
Feb 21 07:16:04 cichlid dhcpd: requesting help.
Feb 21 07:16:04 cichlid kernel: ATA: abnormal status 0x7F on port 0xD407
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid xinetd[6341]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Feb 21 07:16:04 cichlid dhcpd: If you did not get this software from ftp.isc.org, please
Feb 21 07:16:04 cichlid kernel: scsi4 : sata_via
Feb 21 07:16:04 cichlid dhcpd: If you did get this software from ftp.isc.org and have not
Feb 21 07:16:04 cichlid xinetd[6341]: Started working: 0 available services
Feb 21 07:16:04 cichlid dhcpd: get the latest from ftp.isc.org and install that before
Feb 21 07:16:04 cichlid kernel: ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
Feb 21 07:16:04 cichlid dhcpd: requesting help.
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid kernel: ATA: abnormal status 0x7F on port 0xC807
Feb 21 07:16:04 cichlid dhcpd: If you did get this software from ftp.isc.org and have not
Feb 21 07:16:04 cichlid dhcpd: yet read the README, please read it before requesting help.
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:16:04 cichlid dhcpd: yet read the README, please read it before requesting help.
Feb 21 07:16:04 cichlid dhcpd: If you intend to request help from the dhcp-server@isc.org
Feb 21 07:16:04 cichlid kernel: ata3: SATA max UDMA/133 cmd 0xF8D0A200 ctl 0xF8D0A238 bmdma 0x0 irq 5
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid dhcpd: mailing list, please read the section on the README about
Feb 21 07:16:04 cichlid kernel: ata4: SATA max UDMA/133 cmd 0xF8D0A280 ctl 0xF8D0A2B8 bmdma 0x0 irq 5
Feb 21 07:16:04 cichlid dhcpd: If you intend to request help from the dhcp-server@isc.org
Feb 21 07:16:04 cichlid dhcpd: submitting bug reports and requests for help.
Feb 21 07:16:04 cichlid kernel: scsi5 : sata_promise
Feb 21 07:16:04 cichlid dhcpd: mailing list, please read the section on the README about
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid kernel: ata3: SATA link down (SStatus 0 SControl 0)
Feb 21 07:16:04 cichlid dhcpd: submitting bug reports and requests for help.
Feb 21 07:16:04 cichlid dhcpd: Please do not under any circumstances send requests for
Feb 21 07:16:04 cichlid kernel: scsi6 : sata_promise
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid dhcpd: help directly to the authors of this software - please
Feb 21 07:16:04 cichlid kernel: ata4: SATA link down (SStatus 0 SControl 300)
Feb 21 07:16:04 cichlid dhcpd: Please do not under any circumstances send requests for
Feb 21 07:16:04 cichlid dhcpd: send them to the appropriate mailing list as described in
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Feb 21 07:16:04 cichlid dhcpd: help directly to the authors of this software - please
Feb 21 07:16:04 cichlid dhcpd: the README file.
Feb 21 07:16:04 cichlid kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
Feb 21 07:16:04 cichlid dhcpd: send them to the appropriate mailing list as described in
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
Feb 21 07:16:04 cichlid dhcpd: the README file.
Feb 21 07:16:04 cichlid dhcpd: exiting.
Feb 21 07:16:04 cichlid kernel: ehci_hcd 0000:00:10.4: irq 5, io mem 0xfae00000
Feb 21 07:16:04 cichlid dhcpd: 
Feb 21 07:16:04 cichlid kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb 21 07:16:04 cichlid dhcpd: exiting.
Feb 21 07:16:04 cichlid kernel: usb usb1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-0:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-0:1.0: 8 ports detected
Feb 21 07:16:04 cichlid kernel: USB Universal Host Controller Interface driver v3.0
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d800
Feb 21 07:16:04 cichlid kernel: usb usb2: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 2-0:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 2-0:1.0: 2 ports detected
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.1: irq 11, io base 0x0000e000
Feb 21 07:16:04 cichlid kernel: usb 1-2: new high speed USB device using ehci_hcd and address 2
Feb 21 07:16:04 cichlid kernel: usb usb3: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 3-0:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 3-0:1.0: 2 ports detected
Feb 21 07:16:04 cichlid kernel: usb 1-2: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.2: irq 10, io base 0x0000e400
Feb 21 07:16:04 cichlid kernel: usb usb4: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 4-0:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 4-0:1.0: 2 ports detected
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.3: UHCI Host Controller
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
Feb 21 07:16:04 cichlid kernel: uhci_hcd 0000:00:10.3: irq 10, io base 0x0000e800
Feb 21 07:16:04 cichlid kernel: usb usb5: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 5-0:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 5-0:1.0: 2 ports detected
Feb 21 07:16:04 cichlid kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Feb 21 07:16:04 cichlid kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[f8a00000-f8a007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Feb 21 07:16:04 cichlid kernel: usb 1-2.1: new high speed USB device using ehci_hcd and address 6
Feb 21 07:16:04 cichlid kernel: usb 1-2.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.1:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.1:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: usb 1-2.2: new low speed USB device using ehci_hcd and address 7
Feb 21 07:16:04 cichlid kernel: usb 1-2.2: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 1-2.3: new high speed USB device using ehci_hcd and address 8
Feb 21 07:16:04 cichlid kernel: usb 1-2.3: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.3:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.3:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: usb 1-2.4: new full speed USB device using ehci_hcd and address 9
Feb 21 07:16:04 cichlid kernel: usb 1-2.4: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.4:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.4:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: usb 4-1: new full speed USB device using uhci_hcd and address 2
Feb 21 07:16:04 cichlid kernel: usb 4-1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: input: USB Audio as /class/input/input1
Feb 21 07:16:04 cichlid kernel: input: USB HID v1.00 Device [USB Audio] on usb-0000:00:10.2-1
Feb 21 07:16:04 cichlid kernel: EXT3 FS on hda2, internal journal
Feb 21 07:16:04 cichlid kernel: usb 5-1: new full speed USB device using uhci_hcd and address 2
Feb 21 07:16:04 cichlid kernel: usb 5-1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 5-1:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 5-1:1.0: 3 ports detected
Feb 21 07:16:04 cichlid kernel: usb 5-2: new full speed USB device using uhci_hcd and address 3
Feb 21 07:16:04 cichlid kernel: usb 5-2: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 5-2:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 5-2:1.0: 3 ports detected
Feb 21 07:16:04 cichlid kernel: usb 1-2.1.4: new high speed USB device using ehci_hcd and address 10
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on hda4, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdo2, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdt3, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sds4, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdf1, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdm4, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: usb 1-2.1.4: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.1.4:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.1.4:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdp4, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sdc2, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with journal data mode.
Feb 21 07:16:04 cichlid kernel: EXT2-fs warning (device sds1): ext2_fill_super: mounting ext3 filesystem as ext2
Feb 21 07:16:04 cichlid kernel: kjournald starting.  Commit interval 5 seconds
Feb 21 07:16:04 cichlid kernel: EXT3 FS on sds2, internal journal
Feb 21 07:16:04 cichlid kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1: new high speed USB device using ehci_hcd and address 11
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.3.1:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.3.1:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: loop: loaded (max 32 devices)
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.1: new full speed USB device using ehci_hcd and address 12
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.2: new full speed USB device using ehci_hcd and address 13
Feb 21 07:16:04 cichlid dhcpd: dhcpd startup failed
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.2: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.3: new full speed USB device using ehci_hcd and address 14
Feb 21 07:16:04 cichlid kernel: usb 1-2.4.3: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 5-1.1: new full speed USB device using uhci_hcd and address 4
Feb 21 07:16:04 cichlid kernel: usb 5-1.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 5-2.1: new full speed USB device using uhci_hcd and address 5
Feb 21 07:16:04 cichlid kernel: usb 5-2.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1: new high speed USB device using ehci_hcd and address 15
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: hub 1-2.3.1.1:1.0: USB hub found
Feb 21 07:16:04 cichlid kernel: hub 1-2.3.1.1:1.0: 4 ports detected
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1.1: new high speed USB device using ehci_hcd and address 16
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1.1: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: Adding 1004052k swap on /dev/sdp3.  Priority:9 extents:1 across:1004052k
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1.4: new low speed USB device using ehci_hcd and address 17
Feb 21 07:16:04 cichlid kernel: usb 1-2.3.1.1.4: configuration #1 chosen from 1 choice
Feb 21 07:16:04 cichlid kernel: input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/input/input2
Feb 21 07:16:04 cichlid kernel: input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:10.4-2.3.1.1.4
Feb 21 07:16:04 cichlid kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Feb 21 07:16:04 cichlid dhcpd: dhcpd startup failed
Feb 21 07:16:04 cichlid kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Feb 21 07:16:04 cichlid kernel: eth0: network connection up using port A
Feb 21 07:16:04 cichlid kernel:     speed:           10
Feb 21 07:16:04 cichlid kernel:     autonegotiation: yes
Feb 21 07:16:04 cichlid kernel:     duplex mode:     half
Feb 21 07:16:05 cichlid dovecot: dovecot startup succeeded
Feb 21 07:16:05 cichlid kernel:     flowctrl:        none
Feb 21 07:16:05 cichlid kernel:     irq moderation:  disabled
Feb 21 07:16:05 cichlid kernel:     scatter-gather:  disabled
Feb 21 07:16:05 cichlid kernel:     tx-checksum:     disabled
Feb 21 07:16:05 cichlid kernel:     rx-checksum:     disabled
Feb 21 07:16:05 cichlid kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Feb 21 07:16:05 cichlid kernel: w83627hf 9191-0290: Reading VID from GPIO5
Feb 21 07:16:05 cichlid kernel: NET: Registered protocol family 10
Feb 21 07:16:05 cichlid kernel: lo: Disabled Privacy Extensions
Feb 21 07:16:06 cichlid sendmail: sendmail startup succeeded
Feb 21 07:16:06 cichlid sendmail: sm-client startup succeeded
Feb 21 07:16:09 cichlid spamassassin: spamd startup succeeded
Feb 21 07:16:09 cichlid privoxy: Feb 21 07:16:09 Privoxy(-1208990016) Info: loading configuration file '/etc/privoxy/config':
Feb 21 07:16:10 cichlid privoxy: privoxy startup succeeded
Feb 21 07:16:10 cichlid gpm[6521]: *** info [startup.c(95)]: 
Feb 21 07:16:10 cichlid gpm[6521]: Started gpm successfully. Entered daemon mode.
Feb 21 07:16:10 cichlid gpm[6521]: *** info [mice.c(1766)]: 
Feb 21 07:16:10 cichlid gpm[6521]: imps2: Auto-detected intellimouse PS/2
Feb 21 07:16:10 cichlid gpm: gpm startup succeeded
Feb 21 07:16:13 cichlid httpd: [Wed Feb 21 07:16:12 2007] [warn] The Alias directive in /etc/httpd/conf/httpd.conf at line 539 will probably never match because it overlaps an earlier Alias.
Feb 21 07:16:13 cichlid httpd: [Wed Feb 21 07:16:13 2007] [warn] The Alias directive in /etc/httpd/conf/httpd.conf at line 569 will probably never match because it overlaps an earlier AliasMatch.
Feb 21 07:16:14 cichlid httpd: httpd startup succeeded
Feb 21 07:16:14 cichlid alsasound: Starting sound driver snd-usb-audio succeeded
Feb 21 07:16:14 cichlid last message repeated 2 times
Feb 21 07:16:14 cichlid alsasound: Starting sound driver snd-ice1712 succeeded
Feb 21 07:16:14 cichlid alsasound: Starting sound driver snd-via82xx succeeded
Feb 21 07:16:14 cichlid alsasound: Starting sequencer succeeded
Feb 21 07:16:14 cichlid alsasound: Starting sequencer driver snd-seq-midi succeeded
Feb 21 07:16:15 cichlid alsactl: /usr/sbin/alsactl: load_state:1236: No soundcards found...
Feb 21 07:16:15 cichlid alsasound: Restoring sound driver settings failed
Feb 21 07:16:16 cichlid iiim: htt startup succeeded
Feb 21 07:16:17 cichlid rc: Starting rtirq:  succeeded
Feb 21 07:16:17 cichlid htt_server[6683]: started.
Feb 21 07:16:19 cichlid canna:  succeeded
Feb 21 07:16:19 cichlid crond: crond startup succeeded
Feb 21 07:16:21 cichlid xfs: xfs startup succeeded
Feb 21 07:16:21 cichlid xfs[6850]: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/share/fonts/default/TrueType (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/share/AbiSuite/fonts (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/100dpi:unscaled (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/100dpi (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/share/fonts/ISO8859-9/100dpi:unscaled (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/share/fonts/ISO8859-9/100dpi (unreadable) 
Feb 21 07:16:22 cichlid xfs[6850]: ignoring font path element /usr/lib/openoffice/share/fonts/truetype (unreadable) 
Feb 21 07:16:22 cichlid smb: smbd startup succeeded
Feb 21 07:16:23 cichlid smb: nmbd startup succeeded
Feb 21 07:16:23 cichlid atd: atd startup succeeded
Feb 21 07:16:23 cichlid runuser: too soon
Feb 21 07:16:23 cichlid innd: rc.news startup succeeded
Feb 21 07:16:23 cichlid readahead: Starting background readahead: 
Feb 21 07:16:23 cichlid rc: Starting readahead:  succeeded
Feb 21 07:16:24 cichlid messagebus: messagebus startup succeeded
Feb 21 07:16:25 cichlid rhnsd[6957]: Red Hat Network Services Daemon starting up.
Feb 21 07:16:25 cichlid rhnsd: rhnsd startup succeeded
Feb 21 07:16:25 cichlid cups-config-daemon: cups-config-daemon startup succeeded
Feb 21 07:16:25 cichlid haldaemon: haldaemon startup succeeded
Feb 21 07:16:27 cichlid fstab-sync[6992]: removed all generated mount points
Feb 21 07:16:31 cichlid mailman: python startup succeeded
Feb 21 07:16:32 cichlid rtload:  succeeded
Feb 21 07:16:38 cichlid rt_monitor[7566]: running
Feb 21 07:16:38 cichlid rt_monitor[7566]: killing with Aborted
Feb 21 07:16:42 cichlid kernel: Linux video capture interface: v2.00
Feb 21 07:16:42 cichlid kernel: usbcore: registered new interface driver dsbr100
Feb 21 07:16:42 cichlid kernel: drivers/media/radio/dsbr100.c: v0.41:D-Link DSB-R100 USB FM radio driver
Feb 21 07:16:42 cichlid kernel: drivers/usb/misc/emi62.c: emi62_probe start
Feb 21 07:16:42 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:43 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:45 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:45 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:46 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:46 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:46 cichlid kernel: usb 5-1.1: USB disconnect, address 4
Feb 21 07:16:46 cichlid kernel: emi62 - firmware loader: probe of 5-1.1:1.0 failed with error -5
Feb 21 07:16:47 cichlid kernel: drivers/usb/misc/emi62.c: emi62_probe start
Feb 21 07:16:47 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:47 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:49 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:49 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:49 cichlid kernel: usb 5-1.1: new full speed USB device using uhci_hcd and address 6
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: unable to read config index 0 descriptor/all
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: can't read configurations, error -75
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: new full speed USB device using uhci_hcd and address 7
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: unable to read config index 0 descriptor/all
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: can't read configurations, error -75
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: new full speed USB device using uhci_hcd and address 8
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: unable to read config index 0 descriptor/all
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: can't read configurations, error -75
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: new full speed USB device using uhci_hcd and address 9
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: unable to read config index 0 descriptor/all
Feb 21 07:16:50 cichlid kernel: usb 5-1.1: can't read configurations, error -75
Feb 21 07:16:50 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 1
Feb 21 07:16:51 cichlid kernel: drivers/usb/misc/emi62.c: emi62_set_reset - 0
Feb 21 07:16:51 cichlid kernel: usb 5-2.1: USB disconnect, address 5
Feb 21 07:16:51 cichlid kernel: emi62 - firmware loader: probe of 5-2.1:1.0 failed with error -5
Feb 21 07:16:51 cichlid kernel: usbcore: registered new interface driver emi62 - firmware loader
Feb 21 07:16:51 cichlid kernel: usbcore: registered new interface driver emi26 - firmware loader
Feb 21 07:16:51 cichlid kernel: eth1: register 'asix' at usb-0000:00:10.4-2.3.1.1.1, Hawking UF200 USB Ethernet, 00:e0:98:9f:43:7d
Feb 21 07:16:51 cichlid kernel: usbcore: registered new interface driver asix

..

Feb 21 11:23:07 cichlid kernel: BUG: at kernel/softirq.c:559 __tasklet_action()
Feb 21 11:23:07 cichlid kernel:  [dump_trace+453/480] dump_trace+0x1c5/0x1e0
Feb 21 11:23:07 cichlid kernel:  [<c0104085>] dump_trace+0x1c5/0x1e0
Feb 21 11:23:07 cichlid kernel:  [show_trace_log_lvl+24/48] show_trace_log_lvl+0x18/0x30
Feb 21 11:23:07 cichlid kernel:  [<c0104158>] show_trace_log_lvl+0x18/0x30
Feb 21 11:23:07 cichlid kernel:  [show_trace+15/32] show_trace+0xf/0x20
Feb 21 11:23:07 cichlid kernel:  [<c010417f>] show_trace+0xf/0x20
Feb 21 11:23:07 cichlid kernel:  [dump_stack+18/32] dump_stack+0x12/0x20
Feb 21 11:23:07 cichlid kernel:  [<c01042a2>] dump_stack+0x12/0x20
Feb 21 11:23:07 cichlid kernel:  [__tasklet_action+310/320] __tasklet_action+0x136/0x140
Feb 21 11:23:07 cichlid kernel:  [<c0124b86>] __tasklet_action+0x136/0x140
Feb 21 11:23:07 cichlid kernel:  [ksoftirqd+232/400] ksoftirqd+0xe8/0x190
Feb 21 11:23:07 cichlid kernel:  [<c0124d88>] ksoftirqd+0xe8/0x190
Feb 21 11:23:07 cichlid kernel:  [kthread+164/224] kthread+0xa4/0xe0
Feb 21 11:23:07 cichlid kernel:  [<c0134354>] kthread+0xa4/0xe0
Feb 21 11:23:07 cichlid kernel:  [kernel_thread_helper+7/28] kernel_thread_helper+0x7/0x1c
Feb 21 11:23:07 cichlid kernel:  [<c0103d8b>] kernel_thread_helper+0x7/0x1c
Feb 21 11:23:07 cichlid kernel:  =======================

..


Feb 21 16:01:02 cichlid kernel: BUG: time warp detected!
Feb 21 16:01:02 cichlid kernel: prev > now, 104424fbe0109709 > 104424fac96b7198:
Feb 21 16:01:02 cichlid kernel: = 4674889073 delta, on CPU#1
Feb 21 16:01:02 cichlid kernel:  [dump_trace+453/480] dump_trace+0x1c5/0x1e0
Feb 21 16:01:02 cichlid kernel:  [<c0104085>] dump_trace+0x1c5/0x1e0
Feb 21 16:01:02 cichlid kernel:  [show_trace_log_lvl+24/48] show_trace_log_lvl+0x18/0x30
Feb 21 16:01:02 cichlid kernel:  [<c0104158>] show_trace_log_lvl+0x18/0x30
Feb 21 16:01:02 cichlid kernel:  [show_trace+15/32] show_trace+0xf/0x20
Feb 21 16:01:02 cichlid kernel:  [<c010417f>] show_trace+0xf/0x20
Feb 21 16:01:02 cichlid kernel:  [dump_stack+18/32] dump_stack+0x12/0x20
Feb 21 16:01:02 cichlid kernel:  [<c01042a2>] dump_stack+0x12/0x20
Feb 21 16:01:02 cichlid kernel:  [pg0+947886475/1068258304] snd_pcm_period_elapsed+0x20b/0x2a0 [snd_pcm]
Feb 21 16:01:02 cichlid kernel:  [<f8d3298b>] snd_pcm_period_elapsed+0x20b/0x2a0 [snd_pcm]
Feb 21 16:01:02 cichlid kernel:  [pg0+947353477/1068258304] snd_ice1712_interrupt+0x1a5/0x1e0 [snd_ice1712]
Feb 21 16:01:02 cichlid kernel:  [<f8cb0785>] snd_ice1712_interrupt+0x1a5/0x1e0 [snd_ice1712]
Feb 21 16:01:02 cichlid kernel:  [handle_IRQ_event+76/208] handle_IRQ_event+0x4c/0xd0
Feb 21 16:01:02 cichlid kernel:  [<c0148ffc>] handle_IRQ_event+0x4c/0xd0
Feb 21 16:01:02 cichlid kernel:  [thread_simple_irq+90/128] thread_simple_irq+0x5a/0x80
Feb 21 16:01:02 cichlid kernel:  [<c0149b2a>] thread_simple_irq+0x5a/0x80
Feb 21 16:01:02 cichlid kernel:  [thread_level_irq+28/80] thread_level_irq+0x1c/0x50
Feb 21 16:01:02 cichlid kernel:  [<c0149b6c>] thread_level_irq+0x1c/0x50
Feb 21 16:01:02 cichlid kernel:  [do_hardirq+194/208] do_hardirq+0xc2/0xd0
Feb 21 16:01:02 cichlid kernel:  [<c0149e12>] do_hardirq+0xc2/0xd0
Feb 21 16:01:02 cichlid kernel:  [do_irqd+161/272] do_irqd+0xa1/0x110
Feb 21 16:01:02 cichlid kernel:  [<c0149ec1>] do_irqd+0xa1/0x110
Feb 21 16:01:02 cichlid kernel:  [kthread+164/224] kthread+0xa4/0xe0
Feb 21 16:01:02 cichlid kernel:  [<c0134354>] kthread+0xa4/0xe0
Feb 21 16:01:02 cichlid kernel:  [kernel_thread_helper+7/28] kernel_thread_helper+0x7/0x1c
Feb 21 16:01:02 cichlid kernel:  [<c0103d8b>] kernel_thread_helper+0x7/0x1c
Feb 21 16:01:02 cichlid kernel:  =======================
