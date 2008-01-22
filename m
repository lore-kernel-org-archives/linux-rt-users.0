From: "Lampersperger Andreas" <lampersperger.andreas@heidenhain.de>
Subject: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 12:09:42 +0100
Message-ID: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx02.jhcn.net ([194.25.102.130]:57662 "EHLO mx02.jhcn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYAVLT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 06:19:57 -0500
Received: (from mail@localhost)
	by de01mx04.global.jhcn.net (8.12.10/8.12.10) id m0MBACnQ019315
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 12:10:12 +0100
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

does anyone have a hint how to enable High resolution timers on my
system (with a Intel ICH2 (which has afaik 8254 Timers). Is this
hardware not enough for hr-timers?

Thank's for your help!
Andreas

- On my system, cyclictest reports:

WARNING: High resolution timers not available

- By in my .config there are these entries:

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y

- /sys/devices/system/clocksource/clocksource0/available_clocksource
tells:

tsc pit jiffies

- /proc/timer_list tells: 

Timer List Version: v0.3
HRTIMER_MAX_CLOCK_BASES: 2
now at 264765646460 nsecs

cpu: 0
 clock 0:
  .index:      0
  .resolution: 999848 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 1:
  .index:      1
  .resolution: 999848 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 0 nsecs
  .idle_sleeptime : 0 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294932106


Tick Device: mode:     0
Clock Event Device: pit
 max_delta_ns:   27461866
 min_delta_ns:   12571
 mult:           5124677
 shift:          32
 mode:           1
 next_event:     0 nsecs
 set_next_event: pit_next_event
 set_mode:       init_pit_timer
 event_handler:  clockevents_handle_noop
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     0
Clock Event Device: lapic
 max_delta_ns:   1346259629
 min_delta_ns:   2407
 mult:           26762143
 shift:          32
 mode:           2
 next_event:     0 nsecs
 set_next_event: lapic_next_event
 set_mode:       lapic_timer_setup
 event_handler:  tick_handle_periodic


- And my Boot-Log is:

Linux version 2.6.23.9-rt12 (a15108@de01pc6552) (gcc version 4.0.3) #67
SMP PREEMPT RT Tue Jan 22 11:27:38 CET 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001faeb000 (usable)
 BIOS-e820: 000000001faeb000 - 000000001ff00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
506MB LOWMEM available.
Entering add_active_range(0, 0, 129771) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   129771
  HighMem    129771 ->   129771
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   129771
On node 0 totalpages: 129771
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4040 pages, LIFO batch:0
  Normal zone: 1718 pages used for memmap
  Normal zone: 123957 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
DMI not present or invalid.
Using APIC driver default
ACPI: no DMI BIOS year, acpi=force is required to enable ACPI
ACPI: acpi=force override
Allocating PCI resources starting at 20000000 (gap: 1ff00000:e0000000)
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Zone order.  Total pages: 127997
Kernel command line: root_fstype=Linux vga=791 runlevel=5 acpi=force
lapic nosplash hpet=force
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffb000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 398.804 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
num_possible_cpus(): 1
CPU#0: allocated 2097152 bytes trace buffer.
CPU#0: allocated 2097152 bytes max-trace buffer.
allocated 2097152 bytes out-trace buffer.
tracer: a total of 6291456 bytes allocated.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 490872k/519084k available (2235k kernel code, 27748k reserved,
856k data, 10044k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff7f000 - 0xfffff000   ( 512 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfaeb000   ( 506 MB)
      .init : 0xc040b000 - 0xc0dda000   (10044 kB)
      .data : 0xc032ee37 - 0xc04050fc   ( 856 kB)
      .text : 0xc0100000 - 0xc032ee37   (2235 kB)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 798.50 BogoMIPS
(lpj=399253)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 10k freed
ACPI: Core revision 20070126
ACPI Exception (tbxface-0629): AE_NO_ACPI_TABLES, While loading
namespace from ACPI tables [20070126]
ACPI: Unable to load the System Description Tables
CPU0: Intel(R) Celeron(TM) CPU                 400MHz stepping 04
SMP motherboard not detected.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xff6b1, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: c0100000-c18fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 720896 bytes)
TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
Machine check exception polling timer started.
apm: BIOS not found.
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1201002178.727:1): initialized
KGDB Registering GDB sysrq handler
krcupreemptd setsched 0
  prio = 98
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
PCI: Firmware left 0000:01:08.0 e100 interrupts enabled, disabling
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0x80000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 1
Using IPI No-Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
************************************************************************
*****
*
*
*  REMINDER, the following debugging options are turned on in your
.config: *
*
*
*        CONFIG_CRITICAL_PREEMPT_TIMING
*
*        CONFIG_FUNCTION_TRACE
*
*
*
*  they may increase runtime overhead and latencies.
*
*
*
************************************************************************
*****
Freeing unused kernel memory: 10044k freed
i810-i2c: Probe DDC1 Bus
i2c-adapter i2c-0: unable to read EDID block.
i2c-adapter i2c-0: unable to read EDID block.
i2c-adapter i2c-0: unable to read EDID block.
i810-i2c: Probe DDC2 Bus
i2c-adapter i2c-1: sendbytes: error - bailout.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: sendbytes: error - bailout.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: sendbytes: error - bailout.
i2c-adapter i2c-1: unable to read EDID block.
i810-i2c: Probe DDC3 Bus
i810fb_init_pci: Unable to get Mode Database
fbcon: I810 (fb0) is primary device
Console: switching to colour frame buffer device 128x48
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP)
Framebuffer Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 30-65 KHz V: 60-60 Hz
I810FB: Mode        : 1024x768-16bpp@60Hz
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 10, io base 0x0000f400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.3: new low speed USB device using uhci_hcd and address 3
usb 1-1.3: configuration #1 chosen from 1 choice
usb 1-1.4: new low speed USB device using uhci_hcd and address 4
usb 1-1.4: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Dell Dell USB Keyboard as
/devices/pci0000:00/0000:00:1f.2/usb1/1-1/1-1.3/1-1.3:1.0/input/input0
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on
usb-0000:00:1f.2-1.3
input: Logitech USB-PS/2 Optical Mouse as
/devices/pci0000:00/0000:00:1f.2/usb1/1-1/1-1.4/1-1.4:1.0/input/input1
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1f.2-1.4
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver usbkbd
drivers/hid/usbhid/usbkbd.c: :USB HID Boot Protocol keyboard driver
SCSI subsystem initialized
libata version 2.21 loaded.
ata_piix 0000:00:1f.1: version 2.12
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f800
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f808
irq 15
ata1.00: ATA-5: FUJITSU MHK2060AT, D836, max UDMA/66
ata1.00: 11733120 sectors, multi 0: LBA 
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHK2060A D836 PQ: 0
ANSI: 5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
scsi 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 11733120 512-byte hardware sectors (6007 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 11733120 512-byte hardware sectors (6007 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0,
recovered transactions 2288 to 2311
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 1241 and
revoked 0/670 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 148260
ext3_orphan_cleanup: deleting unreferenced inode 148259
ext3_orphan_cleanup: deleting unreferenced inode 148251
ext3_orphan_cleanup: deleting unreferenced inode 148249
ext3_orphan_cleanup: deleting unreferenced inode 587522
ext3_orphan_cleanup: deleting unreferenced inode 685714
ext3_orphan_cleanup: deleting unreferenced inode 685713
ext3_orphan_cleanup: deleting unreferenced inode 685450
EXT3-fs: sda1: 8 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e100: eth0: e100_probe: addr 0xc0100000, irq 11, MAC addr
00:A0:CD:01:5B:CE
EXT3 FS on sda1, internal journal
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex


-------------------------------------------------------------------------------------------------------
Registergericht: Traunstein / Code of Register HRB 275 Sitz / Head Office: Traunreut
Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Burkhard
Geschaeftsfuehrung / Managing Director: Thomas Sesselmann
