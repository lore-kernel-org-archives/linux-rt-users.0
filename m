From: "David Bahi" <dbahi@novell.com>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 10:11:49 -0600
Message-ID: <46974FE50200006C0001494D@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part486F9455.2__="
Cc: <mingo@elte.hu>, <linux-rt-users@vger.kernel.org>
To: <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:17858 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbXGMQcI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 12:32:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__Part486F9455.2__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 2007-07-13 at 13:36 +0200, Remy Bohmer wrote:
> Thomas,
>=20

> It should be: http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/
>=20
> Remy
>=20
> > This release is bugfix release:
> >
> > - update of the x8664 -hrt queue (resolve boot problems)
> > - gtod vsyscall fix from Gregory Haskins
> >

excellent. this definitely de-bricks -rt2 for my box.

still, there's this -rt1 acpi + spinlock panic if ! acpi=3Doff=20
(attached - now with some debug)

db



--=__Part486F9455.2__=
Content-Type: text/plain; name="hardlock.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hardlock.txt"

Linux version 2.6.22.1-rt3-debug (geeko@buildhost) (gcc version 4.1.2 =
20070115 (prerelease) (SUSE Linux)) #3 SMP PREEMPT RT Fri Jul7Command =
line: root=3D/dev/disk/by-id/scsi-SATA_HTS721010G9SA00_MPCZN7Y0H183WL-part6=
 vga=3D0x317 resume=3D/dev/sda5 splash=3Dsilent console=3D8BIOS-provided =
physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfed0000 (usable)
 BIOS-e820: 00000000bfed0000 - 00000000bfedf000 (ACPI data)
 BIOS-e820: 00000000bfedf000 - 00000000bff00000 (ACPI NVS)
 BIOS-e820: 00000000bff00000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
end_pfn_map =3D 1048576
DMI present.
ACPI: RSDP 000F6860, 0024 (r2 LENOVO)
ACPI: XSDT BFED1692, 008C (r1 LENOVO TP-79        2007  LTP        0)
ACPI: FACP BFED1800, 00F4 (r3 LENOVO TP-79        2007 LNVO        1)
ACPI Warning (tbfadt-0434): Optional field "Gpe1Block" has zero address or =
length: 000000000000102C/0 [20070126]
ACPI: DSDT BFED1C32, D1A1 (r1 LENOVO TP-79        2007 MSFT  100000E)
ACPI: FACS BFEF4000, 0040
ACPI: SSDT BFED19B4, 027E (r1 LENOVO TP-79        2007 MSFT  100000E)
ACPI: ECDT BFEDEDD3, 0052 (r1 LENOVO TP-79        2007 LNVO        1)
ACPI: TCPA BFEDEE25, 0032 (r2 LENOVO TP-79        2007 LNVO        1)
ACPI: APIC BFEDEE57, 0068 (r1 LENOVO TP-79        2007 LNVO        1)
ACPI: MCFG BFEDEEBF, 003C (r1 LENOVO TP-79        2007 LNVO        1)
ACPI: HPET BFEDEEFB, 0038 (r1 LENOVO TP-79        2007 LNVO        1)
ACPI: BOOT BFEDEFD8, 0028 (r1 LENOVO TP-79        2007  LTP        1)
ACPI: SSDT BFEF26D9, 025F (r1 LENOVO TP-79        2007 INTL 20050513)
ACPI: SSDT BFEF2938, 00A6 (r1 LENOVO TP-79        2007 INTL 20050513)
ACPI: SSDT BFEF29DE, 04F7 (r1 LENOVO TP-79        2007 INTL 20050513)
ACPI: SSDT BFEF2ED5, 08BD (r1 LENOVO TP-79        2007 INTL 20050513)
ACPI: SSDT BFEF3792, 069C (r1 LENOVO TP-79        2007 INTL 20050513)
No NUMA configuration found
Faking a node at 0000000000000000-00000000bfed0000
Bootmem setup node 0 0000000000000000-00000000bfed0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   786128
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:30000000)
PERCPU: Allocating 447432 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 739589
Kernel command line: root=3D/dev/disk/by-id/scsi-SATA_HTS721010G9SA00_MPCZN=
7Y0H183WL-part6 vga=3D0x317 resume=3D/dev/sda5 splash=3Dsilent c8Initializi=
ng CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
TSC calibrated against HPET
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2327.494 MHz processor.
Console: colour dummy device 80x25
num_possible_cpus(): 2
CPU#0: allocated 3145728 bytes trace buffer.
CPU#0: allocated 3145728 bytes max-trace buffer.
CPU#1: allocated 3145728 bytes trace buffer.
CPU#1: allocated 3145728 bytes max-trace buffer.
allocated 6291456 bytes out-trace buffer.
tracer: a total of 18874368 bytes allocated.
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:      8
... MAX_LOCK_DEPTH:             30
... MAX_LOCKDEP_KEYS:         2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 2672 kB
 per task-struct memory footprint: 2160 bytes
