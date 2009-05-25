From: =?utf-8?Q?Jose_Angel_Mart=C3=ADnez_conde?=
	<joseangel@taller-id.com>
Subject: Re: Oops issue with patch-2.6.29.4-rt15
Date: Mon, 25 May 2009 15:22:35 +0200 (CEST)
Message-ID: <1138703312.2171243257755533.JavaMail.root@groupware>
References: <2117884839.2151243257710066.JavaMail.root@groupware>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:60894 "EHLO
	groupware.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752323AbZEYN2L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 May 2009 09:28:11 -0400
In-Reply-To: <2117884839.2151243257710066.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The same case,

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.4-rt15 (root@tid31) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #13 SMP PREEMPT RT Mon May 25 14:51:52 CEST 2009
[    0.000000] Command line: root=UUID=b177b45d-bc78-4abc-9935-d748ffb33b44 ro 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
[    0.000000]  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bfef0000 (usable)
[    0.000000]  BIOS-e820: 00000000bfef0000 - 00000000bfef3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bfef3000 - 00000000bff00000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] DMI 2.4 present.
[    0.000000] Phoenix BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x140000 max_arch_pfn = 0x100000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CCFFF write-protect
[    0.000000]   CD000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 100000000 mask FC0000000 write-back
[    0.000000]   3 base 0BFF00000 mask FFFF00000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.000000]   get_mtrr: cpu0 reg01 base=0000080000 size=0000040000 write-back
[    0.000000]   get_mtrr: cpu0 reg02 base=0000100000 size=0000040000 write-back
[    0.000000]   get_mtrr: cpu0 reg03 base=00000bff00 size=0000000100 uncachable
[    0.000000] e820 update range: 00000000bff00000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbfef0 max_arch_pfn = 0x100000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009ec00 (usable)
[    0.000000]  modified: 000000000009ec00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000bfef0000 (usable)
[    0.000000]  modified: 00000000bfef0000 - 00000000bfef3000 (ACPI NVS)
[    0.000000]  modified: 00000000bfef3000 - 00000000bff00000 (ACPI data)
[    0.000000]  modified: 00000000f0000000 - 00000000f2000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000140000000 (usable)
[    0.000000] init_memory_mapping: 0000000000000000-00000000bfef0000
[    0.000000]  0000000000 - 00bfe00000 page 2M
[    0.000000]  00bfe00000 - 00bfef0000 page 4k
[    0.000000] kernel direct mapping tables up to bfef0000 @ 10000-15000
[    0.000000] init_memory_mapping: 0000000100000000-0000000140000000
[    0.000000]  0100000000 - 0140000000 page 2M
[    0.000000] kernel direct mapping tables up to 140000000 @ 13000-19000
[    0.000000] RAMDISK: 37bff000 - 37fef008
[    0.000000] ACPI: RSDP 000F7380, 0024 (r2 Nvidia)
[    0.000000] ACPI: XSDT BFEF30C0, 004C (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
[    0.000000] ACPI: FACP BFEF9F80, 00F4 (r3 Nvidia ASUSACPI 42302E31 AWRD        0)
[    0.000000] ACPI Warning (tbfadt-0568): 32/64X length mismatch in Pm1aEventBlock: 32/8 [20081204]
[    0.000000] ACPI Warning (tbfadt-0568): 32/64X length mismatch in Pm1aControlBlock: 16/8 [20081204]
[    0.000000] ACPI Warning (tbfadt-0568): 32/64X length mismatch in PmTimerBlock: 32/8 [20081204]
[    0.000000] ACPI Warning (tbfadt-0568): 32/64X length mismatch in Gpe0Block: 64/8 [20081204]
[    0.000000] ACPI Warning (tbfadt-0568): 32/64X length mismatch in Gpe1Block: 128/8 [20081204]
[    0.000000] ACPI Warning (tbfadt-0412): Invalid length for Pm1aEventBlock: 8, using default 32 [20081204]
[    0.000000] ACPI Warning (tbfadt-0412): Invalid length for Pm1aControlBlock: 8, using default 16 [20081204]
[    0.000000] ACPI Warning (tbfadt-0412): Invalid length for PmTimerBlock: 8, using default 32 [20081204]
[    0.000000] FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
[    0.000000] ACPI: DSDT BFEF3240, 6CF4 (r1 NVIDIA AWRDACPI     1000 MSFT  3000000)
[    0.000000] ACPI: FACS BFEF0000, 0040
[    0.000000] ACPI: HPET BFEFA1C0, 0038 (r1 Nvidia ASUSACPI 42302E31 AWRD       98)
[    0.000000] ACPI: MCFG BFEFA240, 003C (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
[    0.000000] ACPI: APIC BFEFA0C0, 0098 (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
[    0.000000] ACPI: SSDT BFEFA2C0, 087B (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0140000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 0000860890]    TEXT DATA BSS ==> [0000200000 - 0000860890]
[    0.000000]   #3 [0037bff000 - 0037fef008]          RAMDISK ==> [0037bff000 - 0037fef008]
[    0.000000]   #4 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 - 0000100000]
[    0.000000]   #5 [0000861000 - 0000861159]              BRK ==> [0000861000 - 0000861159]
[    0.000000]   #6 [0000010000 - 0000013000]          PGTABLE ==> [0000010000 - 0000013000]
[    0.000000]   #7 [0000013000 - 0000014000]          PGTABLE ==> [0000013000 - 0000014000]
[    0.000000] found SMP MP-table at [ffff8800000f58b0] f58b0
[    0.000000]  [ffffe20000000000-ffffe200045fffff] PMD -> [ffff880028200000-ffff88002c7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00140000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bfef0
[    0.000000]     0: 0x00100000 -> 0x00140000
[    0.000000] On node 0 totalpages: 1048190
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1736 pages reserved
[    0.000000]   DMA zone: 2190 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 767784 pages, LIFO batch:31
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 258560 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfeff0000
[    0.000000] 4 Processors exceeds NR_CPUS limit of 2
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] Allocating PCI resources starting at c0000000 (gap: bff00000:30100000)
[    0.000000] NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 22 pages at ffff88002805e000, static data 58692 bytes
[    0.000000] Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1028534
[    0.000000] Kernel command line: root=UUID=b177b45d-bc78-4abc-9935-d748ffb33b44 ro 
[    0.000000] Initializing CPU#0
[    0.000000] Preemptible RCU implementation.
[    0.000000] NR_IRQS:320
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2666.433 MHz processor.
[    0.000999] spurious 8259A interrupt: IRQ7.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000999] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000999] allocated 52428800 bytes of page_cgroup
[    0.000999] please try cgroup_disable=memory option if you don't want
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000999] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.000999] software IO TLB at phys 0x20000000 - 0x24000000
[    0.000999] Memory: 3985684k/5242880k available (3858k kernel code, 1050120k absent, 206168k reserved, 1532k data, 444k init)
[    0.000999] hpet clockevent registered
[    0.000999] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.000999] Calibrating delay loop (skipped), value calculated using timer frequency.. 5332.86 BogoMIPS (lpj=2666433)
[    0.000999] Security Framework initialized
[    0.000999] Smack:  Initializing.
[    0.000999] Mount-cache hash table entries: 256
[    0.000999] Initializing cgroup subsys ns
[    0.000999] Initializing cgroup subsys cpuacct
[    0.000999] Initializing cgroup subsys memory
[    0.000999] Initializing cgroup subsys freezer
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 2048K
[    0.000999] [ds] using Core 2/Atom configuration
[    0.001044] CPU: Physical Processor ID: 0
[    0.001104] CPU: Processor Core ID: 0
[    0.001166] using mwait in idle threads.
[    0.001226] Intel Performance Monitoring support detected.
[    0.001288] ... version:         2
[    0.001348] ... bit width:       40
[    0.001408] ... mask length:     7
[    0.001467] ... num counters:    2
[    0.001527] ... value mask:      000000ffffffffff
[    0.001588] ... fixed counters:  0
[    0.001647] ... counter mask:    0000000000000003
[    0.001717] Freeing SMP alternatives: 28k freed
[    0.001798] ACPI: Core revision 20081204
[    0.009053] Setting APIC routing to flat
[    0.010437] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020513] CPU0: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
[    0.020996] Booting processor 1 APIC 0x1 ip 0x6000
[    0.020996] Initializing CPU#1
[    0.020996] Calibrating delay using timer specific routine.. 5333.06 BogoMIPS (lpj=2666533)
[    0.020996] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.020996] CPU: L2 cache: 2048K
[    0.020996] [ds] using Core 2/Atom configuration
[    0.020996] CPU: Physical Processor ID: 0
[    0.020996] CPU: Processor Core ID: 1
[    0.091284] CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
[    0.091885] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.092026] Brought up 2 CPUs
[    0.092086] Total of 2 processors activated (10665.93 BogoMIPS).
[    0.092237] net_namespace: 1920 bytes
[    0.092237] regulator: core version 0.5
[    0.092352] NET: Registered protocol family 16
[    0.093029] ACPI: bus type pci registered
[    0.093091] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 31
[    0.093094] PCI: MCFG area at f0000000 reserved in E820
[    0.094253] PCI: Using MMCONFIG at f0000000 - f1ffffff
[    0.094315] PCI: Using configuration type 1 for base access
[    0.094405] mtrr: your CPUs had inconsistent fixed MTRR settings
[    0.094405] mtrr: probably your BIOS does not setup all CPUs.
[    0.095519] mtrr: corrected configuration.
[    0.098024] bio: create slab <bio-0> at 0
[    0.099091] ACPI: EC: Look up EC in DSDT
[    0.107300] ACPI: Interpreter enabled
[    0.107364] ACPI: (supports S0 S5)
[    0.107525] ACPI: Using IOAPIC for interrupt routing
[    0.117125] ACPI: No dock devices found.
[    0.117199] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.118311] pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.118376] pci 0000:00:03.0: PME# disabled
[    0.118643] pci 0000:00:0a.1: reg 10 io port: [0xff00-0xff3f]
[    0.118657] pci 0000:00:0a.1: reg 20 io port: [0x1c00-0x1c3f]
[    0.118661] pci 0000:00:0a.1: reg 24 io port: [0x1c80-0x1cbf]
[    0.118694] pci 0000:00:0a.1: PME# supported from D3hot D3cold
[    0.118760] pci 0000:00:0a.1: PME# disabled
[    0.118843] pci 0000:00:0b.0: reg 10 32bit mmio: [0xeffff000-0xefffffff]
[    0.118876] pci 0000:00:0b.0: supports D1 D2
[    0.118877] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.118942] pci 0000:00:0b.0: PME# disabled
[    0.119022] pci 0000:00:0b.1: reg 10 32bit mmio: [0xefffe000-0xefffe0ff]
[    0.119059] pci 0000:00:0b.1: supports D1 D2
[    0.119061] pci 0000:00:0b.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.119125] pci 0000:00:0b.1: PME# disabled
[    0.119215] pci 0000:00:0d.0: reg 20 io port: [0xfc00-0xfc0f]
[    0.119249] pci 0000:00:0e.0: reg 10 io port: [0x9f0-0x9f7]
[    0.119253] pci 0000:00:0e.0: reg 14 io port: [0xbf0-0xbf3]
[    0.119257] pci 0000:00:0e.0: reg 18 io port: [0x970-0x977]
[    0.119261] pci 0000:00:0e.0: reg 1c io port: [0xb70-0xb73]
[    0.119265] pci 0000:00:0e.0: reg 20 io port: [0xf700-0xf70f]
[    0.119269] pci 0000:00:0e.0: reg 24 32bit mmio: [0xefffd000-0xefffdfff]
[    0.119312] pci 0000:00:0e.1: reg 10 io port: [0x9e0-0x9e7]
[    0.119316] pci 0000:00:0e.1: reg 14 io port: [0xbe0-0xbe3]
[    0.119320] pci 0000:00:0e.1: reg 18 io port: [0x960-0x967]
[    0.119324] pci 0000:00:0e.1: reg 1c io port: [0xb60-0xb63]
[    0.119328] pci 0000:00:0e.1: reg 20 io port: [0xf200-0xf20f]
[    0.119332] pci 0000:00:0e.1: reg 24 32bit mmio: [0xefffc000-0xefffcfff]
[    0.119375] pci 0000:00:0e.2: reg 10 io port: [0xf100-0xf107]
[    0.119379] pci 0000:00:0e.2: reg 14 io port: [0xf000-0xf003]
[    0.119383] pci 0000:00:0e.2: reg 18 io port: [0xef00-0xef07]
[    0.119387] pci 0000:00:0e.2: reg 1c io port: [0xee00-0xee03]
[    0.119391] pci 0000:00:0e.2: reg 20 io port: [0xed00-0xed0f]
[    0.119395] pci 0000:00:0e.2: reg 24 32bit mmio: [0xefffb000-0xefffbfff]
[    0.119476] pci 0000:00:0f.1: reg 10 32bit mmio: [0xefff4000-0xefff7fff]
[    0.119519] pci 0000:00:0f.1: PME# supported from D3hot D3cold
[    0.119583] pci 0000:00:0f.1: PME# disabled
[    0.119672] pci 0000:00:11.0: reg 10 32bit mmio: [0xefffa000-0xefffafff]
[    0.119676] pci 0000:00:11.0: reg 14 io port: [0xec00-0xec07]
[    0.119680] pci 0000:00:11.0: reg 18 32bit mmio: [0xefff9000-0xefff90ff]
[    0.119684] pci 0000:00:11.0: reg 1c 32bit mmio: [0xefff8000-0xefff800f]
[    0.119727] pci 0000:00:11.0: supports D1 D2
[    0.119728] pci 0000:00:11.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.119794] pci 0000:00:11.0: PME# disabled
[    0.119903] pci 0000:00:16.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.119967] pci 0000:00:16.0: PME# disabled
[    0.120090] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.120154] pci 0000:01:00.0: PME# disabled
[    0.120252] pci 0000:00:03.0: bridge io port: [0xb000-0xcfff]
[    0.120255] pci 0000:00:03.0: bridge 32bit mmio: [0xe8000000-0xedffffff]
[    0.120258] pci 0000:00:03.0: bridge 64bit mmio pref: [0xc0000000-0xdfffffff]
[    0.120296] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.120360] pci 0000:02:00.0: PME# disabled
[    0.120460] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    0.120524] pci 0000:02:02.0: PME# disabled
[    0.120612] pci 0000:01:00.0: bridge io port: [0xb000-0xcfff]
[    0.120615] pci 0000:01:00.0: bridge 32bit mmio: [0xe8000000-0xedffffff]
[    0.120620] pci 0000:01:00.0: bridge 64bit mmio pref: [0xc0000000-0xdfffffff]
[    0.120649] pci 0000:02:00.0: bridge io port: [0xc000-0xcfff]
[    0.120652] pci 0000:02:00.0: bridge 32bit mmio: [0xedf00000-0xedffffff]
[    0.120657] pci 0000:02:00.0: bridge 64bit mmio pref: [0xdff00000-0xdfffffff]
[    0.120681] pci 0000:04:00.0: reg 10 32bit mmio: [0xea000000-0xeaffffff]
[    0.120691] pci 0000:04:00.0: reg 14 64bit mmio: [0xc0000000-0xcfffffff]
[    0.120701] pci 0000:04:00.0: reg 1c 64bit mmio: [0xe8000000-0xe9ffffff]
[    0.120707] pci 0000:04:00.0: reg 24 io port: [0xbc00-0xbc7f]
[    0.120713] pci 0000:04:00.0: reg 30 32bit mmio: [0xebfe0000-0xebffffff]
[    0.120780] pci 0000:02:02.0: bridge io port: [0xb000-0xbfff]
[    0.120783] pci 0000:02:02.0: bridge 32bit mmio: [0xe8000000-0xebffffff]
[    0.120788] pci 0000:02:02.0: bridge 64bit mmio pref: [0xc0000000-0xcfffffff]
[    0.120825] pci 0000:05:06.0: reg 10 32bit mmio: [0xefea0000-0xefebffff]
[    0.120831] pci 0000:05:06.0: reg 14 32bit mmio: [0xefec0000-0xefedffff]
[    0.120836] pci 0000:05:06.0: reg 18 io port: [0xdc00-0xdc3f]
[    0.120852] pci 0000:05:06.0: reg 30 32bit mmio: [0xefe80000-0xefe9ffff]
[    0.120881] pci 0000:05:06.0: PME# supported from D0 D3hot D3cold
[    0.120945] pci 0000:05:06.0: PME# disabled
[    0.121045] pci 0000:05:0b.0: reg 10 32bit mmio: [0xefeff000-0xefeff7ff]
[    0.121050] pci 0000:05:0b.0: reg 14 io port: [0xd800-0xd87f]
[    0.121090] pci 0000:05:0b.0: supports D2
[    0.121091] pci 0000:05:0b.0: PME# supported from D2 D3hot D3cold
[    0.121156] pci 0000:05:0b.0: PME# disabled
[    0.121239] pci 0000:00:0f.0: transparent bridge
[    0.121301] pci 0000:00:0f.0: bridge io port: [0xd000-0xdfff]
[    0.121304] pci 0000:00:0f.0: bridge 32bit mmio: [0xefe00000-0xefefffff]
[    0.121306] pci 0000:00:0f.0: bridge 32bit mmio pref: [0xefd00000-0xefdfffff]
[    0.121332] pci 0000:06:00.0: reg 10 io port: [0xac00-0xac07]
[    0.121338] pci 0000:06:00.0: reg 14 io port: [0xa800-0xa803]
[    0.121344] pci 0000:06:00.0: reg 18 io port: [0xa400-0xa407]
[    0.121350] pci 0000:06:00.0: reg 1c io port: [0xa000-0xa003]
[    0.121356] pci 0000:06:00.0: reg 20 io port: [0x9c00-0x9c0f]
[    0.121362] pci 0000:06:00.0: reg 24 32bit mmio: [0xefcff000-0xefcff3ff]
[    0.121401] pci 0000:06:00.0: supports D1
[    0.121403] pci 0000:06:00.0: PME# supported from D0 D1 D3hot
[    0.121467] pci 0000:06:00.0: PME# disabled
[    0.121568] pci 0000:00:16.0: bridge io port: [0x9000-0xafff]
[    0.121571] pci 0000:00:16.0: bridge 32bit mmio: [0xefc00000-0xefcfffff]
[    0.121575] pci 0000:00:16.0: bridge 64bit mmio pref: [0xefb00000-0xefbfffff]
[    0.121583] pci_bus 0000:00: on NUMA node 0
[    0.121590] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.122014] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[    0.200579] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 *10 11 14 15)
[    0.201358] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.202122] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.202867] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 *10 11 14 15)
[    0.203513] ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.204267] ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.205018] ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)
[    0.205658] ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.206407] ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.207153] ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.207896] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
[    0.208554] ACPI: PCI Interrupt Link [LAZA] (IRQs *5 7 9 10 11 14 15)
[    0.209205] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.209947] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.210691] ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.211428] ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.212188] ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 *10 11 14 15)
[    0.212829] ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 *11 14 15)
[    0.213467] ACPI: PCI Interrupt Link [LSA2] (IRQs *5 7 9 10 11 14 15)
[    0.214165] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
[    0.214603] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[    0.215097] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[    0.215583] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0
[    0.216030] ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
[    0.216515] ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
[    0.217005] ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0
[    0.217442] ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
[    0.217926] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
[    0.218545] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
[    0.219142] ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
[    0.219767] ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
[    0.220345] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
[    0.220996] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
[    0.221622] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
[    0.222240] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[    0.222864] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
[    0.223450] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
[    0.224054] ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0
[    0.224502] SCSI subsystem initialized
[    0.224977] libata version 3.00 loaded.
[    0.225058] usbcore: registered new interface driver usbfs
[    0.225153] usbcore: registered new interface driver hub
[    0.225219] usbcore: registered new device driver usb
[    0.225219] ACPI: WMI: Mapper loaded
[    0.225219] PCI: Using ACPI for IRQ routing
[    0.232988] NetLabel: Initializing
[    0.233049] NetLabel:  domain hash size = 128
[    0.233109] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.233181] NetLabel:  unlabeled traffic allowed by default
[    0.233275] hpet0: at MMIO 0xfeff0000, IRQs 2, 8, 31
[    0.233524] hpet0: 3 comparators, 32-bit 25.000000 MHz counter
[    0.242006] pnp: PnP ACPI init
[    0.242071] ACPI: bus type pnp registered
[    0.246144] pnp: PnP ACPI: found 12 devices
[    0.246206] ACPI: ACPI bus type pnp unregistered
[    0.246273] system 00:01: ioport range 0x1000-0x107f has been reserved
[    0.246337] system 00:01: ioport range 0x1080-0x10ff has been reserved
[    0.246401] system 00:01: ioport range 0x1400-0x147f has been reserved
[    0.246465] system 00:01: ioport range 0x1480-0x14ff has been reserved
[    0.246529] system 00:01: ioport range 0x1800-0x187f has been reserved
[    0.246593] system 00:01: ioport range 0x1880-0x18ff has been reserved
[    0.246661] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    0.246724] system 00:02: ioport range 0x800-0x87f has been reserved
[    0.246788] system 00:02: ioport range 0x290-0x297 has been reserved
[    0.246851] system 00:02: ioport range 0x880-0x88f has been reserved
[    0.246919] system 00:0a: iomem range 0xf0000000-0xf1ffffff has been reserved
[    0.246993] system 00:0b: iomem range 0xd6000-0xd7fff has been reserved
[    0.247057] system 00:0b: iomem range 0xd0000-0xd3fff has been reserved
[    0.247121] system 00:0b: iomem range 0xf0000-0xfbfff could not be reserved
[    0.247185] system 00:0b: iomem range 0xfc000-0xfffff could not be reserved
[    0.247250] system 00:0b: iomem range 0xfeff0000-0xfeff00ff has been reserved
[    0.247314] system 00:0b: iomem range 0xbfef0000-0xbfefffff could not be reserved
[    0.247388] system 00:0b: iomem range 0xffff0000-0xffffffff has been reserved
[    0.247453] system 00:0b: iomem range 0x0-0x9ffff could not be reserved
[    0.247517] system 00:0b: iomem range 0x100000-0xbfeeffff could not be reserved
[    0.247591] system 00:0b: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.247655] system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.247720] system 00:0b: iomem range 0xfeff0000-0xfeff03ff could not be reserved
[    0.252792] pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
[    0.252857] pci 0000:02:00.0:   IO window: 0xc000-0xcfff
[    0.252921] pci 0000:02:00.0:   MEM window: 0xedf00000-0xedffffff
[    0.252990] pci 0000:02:00.0:   PREFETCH window: 0x000000dff00000-0x000000dfffffff
[    0.253067] pci 0000:02:02.0: PCI bridge, secondary bus 0000:04
[    0.253130] pci 0000:02:02.0:   IO window: 0xb000-0xbfff
[    0.253195] pci 0000:02:02.0:   MEM window: 0xe8000000-0xebffffff
[    0.253259] pci 0000:02:02.0:   PREFETCH window: 0x000000c0000000-0x000000cfffffff
[    0.253335] pci 0000:01:00.0: PCI bridge, secondary bus 0000:02
[    0.253399] pci 0000:01:00.0:   IO window: 0xb000-0xcfff
[    0.253463] pci 0000:01:00.0:   MEM window: 0xe8000000-0xedffffff
[    0.253527] pci 0000:01:00.0:   PREFETCH window: 0x000000c0000000-0x000000dfffffff
[    0.253604] pci 0000:00:03.0: PCI bridge, secondary bus 0000:01
[    0.253667] pci 0000:00:03.0:   IO window: 0xb000-0xcfff
[    0.253730] pci 0000:00:03.0:   MEM window: 0xe8000000-0xedffffff
[    0.253793] pci 0000:00:03.0:   PREFETCH window: 0x000000c0000000-0x000000dfffffff
[    0.253870] pci 0000:00:0f.0: PCI bridge, secondary bus 0000:05
[    0.253933] pci 0000:00:0f.0:   IO window: 0xd000-0xdfff
[    0.254001] pci 0000:00:0f.0:   MEM window: 0xefe00000-0xefefffff
[    0.254065] pci 0000:00:0f.0:   PREFETCH window: 0x000000efd00000-0x000000efdfffff
[    0.254141] pci 0000:00:16.0: PCI bridge, secondary bus 0000:06
[    0.254204] pci 0000:00:16.0:   IO window: 0x9000-0xafff
[    0.254268] pci 0000:00:16.0:   MEM window: 0xefc00000-0xefcfffff
[    0.254331] pci 0000:00:16.0:   PREFETCH window: 0x000000efb00000-0x000000efbfffff
[    0.254411] pci 0000:00:03.0: setting latency timer to 64
[    0.254417] pci 0000:01:00.0: setting latency timer to 64
[    0.254423] pci 0000:02:00.0: setting latency timer to 64
[    0.254429] pci 0000:02:02.0: setting latency timer to 64
[    0.254433] pci 0000:00:0f.0: setting latency timer to 64
[    0.254438] pci 0000:00:16.0: setting latency timer to 64
[    0.254441] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.254443] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.254445] pci_bus 0000:01: resource 0 io:  [0xb000-0xcfff]
[    0.254447] pci_bus 0000:01: resource 1 mem: [0xe8000000-0xedffffff]
[    0.254448] pci_bus 0000:01: resource 2 mem: [0xc0000000-0xdfffffff]
[    0.254450] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.254452] pci_bus 0000:02: resource 0 io:  [0xb000-0xcfff]
[    0.254454] pci_bus 0000:02: resource 1 mem: [0xe8000000-0xedffffff]
[    0.254455] pci_bus 0000:02: resource 2 mem: [0xc0000000-0xdfffffff]
[    0.254457] pci_bus 0000:02: resource 3 mem: [0x0-0x0]
[    0.254459] pci_bus 0000:03: resource 0 io:  [0xc000-0xcfff]
[    0.254460] pci_bus 0000:03: resource 1 mem: [0xedf00000-0xedffffff]
[    0.254462] pci_bus 0000:03: resource 2 mem: [0xdff00000-0xdfffffff]
[    0.254464] pci_bus 0000:03: resource 3 mem: [0x0-0x0]
[    0.254465] pci_bus 0000:04: resource 0 io:  [0xb000-0xbfff]
[    0.254467] pci_bus 0000:04: resource 1 mem: [0xe8000000-0xebffffff]
[    0.254469] pci_bus 0000:04: resource 2 mem: [0xc0000000-0xcfffffff]
[    0.254470] pci_bus 0000:04: resource 3 mem: [0x0-0x0]
[    0.254472] pci_bus 0000:05: resource 0 io:  [0xd000-0xdfff]
[    0.254474] pci_bus 0000:05: resource 1 mem: [0xefe00000-0xefefffff]
[    0.254476] pci_bus 0000:05: resource 2 mem: [0xefd00000-0xefdfffff]
[    0.254477] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.254479] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.254481] pci_bus 0000:06: resource 0 io:  [0x9000-0xafff]
[    0.254482] pci_bus 0000:06: resource 1 mem: [0xefc00000-0xefcfffff]
[    0.254484] pci_bus 0000:06: resource 2 mem: [0xefb00000-0xefbfffff]
[    0.254486] pci_bus 0000:06: resource 3 mem: [0x0-0x0]
[    0.254509] NET: Registered protocol family 2
[    0.280998] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.281419] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.283286] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
[    0.285085] TCP: Hash tables configured (established 262144 bind 65536)
[    0.285153] TCP reno registered
[    0.297052] NET: Registered protocol family 1
[    0.297172] checking if image is initramfs... it is
[    0.437921] Freeing initrd memory: 4032k freed
[    0.440136] Scanning for low memory corruption every 60 seconds
[    0.440443] audit: initializing netlink socket (disabled)
[    0.440522] type=2000 audit(1243256040.439:1): initialized
[    0.440889] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.441046] VFS: Disk quotas dquot_6.5.2
[    0.441120] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.441312] fuse init (API version 7.11)
[    0.441441] msgmni has been set to 7794
[    0.441614] alg: No test for stdrng (krng)
[    0.441686] io scheduler noop registered
[    0.441747] io scheduler anticipatory registered
[    0.441809] io scheduler deadline registered
[    0.441879] io scheduler cfq registered (default)
[    0.464150] pci 0000:04:00.0: Boot video device
[    0.464315] pcieport-driver 0000:00:03.0: setting latency timer to 64
[    0.464357] pcieport-driver 0000:00:03.0: irq 24 for MSI/MSI-X
[    0.464474] pcieport-driver 0000:00:16.0: setting latency timer to 64
[    0.464522] pcieport-driver 0000:00:16.0: irq 25 for MSI/MSI-X
[    0.464640] pcieport-driver 0000:01:00.0: setting latency timer to 64
[    0.464701] pcieport-driver 0000:02:00.0: setting latency timer to 64
[    0.464758] pcieport-driver 0000:02:02.0: setting latency timer to 64
[    0.465093] input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.466112] ACPI: Power Button (FF) [PWRF]
[    0.466238] input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    0.466313] ACPI: Power Button (CM) [PWRB]
[    0.466498] fan PNP0C0B:00: registered as cooling_device0
[    0.466562] ACPI: Fan [FAN] (on)
[    0.467420] processor ACPI_CPU:00: registered as cooling_device1
[    0.467765] processor ACPI_CPU:01: registered as cooling_device2
[    0.468485] thermal LNXTHERM:01: registered as thermal_zone0
[    0.468904] ACPI: Thermal Zone [THRM] (40 C)
[    0.488270] Linux agpgart interface v0.103
[    0.488334] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.488529] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.489050] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.490775] brd: module loaded
[    0.491565] loop: module loaded
[    0.491785] Driver 'sd' needs updating - please use bus_type methods
[    0.491883] Driver 'sr' needs updating - please use bus_type methods
[    0.492050] ahci 0000:06:00.0: version 3.0
[    0.492364] ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
[    0.492432] ahci 0000:06:00.0: PCI INT A -> Link[APC7] -> GSI 16 (level, low) -> IRQ 16
[    0.492524] ahci 0000:06:00.0: controller can't do NCQ, turning off CAP_NCQ
[    0.492588] ahci 0000:06:00.0: controller can't do PMP, turning off CAP_PMP
[    0.492652] ahci 0000:06:00.0: MV_AHCI HACK: port_map 7 -> 3
[    0.492714] ahci 0000:06:00.0: Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.
[    0.492807] ahci: SSS flag set, parallel bus scan disabled
[    0.492894] ahci 0000:06:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
[    0.492969] ahci 0000:06:00.0: flags: 64bit stag led slum part 
[    0.493041] ahci 0000:06:00.0: setting latency timer to 64
[    0.493198] scsi0 : ahci
[    0.493387] scsi1 : ahci
[    0.493541] scsi2 : ahci
[    0.493685] ata1: SATA max UDMA/133 abar m1024@0xefcff000 port 0xefcff100 irq 16
[    0.493760] ata2: SATA max UDMA/133 abar m1024@0xefcff000 port 0xefcff180 irq 16
[    0.493833] ata3: DUMMY
[    0.787018] ata1: SATA link down (SStatus 0 SControl 300)
[    1.092017] ata2: SATA link down (SStatus 0 SControl 300)
[    1.092515] sata_nv 0000:00:0e.0: version 3.5
[    1.092814] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[    1.092880] sata_nv 0000:00:0e.0: PCI INT A -> Link[APSI] -> GSI 23 (level, low) -> IRQ 23
[    1.092954] sata_nv 0000:00:0e.0: Using SWNCQ mode
[    1.093431] sata_nv 0000:00:0e.0: setting latency timer to 64
[    1.093557] scsi3 : sata_nv
[    1.093747] scsi4 : sata_nv
[    1.094032] ata4: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xf700 irq 23
[    1.094097] ata5: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xf708 irq 23
[    1.967060] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.970132] ata4.00: ATA-6: WDC WD2000JD-60KLB0, 08.05J08, max UDMA/100
[    1.970196] ata4.00: 390721968 sectors, multi 1: LBA48 
[    1.976138] ata4.00: configured for UDMA/100
[    1.976279] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000JD-60K 08.0 PQ: 0 ANSI: 5
[    1.976512] sd 3:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[    1.976597] sd 3:0:0:0: [sda] Write Protect is off
[    1.976659] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.976678] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.976802] sd 3:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[    1.976886] sd 3:0:0:0: [sda] Write Protect is off
[    1.976948] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.976966] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.977052]  sda: sda1 sda2 sda5 sda6
[    2.025013] sd 3:0:0:0: [sda] Attached SCSI disk
[    2.025167] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    2.758459] ata5: SATA link down (SStatus 0 SControl 300)
[    2.758841] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[    2.758908] sata_nv 0000:00:0e.1: PCI INT B -> Link[APSJ] -> GSI 22 (level, low) -> IRQ 22
[    2.758983] sata_nv 0000:00:0e.1: Using SWNCQ mode
[    2.759361] sata_nv 0000:00:0e.1: setting latency timer to 64
[    2.759482] scsi5 : sata_nv
[    2.759674] scsi6 : sata_nv
[    2.759943] ata6: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xf200 irq 22
[    2.760007] ata7: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xf208 irq 22
[    3.492460] ata6: SATA link down (SStatus 0 SControl 300)
[    4.225458] ata7: SATA link down (SStatus 0 SControl 300)
[    4.225829] ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 21
[    4.225895] sata_nv 0000:00:0e.2: PCI INT C -> Link[ASA2] -> GSI 21 (level, low) -> IRQ 21
[    4.225970] sata_nv 0000:00:0e.2: Using SWNCQ mode
[    4.226178] sata_nv 0000:00:0e.2: setting latency timer to 64
[    4.226441] scsi7 : sata_nv
[    4.226646] scsi8 : sata_nv
[    4.226930] ata8: SATA max UDMA/133 cmd 0xf100 ctl 0xf000 bmdma 0xed00 irq 21
[    4.226995] ata9: SATA max UDMA/133 cmd 0xef00 ctl 0xee00 bmdma 0xed08 irq 21
[    4.960458] ata8: SATA link down (SStatus 0 SControl 300)
[    5.693457] ata9: SATA link down (SStatus 0 SControl 300)
[    5.693829] usbcore: registered new interface driver libusual
[    5.693959] usbcore: registered new interface driver usbserial
[    5.694050] USB Serial support registered for generic
[    5.694142] usbcore: registered new interface driver usbserial_generic
[    5.694205] usbserial: USB Serial Driver core
[    5.694349] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    5.694412] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    5.694622] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.694806] mice: PS/2 mouse device common for all mice
[    5.714169] rtc_cmos 00:05: RTC can wake from S4
[    5.714302] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    5.714408] rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    5.714529] device-mapper: uevent: version 1.0.3
[    5.714655] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[    5.714780] device-mapper: multipath: version 1.0.5 loaded
[    5.714843] device-mapper: multipath round-robin: version 1.0.0 loaded
[    5.714942] cpuidle: using governor ladder
[    5.715003] cpuidle: using governor menu
[    5.715174] TCP cubic registered
[    5.715267] NET: Registered protocol family 10
[    5.715426] lo: Disabled Privacy Extensions
[    5.715510] NET: Registered protocol family 17
[    5.715700] registered taskstats version 1
[    5.715916] rtc_cmos 00:05: setting system clock to 2009-05-25 12:54:06 UTC (1243256046)
[    5.715990] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    5.716053] EDD information not available.
[    5.716146] Freeing unused kernel memory: 444k freed
[    5.735838] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    5.951887] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.952345] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
[    5.952413] ohci_hcd 0000:00:0b.0: PCI INT A -> Link[APCF] -> GSI 20 (level, low) -> IRQ 20
[    5.952506] ohci_hcd 0000:00:0b.0: setting latency timer to 64
[    5.952509] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    5.952660] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[    5.952793] ohci_hcd 0000:00:0b.0: irq 20, io mem 0xeffff000
[    5.954086] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.954151] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[    5.978433] Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
[    5.978501] Copyright (c) 1999-2006 Intel Corporation.
[    5.978940] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
[    5.979118] e1000 0000:05:06.0: PCI INT A -> Link[APC1] -> GSI 16 (level, low) -> IRQ 16
[    6.006182] usb usb1: configuration #1 chosen from 1 choice
[    6.006304] hub 1-0:1.0: USB hub found
[    6.006374] hub 1-0:1.0: 10 ports detected
[    6.006912] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
[    6.006980] ehci_hcd 0000:00:0b.1: PCI INT B -> Link[APCL] -> GSI 23 (level, low) -> IRQ 23
[    6.007130] ehci_hcd 0000:00:0b.1: setting latency timer to 64
[    6.007132] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    6.007253] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[    6.007351] ehci_hcd 0000:00:0b.1: debug port 1
[    6.007415] ehci_hcd 0000:00:0b.1: cache line size of 32 is not supported
[    6.007425] ehci_hcd 0000:00:0b.1: irq 23, io mem 0xefffe000
[    6.014009] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00
[    6.014173] usb usb2: configuration #1 chosen from 1 choice
[    6.014264] hub 2-0:1.0: USB hub found
[    6.014332] hub 2-0:1.0: 10 ports detected
[    6.253265] e1000: 0000:05:06.0: e1000_probe: (PCI:33MHz:32-bit) 00:1b:21:28:dc:a4
[    6.401064] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    6.401604] ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
[    6.401674] ohci1394 0000:05:0b.0: PCI INT A -> Link[APC4] -> GSI 19 (level, low) -> IRQ 19
[    6.456070] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[efeff000-efeff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    6.514178] EXT3-fs: INFO: recovery required on readonly filesystem.
[    6.514243] EXT3-fs: write access will be enabled during recovery.
[    6.526263] usb 1-2: new low speed USB device using ohci_hcd and address 2
[    6.565344] kjournald starting.  Commit interval 5 seconds
[    6.565350] EXT3-fs: recovery complete.
[    6.565694] EXT3-fs: mounted filesystem with ordered data mode.
[    6.717201] usb 1-2: configuration #1 chosen from 1 choice
[    7.718351] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c00016c477f]
[   11.393707] ACPI: I/O resource nForce2_smbus [0x1c00-0x1c3f] conflicts with ACPI region SM00 [0x1c00-0x1c05]
[   11.393796] ACPI: Device needs an ACPI driver
[   11.393886] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x1c00
[   11.393950] ACPI: I/O resource nForce2_smbus [0x1c80-0x1cbf] conflicts with ACPI region SM01 [0x1c80-0x1c85]
[   11.394042] ACPI: Device needs an ACPI driver
[   11.394117] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x1c80
[   11.613741] usbcore: registered new interface driver hiddev
[   11.619777] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:0b.0/usb1/1-2/1-2:1.0/input/input3
[   11.637129] generic-usb 0003:046D:C03E.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0b.0-2/input0
[   11.637231] usbcore: registered new interface driver usbhid
[   11.637296] usbhid: v2.6:USB HID core driver
[   11.745084] udev: renamed network interface eth0 to eth1
[   11.826806] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   12.476872] Error: Driver 'pcspkr' is already registered, aborting...
[   12.530819] ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
[   12.530890] HDA Intel 0000:00:0f.1: PCI INT B -> Link[AAZA] -> GSI 22 (level, low) -> IRQ 22
[   12.531046] HDA Intel 0000:00:0f.1: setting latency timer to 64
[   12.760524] hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...
[   14.084702] it87: Found IT8718F chip at 0x290, revision 4
[   14.084784] it87: in3 is VCC (+5V)
[   14.084845] it87: in7 is VCCH (+5V Stand-By)
[   14.084932] ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region IP__ [0x295-0x296]
[   14.085253] ACPI: Device needs an ACPI driver
[   14.095983] coretemp coretemp.0: Using relative temperature scale!
[   14.096084] coretemp coretemp.1: Using relative temperature scale!
[   14.139398] Adding 3068404k swap on /dev/sda5.  Priority:-1 extents:1 across:3068404k 
[   14.429264] EXT3 FS on sda1, internal journal
[   14.788034] kjournald starting.  Commit interval 5 seconds
[   14.788293] EXT3 FS on sda2, internal journal
[   14.788296] EXT3-fs: mounted filesystem with ordered data mode.
[   15.419466] sensors[3189]: segfault at 0 ip 00007fb321898c67 sp 00007fff29fc3a80 error 4 in libc-2.7.so[7fb321836000+158000]
[   15.420455] sensors[3190]: segfault at 0 ip 00007f16992bac67 sp 00007fffa19e54b0 error 4 in libc-2.7.so[7f1699258000+158000]
[   16.876977] warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
[   18.237371] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   18.259080] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   18.259726] ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   18.351713] sensors[4058]: segfault at 0 ip 00007f05b5e6ac67 sp 00007fffbe593050 error 4 in libc-2.7.so[7f05b5e08000+158000]
[   18.352906] sensors[4059]: segfault at 0 ip 00007f429a521c67 sp 00007fffa2c4a710 error 4 in libc-2.7.so[7f429a4bf000+158000]
[   29.201047] eth1: no IPv6 routers present
[   48.362764] nvidia: module license 'NVIDIA' taints kernel.
[   48.617352] nvidia 0000:04:00.0: PCI INT A -> Link[APC7] -> GSI 16 (level, low) -> IRQ 16
[   48.617359] nvidia 0000:04:00.0: setting latency timer to 64
[   48.617543] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  185.18.08  Thu Apr 30 15:48:49 PDT 2009
[   53.449006] eth1: no IPv6 routers present
[   95.269584] nvidia 0000:04:00.0: setting latency timer to 64
[   95.270066] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  185.18.08  Thu Apr 30 15:48:49 PDT 2009
[   95.285929] IRQ 16/nvidia: IRQF_DISABLED is not guaranteed on shared IRQs
[  140.236045]  CIFS VFS: Error connecting to socket. Aborting operation
[  140.236051]  CIFS VFS: cifs_mount failed w/return code = -113
[ 1000.748458] BUG: unable to handle kernel paging request at 0000000000005073
[ 1000.748462] IP: [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1000.748468] PGD 13352c067 PUD 112d39067 PMD 0 
[ 1000.748471] Oops: 0000 [#1] PREEMPT SMP 
[ 1000.748474] last sysfs file: /sys/devices/virtual/vc/vcsa7/dev
[ 1000.748476] CPU 1 
[ 1000.748477] Modules linked in: nls_cp437 cifs nvidia(P) binfmt_misc autofs4 video output coretemp it87 hwmon_vid sbp2 snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_pcm_oss snd_mixer_oss snd_seq_midi_event snd_seq snd_pcm firewire_ohci snd_seq_device firewire_core snd_timer pcspkr serio_raw crc_itu_t snd soundcore snd_page_alloc usbhid i2c_nforce2 ohci1394 e1000 ieee1394 ehci_hcd ohci_hcd [last unloaded: nvidia]
[ 1000.748500] Pid: 6279, comm: top Tainted: P           2.6.29.4-rt15 #13 P5N-T DELUXE
[ 1000.748502] RIP: 0010:[<ffffffff802ea9cc>]  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1000.748506] RSP: 0018:ffff88013e52be68  EFLAGS: 00010246
[ 1000.748507] RAX: 0000000000000000 RBX: 000000000000505b RCX: 0000000000000000
[ 1000.748509] RDX: 0000000000000000 RSI: ffffffff80679852 RDI: ffff88010be3301b
[ 1000.748511] RBP: 0000000000000001 R08: 0000000000000008 R09: 000000000000000a
[ 1000.748512] R10: 0000000000000000 R11: 0a7c5ac471b47843 R12: ffffffff802ea900
[ 1000.748514] R13: 0000000000000000 R14: ffff88013e52be98 R15: 00000000000003ff
[ 1000.748516] FS:  00007f546d2046e0(0000) GS:ffff880028074000(0000) knlGS:0000000000000000
[ 1000.748518] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1000.748520] CR2: 0000000000005073 CR3: 0000000112c89000 CR4: 00000000000006a0
[ 1000.748522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1000.748524] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1000.748526] Process top (pid: 6279, threadinfo ffff88013e52a000, task ffff88006656b0c0)
[ 1000.748527] Stack:
[ 1000.748528]  ffff88011c1fd0f8 ffff88013e52bf50 00007f546cfdc460 ffff880112ebc200
[ 1000.748531]  0000000000000000 ffff880100000000 0000000000000000 ffff88013f9ca380
[ 1000.748534]  fffffffffffffffb ffffffff802ea900 ffff880112ebc200 ffff88013e52bf50
[ 1000.748537] Call Trace:
[ 1000.748539]  [<ffffffff802ea900>] ? seq_read+0x0/0x3a0
[ 1000.748541]  [<ffffffff8031bf41>] ? proc_reg_read+0x81/0xd0
[ 1000.748545]  [<ffffffff802cf845>] ? vfs_read+0xc5/0x180
[ 1000.748548]  [<ffffffff802cfcf3>] ? sys_read+0x53/0x90
[ 1000.748551]  [<ffffffff8020be6b>] ? system_call_fastpath+0x16/0x1b
[ 1000.748554] Code: 81 fd 00 f0 ff ff 0f 87 a3 00 00 00 48 8b 43 68 48 89 ee 48 89 df ff 50 18 83 f8 00 41 89 c5 0f 8c 8a 00 00 00 0f 85 57 02 00 00 <4c> 8b 63 18 4d 85 e4 0f 84 57 02 00 00 4c 3b 63 08 0f 1f 00 0f 
[ 1000.748579] RIP  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1000.748582]  RSP <ffff88013e52be68>
[ 1000.748583] CR2: 0000000000005073
[ 1000.748586] ---[ end trace 0788871bf9df9249 ]---
[ 1254.334812] BUG: unable to handle kernel paging request at 0000000000003dab
[ 1254.334816] IP: [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1254.334822] PGD 112d55067 PUD 1338f3067 PMD 0 
[ 1254.334825] Oops: 0000 [#2] PREEMPT SMP 
[ 1254.334827] last sysfs file: /sys/devices/virtual/vc/vcsa7/dev
[ 1254.334829] CPU 0 
[ 1254.334831] Modules linked in: nls_cp437 cifs nvidia(P) binfmt_misc autofs4 video output coretemp it87 hwmon_vid sbp2 snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_pcm_oss snd_mixer_oss snd_seq_midi_event snd_seq snd_pcm firewire_ohci snd_seq_device firewire_core snd_timer pcspkr serio_raw crc_itu_t snd soundcore snd_page_alloc usbhid i2c_nforce2 ohci1394 e1000 ieee1394 ehci_hcd ohci_hcd [last unloaded: nvidia]
[ 1254.334854] Pid: 6352, comm: top Tainted: P      D    2.6.29.4-rt15 #13 P5N-T DELUXE
[ 1254.334856] RIP: 0010:[<ffffffff802ea9cc>]  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1254.334859] RSP: 0018:ffff88010bdffe68  EFLAGS: 00010246
[ 1254.334861] RAX: 0000000000000000 RBX: 0000000000003d93 RCX: 0000000000000000
[ 1254.334862] RDX: 0000000000000000 RSI: ffffffff80679852 RDI: ffff880115cb101a
[ 1254.334864] RBP: 0000000000000001 R08: 0000000000000008 R09: 000000000000000a
[ 1254.334866] R10: 0000000000000000 R11: 0a7c5ac471b47843 R12: ffffffff802ea900
[ 1254.334868] R13: 0000000000000000 R14: ffff88010bdffe98 R15: 00000000000003ff
[ 1254.334870] FS:  00007fd2651866e0(0000) GS:ffff88002805e000(0000) knlGS:0000000000000000
[ 1254.334872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1254.334873] CR2: 0000000000003dab CR3: 000000011154c000 CR4: 00000000000006a0
[ 1254.334875] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1254.334877] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1254.334879] Process top (pid: 6352, threadinfo ffff88010bdfe000, task ffff88013e5dd0c0)
[ 1254.334880] Stack:
[ 1254.334881]  ffff88013f9e58f8 ffff88010bdfff50 00007fd264f5e460 ffff880133838c00
[ 1254.334884]  0000000000000000 ffff880100000000 0000000000000000 ffff88013f9ca380
[ 1254.334887]  fffffffffffffffb ffffffff802ea900 ffff880133838c00 ffff88010bdfff50
[ 1254.334890] Call Trace:
[ 1254.334892]  [<ffffffff802ea900>] ? seq_read+0x0/0x3a0
[ 1254.334895]  [<ffffffff8031bf41>] ? proc_reg_read+0x81/0xd0
[ 1254.334898]  [<ffffffff802cf845>] ? vfs_read+0xc5/0x180
[ 1254.334901]  [<ffffffff802cfcf3>] ? sys_read+0x53/0x90
[ 1254.334904]  [<ffffffff8020be6b>] ? system_call_fastpath+0x16/0x1b
[ 1254.334907] Code: 81 fd 00 f0 ff ff 0f 87 a3 00 00 00 48 8b 43 68 48 89 ee 48 89 df ff 50 18 83 f8 00 41 89 c5 0f 8c 8a 00 00 00 0f 85 57 02 00 00 <4c> 8b 63 18 4d 85 e4 0f 84 57 02 00 00 4c 3b 63 08 0f 1f 00 0f 
[ 1254.334933] RIP  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1254.334936]  RSP <ffff88010bdffe68>
[ 1254.334937] CR2: 0000000000003dab
[ 1254.334939] ---[ end trace 0788871bf9df924a ]---
[ 1257.096412] BUG: unable to handle kernel paging request at 0000000000003d61
[ 1257.096416] IP: [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1257.096422] PGD 112d7c067 PUD 112d1f067 PMD 0 
[ 1257.096425] Oops: 0000 [#3] PREEMPT SMP 
[ 1257.096428] last sysfs file: /sys/devices/virtual/vc/vcsa7/dev
[ 1257.096430] CPU 1 
[ 1257.096431] Modules linked in: nls_cp437 cifs nvidia(P) binfmt_misc autofs4 video output coretemp it87 hwmon_vid sbp2 snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_pcm_oss snd_mixer_oss snd_seq_midi_event snd_seq snd_pcm firewire_ohci snd_seq_device firewire_core snd_timer pcspkr serio_raw crc_itu_t snd soundcore snd_page_alloc usbhid i2c_nforce2 ohci1394 e1000 ieee1394 ehci_hcd ohci_hcd [last unloaded: nvidia]
[ 1257.096454] Pid: 6366, comm: htop Tainted: P      D    2.6.29.4-rt15 #13 P5N-T DELUXE
[ 1257.096456] RIP: 0010:[<ffffffff802ea9cc>]  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1257.096459] RSP: 0018:ffff880133867e68  EFLAGS: 00010246
[ 1257.096461] RAX: 0000000000000000 RBX: 0000000000003d49 RCX: 0000000000000000
[ 1257.096463] RDX: 0000000000000000 RSI: ffffffff80679852 RDI: ffff88013701d01a
[ 1257.096464] RBP: 0000000000000001 R08: 0000000000000008 R09: 000000000000000a
[ 1257.096466] R10: 0000000000000000 R11: 0a7c5ac471b47843 R12: ffffffff802ea900
[ 1257.096468] R13: 0000000000000000 R14: ffff880133867e98 R15: 0000000000000400
[ 1257.096470] FS:  00007f52aad8e6e0(0000) GS:ffff880028074000(0000) knlGS:0000000000000000
[ 1257.096472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1257.096474] CR2: 0000000000003d61 CR3: 000000011cc31000 CR4: 00000000000006a0
[ 1257.096475] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1257.096477] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1257.096479] Process htop (pid: 6366, threadinfo ffff880133866000, task ffff88013e5dd0c0)
[ 1257.096480] Stack:
[ 1257.096481]  ffff88010d3f7378 ffff880133867f50 00007f52aad8d000 ffff88011ccc86c0
[ 1257.096484]  0000000000000000 00000007f52aad8d 0000000000000000 ffff88013f9ca380
[ 1257.096487]  fffffffffffffffb ffffffff802ea900 ffff88011ccc86c0 ffff880133867f50
[ 1257.096491] Call Trace:
[ 1257.096492]  [<ffffffff802ea900>] ? seq_read+0x0/0x3a0
[ 1257.096495]  [<ffffffff8031bf41>] ? proc_reg_read+0x81/0xd0
[ 1257.096498]  [<ffffffff802cf845>] ? vfs_read+0xc5/0x180
[ 1257.096502]  [<ffffffff802cfcf3>] ? sys_read+0x53/0x90
[ 1257.096504]  [<ffffffff8020be6b>] ? system_call_fastpath+0x16/0x1b
[ 1257.096508] Code: 81 fd 00 f0 ff ff 0f 87 a3 00 00 00 48 8b 43 68 48 89 ee 48 89 df ff 50 18 83 f8 00 41 89 c5 0f 8c 8a 00 00 00 0f 85 57 02 00 00 <4c> 8b 63 18 4d 85 e4 0f 84 57 02 00 00 4c 3b 63 08 0f 1f 00 0f 
[ 1257.096533] RIP  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1257.096536]  RSP <ffff880133867e68>
[ 1257.096537] CR2: 0000000000003d61
[ 1257.096539] ---[ end trace 0788871bf9df924b ]---
[ 1276.397406] BUG: unable to handle kernel paging request at 0000000000003c1c
[ 1276.397409] IP: [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1276.397415] PGD 1338f3067 PUD 1345ef067 PMD 0 
[ 1276.397419] Oops: 0000 [#4] PREEMPT SMP 
[ 1276.397421] last sysfs file: /sys/devices/virtual/vc/vcsa7/dev
[ 1276.397424] CPU 0 
[ 1276.397425] Modules linked in: nls_cp437 cifs nvidia(P) binfmt_misc autofs4 video output coretemp it87 hwmon_vid sbp2 snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_pcm_oss snd_mixer_oss snd_seq_midi_event snd_seq snd_pcm firewire_ohci snd_seq_device firewire_core snd_timer pcspkr serio_raw crc_itu_t snd soundcore snd_page_alloc usbhid i2c_nforce2 ohci1394 e1000 ieee1394 ehci_hcd ohci_hcd [last unloaded: nvidia]
[ 1276.397448] Pid: 6383, comm: cyclictest Tainted: P      D    2.6.29.4-rt15 #13 P5N-T DELUXE
[ 1276.397450] RIP: 0010:[<ffffffff802ea9cc>]  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1276.397453] RSP: 0018:ffff88013e501e68  EFLAGS: 00010246
[ 1276.397455] RAX: 0000000000000000 RBX: 0000000000003c04 RCX: 0000000000000000
[ 1276.397456] RDX: 0000000000000000 RSI: ffffffff80679852 RDI: ffff8801334f201a
[ 1276.397458] RBP: 0000000000000001 R08: 0000000000000008 R09: 000000000000000a
[ 1276.397460] R10: 0000000000000000 R11: 0a7c5ac471b47843 R12: ffffffff802ea900
[ 1276.397462] R13: 0000000000000000 R14: ffff88013e501e98 R15: 00000000000000ff
[ 1276.397464] FS:  00007f2e63b9b6e0(0000) GS:ffff88002805e000(0000) knlGS:0000000000000000
[ 1276.397466] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1276.397467] CR2: 0000000000003c1c CR3: 000000010d1cf000 CR4: 00000000000006a0
[ 1276.397469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1276.397471] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1276.397473] Process cyclictest (pid: 6383, threadinfo ffff88013e500000, task ffff8800379e6800)
[ 1276.397474] Stack:
[ 1276.397475]  ffff88010d151af8 ffff88013e501f50 00007fff6bbbb5e0 ffff8801338995c0
[ 1276.397478]  0000000000000000 0000000000000000 0000000000000000 ffff88013f9ca380
[ 1276.397481]  fffffffffffffffb ffffffff802ea900 ffff8801338995c0 ffff88013e501f50
[ 1276.397485] Call Trace:
[ 1276.397486]  [<ffffffff802ea900>] ? seq_read+0x0/0x3a0
[ 1276.397489]  [<ffffffff8031bf41>] ? proc_reg_read+0x81/0xd0
[ 1276.397492]  [<ffffffff802cf845>] ? vfs_read+0xc5/0x180
[ 1276.397496]  [<ffffffff802cfcf3>] ? sys_read+0x53/0x90
[ 1276.397498]  [<ffffffff8020be6b>] ? system_call_fastpath+0x16/0x1b
[ 1276.397502] Code: 81 fd 00 f0 ff ff 0f 87 a3 00 00 00 48 8b 43 68 48 89 ee 48 89 df ff 50 18 83 f8 00 41 89 c5 0f 8c 8a 00 00 00 0f 85 57 02 00 00 <4c> 8b 63 18 4d 85 e4 0f 84 57 02 00 00 4c 3b 63 08 0f 1f 00 0f 
[ 1276.397527] RIP  [<ffffffff802ea9cc>] seq_read+0xcc/0x3a0
[ 1276.397530]  RSP <ffff88013e501e68>
[ 1276.397531] CR2: 0000000000003c1c
[ 1276.397533] ---[ end trace 0788871bf9df924c ]---


--

joseangel


