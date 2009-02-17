From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [Announce] 2.6.29-rc4-rt2
Date: Tue, 17 Feb 2009 21:15:53 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0902172104480.3930@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:42759 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZBQUPz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2009 15:15:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 75D2A42029C0
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2009 21:15:53 +0100 (CET)
In-Reply-To: alpine.LFD.2.00.0902122353050.16972@localhost.localdomain
References: alpine.LFD.2.00.0902122353050.16972@localhost.localdomain
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


>We are pleased to announce the first update to our new preempt-rt
>series. It fixes the reported bugs and some more.[...]


It happens to spew a warning (see full dmesg below)
and a call trace. Seems harmless otherwise, though.


Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.29-rc4-rt2 (abuild@sovereign) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP PREEMPT RT 2009-02-09 18:36:31 +0100
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
DMI present.
Phoenix BIOS detected: BIOS may corrupt low RAM, working around it.
last_pfn = 0x10000 max_arch_pfn = 0x100000
x86 PAT enabled: cpu 0, old 0x0, new 0x7010600070106
kernel direct mapping tables up to 10000000 @ 10000-14000
RAMDISK: 0fc47000 - 0fedf746
ACPI: RSDP 000F6A30, 0024 (r2 PTLTD )
ACPI: XSDT 0FEFA146, 003C (r1 INTEL  440BX     6040000 VMW   1324272)
ACPI: FACP 0FEFEE98, 00F4 (r4 INTEL  440BX     6040000 PTL     F4240)
FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
ACPI: DSDT 0FEFA22A, 4C6E (r1 PTLTD  Custom    6040000 MSFT  3000001)
ACPI: FACS 0FEFFFC0, 0040
ACPI: BOOT 0FEFA202, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: APIC 0FEFA1B2, 0050 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: Local APIC address 0xfee00000
0MB HIGHMEM available.
256MB LOWMEM available.
  mapped low ram: 0 - 10000000
  low ram: 00000000 - 10000000
  bootmap 00010000 - 00012000