------------------------
| Locking API testsuite:
---------------------------------------------------------------------------=
-
                                 | spin |wlock |rlock |mutex | wsem | rsem =
|
  -------------------------------------------------------------------------=
-
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|
  -------------------------------------------------------------------------=
-
              recursive read-lock:             |  ok  |             |  ok  =
|
           recursive read-lock #2:             |  ok  |             |  ok  =
|
            mixed read-write-lock:             |  ok  |             |  ok  =
|
            mixed write-read-lock:             |  ok  |             |  ok  =
|
  -------------------------------------------------------------------------=
-
-------------------------------------------------------
Good, all  68 testcases passed! |
---------------------------------
Checking aperture...
Memory: 2930700k/3144512k available (2562k kernel code, 213424k reserved, =
1460k data, 700k init)
Calibrating delay using timer specific routine.. 4660.34 BogoMIPS =
(lpj=3D2330172)
Security Framework v1.0.0 initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
Freeing SMP alternatives: 20k freed
Unpacking initramfs... done
Freeing initrd memory: 6674k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 1623 Objects with 76 Devices 437 Methods 27 =
Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 11 Objects with 0 Devices 7 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 7 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 4 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0006) - 48 Objects with 2 Devices 5 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0007) - 47 Objects with 2 Devices 5 Methods 0 Regions
 tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully =
acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode =
successful
Using local APIC timer interrupts.
Detected 10.390 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4654.79 BogoMIPS =
(lpj=3D2327398)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU         T7600  @ 2.33GHz stepping 06
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000 - f3ffffff
evgpeblk-0952 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on =
int 0x9
evgpeblk-1048 [00] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 2 Runtime =
GPEs in this block
Completing Region/Field/Buffer/Package initialization:.....................=
.........................................................Initialized 25/27 =
Regions 184/184 Fields 76/76 Buffers 43/55 Packages (1763 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:...=
.....
Executed 8 _INI methods requiring 2 _STA executions (examined 86 objects)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a =
report
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: 00:00: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:00: iomem range 0xc0000-0xc3fff has been reserved
pnp: 00:00: iomem range 0xc4000-0xc7fff has been reserved
pnp: 00:00: iomem range 0xc8000-0xcbfff has been reserved
pnp: 00:02: iomem range 0xf0000000-0xf3ffffff could not be reserved
pnp: 00:02: iomem range 0xfed1c000-0xfed1ffff could not be reserved
pnp: 00:02: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:02: iomem range 0xfed18000-0xfed18fff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: ee100000-ee1fffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: ee000000-ee0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 4000-5fff
  MEM window: ec000000-edffffff
  PREFETCH window: e4000000-e40fffff
PCI: Bridge: 0000:00:1c.2
  IO window: 6000-7fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: e4100000-e41fffff
PCI: Bridge: 0000:00:1c.3
  IO window: 8000-9fff
  MEM window: ea000000-ebffffff
  PREFETCH window: e4200000-e42fffff
PCI: Bus 22, cardbus bridge: 0000:15:00.0
  IO window: 0000a000-0000a0ff
  IO window: 0000a400-0000a4ff
  PREFETCH window: e0000000-e3ffffff
  MEM window: c4000000-c7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: a000-dfff
  MEM window: e4300000-e7ffffff
  PREFETCH window: e0000000-e3ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 14, 104857600 bytes)
