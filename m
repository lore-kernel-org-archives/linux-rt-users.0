From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 12:19:26 -0200
Message-ID: <20081120141926.GK30491@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com> <20081120132544.GG30491@ghostprotocols.net> <20081120132910.GH30491@ghostprotocols.net> <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60424 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbYKTOTe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 09:19:34 -0500
Content-Disposition: inline
In-Reply-To: <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Thu, Nov 20, 2008 at 02:43:09PM +0100, Alessio Igor Bogani escreveu:
> Dear Sir Carvalho de Melo,
>=20
> 2008/11/20 Arnaldo Carvalho de Melo <acme@redhat.com>:
> [...]
> >> I hit one, DELL PE1900, dual dual core xeon, megasas disk controle=
r,
> [...]
> >> BUG: unable to handle kernel NULL pointer dereference at 000000000=
0000008
> [...]
>=20
> Could you try this patch, please?
>=20
> Thanks!
>=20
> Ciao,
> Alessio
>=20
> Index: linux-source-2.6.27/kernel/fork.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-source-2.6.27.orig/kernel/fork.c  2008-11-11 10:50:21.00000=
0000 +0100
> +++ linux-source-2.6.27/kernel/fork.c   2008-11-11 10:50:40.000000000=
 +0100
> @@ -229,7 +229,7 @@
>     init_task.signal->rlim[RLIMIT_SIGPENDING] =3D
>         init_task.signal->rlim[RLIMIT_NPROC];
>=20
> -   for (i =3D 0; i < NR_CPUS; i++)
> +   for (i =3D 0; i < nr_cpu_ids; i++)
>         INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
>  }

Wouldn't it be better to use for_each_possible_cpu()? But yes, it fixes
this problem, we go further then die with:

                                                    F2 =3D Setup
Phoenix ROM BIOS PLUS Version 1.10 1.2.0            F10 =3D Utility Mod=
e
Copyright 1985-1988 Phoenix Technologies Ltd.       F11 =3D Boot Menu
Copyright 1990-2006 Dell Inc.                       F12 =3D PXE Boot
All Rights Reserved

Dell System PowerEdge 1900
www.dell.com


Two 2.00 GHz Dual-core Processors, Bus Speed: 1333 MHz, L2 Cache: 4 MB

System Memory Size: 4.0 GB, System Memory Speed: 533 MHz


PowerEdge Expandable RAID Controller BIOS
Copyright(c) 2006 LSI Logic Corporation
Press <Ctrl><R> to Run Configuration Utility

HA -0 (Bus 2 Dev 14) PERC 5/i Integrated
=46W package: 5.1.1-0040
  Booting 'Red Hat Enterprise Linux (realtime) (2.6.27.5-26rt11)'
1 Logical Drive(s) found on the host adapter.
rootg(hd0,0)ive(s) handled by BIOS
 Filesystem type is ext2fs, part  ion type 0x83
kernel /vmlinuz-2.6.27.5-26rt11 ro root=3DLABEL=3D/ rhgb console=3DttyS=
1,57600
consol
e=3Dtty0 idle=3Dpollnfiguration Utility 1.03
   [Linux-bzImage, setup=3D0x3000, size=3D0x2vdb30]
initrd /initrd-2.6.27.5-26rt11.img
Bas[Linux-initrdm@n0x37d9a000,r0x2550f3nbytes]
                          =20
                      =20
