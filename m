From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: patch-2.6.20-rt5: time warp detected!
Date: Tue, 20 Feb 2007 19:07:13 +0100
Message-ID: <45DB38D1.4000204@grandegger.com>
References: <45D9D7B5.9020404@grandegger.com> <1171966493.30834.225.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050207010800000407090901"
Cc: linux-rt-users@vger.kernel.org
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60667 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030180AbXBTSGS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Feb 2007 13:06:18 -0500
In-Reply-To: <1171966493.30834.225.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------050207010800000407090901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thomas Gleixner wrote:
> On Mon, 2007-02-19 at 18:00 +0100, Wolfgang Grandegger wrote:
>> Hello,
>>
>> sometimes I get the following message when calling ktime_get_real() from 
>> my interrupt handler:
> 
> SMP machine ?

No, it's my old DELL Inspiron 5000e notebook (with a PIII at 600 MHz).

>> BUG: time warp detected!
>> prev > now, 104357354c79dfed > 1043573435312fb2:
>> = 4685606971 delta, on CPU#0
>>   [<c0103d51>] dump_trace+0x68/0x1d9
>>   [<c0103edd>] show_trace_log_lvl+0x1b/0x36
>>   [<c01044dd>] show_trace+0xf/0x11
>>   [<c010455e>] dump_stack+0x12/0x14
>>   [<c012f1b2>] ktime_get_real+0x10/0x2c
>>   [<e09c03ad>] rtcan_rcv+0x12/0x99 [xeno_can]
>>   [<e09c951d>] rtcan_sja_interrupt+0x220/0x43e [xeno_can_sja1000]
>>   [<e0992018>] _rtdm_irq_trampoline+0x15/0x34 [xeno_rtdm]
>>   [<c0145eb7>] handle_IRQ_event+0x41/0xb7
>>   [<c0146334>] thread_simple_irq+0x31/0x5f
>>   [<c01468f8>] do_irqd+0xbd/0x249
>>   [<c012c531>] kthread+0xa0/0xcb
>>   [<c010397b>] kernel_thread_helper+0x7/0x10
>>   =======================
>> ---------------------------
>> | preempt count: 00000000 ]
>> | 0-level deep critical section nesting:
>> ----------------------------------------
>>
>> Any idea how this can happen?
> 
> Can you please provide a boot log ?

Attached is the boot log.

Thanks.

Wolfgang.


--------------050207010800000407090901
Content-Type: text/x-log;
 name="linux-2.6.20-rt5-boot.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="linux-2.6.20-rt5-boot.log"

Linux version 2.6.20-rt5 (wolf@lancy.denx.de) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #3 PREEMPT Mon Feb 19 11:23:03 CET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000e6800 size: 0000000000019800 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fef0000 end: 000000001fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fff0000 size: 000000000000fc00 end: 000000001ffffc00 type: 3
copy_e820_map() start: 000000001ffffc00 size: 0000000000000400 end: 0000000020000000 type: 4
copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
  HighMem    131056 ->   131056
early_node_map[1] active PFN ranges
    0:        0 ->   131056
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 597.434 MHz processor.
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 130033
Kernel command line: ro root=LABEL=/ rhgb lapic console=tty0 console=ttyS0,19200
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
CPU 0 irqstacks, hard=c04d2000 soft=c04d1000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
num_possible_cpus(): 1
CPU#0: allocated 2097152 bytes trace buffer.
CPU#0: allocated 2097152 bytes max-trace buffer.
allocated 2097152 bytes out-trace buffer.
tracer: a total of 6291456 bytes allocated.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507284k/524224k available (2385k kernel code, 16368k reserved, 1239k data, 256k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9c000 - 0xfffff000   ( 396 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc048c000 - 0xc04cc000   ( 256 kB)
      .data : 0xc0354689 - 0xc048a614   (1239 kB)
      .text : 0xc0100000 - 0xc0354689   (2385 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1195.46 BogoMIPS (lpj=597730)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0820)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1040-104f claimed by PIIX4 SMB
ACPI: [Package] has zero elements (dfe06ce0)
ACPI: [Package] has zero elements (dfe06e20)
ACPI: [Package] has zero elements (dfe06d40)
ACPI: [Package] has zero elements (dfe06ce0)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 14 15)
ACPI: [Package] has zero elements (dfe06c20)
ACPI: [Package] has zero elements (dfe06c80)
ACPI: [Package] has zero elements (dfe06c20)
ACPI: [Package] has zero elements (dfe06c40)
ACPI: [Package] has zero elements (dfe06e20)
ACPI: [Package] has zero elements (dfe06c00)
ACPI: [Package] has zero elements (dfe06b80)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x1040-0x104f has been reserved
pnp: 00:05: ioport range 0x3810-0x381f has been reserved
pnp: 00:05: ioport range 0x1016-0x103f has been reserved
pnp: 00:05: ioport range 0xfe00-0xfefe has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: f4100000-f41fffff
  PREFETCH window: f8000000-fbffffff
PCI: Bus 2, cardbus bridge: 0000:00:04.0
  IO window: 00001c00-00001cff
  IO window: 00003000-000030ff
  PREFETCH window: 30000000-33ffffff
  MEM window: 34000000-37ffffff
PCI: Bus 6, cardbus bridge: 0000:00:04.1
  IO window: 00003400-000034ff
  IO window: 00003c00-00003cff
  PREFETCH window: 38000000-3bffffff
  MEM window: 3c000000-3fffffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:04.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 786432 bytes)
TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1068k freed
Simple Boot Flag at 0x37 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1171997956.540:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN0] (on)
ACPI: Fan [FAN1] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Invalid passive threshold
ACPI: Thermal Zone [THRM] (51 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
%Gï¿½%@serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG MP0402H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78242976 sectors (40060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:00:04.0 [1028:00cc]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x01021c72, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000059
Yenta: CardBus bridge found at 0000:00:04.1 [1028:00cc]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x01021c72, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
usbcore: registered new interface driver libusual
pccard: PCMCIA card inserted into slot 0
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: acpi_pm clocksource has been installed.
Switched to high resolution mode on CPU 0
ACPI: (supports S0 S1 S3 S4 S5)
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging option is turned on in your .config:   *
*                                                                           *
*        CONFIG_FUNCTION_TRACE                                               *
*                                                                           *
*  it may increase runtime overhead and latencies.                          *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 256k freed
Write protecting the kernel read-only data: 953k
Red Hat nash version 4.2.15 starting
Mounted /proc filesystem
Mounting sysfs
Creating /dev
Starting udev
Loading jbd.ko module
Loading ext3.ko module
Synaptics Touchpad, model: 1, fw: 4.3, id: 0x8858a1, caps: 0x0/0x0
Creating root device
input: SynPS/2 Synaptics TouchPad as /class/input/input1
Mounting root filesystem
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Switching to new root
unmounting old /proc
unmounting old /sys
Clocksource tsc unstable (delta = -97465797 ns)
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1171997964.136:2): selinux=0 auid=4294967295

--------------050207010800000407090901--