TCP bind hash table entries: 65536 (order: 11, 12582912 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
Simple Boot Flag at 0x35 set to 0x1
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1184328004.428:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
vesafb: framebuffer at 0xd0000000, mapped to 0xffffc2000b800000, using =
3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /class/input/input2
cpuidle: using governor ladder
NET: Registered protocol family 1
***************************************************************************=
**
*                                                                          =
 *
*  REMINDER, the following debugging options are turned on in your =
.config: *
*                                                                          =
 *
*        CONFIG_DEBUG_RT_MUTEXES                                           =
 *
*        CONFIG_FUNCTION_TRACE                                             =
 *
*        CONFIG_LOCKDEP                                                    =
 *
*                                                                          =
 *
*  they may increase runtime overhead and latencies.                       =
 *
*                                                                          =
 *
***************************************************************************=
**
Freeing unused kernel memory: 700k freed
Write protecting the kernel read-only data: 1040k
Starting udevd
Creating devices
Loading scsi_mod
SCSI subsystem initialized
Loading sd_mod
Loading libata
Loading ata_piix
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 16
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 =
bmdma 0x00000000000118b0 irq 14
ata2: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 =
bmdma 0x00000000000118b8 irq 15
ata1.00: ATA-7: HTS721010G9SA00, MCZIC10V, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48
ata1.00: configured for UDMA/100
ata2.00: ATAPI: MATSHITADVD-RAM UJ-842, RB01, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      HTS721010G9SA00  MCZI PQ: 0 ANSI: =
5
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-842   RB01 PQ: 0 ANSI: =
5
Loading processor
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
ACPI: SSDT BFEF1D36, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
Parsing all Control Methods:
Table [SSDT](id 0013) - 6 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT BFEF207F, 065A (r1  PmRef  Cpu0Cst      100 INTL 20050513)
Parsing all Control Methods:
Table [SSDT](id 0014) - 13 Objects with 0 Devices 1 Methods 0 Regions
Loading thermal
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT BFEF1C6E, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
Parsing all Control Methods:
Table [SSDT](id 0019) - 4 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT BFEF1FFA, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
Loading fan
Parsing all Control Methods:
Table [SSDT](id 001A) - 1 Objects with 0 Devices 1 Methods 0 Regions
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
Loading edd
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
cpuidle: using driver acpi_idle
ACPI: Thermal Zone [THM0] (73 C)
ACPI: Thermal Zone [THM1] (76 C)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
BUG: sleeping function called from invalid context swapper(0) at kernel/rtm=
utex.c:636
in_atomic():1 [00000001], irqs_disabled():1
1 lock held by swapper/0:
 #0:  (c3_lock){....}, at: [<ffffffff88093774>] acpi_idle_enter_c3+0x179/0x=
281 [processor]
irq event stamp: 58216
hardirqs last  enabled at (58215): [<ffffffff80259b9d>] trace_hardirqs_on+0=
xd/0x10
hardirqs last disabled at (58216): [<ffffffff80256ccd>] trace_hardirqs_off+=
0xd/0x10
softirqs last  enabled at (0): [<ffffffff80234223>] copy_process+0x513/0x18=
50
softirqs last disabled at (0): [<0000000000000000>] 0x0

Call Trace:
 [<ffffffff8022d803>] __might_sleep+0x113/0x150
 [<ffffffff80478305>] __rt_spin_lock+0x35/0x50
 [<ffffffff804784e8>] rt_spin_lock+0x58/0x70
 [<ffffffff88093774>] :processor:acpi_idle_enter_c3+0x179/0x281
 [<ffffffff803ed57a>] cpuidle_idle_call+0x9a/0xd0
 [<ffffffff803ed4e0>] cpuidle_idle_call+0x0/0xd0
 [<ffffffff80208d15>] cpu_idle+0x75/0xc0
 [<ffffffff8086a54d>] start_secondary+0x27d/0x370

---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208d4c>] .... cpu_idle+0xac/0xc0
.....[<ffffffff8086a54d>] ..   ( <=3D start_secondary+0x27d/0x370)

BUG: scheduling with irqs disabled: swapper/0x00000001/0
stopped custom tracer.
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<0000000000000000>]
PGD acac4067 PUD acad7067 PMD 0
Oops: 0010 [1] PREEMPT SMP
CPU 0
Modules linked in: edd fan thermal sg processor sr_mod cdrom ata_piix =
libata sd_mod scsi_mod
Pid: 0, comm: swapper Tainted: G      N 2.6.22.1-rt3-debug #3
RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
RSP: 0018:ffffffff80857d40  EFLAGS: 00010003
RAX: ffffffff808515a0 RBX: ffff810037998740 RCX: 00000001da576082
RDX: 0000000000000001 RSI: ffff810037998740 RDI: ffff81000113da80
RBP: ffffffff80857d68 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: 00000001da576082
R13: 0000000000000001 R14: ffff81000113da80 R15: ffff81000113da80
FS:  0000000000000000(0000) GS:ffffffff805ee280(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000acae9000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80856000, task ffffffff80591cc0=
)
Stack:  ffffffff8022ad9c ffff81000113da80 ffff810037998740 00000001da576082=

 0000000000000001 ffffffff80857d98 ffffffff8022c47b 000000000000001f
 0000000000000000 ffff810037998740 0000000000000001 ffffffff80857e58