Initializing cgroup subsys cpuset
Linux version 2.6.27.5-26rt11 (acme@mica.ghostprotocols.net) (gcc
version 4.1.2 2007118
Command line: ro root=3DLABEL=3D/ rhgb console=3DttyS1,57600 console=3D=
tty0
idle=3Dpoll
KERNEL supported cpus:ote Access Setup within 5 sec......
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 00000000cffa8000 (usable)
 BIOS-e820: 00000000cffa8000 - 00000000cffb7c00 (ACPI data)
 BIOS-e820: 00000000cffb7c00 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fe000000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
using polling idle threads.
last_pfn =3D 0x130000 max_arch_pfn =3D 0x3ffffffff
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
last_pfn =3D 0xcffa8 max_arch_pfn =3D 0x3ffffffff
init_memory_mapping
last_map_addr: cffa8000 end: cffa8000
init_memory_mapping
last_map_addr: 130000000 end: 130000000
RAMDISK: 37d9a000 - 37fef0f3
DMI 2.4 present.
ACPI: RSDP 000F2900, 0024 (r2 DELL  )
ACPI: XSDT 000F2980, 004C (r1 DELL   PE_SC3          1 DELL        1)
ACPI: FACP 000F2A88, 00F4 (r3 DELL   PE_SC3          1 DELL        1)
ACPI: DSDT CFFA8000, 2A90 (r1 DELL   PE_SC3          1 MSFT  100000E)
ACPI: FACS CFFB7C00, 0040
ACPI: APIC 000F2B7C, 00D4 (r1 DELL   PE_SC3          1 DELL        1)
ACPI: SPCR 000F2C5D, 0050 (r1 DELL   PE_SC3          1 DELL        1)
ACPI: HPET 000F2CAD, 0038 (r1 DELL   PE_SC3          1 DELL        1)
ACPI: MCFG 000F2CE5, 003C (r1 DELL   PE_SC3          1 DELL        1)
ACPI: DMI detected: Dell PE 1900
No NUMA configuration found
=46aking a node at 0000000000000000-0000000130000000
Bootmem setup node 0 0000000000000000-0000000130000000
  NODE_DATA [0000000000001000 - 0000000000005fff]
  bootmap [000000000000d000 -  0000000000032fff] pages 26
(7 early reservations) =3D=3D> bootmem [0000000000 - 0130000000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 0=
000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> [0000006000 - 0=
000008000]
  #2 [0000200000 - 0000854520]    TEXT DATA BSS =3D=3D> [0000200000 - 0=
000854520]
  #3 [0037d9a000 - 0037fef0f3]          RAMDISK =3D=3D> [0037d9a000 - 0=
037fef0f3]
  #4 [000009f000 - 0000100000]    BIOS reserved =3D=3D> [000009f000 - 0=
000100000]
  #5 [0000008000 - 000000c000]          PGTABLE =3D=3D> [0000008000 - 0=
00000c000]
  #6 [000000c000 - 000000d000]          PGTABLE =3D=3D> [000000c000 - 0=
