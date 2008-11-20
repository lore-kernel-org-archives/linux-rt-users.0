From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 11:25:44 -0200
Message-ID: <20081120132544.GG30491@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47310 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbYKTNZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 08:25:57 -0500
Content-Disposition: inline
In-Reply-To: <20081110234740.GB18819@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Mon, Nov 10, 2008 at 06:47:40PM -0500, Paul Gortmaker escreveu:
> I've updated from the 2.6.27-rc8 patch series based on 26rt9 to be
> based on 2.6.27.5 kernel.org and 26rt11 preempt_rt.
>=20
> I've done a successful boot to X11 on basic old P4 and it survived a
> make -j20 of kernel.org git.  There is still work to be done in order=
 to
> stabilize more complex hardware (e.g. SMP etc) -- but I see this stil=
l

I hit one, DELL PE1900, dual dual core xeon, megasas disk controler,
bnx2 NIC:

ipmitool> sol activate
[SOL Session operational.  Use ~? for help]
Initializing cgroup subsys cpuset
Linux version 2.6.27.5-26rt11 (acme@mica.ghostprotocols.net) (gcc
version 4.1.2 20071124 (Red Hat 4.1.2-42)) #1 SMP PREEMPT RT Thu Nov 20
10:51:37 BRST 2008
Command line: ro root=3DLABEL=3D/ rhgb console=3DttyS1,57600 console=3D=
tty0
idle=3Dpoll
KERNEL supported cpus:
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
RAMDISK: 37d9a000 - 37fef0ed
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
  #3 [0037d9a000 - 0037fef0ed]          RAMDISK =3D=3D> [0037d9a000 - 0=
037fef0ed]
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
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 0, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9,H=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=02=D1=95=EF=BF=
=BD=EF=BF=BDExtended CMOS year: 2000
TSC: PIT calibration confirmed by PMTIMER.
TSC: using PIT calibration value
Detected 1994.981 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS1] enabled
Checking aperture...
No AGP bridge found
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x20000000 - 0x24000000
Memory: 4009156k/4980736k available (2784k kernel code, 184412k
reserved, 1650k data, 496k init)
Calibrating delay loop (skipped), value calculated using timer
frequency.. 3989.96 BogoMIPS (lpj=3D1994981)
BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
08
IP: [<ffffffff8151d8b8>] fork_init+0xba/0xd2 PGD 0=20
Oops: 0000 [1] PREEMPT SMP=20
CPU 0=20
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.27.5-26rt11 #1
RIP: 0010:[<ffffffff8151d8b8>]  [<ffffffff8151d8b8>] fork_init+0xba/0xd=
2
RSP: 0018:ffffffff814fff08  EFLAGS: 00010206
RAX: ffffffff8157caf0 RBX: 0000000000130000 RCX: 0000000000000048
RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffffffff815cfc48
RBP: ffffffff814fff18 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000002 R12: 4ec4ec4ec4ec4ec5
R13: ffffffff81535d80 R14: ffffffff815381c0 R15: 0000000000000000
=46S:  0000000000000000(0000) GS:ffffffff814eb100(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000201000 CR4: 00000000000006a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 0, threadinfo ffffffff814fe000, task ffffffff8140=
64a0)
Stack:  ffffffff814fff18 0000000000000000 ffffffff814fff58
ffffffff81506cf6
 ffffffff814fff58 ffffffff815381c0 0000000000854520 ffffffff81506140
 0000000000093390 0000000000000000 ffffffff814fff78 ffffffff815062a3
Call Trace:
 [<ffffffff81506cf6>] start_kernel+0x34c/0x3d1
 [<ffffffff81506140>] ? early_idt_handler+0x0/0x72
 [<ffffffff815062a3>] x86_64_start_reservations+0xa9/0xad
 [<ffffffff815063c5>] x86_64_start_kernel+0xfb/0x106


Code: 48 89 90 e0 02 00 00 48 8b 90 98 02 00 00 48 89 90 e8 02 00 00 48
8b 15 9f da fc ff 48 c7 c0 f0 ca 57 81 48 8b 14 0a 48 83 c1 08 <48> 03
42 08 48 81 f9 00 02 00 00 48 89 00 48 89 40 08 75 d6 5b=20
RIP  [<ffffffff8151d8b8>] fork_init+0xba/0xd2
 RSP <ffffffff814fff08>
CR2: 0000000000000008
---[ end trace 4eaa2a86a8e2da22 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Pid: 0, comm: swapper Tainted: G      D   2.6.27.5-26rt11 #1

Call Trace:
 [<ffffffff8103c1fb>] panic+0xaf/0x167
 [<ffffffff811a25c4>] ? account+0xd8/0xe7
 [<ffffffff8100c95a>] ? retint_restore_args+0x13/0x20
 [<ffffffff81054606>] ? blocking_notifier_call_chain+0xf/0x11
 [<ffffffff8103f28d>] do_exit+0x78/0x88e
 [<ffffffff811a2775>] ? get_random_bytes+0x1b/0x1d
 [<ffffffff812b1a8d>] oops_begin+0x0/0x7c
 [<ffffffff812b3f98>] do_page_fault+0x9e5/0xaa8
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