Call Trace:
 [<ffffffff8022ad9c>] enqueue_task+0x4c/0x90
 [<ffffffff8022c47b>] activate_task+0x8b/0x110
 [<ffffffff8023049b>] try_to_wake_up+0x37b/0x570
 [<ffffffff802607d5>] wakeup_next_waiter+0x135/0x250
 [<ffffffff8023070a>] wake_up_process_mutex+0x1a/0x20
 [<ffffffff802607e4>] wakeup_next_waiter+0x144/0x250
 [<ffffffff8047761d>] rt_spin_lock_slowunlock+0x6d/0x90
 [<ffffffff8047840e>] rt_spin_unlock+0x2e/0x40
 [<ffffffff880937ad>] :processor:acpi_idle_enter_c3+0x1b2/0x281
 [<ffffffff803ed57a>] cpuidle_idle_call+0x9a/0xd0
 [<ffffffff803ed4e0>] cpuidle_idle_call+0x0/0xd0
 [<ffffffff80208d15>] cpu_idle+0x75/0xc0
 [<ffffffff8047535f>] rest_init+0x7f/0x90
 [<ffffffff8085f8ba>] start_kernel+0x2da/0x390
 [<ffffffff8085f119>] _sinittext+0x119/0x160

INFO: lockdep is turned off.
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208d4c>] .... cpu_idle+0xac/0xc0
.....[<ffffffff8047535f>] ..   ( <=3D rest_init+0x7f/0x90)
.. [<ffffffff8047935f>] .... __spin_lock_irqsave+0x2f/0x90
.....[<ffffffff804775ce>] ..   ( <=3D rt_spin_lock_slowunlock+0x1e/0x90)
.. [<ffffffff80478e79>] .... __spin_lock+0x19/0x70
.....[<ffffffff8022d8d6>] ..   ( <=3D task_rq_lock+0x56/0xa0)


Code:  Bad RIP value.
RIP  [<0000000000000000>]
 RSP <ffffffff80857d40>
CR2: 0000000000000000
Kernel panic - not syncing: Attempted to kill the idle task!

Call Trace:
 [<ffffffff802368e4>] panic+0xb4/0x190
 [<ffffffff80257fd7>] print_lock_contention_bug+0x27/0x100
 [<ffffffff80245c81>] __blocking_notifier_call_chain+0x21/0x80
 [<ffffffff80245cf6>] blocking_notifier_call_chain+0x16/0x20
 [<ffffffff8023afaa>] do_exit+0xa0a/0xa20
 [<ffffffff80477604>] rt_spin_lock_slowunlock+0x54/0x90
 [<ffffffff80236609>] do_oops_enter_exit+0x9/0xe0
 [<ffffffff8047c6dd>] do_page_fault+0x51d/0x920
 [<ffffffff80263789>] __module_text_address+0x9/0x70
 [<ffffffff8024ae27>] __kernel_text_address+0x27/0x40
 [<ffffffff8020b75d>] dump_trace+0xed/0x2b0
 [<ffffffff80212bdd>] save_stack_trace+0x2d/0x50
 [<ffffffff8047a46d>] error_exit+0x0/0x96
 [<ffffffff8022ad9c>] enqueue_task+0x4c/0x90
 [<ffffffff8022c47b>] activate_task+0x8b/0x110
 [<ffffffff8023049b>] try_to_wake_up+0x37b/0x570
 [<ffffffff802607d5>] wakeup_next_waiter+0x135/0x250
 [<ffffffff8023070a>] wake_up_process_mutex+0x1a/0x20
 [<ffffffff802607e4>] wakeup_next_waiter+0x144/0x250
 [<ffffffff8047761d>] rt_spin_lock_slowunlock+0x6d/0x90
 [<ffffffff8047840e>] rt_spin_unlock+0x2e/0x40
 [<ffffffff880937ad>] :processor:acpi_idle_enter_c3+0x1b2/0x281
 [<ffffffff803ed57a>] cpuidle_idle_call+0x9a/0xd0
 [<ffffffff803ed4e0>] cpuidle_idle_call+0x0/0xd0
 [<ffffffff80208d15>] cpu_idle+0x75/0xc0
 [<ffffffff8047535f>] rest_init+0x7f/0x90
 [<ffffffff8085f8ba>] start_kernel+0x2da/0x390
 [<ffffffff8085f119>] _sinittext+0x119/0x160