(9 early reservations) ==> bootmem [0000000000 - 0010000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
  #3 [0000100000 - 00005bd490]    TEXT DATA BSS ==> [0000100000 - 00005bd490]
  #4 [000fc47000 - 000fedf746]          RAMDISK ==> [000fc47000 - 000fedf746]
  #5 [00005be000 - 00005c1000]    INIT_PG_TABLE ==> [00005be000 - 00005c1000]
  #6 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
  #7 [0000010000 - 0000010000]          PGTABLE
  #8 [0000010000 - 0000012000]          BOOTMAP ==> [0000010000 - 0000012000]
found SMP MP-table at [c00f6aa0] f6aa0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  Normal   0x00001000 -> 0x00010000
  HighMem  0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x0000fef0
    0: 0x0000ff00 -> 0x00010000
On node 0 totalpages: 65407
free_area_init_node: node 0, pgdat c0484280, node_mem_map c1000340
  DMA zone: 52 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3931 pages, LIFO batch:0
  Normal zone: 780 pages used for memmap
  Normal zone: 60644 pages, LIFO batch:15
Using APIC driver default
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 1 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000ca000
PM: Registered nosave memory: 00000000000ca000 - 00000000000cc000
PM: Registered nosave memory: 00000000000cc000 - 00000000000dc000
PM: Registered nosave memory: 00000000000dc000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
PM: Registered nosave memory: 000000000fef0000 - 000000000feff000
PM: Registered nosave memory: 000000000feff000 - 000000000ff00000
Allocating PCI resources starting at 20000000 (gap: 10000000:eec00000)
NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_node_ids:1
PERCPU: Allocating 32768 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64575
Kernel command line: root=/dev/sda3 rootfstype=btrfs
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Preemptible RCU implementation.
NR_IRQS:1280
PID hash table entries: 1024 (order: 10, 4096 bytes)
Extended CMOS year: 2000
TSC: Frequency read from the hypervisor
Detected 1666.800 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
allocated 1310400 bytes of page_cgroup
please try cgroup_disable=memory option if you don't want
Memory: 248868k/262144k available (2232k kernel code, 12468k reserved, 1631k data, 316k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe17000 - 0xfffff000   (1952 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xd0800000 - 0xff7fe000   ( 751 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
      .init : 0xc04cb000 - 0xc051a000   ( 316 kB)
      .data : 0xc032e359 - 0xc04c5f98   (1631 kB)
      .text : 0xc0100000 - 0xc032e359   (2232 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Calibrating delay loop (skipped), value calculated using timer frequency.. 3333.60 BogoMIPS (lpj=1666800)
Security Framework initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
------------[ cut here ]------------
WARNING: at mm/highmem.c:225 kmap_flush_unused+0x1d/0x2c()
Hardware name: VMware Virtual Platform
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.29-rc4-rt2-jen73-exp #1
Call Trace:
 [<c012b4ac>] warn_slowpath+0x71/0xa8
 [<c0116800>] ? arch_flush_lazy_cpu_mode+0x0/0x63
 [<c02b000f>] ? cpuidle_switch_governor+0xeb/0x104
 [<c02ce20f>] ? netpoll_send_skb+0xf9/0x131
 [<c02ce20f>] ? netpoll_send_skb+0xf9/0x131
 [<c010727c>] ? apply_paravirt+0x92/0xa2
 [<c018a4cb>] ? __insert_vmap_area+0x61/0x9a
 [<c018a67a>] ? alloc_vmap_area+0x176/0x180
 [<c018ab68>] ? vmap_pte_range+0xea/0x11a
 [<c018ac02>] ? vmap_page_range+0x6a/0x91
 [<c0181397>] kmap_flush_unused+0x1d/0x2c
 [<c011861f>] change_page_attr_set_clr+0xd0/0x2ca
 [<c018aa2b>] ? __vunmap+0x86/0x8e
 [<c018aa55>] ? vunmap+0x22/0x24
 [<c032b5aa>] ? text_poke+0xec/0x11a
 [<c01188e6>] set_memory_rw+0x1c/0x1e
 [<c0116edb>] free_init_pages+0x21/0x90
 [<c04d10c9>] alternative_instructions+0x100/0x10f
 [<c04d19f8>] check_bugs+0xd8/0xda
 [<c04cb83d>] start_kernel+0x2df/0x30d
 [<c04cb085>] __init_begin+0x85/0x8d
---[ end trace 4eaa2a86a8e2da22 ]---
Freeing SMP alternatives: 10k freed
ACPI: Core revision 20081204
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: AMD Athlon(tm) XP 2000+ stepping 00
Brought up 1 CPUs
Total of 1 processors activated (3333.60 BogoMIPS).
CPU0 attaching NULL sched-domain.
net_namespace: 1100 bytes
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8a0, last bus=2
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:07.1: reg 20 io port: [0x1060-0x106f]
pci 0000:00:07.3: quirk: region 1000-103f claimed by PIIX4 ACPI
pci 0000:00:07.3: quirk: region 1040-104f claimed by PIIX4 SMB
pci 0000:00:0f.0: reg 10 io port: [0x1070-0x107f]
pci 0000:00:0f.0: reg 14 32bit mmio: [0xf0000000-0xf7ffffff]
pci 0000:00:0f.0: reg 18 32bit mmio: [0xe8000000-0xe87fffff]
pci 0000:00:0f.0: reg 30 32bit mmio: [0x000000-0x007fff]
pci 0000:00:10.0: reg 10 io port: [0x1080-0x10ff]
pci 0000:00:10.0: reg 14 32bit mmio: [0xe8800000-0xe8800fff]
pci 0000:00:10.0: reg 30 32bit mmio: [0x000000-0x003fff]
pci 0000:00:11.0: reg 10 64bit mmio: [0xe8801000-0xe8801fff]
pci 0000:02:00.0: reg 10 io port: [0x2000-0x207f]
pci 0000:02:00.0: reg 30 32bit mmio: [0x000000-0x00ffff]
pci 0000:02:01.0: reg 10 io port: [0x2080-0x20ff]
pci 0000:02:01.0: reg 30 32bit mmio: [0x000000-0x00ffff]
pci 0000:02:03.0: reg 10 io port: [0x2400-0x247f]
pci 0000:02:03.0: reg 30 32bit mmio: [0x000000-0x00ffff]
pci 0000:02:04.0: reg 10 io port: [0x2480-0x24ff]
pci 0000:02:04.0: reg 30 32bit mmio: [0x000000-0x00ffff]
pci 0000:00:11.0: transparent bridge
pci 0000:00:11.0: bridge io port: [0x2000-0x2fff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 14 15)
PCI: Using ACPI for IRQ routing
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
system 00:01: ioport range 0x1000-0x103f has been reserved
system 00:01: ioport range 0x1040-0x104f has been reserved
system 00:01: ioport range 0xcf0-0xcf1 has been reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: disabled
pci 0000:00:01.0:   MEM window: disabled
pci 0000:00:01.0:   PREFETCH window: disabled
pci 0000:00:11.0: PCI bridge, secondary bus 0000:02
pci 0000:00:11.0:   IO window: 0x2000-0x2fff
pci 0000:00:11.0:   MEM window: disabled
pci 0000:00:11.0:   PREFETCH window: 0x00000020000000-0x000000200fffff
pci 0000:00:01.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
pci_bus 0000:01: resource 0 mem: [0x0-0x0]
pci_bus 0000:01: resource 1 mem: [0x0-0x0]
pci_bus 0000:01: resource 2 mem: [0x0-0x0]
pci_bus 0000:01: resource 3 mem: [0x0-0x0]
pci_bus 0000:02: resource 0 io:  [0x2000-0x2fff]
pci_bus 0000:02: resource 1 mem: [0x0-0x0]
pci_bus 0000:02: resource 2 mem: [0x20000000-0x200fffff]
pci_bus 0000:02: resource 3 io:  [0x00-0xffff]
pci_bus 0000:02: resource 4 mem: [0x000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs... done
Freeing initrd memory: 2657k freed
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
type=2000 audit(1234903163.380:1): initialized
HugeTLB registered 4 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 491
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:0f.0: Boot video device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
rpldhk 2.40, by Jan Engelhardt, 2004 - 2009
Serial: 8250/16550 driver, 8 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUS] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
Using IPI No-Shortcut mode
registered taskstats version 1
elantech.c: unexpected magic knock result 0x00, 0x02, 0x64.
input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input1
Freeing unused kernel memory: 316k freed
Write protecting the kernel text: 2236k
Write protecting the kernel read-only data: 1208k
SCSI subsystem initialized
Fusion MPT base driver 3.04.07
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SPI Host driver 3.04.07
mptspi 0000:00:10.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
mptbase: ioc0: Initiating bringup
ioc0: LSI53C1030 B0: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030 B0, FwRev=00000000h, Ports=1, MaxQ=128, IRQ=17
scsi 0:0:0:0: Direct-Access     VMware,  VMware Virtual S 1.0  PQ: 0 ANSI: 2
scsi target0:0:0: Beginning Domain Validation
scsi target0:0:0: Domain Validation skipping write tests
scsi target0:0:0: Ending Domain Validation
scsi target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 127)
scsi 0:0:1:0: Direct-Access     VMware,  VMware Virtual S 1.0  PQ: 0 ANSI: 2
scsi target0:0:1: Beginning Domain Validation
scsi target0:0:1: Domain Validation skipping write tests
scsi target0:0:1: Ending Domain Validation
scsi target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 127)
Btrfs loaded
libata version 3.00 loaded.
ata_piix 0000:00:07.1: version 2.12
scsi1 : ata_piix
scsi2 : ata_piix
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1060 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1068 irq 15
ata1: port disabled. ignoring.
ata2.00: ATAPI: VMware Virtual IDE CDROM Drive, 00000001, max UDMA/33
ata2.00: configured for UDMA/33
scsi 2:0:0:0: CD-ROM            NECVMWar VMware IDE CDR10 1.00 PQ: 0 ANSI: 5
udevd version 128 started
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] 8388608 512-byte hardware sectors: (4.29 GB/4.00 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 5d 00 00 00
sd 0:0:0:0: [sda] Cache data unavailable
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 8388608 512-byte hardware sectors: (4.29 GB/4.00 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 5d 00 00 00
sd 0:0:0:0: [sda] Cache data unavailable
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:1:0: [sdb] 16777216 512-byte hardware sectors: (8.58 GB/8.00 GiB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 5d 00 00 00
sd 0:0:1:0: [sdb] Cache data unavailable
sd 0:0:1:0: [sdb] Assuming drive cache: write through
sd 0:0:1:0: [sdb] 16777216 512-byte hardware sectors: (8.58 GB/8.00 GiB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 5d 00 00 00
sd 0:0:1:0: [sdb] Cache data unavailable
sd 0:0:1:0: [sdb] Assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: [sdb] Attached SCSI disk
device label root devid 1 transid 1505 /dev/sda3
udevd version 128 started
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Linux agpgart interface v0.103
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Attached scsi generic sg2 type 5
ACPI: I/O resource piix4_smbus [0x1040-0x1047] conflicts with ACPI region SMB_ [0x1040-0x104b]
ACPI: Device needs an ACPI driver
piix4_smbus 0000:00:07.3: Host SMBus controller not enabled!
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: Power Button (FF) [PWRF]
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: AC Adapter [ACAD] (on-line)
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 1x/1x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
agpgart-intel 0000:00:00.0: Intel 440BX Chipset
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x0
input: PC Speaker as /devices/platform/pcspkr/input/input3
pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
pcnet32 0000:02:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
pcnet32: PCnet/PCI II 79C970A at 0x2000, 00:0c:29:17:8a:3c assigned IRQ 18.
eth0: registered as PCnet/PCI II 79C970A
pcnet32 0000:02:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
pcnet32: PCnet/PCI II 79C970A at 0x2080, 00:0c:29:17:8a:46 assigned IRQ 19.
eth1: registered as PCnet/PCI II 79C970A
pcnet32 0000:02:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pcnet32: PCnet/PCI II 79C970A at 0x2400, 00:0c:29:17:8a:50 assigned IRQ 17.
eth2: registered as PCnet/PCI II 79C970A
pcnet32 0000:02:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
pcnet32: PCnet/PCI II 79C970A at 0x2480, 00:0c:29:17:8a:5a assigned IRQ 18.
eth3: registered as PCnet/PCI II 79C970A
pcnet32: 4 cards_found.
processor ACPI_CPU:00: registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport_pc 00:08: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
udev: renamed network interface eth0 to mg0
udev: renamed network interface eth1 to vn5
udev: renamed network interface eth2 to vn6
udev: renamed network interface eth3 to vn7
ppdev: user-space parallel port driver
Adding 72284k swap on /dev/sda2.  Priority:-1 extents:1 across:72284k 
loop: module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
fuse init (API version 7.11)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
powernow-k8: Processor cpuid 680 not supported
mg0: link up
NET: Registered protocol family 17
vn5: link up
vn6: link up
vn7: link up
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found

