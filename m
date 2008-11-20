From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Thu, 20 Nov 2008 12:44:51 -0200
Message-ID: <20081120144450.GL30491@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com> <20081120132544.GG30491@ghostprotocols.net> <20081120132910.GH30491@ghostprotocols.net> <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com> <20081120141926.GK30491@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41173 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538AbYKTOo5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Nov 2008 09:44:57 -0500
Content-Disposition: inline
In-Reply-To: <20081120141926.GK30491@ghostprotocols.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Another one, this time with more context:

(gdb) l *0xffffffff8105d5d9
0xffffffff8105d5d9 is in wakeup_next_waiter
(/home/acme/git/paulg-rt-linux-2.6/kernel/rtmutex_common.h:77).
72	{
73		struct rt_mutex_waiter *w;
74=09
75		w =3D plist_first_entry(&lock->wait_list, struct rt_mutex_waiter,
76				       list_entry);
77		BUG_ON(w->lock !=3D lock); <--------------------------
78=09
79		return w;
80	}
81=09
(gdb)

Linux version 2.6.27.5-26rt11 (acme@mica.ghostprotocols.net) (gcc versi=
on 4.1.2 20071124 (Red Hat 4.1.2-42)) #8
Command line: ro root=3DLABEL=3D/ rhgb console=3DttyS1,57600 console=3D=
tty0 idle=3Dpoll
KERNEL supported cpus:al.  Use ~? for help]
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
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 0, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 0, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec83000] gsi_base[128])
IOAPIC[2]: apic_id 10, version 0, address 0xfec83000, GSI 128-151
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HJ=EF=BF=BDACPI: Core revision 20080609
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
Using local APIC timer interrupts.
Detected 20.781 MHz APIC timer.
Booting processor 1/6 ip 6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3990.04 BogoMIPS (lpj=3D=
1995024)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/6 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2/1 ip 6000
Initializing CPU#2
Calibrating delay using timer specific routine.. 3990.05 BogoMIPS (lpj=3D=
1995027)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 2, old 0x7040600070406, new 0x7010600070106
CPU2: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3/7 ip 6000
Initializing CPU#3
Calibrating delay using timer specific routine.. 3990.05 BogoMIPS (lpj=3D=
1995027)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/7 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 3, old 0x7040600070406, new 0x7010600070106
CPU3: Intel(R) Xeon(R) CPU            5130  @ 2.00GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (15960.10 BogoMIPS).
net_namespace: 1712 bytes
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1 for base access
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: PME# disabled
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
pci 0000:00:04.0: PME# disabled
pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
pci 0000:00:05.0: PME# disabled
pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
pci 0000:00:06.0: PME# disabled
pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
pci 0000:00:07.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1d.7: PME it is
=46reeing initrd memory: 2388k freed
audit: initializing netlink socket (disabled)
type=3D2000 audit(1227191249.754:1): initialized
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
mice: PS/2 mouse device common for all mice
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, y3k, hpet irqs
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
registered taskstats version 1
=46reeing unused kernel memory: 496k freed
Write protecting the kernel read-only data: 4084k
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xfc800000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 21 (kjournald starting.  Commit=
 interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
type=3D1404 audit(1227191255.307:2): selinux=3D0 auid=3D4294967295 ses=3D=
4294967295
BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
40
IP: [<ffffffff8105d5d9>] wakeup_next_waiter+0x35/0x173
PGD 0=20
Oops: 0000 [1] PREEMPT SMP=20
CPU 3=20
Modules linked in: megaraid_sas sd_mod scsi_mod ext3 jbd mbcache uhci_h=
cd ohci_hcd ehci_hcd
Pid: 733, comm: udevd Not tainted 2.6.27.5-26rt11 #2
RIP: 0010:[<ffffffff8105d5d9>]  [<ffffffff8105d5d9>] wakeup_next_waiter=
+0x35/0x173
RSP: 0018:ffff88012d65db18  EFLAGS: 00010097
RAX: 0000000000006464 RBX: ffff880028070920 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88012d65ac48
RBP: ffff88012d65db48 R08: ffff88012fb6926c R09: ffff88012d65dac8
R10: ffff88012c519be8 R11: 0000000000000002 R12: ffff880028070920
R13: ffffffffffffffe8 R14: 0000000000000001 R15: ffff88012d60ec38
=46S:  00007f0ad6817710(0000) GS:ffff88012fb691c0(0000) knlGS:000000000=
0000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 000000012dced000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process udevd (pid: 733, threadinfo ffff88012d65c000, task ffff88012d65=
a5c0)
Stack:  0000000000000000 ffff880028070920 0000000000000203 000000000000=
0001
 ffff88012e1c2980 ffff88012d60ec38 ffff88012d65db68 ffffffff812af932
 ffff880028070960 0000000000000008 ffff88012d65db78 ffffffff812b0ba4
Call Trace:
 [<ffffffff812af932>] rt_spin_lock_slowunlock+0x3e/0x5c
 [<ffffffff812b0ba4>] __lock_text_start+0x44/0x46
 [<ffffffff8109b86a>] exit_mmap+0x12e/0x15d
 [<ffffffff81039823>] mmput+0x2d/0xa8
 [<ffffffff810bc7dc>] flush_old_exec+0x465/0x793
 [<ffffffff810ebd9f>] load_elf_binary+0x382/0x1759
 [<ffffffff8105dfc1>] ? rt_mutex_adjust_prio+0x35/0x3e
 [<ffffffff812afe00>] ? rt_read_slowunlock+0x3f9/0x431
 [<ffffffff810eba1d>] ? load_elf_binary+0x0/0x1759
 [<ffffffff8105ec9d>] ? rt_rwlock_read_unlock+0x28d/0x296
 [<ffffffff810eba1d>] ? load_elf_binary+0x0/0x1759
 [<ffffffff810bb7dd>] search_binary_handler+0x105/0x2c4
 [<ffffffff810eb0ac>] ? load_script+0x0/0x1c4
 [<ffffffff810eb25a>] load_script+0x1ae/0x1c4
 [<ffffffff812afe00>] ? rt_read_slowunlock+0x3f9/0x431
 [<ffffffff810eb0ac>] ? load_script+0x0/0x1c4
 [<ffffffff8105ec9d>] ? rt_rwlock_read_unlock+0x28d/0x296
 [<ffffffff810bb7dd>] search_binary_handler+0x105/0x2c4
 [<ffffffff810bcc88>] do_execve+0x17e/0x227
 [<ffffffff8100a556>] sys_execve+0x3e/0x59
 [<ffffffff8100c73a>] stub_execve+0x6a/0xc0


Code: f6 41 55 41 54 49 89 fc 53 48 83 ec 08 65 48 8b 3c 25 00 00 00 00=
 48 81 c7 88 06 00 00 e8 b0 38 25 00 4d=20
RIP  [<ffffffff8105d5d9>] wakeup_next_waiter+0x35/0x173
 RSP <ffff88012d65db18>
CR2: 0000000000000040
---[ end trace ccd0141168105e57 ]---
------------[ cut here ]------------
kernel BUG at /home/acme/git/paulg-rt-linux-2.6/kernel/rtmutex.c:831!
invalid opcode: 0000 [2] PREEMPT SMP=20
CPU 0=20
Modules linked in: megaraid_sas sd_mod scsi_mod ext3 jbd mbcache uhci_h=
cd ohci_hcd ehci_hcd
Pid: 919, comm: udev_run_devd Tainted: G      D   2.6.27.5-26rt11 #2
RIP: 0010:[<ffffffff812b062e>]  [<ffffffff812b062e>] rt_spin_lock_slowl=
ock+0x69/0x235
RSP: 0018:ffff88012ad7fc08  EFLAGS: 00010046
RAX: ffff88012ad7c540 RBX: ffff880028061920 RCX: 0000000000000000
RDX: ffff88012ad7c540 RSI: 0000000000000292 RDI: ffff880028061920
RBP: ffff88012ad7fcb8 R08: ffff88012fc02cec R09: 000000000002b28a
R10: 0000000000000000 R11: 0000000000000002 R12: ffff880028061920
R13: ffffffff81578960 R14: ffff88012acf0c38 R15: 00007fffffffe000
=46S:  00007f0ad6817710(0000) GS:ffffffff814eb100(0000) knlGS:000000000=
0000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007f0ad61b0190 CR3: 000000012accc000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDCall Trace:
 [<ffffffff8109e747>] ? move_page_tables+0x39f/0x53a
 [<ffffffff812b0c04>] __rt_spin_lock+0x5e/0x62
 [<ffffffff812b0c11>] rt_spin_lock+0x9/0xb
 [<ffffffff810bc0c7>] setup_arg_pages+0x1d5/0x301
 [<ffffffff810ebf0a>] load_elf_binary+0x4ed/0x1759
 [<ffffffff8105ebea>] ? rt_rwlock_read_unlock+0x1da/0x296
 [<ffffffff810eba1d>] ? load_elf_binary+0x0/0x1759
 [<ffffffff810bb7dd>] search_binary_handler+0x105/0x2c4
 [<ffffffff810bcc88>] do_execve+0x17e/0x227
 [<ffffffff8100a556>] sys_execve+0x3e/0x59
 [<ffffffff8100c73a>] stub_execve+0x6a/0xc0


Code: 08 49 89 44 24 08 49 8d 44 24 18 49 89 44 24 18 48 89 40 08 49 8b=
 44 24 28 65 48 8b 14 25 00 00 00 00 48=20
RIP  [<ffffffff812b062e>] rt_spin_lock_slowlock+0x69/0x235
 RSP <ffff88012ad7fc08>
---[ end trace ccd0141168105e57 ]---
note: udev_run_devd[919] exited with preempt_count 1
BUG: scheduling with irqs disabled: udev_run_devd/0x00000001/919
caller is rt_read_slowlock+0x2e9/0x32c
Pid: 919, comm: udev_run_devd Tainted: G      D   2.6.27.5-26rt11 #2

Call Trace:
 [<ffffffff812aec76>] schedule+0x73/0xf0
 [<ffffffff8105f521>] rt_read_slowlock+0x2e9/0x32c
 [<ffffffff8105f22f>] rt_mutex_down_read+0x178/0x181
 [<ffffffff8105f8f8>] __rt_down_read+0x9/0xb
 [<ffffffff8105f910>] rt_down_read+0xb/0xd
 [<ffffffff810698a8>] acct_collect+0x4c/0x19d
 [<ffffffff8103f3e6>] do_exit+0x1d1/0x88e
 [<ffffffff811b2ec0>] ? do_unblank_screen+0xf/0x10b
 [<ffffffff812b1a8d>] oops_begin+0x0/0x7c
 [<ffffffff8100e2f3>] die+0x5d/0x66
 [<ffffffff812b1f75>] do_trap+0x110/0x11f
 [<ffffffff8100e88f>] do_invalid_op+0xa0/0xa9
 [<ffffffff812b062e>] ? rt_spin_lock_slowlock+0x69/0x235
 [<ffffffff8108caf0>] ? __alloc_pages_internal+0xcb/0x3ab
 [<ffffffff812b156a>] error_exit+0x0/0x70
 [<ffffffff812b062e>] ? rt_spin_lock_slowlock+0x69/0x235
 [<ffffffff812b05f0>] ? rt_spin_lock_slowlock+0x2b/0x235
 [<ffffffff8109e747>] ? move_page_tables+0x39f/0x53a
 [<ffffffff812b0c04>] __rt_spin_lock+0x5e/0x62
 [<ffffffff812b0c11>] rt_spin_lock+0x9/0xb
 [<ffffffff810bc0c7>] setup_arg_pages+0x1d5/0x301
 [<ffffffff810ebf0a>] load_elf_binary+0x4ed/0x1759
 [<ffffffff8105ebea>] ? rt_rwlock_read_unlock+0x1da/0x296
 [<ffffffff810eba1d>] ? load_elf_binary+0x0/0x1759
 [<ffffffff810bb7dd>] search_binary_handler+0x105/0x2c4
 [<ffffffff810bcc88>] do_execve+0x17e/0x227
 [<ffffffff8100a556>] sys_execve+0x3e/0x59
 [<ffffffff8100c73a>] stub_execve+0x6a/0xc0

BUG: scheduling while atomic: udev_run_devd/0x00000002/919, CPU#0
Modules linked in: megaraid_sas sd_mod scsi_mod ext3 jbd mbcache uhci_h=
cd ohci_hcd ehci_hcd
Pid: 919, comm: udev_run_devd Tainted: G      D   2.6.27.5-26rt11 #2

Call Trace:
 [<ffffffff810342f1>] __schedule_bug+0x71/0x76
 [<ffffffff812ae3e4>] __schedule+0xdf/0x76e
 [<ffffffff8100df96>] ? show_trace_log_lvl+0x61/0x6d
 [<ffffffff8100e391>] ? show_trace+0x10/0x12
 [<ffffffff8100e66b>] ?=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
