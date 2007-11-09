From: Andrzej Walczak <awalczak@pit.edu.pl>
Subject: Log from 2.6.23.1-rt11
Date: Fri, 09 Nov 2007 10:38:03 +0100
Message-ID: <1194601083.8476.2.camel@aquarius.pit.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pi.pit.edu.pl ([195.136.249.67]:6222 "HELO pi.pit.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751374AbXKIKLX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Nov 2007 05:11:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by merlin (Postfix) with ESMTP id AB73B69E1
	for <linux-rt-users@vger.kernel.org>; Fri,  9 Nov 2007 10:38:04 +0100 (CET)
Received: from merlin ([127.0.0.1])
	by localhost (merlin.pit.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2v-3GXpsXyOw for <linux-rt-users@vger.kernel.org>;
	Fri,  9 Nov 2007 10:38:04 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear All,

Sorry for the long log file inline with the mail. 

I have similar problems (oops) since rt5. 

Maybe this log will help you to understand what is going wrong. 


With regards, Andrzej Walczak


#####################################################################



Nov  9 10:17:15 aquarius kernel: Linux version 2.6.23-snake-rt
(awalczak@aquarius) (gcc version 4.2.3 20071014 (prerelease) (Debian
4.2.2-3)) #1 SMP PREEMPT RT Fri Nov 9 10:07:51 CET 2007
Nov  9 10:17:15 aquarius kernel: BIOS-provided physical RAM map:
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 0000000000000000 -
000000000009e000 (usable)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 000000000009e000 -
00000000000a0000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000000e0000 -
00000000000eee00 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000000eee00 -
00000000000ef000 (ACPI NVS)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000000ef000 -
0000000000100000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 0000000000100000 -
000000007ff70000 (usable)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 000000007ff70000 -
000000007ff80000 (ACPI data)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 000000007ff80000 -
0000000080000000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000fec00000 -
00000000fec28000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000fed00000 -
00000000fed00400 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000fed14000 -
00000000fed1a000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000fed1c000 -
00000000fed90000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000feda0000 -
00000000fedc0000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000ffb00000 -
00000000ffc00000 (reserved)
Nov  9 10:17:15 aquarius kernel: BIOS-e820: 00000000ffe00000 -
0000000100000000 (reserved)
Nov  9 10:17:15 aquarius kernel: 1151MB HIGHMEM available.
Nov  9 10:17:15 aquarius kernel: 896MB LOWMEM available.
Nov  9 10:17:15 aquarius kernel: Entering add_active_range(0, 0, 524144)
0 entries of 256 used
Nov  9 10:17:15 aquarius kernel: Zone PFN ranges:
Nov  9 10:17:15 aquarius kernel: DMA             0 ->     4096
Nov  9 10:17:15 aquarius kernel: Normal       4096 ->   229376
Nov  9 10:17:15 aquarius kernel: HighMem    229376 ->   524144
Nov  9 10:17:15 aquarius kernel: Movable zone start PFN for each node
Nov  9 10:17:15 aquarius kernel: early_node_map[1] active PFN ranges
Nov  9 10:17:15 aquarius kernel: 0:        0 ->   524144
Nov  9 10:17:15 aquarius kernel: On node 0 totalpages: 524144
Nov  9 10:17:15 aquarius kernel: DMA zone: 32 pages used for memmap
Nov  9 10:17:15 aquarius kernel: DMA zone: 0 pages reserved
Nov  9 10:17:15 aquarius kernel: DMA zone: 4064 pages, LIFO batch:0
Nov  9 10:17:15 aquarius kernel: Normal zone: 1760 pages used for memmap
Nov  9 10:17:15 aquarius kernel: Normal zone: 223520 pages, LIFO
batch:31
Nov  9 10:17:15 aquarius kernel: HighMem zone: 2302 pages used for
memmap
Nov  9 10:17:15 aquarius kernel: HighMem zone: 292466 pages, LIFO
batch:31
Nov  9 10:17:15 aquarius kernel: Movable zone: 0 pages used for memmap
Nov  9 10:17:15 aquarius kernel: DMI 2.3 present.
Nov  9 10:17:15 aquarius kernel: ACPI: RSDP 000F0180, 0014 (r0 TOSHIB)
Nov  9 10:17:15 aquarius kernel: ACPI: RSDT 7FF70000, 004C (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: FACP 7FF70074, 0084 (r2 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: DSDT 7FF700F8, 5179 (r1 TOSHIB
A0037    20060706 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: FACS 000EEE00, 0040
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75271, 0306 (r1 TOSHIB
A0037    20050926 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: DBGP 7FF75D88, 0034 (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: BOOT 7FF7004C, 0028 (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: APIC 7FF75CE4, 0068 (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: MCFG 7FF75D4C, 003C (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: HPET 7FF75F1C, 0038 (r1 TOSHIB
750        970814 TASM  4010000)
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75F54, 05E1 (r1 TOSHIB
A0037    20050523 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75E6C, 00B0 (r1 TOSHIB
A0037    20051014 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF77078, 0076 (r1 TOSHIB
A0037    20051021 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: PM-Timer IO Port: 0xd808
Nov  9 10:17:15 aquarius kernel: ACPI: Local APIC address 0xfee00000
Nov  9 10:17:15 aquarius kernel: ACPI: LAPIC (acpi_id[0x00]
lapic_id[0x00] enabled)
Nov  9 10:17:15 aquarius kernel: Processor #0 6:15 APIC version 20
Nov  9 10:17:15 aquarius kernel: ACPI: LAPIC (acpi_id[0x01]
lapic_id[0x01] enabled)
Nov  9 10:17:15 aquarius kernel: Processor #1 6:15 APIC version 20
Nov  9 10:17:15 aquarius kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high
edge lint[0x1])
Nov  9 10:17:15 aquarius kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high
edge lint[0x1])
Nov  9 10:17:15 aquarius kernel: ACPI: IOAPIC (id[0x01]
address[0xfec00000] gsi_base[0])
Nov  9 10:17:15 aquarius kernel: IOAPIC[0]: apic_id 1, version 32,
address 0xfec00000, GSI 0-23
Nov  9 10:17:15 aquarius kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Nov  9 10:17:15 aquarius kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 high level)
Nov  9 10:17:15 aquarius kernel: ACPI: IRQ0 used by override.
Nov  9 10:17:15 aquarius kernel: ACPI: IRQ2 used by override.
Nov  9 10:17:15 aquarius kernel: ACPI: IRQ9 used by override.
Nov  9 10:17:15 aquarius kernel: Enabling APIC mode:  Flat.  Using 1 I/O
APICs
Nov  9 10:17:15 aquarius kernel: ACPI: HPET id: 0x8086a201 base:
0xfed00000
Nov  9 10:17:15 aquarius kernel: Using ACPI (MADT) for SMP configuration
information
Nov  9 10:17:15 aquarius kernel: Allocating PCI resources starting at
88000000 (gap: 80000000:7ec00000)
Nov  9 10:17:15 aquarius kernel: Real-Time Preemption Support (C)
2004-2007 Ingo Molnar
Nov  9 10:17:15 aquarius kernel: Built 1 zonelists in Zone order.  Total
pages: 520050
Nov  9 10:17:15 aquarius kernel: Kernel command line:
BOOT_IMAGE=Linux-23-rt root=802
Nov  9 10:17:15 aquarius kernel: mapped APIC to ffffb000 (fee00000)
Nov  9 10:17:15 aquarius kernel: mapped IOAPIC to ffffa000 (fec00000)
Nov  9 10:17:15 aquarius kernel: Enabling fast FPU save and restore...
done.
Nov  9 10:17:15 aquarius kernel: Enabling unmasked SIMD FPU exception
support... done.
Nov  9 10:17:15 aquarius kernel: Initializing CPU#0
Nov  9 10:17:15 aquarius kernel: WARNING: experimental RCU
implementation.
Nov  9 10:17:15 aquarius kernel: PID hash table entries: 4096 (order:
12, 16384 bytes)
Nov  9 10:17:15 aquarius kernel: Detected 2327.713 MHz processor.
Nov  9 10:17:15 aquarius kernel: Console: colour VGA+ 80x25
Nov  9 10:17:15 aquarius kernel: console [tty0] enabled
Nov  9 10:17:15 aquarius kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Nov  9 10:17:15 aquarius kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Nov  9 10:17:15 aquarius kernel: Memory: 2066748k/2096576k available
(2770k kernel code, 28700k reserved, 947k data, 268k init, 1179072k
highmem)
Nov  9 10:17:15 aquarius kernel: virtual kernel memory layout:
Nov  9 10:17:15 aquarius kernel: fixmap  : 0xfff9b000 - 0xfffff000
( 400 kB)
Nov  9 10:17:15 aquarius kernel: pkmap   : 0xff800000 - 0xffc00000
(4096 kB)
Nov  9 10:17:15 aquarius kernel: vmalloc : 0xf8800000 - 0xff7fe000
( 111 MB)
Nov  9 10:17:15 aquarius kernel: lowmem  : 0xc0000000 - 0xf8000000
( 896 MB)
Nov  9 10:17:15 aquarius kernel: .init : 0xc04a8000 - 0xc04eb000   ( 268
kB)
Nov  9 10:17:15 aquarius kernel: .data : 0xc03b4a7e - 0xc04a16a4   ( 947
kB)
Nov  9 10:17:15 aquarius kernel: .text : 0xc0100000 - 0xc03b4a7e   (2770
kB)
Nov  9 10:17:15 aquarius kernel: Checking if this processor honours the
WP bit even in supervisor mode... Ok.
Nov  9 10:17:15 aquarius kernel: hpet clockevent registered
Nov  9 10:17:15 aquarius kernel: Calibrating delay using timer specific
routine.. 4657.61 BogoMIPS (lpj=2328806)
Nov  9 10:17:15 aquarius kernel: Security Framework v1.0.0 initialized
Nov  9 10:17:15 aquarius kernel: Mount-cache hash table entries: 512
Nov  9 10:17:15 aquarius kernel: CPU: After generic identify, caps:
bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001 00000000
Nov  9 10:17:15 aquarius kernel: monitor/mwait feature present.
Nov  9 10:17:15 aquarius kernel: using mwait in idle threads.
Nov  9 10:17:15 aquarius kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Nov  9 10:17:15 aquarius kernel: CPU: L2 cache: 4096K
Nov  9 10:17:15 aquarius kernel: CPU: Physical Processor ID: 0
Nov  9 10:17:15 aquarius kernel: CPU: Processor Core ID: 0
Nov  9 10:17:15 aquarius kernel: CPU: After all inits, caps: bfebfbff
20100000 00000000 00003940 0000e3bd 00000000 00000001 00000000
Nov  9 10:17:15 aquarius kernel: Intel machine check architecture
supported.
Nov  9 10:17:15 aquarius kernel: Intel machine check reporting enabled
on CPU#0.
Nov  9 10:17:15 aquarius kernel: Compat vDSO mapped to ffffe000.
Nov  9 10:17:15 aquarius kernel: Checking 'hlt' instruction... OK.
Nov  9 10:17:15 aquarius kernel: Freeing SMP alternatives: 12k freed
Nov  9 10:17:15 aquarius kernel: ACPI: Core revision 20070126
Nov  9 10:17:15 aquarius kernel: CPU0: Intel(R) Core(TM)2 CPU
T7600  @ 2.33GHz stepping 06
Nov  9 10:17:15 aquarius kernel: Booting processor 1/1 eip 2000
Nov  9 10:17:15 aquarius kernel: Initializing CPU#1
Nov  9 10:17:15 aquarius kernel: Calibrating delay using timer specific
routine.. 4642.48 BogoMIPS (lpj=2321241)
Nov  9 10:17:15 aquarius kernel: CPU: After generic identify, caps:
bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001 00000000
Nov  9 10:17:15 aquarius kernel: monitor/mwait feature present.
Nov  9 10:17:15 aquarius kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Nov  9 10:17:15 aquarius kernel: CPU: L2 cache: 4096K
Nov  9 10:17:15 aquarius kernel: CPU: Physical Processor ID: 0
Nov  9 10:17:15 aquarius kernel: CPU: Processor Core ID: 1
Nov  9 10:17:15 aquarius kernel: CPU: After all inits, caps: bfebfbff
20100000 00000000 00003940 0000e3bd 00000000 00000001 00000000
Nov  9 10:17:15 aquarius kernel: Intel machine check architecture
supported.
Nov  9 10:17:15 aquarius kernel: Intel machine check reporting enabled
on CPU#1.
Nov  9 10:17:15 aquarius kernel: CPU1: Intel(R) Core(TM)2 CPU
T7600  @ 2.33GHz stepping 06
Nov  9 10:17:15 aquarius kernel: Total of 2 processors activated
(9300.09 BogoMIPS).
Nov  9 10:17:15 aquarius kernel: ENABLING IO-APIC IRQs
Nov  9 10:17:15 aquarius kernel: ..TIMER: vector=0x31 apic1=0 pin1=2
apic2=-1 pin2=-1
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 00(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] smp_error_interrupt
+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c013bf70>] tick_handle_periodic
+0x0/0x80
Nov  9 10:17:15 aquarius kernel: [<c01300d8>] __call_usermodehelper
+0x28/0x70
Nov  9 10:17:15 aquarius kernel: [<c04b84b7>] setup_boot_APIC_clock
+0x67/0x510
Nov  9 10:17:15 aquarius kernel: [<c012124b>] printk+0x1b/0x20
Nov  9 10:17:15 aquarius kernel: [<c04b6458>] native_smp_prepare_cpus
+0x278/0x9d0
Nov  9 10:17:15 aquarius kernel: [<c04a8720>] kernel_init+0x0/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8772>] kernel_init+0x52/0x390
Nov  9 10:17:15 aquarius kernel: [<c011d11e>] schedule_tail+0x4e/0xe0
Nov  9 10:17:15 aquarius kernel: [<c0102c52>] ret_from_fork+0x6/0x1c
Nov  9 10:17:15 aquarius kernel: [<c04a8720>] kernel_init+0x0/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8720>] kernel_init+0x0/0x390
Nov  9 10:17:15 aquarius kernel: [<c010399b>] kernel_thread_helper
+0x7/0x1c
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC calibration not consistent with PM
Timer: 102ms instead of 100ms
Nov  9 10:17:15 aquarius kernel: APIC delta adjusted to PM-Timer:
1039060 (1070228)
Nov  9 10:17:15 aquarius kernel: checking TSC synchronization [CPU#0 ->
CPU#1]: passed.
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 00(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] <6>Brought up 2 CPUs
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c03b3a92>] __spin_unlock_irq
+0x12/0x20
Nov  9 10:17:15 aquarius kernel: [<c04b6de8>] start_secondary
+0x168/0x190
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: NET: Registered protocol family 16
Nov  9 10:17:15 aquarius kernel: ACPI: bus type pci registered
Nov  9 10:17:15 aquarius kernel: PCI: BIOS Bug: MCFG area at f0000000 is
not E820-reserved
Nov  9 10:17:15 aquarius kernel: PCI: Not using MMCONFIG.
Nov  9 10:17:15 aquarius kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd5b9, last bus=8
Nov  9 10:17:15 aquarius kernel: PCI: Using configuration type 1
Nov  9 10:17:15 aquarius kernel: Setting up standard PCI resources
Nov  9 10:17:15 aquarius kernel: ACPI: EC: Look up EC in DSDT
Nov  9 10:17:15 aquarius kernel: ACPI: Interpreter enabled
Nov  9 10:17:15 aquarius kernel: ACPI: (supports S0 S5)
Nov  9 10:17:15 aquarius kernel: ACPI: Using IOAPIC for interrupt
routing
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Nov  9 10:17:15 aquarius kernel: PCI quirk: region d800-d87f claimed by
ICH6 ACPI/GPIO/TCO
Nov  9 10:17:15 aquarius kernel: PCI quirk: region eec0-eeff claimed by
ICH6 GPIO
Nov  9 10:17:15 aquarius kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCIB._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PEX1._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.EXCB._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.MPEX._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCI1._PRT]
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
*10)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3
4 5 6 7 *11)
Nov  9 10:17:15 aquarius kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Nov  9 10:17:15 aquarius kernel: pnp: PnP ACPI init
Nov  9 10:17:15 aquarius kernel: ACPI: bus type pnp registered
Nov  9 10:17:15 aquarius kernel: pnp: PnP ACPI: found 11 devices
Nov  9 10:17:15 aquarius kernel: ACPI: ACPI bus type pnp unregistered
Nov  9 10:17:15 aquarius kernel: PnPBIOS: Disabled by ACPI PNP
Nov  9 10:17:15 aquarius kernel: SCSI subsystem initialized
Nov  9 10:17:15 aquarius kernel: libata version 2.21 loaded.
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver usbfs
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver hub
Nov  9 10:17:15 aquarius kernel: usbcore: registered new device driver
usb
Nov  9 10:17:15 aquarius kernel: PCI: Using ACPI for IRQ routing
Nov  9 10:17:15 aquarius kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Nov  9 10:17:15 aquarius kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Nov  9 10:17:15 aquarius kernel: hpet0: 3 64-bit timers, 14318180 Hz
Nov  9 10:17:15 aquarius kernel: ACPI: RTC can wake from S4
Nov  9 10:17:15 aquarius kernel: pnp: 00:00: iomem range 0x0-0x9ffff
could not be reserved
Nov  9 10:17:15 aquarius kernel: pnp: 00:00: iomem range 0xe0000-0xfffff
could not be reserved
Nov  9 10:17:15 aquarius kernel: pnp: 00:00: iomem range
0x100000-0x7ff6ffff could not be reserved
Nov  9 10:17:15 aquarius kernel: pnp: 00:00: iomem range
0x7ff70000-0x7ff7ffff could not be reserved
Nov  9 10:17:15 aquarius kernel: pnp: 00:01: iomem range
0xf0000000-0xf3ffffff has been reserved
Nov  9 10:17:15 aquarius kernel: pnp: 00:09: ioport range 0x1e0-0x1ef
has been reserved
Nov  9 10:17:15 aquarius kernel: PCI: Failed to allocate mem resource
#6:20000@f0000000 for 0000:01:00.0
Nov  9 10:17:15 aquarius kernel: PCI: Bridge: 0000:00:01.0
Nov  9 10:17:15 aquarius kernel: IO window: c000-cfff
Nov  9 10:17:15 aquarius kernel: MEM window: fc000000-fdffffff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: e0000000-efffffff
Nov  9 10:17:15 aquarius kernel: PCI: Bridge: 0000:00:1c.0
Nov  9 10:17:15 aquarius kernel: IO window: b000-bfff
Nov  9 10:17:15 aquarius kernel: MEM window: ffd00000-ffdfffff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: disabled.
Nov  9 10:17:15 aquarius kernel: PCI: Bridge: 0000:00:1c.1
Nov  9 10:17:15 aquarius kernel: IO window: a000-afff
Nov  9 10:17:15 aquarius kernel: MEM window: fa000000-fbffffff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: disabled.
Nov  9 10:17:15 aquarius kernel: PCI: Bridge: 0000:00:1c.2
Nov  9 10:17:15 aquarius kernel: IO window: disabled.
Nov  9 10:17:15 aquarius kernel: MEM window: ffc00000-ffcfffff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: disabled.
Nov  9 10:17:15 aquarius kernel: PCI: Bus 7, cardbus bridge:
0000:06:0b.0
Nov  9 10:17:15 aquarius kernel: IO window: 00001000-000010ff
Nov  9 10:17:15 aquarius kernel: IO window: 00001400-000014ff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: 88000000-8bffffff
Nov  9 10:17:15 aquarius kernel: MEM window: 90000000-93ffffff
Nov  9 10:17:15 aquarius kernel: PCI: Bridge: 0000:00:1e.0
Nov  9 10:17:15 aquarius kernel: IO window: 1000-1fff
Nov  9 10:17:15 aquarius kernel: MEM window: 8c000000-95ffffff
Nov  9 10:17:15 aquarius kernel: PREFETCH window: 88000000-8bffffff
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:01.0[A] ->
GSI 16 (level, low) -> IRQ 16
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:01.0 to 64
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] ->
GSI 17 (level, low) -> IRQ 17
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.0 to 64
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] ->
GSI 16 (level, low) -> IRQ 16
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.1 to 64
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] ->
GSI 18 (level, low) -> IRQ 18
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.2 to 64
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1e.0 to 64
Nov  9 10:17:15 aquarius kernel: PCI: Enabling device 0000:06:0b.0 (0000
-> 0003)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:06:0b.0[A] ->
GSI 21 (level, low) -> IRQ 19
Nov  9 10:17:15 aquarius kernel: NET: Registered protocol family 2
Nov  9 10:17:15 aquarius kernel: IP route cache hash table entries:
32768 (order: 5, 131072 bytes)
Nov  9 10:17:15 aquarius kernel: TCP established hash table entries:
65536 (order: 9, 2883584 bytes)
Nov  9 10:17:15 aquarius kernel: TCP bind hash table entries: 65536
(order: 9, 2359296 bytes)
Nov  9 10:17:15 aquarius kernel: TCP: Hash tables configured
(established 65536 bind 65536)
Nov  9 10:17:15 aquarius kernel: TCP reno registered
Nov  9 10:17:15 aquarius kernel: checking if image is
initramfs...<7>APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] smp_error_interrupt
+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] smp_error_interrupt
+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c04acc67>] inflate_codes+0x327/0x510
Nov  9 10:17:15 aquarius kernel: [<c04ade57>] inflate_dynamic
+0x587/0x5b0
Nov  9 10:17:15 aquarius kernel: [<c04ae853>] unpack_to_rootfs
+0x823/0x960
Nov  9 10:17:15 aquarius kernel: [<c04aebf6>] populate_rootfs+0x56/0x100
Nov  9 10:17:15 aquarius kernel: [<c04cd462>] pcibios_assign_resources
+0x12/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8860>] kernel_init+0x140/0x390
Nov  9 10:17:15 aquarius kernel: [<c0102c52>] ret_from_fork+0x6/0x1c
Nov  9 10:17:15 aquarius kernel: [<c04a8720>] kernel_init+0x0/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8720>] kernel_init+0x0/0x390
Nov  9 10:17:15 aquarius kernel: [<c010399b>] kernel_thread_helper
+0x7/0x1c
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: it is
Nov  9 10:17:15 aquarius kernel: Freeing initrd memory: 6840k freed
Nov  9 10:17:15 aquarius kernel: Simple Boot Flag at 0x7c set to 0x1
Nov  9 10:17:15 aquarius kernel: Machine check exception polling timer
started.
Nov  9 10:17:15 aquarius kernel: IA-32 Microcode Update Driver: v1.14a
<tigran@aivazian.fsnet.co.uk>
Nov  9 10:17:15 aquarius kernel: krcupreemptd setsched 0
Nov  9 10:17:15 aquarius kernel: prio = 98
Nov  9 10:17:15 aquarius kernel: highmem bounce pool size: 64 pages
Nov  9 10:17:15 aquarius kernel: Total HugeTLB memory allocated, 0
Nov  9 10:17:15 aquarius kernel: Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 253)
Nov  9 10:17:15 aquarius kernel: io scheduler noop registered
Nov  9 10:17:15 aquarius kernel: io scheduler anticipatory registered
Nov  9 10:17:15 aquarius kernel: io scheduler deadline registered
Nov  9 10:17:15 aquarius kernel: io scheduler cfq registered (default)
Nov  9 10:17:15 aquarius kernel: Boot video device is 0000:01:00.0
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:01.0 to 64
Nov  9 10:17:15 aquarius kernel: assign_interrupt_mode Found MSI
capability
Nov  9 10:17:15 aquarius kernel: Allocate Port
Service[0000:00:01.0:pcie00]
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.0 to 64
Nov  9 10:17:15 aquarius kernel: assign_interrupt_mode Found MSI
capability
Nov  9 10:17:15 aquarius kernel: Allocate Port
Service[0000:00:1c.0:pcie00]
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.1 to 64
Nov  9 10:17:15 aquarius kernel: assign_interrupt_mode Found MSI
capability
Nov  9 10:17:15 aquarius kernel: Allocate Port
Service[0000:00:1c.1:pcie00]
Nov  9 10:17:15 aquarius kernel: Allocate Port
Service[0000:00:1c.1:pcie02]
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1c.2 to 64
Nov  9 10:17:15 aquarius kernel: assign_interrupt_mode Found MSI
capability
Nov  9 10:17:15 aquarius kernel: Allocate Port
Service[0000:00:1c.2:pcie00]
Nov  9 10:17:15 aquarius kernel: ACPI: AC Adapter [ADP1] (on-line)
Nov  9 10:17:15 aquarius kernel: ACPI: Battery Slot [BAT1] (battery
present)
Nov  9 10:17:15 aquarius kernel: input: Power Button (FF)
as /class/input/input0
Nov  9 10:17:15 aquarius kernel: ACPI: Power Button (FF) [PWRF]
Nov  9 10:17:15 aquarius kernel: input: Lid Switch
as /class/input/input1
Nov  9 10:17:15 aquarius kernel: ACPI: Lid Switch [LID]
Nov  9 10:17:15 aquarius kernel: input: Power Button (CM)
as /class/input/input2
Nov  9 10:17:15 aquarius kernel: ACPI: Power Button (CM) [PWRB]
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75774, 00F3 (r1 TOSHIB
A0037    20050623 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF758DD, 034E (r1 TOSHIB
A0037    20050916 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: CPU0 (power states: C1[C1]
C2[C2])
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75867, 0076 (r1 TOSHIB
A0037    20050623 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: SSDT 7FF75C2B, 0079 (r1 TOSHIB
A0037    20050916 MSFT  100000E)
Nov  9 10:17:15 aquarius kernel: ACPI: CPU1 (power states: C1[C1]
C2[C2])
Nov  9 10:17:15 aquarius kernel: ACPI: Thermal Zone [THRM] (65 C)
Nov  9 10:17:15 aquarius kernel: toshiba_acpi: Toshiba Laptop ACPI
Extras version 0.18
Nov  9 10:17:15 aquarius kernel: toshiba_acpi:     HCI method:
\_SB_.VALZ.GHCI
Nov  9 10:17:15 aquarius kernel: isapnp: Scanning for PnP cards...
Nov  9 10:17:15 aquarius kernel: isapnp: No Plug & Play device found
Nov  9 10:17:15 aquarius kernel: Real Time Clock Driver v1.12ac
Nov  9 10:17:15 aquarius kernel: hpet_resources: 0xfed00000 is busy
Nov  9 10:17:15 aquarius kernel: Non-volatile memory driver v1.2
Nov  9 10:17:15 aquarius kernel: Toshiba System Managment Mode driver
v1.11 26/9/2001
Nov  9 10:17:15 aquarius kernel: Hangcheck: starting hangcheck timer
0.9.0 (tick is 180 seconds, margin is 60 seconds).
Nov  9 10:17:15 aquarius kernel: Hangcheck: Using get_cycles().
Nov  9 10:17:15 aquarius kernel: RAMDISK driver initialized: 4 RAM disks
of 8192K size 1024 blocksize
Nov  9 10:17:15 aquarius kernel: Intel(R) PRO/1000 Network Driver -
version 7.3.20-k2-NAPI
Nov  9 10:17:15 aquarius kernel: Copyright (c) 1999-2006 Intel
Corporation.
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:02:00.0[A] ->
GSI 16 (level, low) -> IRQ 16
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:02:00.0 to 64
Nov  9 10:17:15 aquarius kernel: e1000: 0000:02:00.0: e1000_probe: (PCI
Express:2.5Gb/s:Width x1) 00:15:b7:c5:66:5e
Nov  9 10:17:15 aquarius kernel: e1000: eth0: e1000_probe: Intel(R)
PRO/1000 Network Connection
Nov  9 10:17:15 aquarius kernel: Linux video capture interface: v2.00
Nov  9 10:17:15 aquarius kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Nov  9 10:17:15 aquarius kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Nov  9 10:17:15 aquarius kernel: ICH7: IDE controller at PCI slot
0000:00:1f.1
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] ->
GSI 18 (level, low) -> IRQ 18
Nov  9 10:17:15 aquarius kernel: ICH7: chipset revision 2
Nov  9 10:17:15 aquarius kernel: ICH7: not 100% native mode: will probe
irqs later
Nov  9 10:17:15 aquarius kernel: ide0: BM-DMA at 0x9f10-0x9f17, BIOS
settings: hda:DMA, hdb:pio
Nov  9 10:17:15 aquarius kernel: Probing IDE interface ide0...
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] smp_error_interrupt
+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: [<c01114ce>] smp_error_interrupt
+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: hda: TOSHIBA DVDW/HD TS-L802A, ATAPI
CD/DVD-ROM drive
Nov  9 10:17:15 aquarius kernel: hda: selected mode 0x42
Nov  9 10:17:15 aquarius kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  9 10:17:15 aquarius kernel: Probing IDE interface ide1...
Nov  9 10:17:15 aquarius kernel: hda: ATAPI 24X DVD-ROM DVD-R-RAM
CD-R/RW drive, 8192kB Cache, UDMA(33)
Nov  9 10:17:15 aquarius kernel: Uniform CD-ROM driver Revision: 3.20
Nov  9 10:17:15 aquarius kernel: ahci 0000:00:1f.2: version 2.3
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
GSI 19 (level, low) -> IRQ 20
Nov  9 10:17:15 aquarius kernel: ahci 0000:00:1f.2: AHCI 0001.0100 32
slots 4 ports 1.5 Gbps 0xf impl SATA mode
Nov  9 10:17:15 aquarius kernel: ahci 0000:00:1f.2: flags: 64bit ncq pm
led clo pio slum part 
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Nov  9 10:17:15 aquarius kernel: scsi0 : ahci
Nov  9 10:17:15 aquarius kernel: scsi1 : ahci
Nov  9 10:17:15 aquarius kernel: scsi2 : ahci
Nov  9 10:17:15 aquarius kernel: scsi3 : ahci
Nov  9 10:17:15 aquarius kernel: ata1: SATA max UDMA/133 cmd 0xf8828900
ctl 0x00000000 bmdma 0x00000000 irq 219
Nov  9 10:17:15 aquarius kernel: ata2: SATA max UDMA/133 cmd 0xf8828980
ctl 0x00000000 bmdma 0x00000000 irq 219
Nov  9 10:17:15 aquarius kernel: ata3: SATA max UDMA/133 cmd 0xf8828a00
ctl 0x00000000 bmdma 0x00000000 irq 219
Nov  9 10:17:15 aquarius kernel: ata4: SATA max UDMA/133 cmd 0xf8828a80
ctl 0x00000000 bmdma 0x00000000 irq 219
Nov  9 10:17:15 aquarius kernel: ata1: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Nov  9 10:17:15 aquarius kernel: ata1.00: Host Protected Area detected:
Nov  9 10:17:15 aquarius kernel: 	current size: 302825250 sectors
Nov  9 10:17:15 aquarius kernel: 	native size: 312581808 sectors
Nov  9 10:17:15 aquarius kernel: ata1.00: ATA-7: TOSHIBA MK1637GSX,
DL020M, max UDMA/100
Nov  9 10:17:15 aquarius kernel: ata1.00: 302825250 sectors, multi 16:
LBA48 NCQ (depth 31/32)
Nov  9 10:17:15 aquarius kernel: ata1.00: Host Protected Area detected:
Nov  9 10:17:15 aquarius kernel: 	current size: 302825250 sectors
Nov  9 10:17:15 aquarius kernel: 	native size: 312581808 sectors
Nov  9 10:17:15 aquarius kernel: ata1.00: configured for UDMA/100
Nov  9 10:17:15 aquarius kernel: ata2: SATA link down (SStatus 0
SControl 0)
Nov  9 10:17:15 aquarius kernel: ata3: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Nov  9 10:17:15 aquarius kernel: ata3.00: ATA-7: TOSHIBA MK1637GSX,
DL020M, max UDMA/100
Nov  9 10:17:15 aquarius kernel: ata3.00: 312581808 sectors, multi 16:
LBA48 NCQ (depth 31/32)
Nov  9 10:17:15 aquarius kernel: ata3.00: configured for UDMA/100
Nov  9 10:17:15 aquarius kernel: ata4: SATA link down (SStatus 0
SControl 0)
Nov  9 10:17:15 aquarius kernel: scsi 0:0:0:0: Direct-Access     ATA
TOSHIBA MK1637GS DL02 PQ: 0 ANSI: 5
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] 302825250 512-byte
hardware sectors (155047 MB)
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Write Protect is off
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00
00
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] 302825250 512-byte
hardware sectors (155047 MB)
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Write Protect is off
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00
00
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov  9 10:17:15 aquarius kernel: sda: sda1 sda2 sda3
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Nov  9 10:17:15 aquarius kernel: sd 0:0:0:0: Attached scsi generic sg0
type 0
Nov  9 10:17:15 aquarius kernel: scsi 2:0:0:0: Direct-Access     ATA
TOSHIBA MK1637GS DL02 PQ: 0 ANSI: 5
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] 312581808 512-byte
hardware sectors (160042 MB)
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Write Protect is off
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00
00
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] 312581808 512-byte
hardware sectors (160042 MB)
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Write Protect is off
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00
00
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov  9 10:17:15 aquarius kernel: sdb: sdb1 sdb2 sdb3
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: [sdb] Attached SCSI disk
Nov  9 10:17:15 aquarius kernel: sd 2:0:0:0: Attached scsi generic sg1
type 0
Nov  9 10:17:15 aquarius kernel: usbmon: debugfs is not available
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] ->
GSI 23 (level, low) -> IRQ 21
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Nov  9 10:17:15 aquarius kernel: ehci_hcd 0000:00:1d.7: EHCI Host
Controller
Nov  9 10:17:15 aquarius kernel: ehci_hcd 0000:00:1d.7: new USB bus
registered, assigned bus number 1
Nov  9 10:17:15 aquarius kernel: ehci_hcd 0000:00:1d.7: debug port 1
Nov  9 10:17:15 aquarius kernel: PCI: cache line size of 32 is not
supported by device 0000:00:1d.7
Nov  9 10:17:15 aquarius kernel: ehci_hcd 0000:00:1d.7: irq 21, io mem
0xffaffc00
Nov  9 10:17:15 aquarius kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started,
EHCI 1.00, driver 10 Dec 2004
Nov  9 10:17:15 aquarius kernel: usb usb1: configuration #1 chosen from
1 choice
Nov  9 10:17:15 aquarius kernel: hub 1-0:1.0: USB hub found
Nov  9 10:17:15 aquarius kernel: hub 1-0:1.0: 8 ports detected
Nov  9 10:17:15 aquarius kernel: USB Universal Host Controller Interface
driver v3.0
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] ->
GSI 23 (level, low) -> IRQ 21
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.0: UHCI Host
Controller
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 2
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.0: irq 21, io base
0x00009fe0
Nov  9 10:17:15 aquarius kernel: usb usb2: configuration #1 chosen from
1 choice
Nov  9 10:17:15 aquarius kernel: hub 2-0:1.0: USB hub found
Nov  9 10:17:15 aquarius kernel: hub 2-0:1.0: 2 ports detected
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] ->
GSI 19 (level, low) -> IRQ 20
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.1: UHCI Host
Controller
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 3
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.1: irq 20, io base
0x00009f80
Nov  9 10:17:15 aquarius kernel: usb usb3: configuration #1 chosen from
1 choice
Nov  9 10:17:15 aquarius kernel: hub 3-0:1.0: USB hub found
Nov  9 10:17:15 aquarius kernel: hub 3-0:1.0: 2 ports detected
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] ->
GSI 18 (level, low) -> IRQ 18
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.2: UHCI Host
Controller
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 4
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.2: irq 18, io base
0x00009f60
Nov  9 10:17:15 aquarius kernel: usb usb4: configuration #1 chosen from
1 choice
Nov  9 10:17:15 aquarius kernel: hub 4-0:1.0: USB hub found
Nov  9 10:17:15 aquarius kernel: hub 4-0:1.0: 2 ports detected
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] ->
GSI 16 (level, low) -> IRQ 16
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.3: UHCI Host
Controller
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.3: new USB bus
registered, assigned bus number 5
Nov  9 10:17:15 aquarius kernel: uhci_hcd 0000:00:1d.3: irq 16, io base
0x00009f40
Nov  9 10:17:15 aquarius kernel: usb usb5: configuration #1 chosen from
1 choice
Nov  9 10:17:15 aquarius kernel: hub 5-0:1.0: USB hub found
Nov  9 10:17:15 aquarius kernel: hub 5-0:1.0: 2 ports detected
Nov  9 10:17:15 aquarius kernel: Initializing USB Mass Storage driver...
Nov  9 10:17:15 aquarius kernel: usb 4-2: new full speed USB device
using uhci_hcd and address 2
Nov  9 10:17:15 aquarius kernel: usb 4-2: configuration #1 chosen from 1
choice
Nov  9 10:17:15 aquarius kernel: usb 5-1: new low speed USB device using
uhci_hcd and address 2
Nov  9 10:17:15 aquarius kernel: usb 5-1: configuration #1 chosen from 1
choice
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver usb-storage
Nov  9 10:17:15 aquarius kernel: USB Mass Storage support registered.
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver libusual
Nov  9 10:17:15 aquarius kernel: PNP: PS/2 Controller
[PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Nov  9 10:17:15 aquarius kernel: serio: i8042 KBD port at 0x60,0x64 irq
1
Nov  9 10:17:15 aquarius kernel: serio: i8042 AUX port at 0x60,0x64 irq
12
Nov  9 10:17:15 aquarius kernel: mice: PS/2 mouse device common for all
mice
Nov  9 10:17:15 aquarius kernel: input: AT Translated Set 2 keyboard
as /class/input/input3
Nov  9 10:17:15 aquarius kernel: rtc_cmos 00:08: rtc core: registered
rtc_cmos as rtc0
Nov  9 10:17:15 aquarius kernel: rtc_cmos: probe of 00:08 failed with
error -16
Nov  9 10:17:15 aquarius kernel: i2c /dev entries driver
Nov  9 10:17:15 aquarius kernel: Synaptics Touchpad, model: 1, fw: 6.2,
id: 0x25a0b1, caps: 0xa04713/0x0
Nov  9 10:17:15 aquarius kernel: input: SynPS/2 Synaptics TouchPad
as /class/input/input4
Nov  9 10:17:15 aquarius kernel: md: raid0 personality registered for
level 0
Nov  9 10:17:15 aquarius kernel: md: raid1 personality registered for
level 1
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver hiddev
Nov  9 10:17:15 aquarius kernel: input: KYE Genius USB Wheel Mouse
as /class/input/input5
Nov  9 10:17:15 aquarius kernel: input: USB HID v1.00 Mouse [KYE Genius
USB Wheel Mouse] on usb-0000:00:1d.3-1
Nov  9 10:17:15 aquarius kernel: usbcore: registered new interface
driver usbhid
Nov  9 10:17:15 aquarius kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB
HID core driver
Nov  9 10:17:15 aquarius kernel: Advanced Linux Sound Architecture
Driver Version 1.0.14 (Fri Jul 20 09:12:58 2007 UTC).
Nov  9 10:17:15 aquarius kernel: ALSA device list:
Nov  9 10:17:15 aquarius kernel: No soundcards found.
Nov  9 10:17:15 aquarius kernel: Netfilter messages via NETLINK v0.30.
Nov  9 10:17:15 aquarius kernel: ip_tables: (C) 2000-2006 Netfilter Core
Team
Nov  9 10:17:15 aquarius kernel: arp_tables: (C) 2002 David S. Miller
Nov  9 10:17:15 aquarius kernel: TCP vegas registered
Nov  9 10:17:15 aquarius kernel: TCP veno registered
Nov  9 10:17:15 aquarius kernel: TCP yeah registered
Nov  9 10:17:15 aquarius kernel: NET: Registered protocol family 1
Nov  9 10:17:15 aquarius kernel: NET: Registered protocol family 17
Nov  9 10:17:15 aquarius kernel: Using IPI Shortcut mode
Nov  9 10:17:15 aquarius kernel: drivers/rtc/hctosys.c: unable to open
rtc device (rtc0)
Nov  9 10:17:15 aquarius kernel: BIOS EDD facility v0.16 2004-Jun-25, 6
devices found
Nov  9 10:17:15 aquarius kernel: Freeing unused kernel memory: 268k
freed
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c01164e5>] do_page_fault+0x85/0x660
Nov  9 10:17:15 aquarius kernel: [<c03b3c42>] error_code+0x72/0x78
Nov  9 10:17:15 aquarius kernel: [<c019ea7c>] dnotify_flush+0x4c/0xb0
Nov  9 10:17:15 aquarius kernel: [<c016bf87>] filp_close+0x47/0x80
Nov  9 10:17:15 aquarius kernel: [<c0116460>] do_page_fault+0x0/0x660
Nov  9 10:17:15 aquarius kernel: [<c03b3c42>] error_code+0x72/0x78
Nov  9 10:17:15 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: usb_id[1977]: segfault at 00000000 eip
b7e5d7c4 esp bfec57f0 error 4
Nov  9 10:17:15 aquarius kernel: usb_id[1978]: segfault at 00000000 eip
b7ec87c4 esp bfda1070 error 4
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: md: md0 stopped.
Nov  9 10:17:15 aquarius kernel: md: bind<sdb3>
Nov  9 10:17:15 aquarius kernel: md: bind<sda3>
Nov  9 10:17:15 aquarius kernel: md0: setting max_sectors to 128,
segment boundary to 32767
Nov  9 10:17:15 aquarius kernel: raid0: looking at sda3
Nov  9 10:17:15 aquarius kernel: raid0:   comparing sda3(128945600) with
sda3(128945600)
Nov  9 10:17:15 aquarius kernel: raid0:   END
Nov  9 10:17:15 aquarius kernel: raid0:   ==> UNIQUE
Nov  9 10:17:15 aquarius kernel: raid0: 1 zones
Nov  9 10:17:15 aquarius kernel: raid0: looking at sdb3
Nov  9 10:17:15 aquarius kernel: raid0:   comparing sdb3(128945600) with
sda3(128945600)
Nov  9 10:17:15 aquarius kernel: raid0:   EQUAL
Nov  9 10:17:15 aquarius kernel: raid0: FINAL 1 zones
Nov  9 10:17:15 aquarius kernel: raid0: done.
Nov  9 10:17:15 aquarius kernel: raid0 : md_size is 257891200 blocks.
Nov  9 10:17:15 aquarius kernel: raid0 : conf->hash_spacing is 257891200
blocks.
Nov  9 10:17:15 aquarius kernel: raid0 : nb_zone is 1.
Nov  9 10:17:15 aquarius kernel: raid0 : Allocating 4 bytes for hash.
Nov  9 10:17:15 aquarius kernel: usb_id[2915]: segfault at 00000000 eip
b7e227c4 esp bfe49030 error 4
Nov  9 10:17:15 aquarius kernel: usb_id[2917]: segfault at 00000000 eip
b7e227c4 esp bfe49030 error 4
Nov  9 10:17:15 aquarius kernel: kjournald starting.  Commit interval 5
seconds
Nov  9 10:17:15 aquarius kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Nov  9 10:17:15 aquarius kernel: usb_id[4517]: segfault at 00000000 eip
b7eb15d8 esp bff2c920 error 4
Nov  9 10:17:15 aquarius kernel: usb_id[4507]: segfault at 00000000 eip
b7ea15d8 esp bfe672a0 error 4
Nov  9 10:17:15 aquarius kernel: Linux agpgart interface v0.102
Nov  9 10:17:15 aquarius kernel: sdhci: Secure Digital Host Controller
Interface driver
Nov  9 10:17:15 aquarius kernel: sdhci: Copyright(c) Pierre Ossman
Nov  9 10:17:15 aquarius kernel: sdhci: SDHCI controller found at
0000:06:0b.3 [104c:803c] (rev 0)
Nov  9 10:17:15 aquarius kernel: PCI: Enabling device 0000:06:0b.3 (0000
-> 0002)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:06:0b.3[D] ->
GSI 23 (level, low) -> IRQ 21
Nov  9 10:17:15 aquarius kernel: mmc0: SDHCI at 0x94006800 irq 21 DMA
Nov  9 10:17:15 aquarius kernel: PCI: Enabling device 0000:06:0b.1 (0000
-> 0002)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:06:0b.1[B] ->
GSI 20 (level, low) -> IRQ 22
Nov  9 10:17:15 aquarius kernel: ohci1394: fw-host0: OHCI-1394 1.1
(PCI): IRQ=[22]  MMIO=[94006000-940067ff]  Max Packet=[2048]  IR/IT
contexts=[4/8]
Nov  9 10:17:15 aquarius kernel: Yenta: CardBus bridge found at
0000:06:0b.0 [1179:0001]
Nov  9 10:17:15 aquarius kernel: Yenta: Enabling burst memory read
transactions
Nov  9 10:17:15 aquarius kernel: Yenta: Using CSCINT to route CSC
interrupts to PCI
Nov  9 10:17:15 aquarius kernel: Yenta: Routing CardBus interrupts to
PCI
Nov  9 10:17:15 aquarius kernel: Yenta TI: socket 0000:06:0b.0, mfunc
0x01aa1022, devctl 0x64
Nov  9 10:17:15 aquarius kernel: input: PC Speaker
as /class/input/input6
Nov  9 10:17:15 aquarius kernel: Yenta: ISA IRQ mask 0x0cf8, PCI irq 19
Nov  9 10:17:15 aquarius kernel: Socket status: 30000006
Nov  9 10:17:15 aquarius kernel: pcmcia: parent PCI bridge I/O window:
0x1000 - 0x1fff
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0x1000-0x1fff: clean.
Nov  9 10:17:15 aquarius kernel: pcmcia: parent PCI bridge Memory
window: 0x8c000000 - 0x95ffffff
Nov  9 10:17:15 aquarius kernel: pcmcia: parent PCI bridge Memory
window: 0x88000000 - 0x8bffffff
Nov  9 10:17:15 aquarius kernel: PCI: Enabling device 0000:00:1b.0 (0000
-> 0002)
Nov  9 10:17:15 aquarius kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] ->
GSI 22 (level, low) -> IRQ 23
Nov  9 10:17:15 aquarius kernel: PCI: Setting latency timer of device
0000:00:1b.0 to 64
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0x100-0x3af: clean.
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0x3e0-0x4ff:
excluding 0x4d0-0x4d7
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0x820-0x8ff: clean.
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0xc00-0xcf7: clean.
Nov  9 10:17:15 aquarius kernel: cs: IO port probe 0xa00-0xaff: clean.
Nov  9 10:17:15 aquarius kernel: Adding 2931852k swap on /dev/sdb2.
Priority:-1 extents:1 across:2931852k
Nov  9 10:17:15 aquarius kernel: ieee1394: Host added: ID:BUS[0-00:1023]
GUID[0000390000a60d7b]
Nov  9 10:17:15 aquarius kernel: EXT3 FS on sda2, internal journal
Nov  9 10:17:15 aquarius kernel: loop: module loaded
Nov  9 10:17:15 aquarius kernel: device-mapper: ioctl: 4.11.0-ioctl
(2006-10-12) initialised: dm-devel@redhat.com
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: fuse init (API version 7.8)
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-2: found reiserfs format
"3.6" with standard journal
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-2: using ordered data mode
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-2: journal params: device
dm-2, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-2: checking transaction
log (dm-2)
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-2: Using r5 hash to sort
names
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-1: found reiserfs format
"3.6" with standard journal
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-1: using ordered data mode
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-1: journal params: device
dm-1, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-1: checking transaction
log (dm-1)
Nov  9 10:17:15 aquarius kernel: ReiserFS: dm-1: Using r5 hash to sort
names
Nov  9 10:17:15 aquarius kernel: kjournald starting.  Commit interval 5
seconds
Nov  9 10:17:15 aquarius kernel: EXT3-fs warning: maximal mount count
reached, running e2fsck is recommended
Nov  9 10:17:15 aquarius kernel: EXT3 FS on sdb1, internal journal
Nov  9 10:17:15 aquarius kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Nov  9 10:17:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:15 aquarius kernel: =======================
Nov  9 10:17:15 aquarius kernel: e1000: eth0: e1000_watchdog: NIC Link
is Up 100 Mbps Full Duplex, Flow Control: RX
Nov  9 10:17:15 aquarius kernel: e1000: eth0: e1000_watchdog: 10/100
speed: disabling TSO
Nov  9 10:17:30 aquarius kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Nov  9 10:17:30 aquarius kernel: NFSD: Using /var/lib/nfs/v4recovery as
the NFSv4 state recovery directory
Nov  9 10:17:30 aquarius kernel: NFSD: starting 90-second grace period
Nov  9 10:17:32 aquarius kernel: Capability LSM initialized
Nov  9 10:17:33 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:33 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:33 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:33 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:33 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:33 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:33 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:33 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:33 aquarius kernel: =======================
Nov  9 10:17:33 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:33 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:33 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:17:33 aquarius kernel: =======================
Nov  9 10:17:33 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:33 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:33 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:33 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:33 aquarius kernel: =======================
Nov  9 10:17:33 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:33 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:33 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:33 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:33 aquarius kernel: =======================
Nov  9 10:17:37 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:37 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:37 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:37 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:37 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:37 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:37 aquarius kernel: =======================
Nov  9 10:17:37 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:37 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:37 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:37 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:37 aquarius kernel: =======================
Nov  9 10:17:37 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:37 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:37 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:37 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:37 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:37 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:37 aquarius kernel: =======================
Nov  9 10:17:37 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:37 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:37 aquarius kernel: =======================
Nov  9 10:17:45 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:45 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:45 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:45 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:45 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:45 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:45 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:45 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:45 aquarius kernel: =======================
Nov  9 10:17:45 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:45 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:45 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:45 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:45 aquarius kernel: =======================
Nov  9 10:17:53 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:53 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:53 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:53 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:53 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:53 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:53 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:53 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:53 aquarius kernel: =======================
Nov  9 10:17:53 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:53 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:53 aquarius kernel: =======================
Nov  9 10:17:53 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:53 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:53 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:53 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:53 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:53 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:53 aquarius kernel: =======================
Nov  9 10:17:53 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:53 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:53 aquarius kernel: =======================
Nov  9 10:17:57 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:17:57 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:17:57 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:17:57 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:57 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:57 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:57 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:17:57 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:17:57 aquarius kernel: =======================
Nov  9 10:17:57 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:17:57 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:17:57 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:17:57 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:17:57 aquarius kernel: =======================
Nov  9 10:18:15 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:18:15 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:18:15 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:18:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:18:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:18:15 aquarius kernel: [<c04a8d8b>] start_kernel+0x2db/0x390
Nov  9 10:18:15 aquarius kernel: [<c04a8420>] unknown_bootoption
+0x0/0x1f0
Nov  9 10:18:15 aquarius kernel: =======================
Nov  9 10:18:15 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:18:15 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:15 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:18:15 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:18:15 aquarius kernel: =======================
Nov  9 10:18:28 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:18:28 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:18:28 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:18:28 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:28 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:18:28 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:18:28 aquarius kernel: =======================
Nov  9 10:18:28 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:18:28 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:28 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:18:28 aquarius kernel: =======================
Nov  9 10:18:28 aquarius kernel: APIC error on CPU0: 40(40)
Nov  9 10:18:28 aquarius kernel: APIC error on CPU1: 40(40)
Nov  9 10:18:28 aquarius kernel: [<c01114ce>]  [<c01114ce>]
smp_error_interrupt+0x5e/0x70
Nov  9 10:18:28 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:28 aquarius kernel: [<c0100b48>] mwait_idle_with_hints
+0x58/0x70
Nov  9 10:18:28 aquarius kernel: [<c0100d83>] cpu_idle+0x63/0xa0
Nov  9 10:18:28 aquarius kernel: =======================
Nov  9 10:18:28 aquarius kernel: smp_error_interrupt+0x5e/0x70
Nov  9 10:18:28 aquarius kernel: [<c0103848>] error_interrupt+0x28/0x30
Nov  9 10:18:28 aquarius kernel: [<c03b0000>] wext_handle_ioctl
+0x2c0/0x450
Nov  9 10:18:28 aquarius kernel: =======================
Nov  9 10:18:28 aquarius kernel: fuse exit