INFO: lockdep is turned off.
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208d4c>] .... cpu_idle+0xac/0xc0
.....[<ffffffff8047535f>] ..   ( <=3D rest_init+0x7f/0x90)
.. [<ffffffff8047935f>] .... __spin_lock_irqsave+0x2f/0x90
.....[<ffffffff804775ce>] ..   ( <=3D rt_spin_lock_slowunlock+0x1e/0x90)
.. [<ffffffff80478e79>] .... __spin_lock+0x19/0x70
.....[<ffffffff8022d8d6>] ..   ( <=3D task_rq_lock+0x56/0xa0)
.. [<ffffffff80236878>] .... panic+0x48/0x190
.....[<ffffffff8023afaa>] ..   ( <=3D do_exit+0xa0a/0xa20)

caller is rt_spin_lock_slowlock+0x99/0x220

Call Trace:
 [<ffffffff804766c1>] schedule+0x121/0x130
 [<ffffffff804777a9>] rt_spin_lock_slowlock+0x99/0x220
 [<ffffffff8047830d>] __rt_spin_lock+0x3d/0x50
 [<ffffffff804784e8>] rt_spin_lock+0x58/0x70
 [<ffffffff88093774>] :processor:acpi_idle_enter_c3+0x179/0x281
 [<ffffffff803ed57a>] cpuidle_idle_call+0x9a/0xd0
 [<ffffffff803ed4e0>] cpuidle_idle_call+0x0/0xd0
 [<ffffffff80208d15>] cpu_idle+0x75/0xc0
 [<ffffffff8086a54d>] start_secondary+0x27d/0x370

INFO: lockdep is turned off.
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208d4c>] .... cpu_idle+0xac/0xc0
.....[<ffffffff8086a54d>] ..   ( <=3D start_secondary+0x27d/0x370)

BUG: scheduling while atomic: swapper/0x00000002/0, CPU#1
INFO: lockdep is turned off.
irq event stamp: 58288
hardirqs last  enabled at (58287): [<ffffffff80259b9d>] trace_hardirqs_on+0=
xd/0x10
hardirqs last disabled at (58288): [<ffffffff80256ccd>] trace_hardirqs_off+=
0xd/0x10
softirqs last  enabled at (0): [<ffffffff80234223>] copy_process+0x513/0x18=
50
softirqs last disabled at (0): [<0000000000000000>] 0x0

Call Trace:
 [<ffffffff80231004>] __schedule_bug+0x64/0x70
 [<ffffffff80475f61>] thread_return+0x5ea/0xac9
 [<ffffffff8020b990>] show_trace+0x70/0x80
 [<ffffffff8024a6b9>] pid_task+0x9/0x40
 [<ffffffff804765db>] schedule+0x3b/0x130
 [<ffffffff804777a9>] rt_spin_lock_slowlock+0x99/0x220
 [<ffffffff8047830d>] __rt_spin_lock+0x3d/0x50
 [<ffffffff804784e8>] rt_spin_lock+0x58/0x70
 [<ffffffff88093774>] :processor:acpi_idle_enter_c3+0x179/0x281
 [<ffffffff803ed57a>] cpuidle_idle_call+0x9a/0xd0
 [<ffffffff803ed4e0>] cpuidle_idle_call+0x0/0xd0
 [<ffffffff80208d15>] cpu_idle+0x75/0xc0
 [<ffffffff8086a54d>] start_secondary+0x27d/0x370

INFO: lockdep is turned off.
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208d4c>] .... cpu_idle+0xac/0xc0
.....[<ffffffff8086a54d>] ..   ( <=3D start_secondary+0x27d/0x370)
.. [<ffffffff80475720>] .... __sched_text_start+0x20/0x277
.....[<ffffffff804765db>] ..   ( <=3D schedule+0x3b/0x130)


--=__Part486F9455.2__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCR2w2US9IMjhKSFlhekxhUVJBdnFMQUo5SStXajZsbkhwcEJQbVk0dkY5
RWZJUTBsdmRnQ2ZVM3IvCmpuOWxHYktqdktzR1prU3ZNTTcrUDNrPQo9QmZRYQotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__Part486F9455.2__=--