00000d000]
found SMP MP-table at [ffff8800000fe710] 000fe710
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00130000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x000000a0
    0: 0x00000100 -> 0x000cffa8
    0: 0x00100000 -> 0x00130000
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000]
gsi_bas=EF=BF=BD5%=EF=BF=BDe%B=CD=89=EF=BF=BD=EF=BF=BD}=EF=BF=BD=EF=BF=BD=
=C5=9D=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD}=EF=BF=BD=EF=BF=BD=C5=
=91=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDACPI:)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 8 CPUs, 4 hotplug CPUs
PM: Registered nosave memory: 00000000000a0000 - 0000000000100000
PM: Registered nosave memory: 00000000cffa8000 - 00000000cffb7000
PM: Registered nosave memory: 00000000cffb7000 - 00000000cffb8000
PM: Registered nosave memory: 00000000cffb8000 - 00000000d0000000
PM: Registered nosave memory: 00000000d0000000 - 00000000e0000000
PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
PM: Registered nosave memory: 00000000f0000000 - 00000000fe000000
PM: Registered nosave memory: 00000000fe000000 - 0000000100000000
Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
PERCPU: Allocating 57988 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Node order, mobility grouping on.  Total pages:
1015049
Policy zone: Normal
Kernel command line: ro root=3DLABEL=3D/ rhgb console=3DttyS1,57600
console=3Dtty0 idle=3Dpoll
Initializing CPU#0
Preemptible RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
TSC: PIT calibration confirmed by PMTIMER.
TSC: using PIT calibration value
Detected 1994.983 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS1] enabled
Checking aperture...
No AGP bridge found
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x20000000 - 0x24000000
Memory: 4009156k/4980736k available (2784k kernel code, 184412k
reserved, 1650k data, )
Calibrating delay loop (skipped), value calculated using timer
frequency.. 3989.96 Bog)
Security Framework initialized
SELinux:  Initializing.
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
ACPI: Core revision 20080609
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
Using local APIC timer interrupts.
Detected 20.781 MHz APIC timer.
Booting processor 1/6 ip 6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3990.04 BogoMIPS
(lpj=3D1995024)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/6 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) X=EF=BF=BDbus: 0d index 1 mmio: [0, 0]
bus: 0d index 2 mmio: [0, 0]
bus: 0d index 3 mmio: [0, 0]
bus: 0e index 0 mmio: [0, 0]
bus: 0e index 1 mmio: [0, 0]
bus: 0e index 2 mmio: [0, 0]
bus: 0e index 3 mmio: [0, 0]
bus: 04 index 0 mmio: [0, 0]
bus: 04 index 1 mmio: [f8000000, fbffffff]
bus: 04 index 2 mmio: [0, 0]
bus: 04 index 3 mmio: [0, 0]
bus: 05 index 0 mmio: [0, 0]
bus: 05 index 1 mmio: [f8000000, fbffffff]
bus: 05 index 2 mmio: [0, 0]
bus: 05 index 3 mmio: [0, 0]
bus: 0f index 0 io port: [e000, efff]
bus: 0f index 1 mmio: [fc100000, fc2fffff]
bus: 0f index 2 mmio: [d0000000, d7ffffff]
bus: 0f index 3 io port: [0, ffff]
bus: 0f index 4 mmio: [0, ffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
=46reeing initrd memory: 2388k freed
audit: initializing netlink socket (disabled)
type=3D2000 audit(1227190309.758:1): initialized
krcupreemptd setsched 0
  prio =3D 98
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 7835
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport-driver 0000:00:02.0: found MSI capability
pcieport-driver 0000:00:03.0: found MSI capability
pcieport-driver 0000:00:04.0: found MSI capability
pcieport-driver 0000:00:05.0: found MSI capability
pcieport-driver 0000:00:06.0: found MSI capability
pcieport-driver 0000:00:07.0: found MSI capability
pcieport-driver 0000:00:1c.0: found MSI capability
pcieport-driver 0000:07:00.0: found MSI capability
pcieport-driver 0000:07:01.0: found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
processor ACPI0007:00: registered as cooling_device0
processor ACPI0007:01: registered as cooling_device1
processor ACPI0007:02: registered as cooling_device2
processor ACPI0007:03: registered as cooling_device3
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=EF=BF=BDserial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
brd: module loaded
input: Macintosh mouse button emulation as /class/input/input0
usbcore: registered new interface driver libusual
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device cSCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
megasas: 00.00.04.01 Thu July 24 11:41:51 PST 2008
megasas: 0x1028:0x0015:0x1028:0x1f03: bus 2:slot 14:func 0
megaraid_sas 0000:02:0e.0: PCI INT A -> GSI 142 (level, low) -> IRQ 142
megasas: FW now in Ready state
scsi0 : LSI SAS based MegaRAID driver
scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K5_073SAS BP00 PQ: 0 AN=
SI: 5
scsi 0:0:3:0: Direct-Access     MAXTOR   ATLAS10K5_073SAS BP00 PQ: 0 AN=
SI: 5
scsi 0:2:0:0: Direct-Access     DELL     PERC 5/i         1.03 PQ: 0 AN=
SI: 5
sd 0:2:0:0: [sda] 284164096 512-byte hardware sectors (145492 MB)
sd 0:2:0:0: [sda] Write Protect is off
sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled, supports =
DPO and FUA
sd 0:2:0:0: [sda] 284164096 512-byte hardware sectors (145492 MB)
sd 0:2:0:0: [sda] Write Protect is off
sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled, supports =
DPO and FUA
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:2:0:0: [sda] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
type=3D1404 audit(1227190315.328:2): selinux=3D0 auid=3D4294967295
ses=3D4294967295
Bad page state in process 'modprobe'
page:ffffe20007966a88 flags:0x0200000000000008 mapping:0000000000000000
mapcount:0 cou1
Bad page sta


---------------------
Truncated output over serial+ipmi, investigating...

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
