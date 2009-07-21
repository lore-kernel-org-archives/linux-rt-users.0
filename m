From: =?ISO-8859-15?Q?Jens_D=F6ring?= <j.doering@systektum.de>
Subject: geode-mfgpt oops 2.6.29.6-rt23
Date: Tue, 21 Jul 2009 17:57:10 +0200
Message-ID: <4A65E556.4050007@systektum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070206030307070502010105"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:52053 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZGUP5M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Jul 2009 11:57:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070206030307070502010105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

I noticessed the following oops on 2.6.29.6 with -rt23 patch. without 
the patch anything is fine.

[    0.593279] geode-mfgpt:  3 MFGPT timers available.
[    0.651678] geode-mfgpt:  Registered timer 0
[    0.702818] mfgpt-timer:  Registering MFGPT timer 0 as a clock event, 
using IRQ 11
[    0.797051] PCI: PCI BIOS revision 2.10 entry at 0xff8b7, last bus=0
[    0.800000] BUG: unable to handle kernel NULL pointer dereference at 
00000034
[    0.800000] IP: [<c0233d54>] tick_periodic+0x59/0x6d
[    0.800000] *pde = 00000000
[    0.800000] Oops: 0000 [#1] PREEMPT
[    0.800000] last sysfs file:
[    0.800000] Modules linked in:
[    0.800000]
[    0.800000] Pid: 19, comm: IRQ-11 Not tainted (2.6.29.6-rt23 #8)
[    0.800000] EIP: 0060:[<c0233d54>] EFLAGS: 00010246 CPU: 0
[    0.800000] EIP is at tick_periodic+0x59/0x6d
[    0.800000] EAX: 00000000 EBX: 00006206 ECX: 2faf0824 EDX: ffff8b20
[    0.800000] ESI: 00000000 EDI: c051c4a0 EBP: 00000000 ESP: ce041f78
[    0.800000]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 
preempt:00000001
[    0.800000] Process IRQ-11 (pid: 19, ti=ce041000 task=ce03a7f0 
task.ti=ce041000)
[    0.800000] Stack:
[    0.800000]  c0233d74 00006206 00000000 0000000b c0213339 c051c460 
c023d43a 0000000b
[    0.800000]  00000000 c051f650 0000000b 0000000b c051c460 c023d7bb 
c051f650 0000000b
[    0.800000]  00000000 00000246 c023dd44 00000032 c051f650 c023dcb4 
00000000 00000000
[    0.800000] Call Trace:
[    0.800000]  [<c0233d74>] ? tick_handle_periodic+0xc/0x60
[    0.800000]  [<c0213339>] ? mfgpt_tick+0x89/0x90
[    0.800000]  [<c023d43a>] ? handle_IRQ_event+0x3f/0xad
[    0.800000]  [<c023d7bb>] ? thread_simple_irq+0x3a/0x72
[    0.800000]  [<c023dd44>] ? do_irqd+0x90/0x23e
[    0.800000]  [<c023dcb4>] ? do_irqd+0x0/0x23e
[    0.800000]  [<c022c0eb>] ? kthread+0x38/0x5d
[    0.800000]  [<c022c0b3>] ? kthread+0x0/0x5d
[    0.800000]  [<c0202f43>] ? kernel_thread_helper+0x7/0x10
[    0.800000] Code: c0 b8 01 00 00 00 e8 ad 09 ff ff ff 05 40 31 5c c0 
89 e0 25 00 f0 ff ff ff 48 14 f6 40 08 08 74 05 e8 39 84 20 00 a1 e8 92 
51 c0 <8b> 40 34 83 e0 03 83 f8 03 0f 94 c0 0f b6 c0 e9 22 0c ff ff 57
[    0.800000] EIP: [<c0233d54>] tick_periodic+0x59/0x6d SS:ESP 
0068:ce041f78
[    0.800000] CR2: 0000000000000034
[    0.800000] ---[ end trace 4eaa2a86a8e2da22 ]---


any ideas?

the system is AMD LX800 with CS5536 PC-104

attached the bootlog.

-- 

Mit freundlichen Grüßen

Jens Döring




--------------070206030307070502010105
Content-Type: text/plain;
 name="log_MFGPT_IRQ11.TXT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log_MFGPT_IRQ11.TXT"

[    0.000000] Linux version 2.6.29.6-rt23 (root@Gentoo-LX800) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)) #8 PREEMPT RT Mon Jul 20 09:45:15 CEST 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000e7c0000 (usable)
[    0.000000]  BIOS-e820: 0000000080400000 - 0000000080440004 (reserved)
[    0.000000]  BIOS-e820: 00000000f0000000 - 0000000100000000 (reserved)
[    0.000000] DMI not present or invalid.
[    0.000000] last_pfn = 0xe7c0 max_arch_pfn = 0x100000
[    0.000000] init_memory_mapping: 0000000000000000-000000000e7c0000
[    0.000000] ACPI Error (tbxfroot-0219): A valid RSDP was not found [20081204]
[    0.000000] 231MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 0e7c0000
[    0.000000]   low ram: 0 - 0e7c0000
[    0.000000]   node 0 low ram: 00000000 - 0e7c0000
[    0.000000]   node 0 bootmap 00001000 - 00002cf8
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 000e7c0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000200000 - 00005d9634]    TEXT DATA BSS ==> [0000200000 - 00005d9634]
[    0.000000]   #2 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #3 [00005da000 - 00005dc000]              BRK ==> [00005da000 - 00005dc000]
[    0.000000]   #4 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
[    0.000000]   #5 [0000001000 - 0000003000]          BOOTMAP ==> [0000001000 - 0000003000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0000e7c0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0000e7c0
[    0.000000] Using APIC driver default
[    0.000000] No local APIC present or hardware disabled
[    0.000000] Allocating PCI resources starting at 10000000 (gap: e7c0000:71c40000)
[    0.000000] Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 58767
[    0.000000] Kernel command line: console=ttyS0 root=/dev/hda3
[    0.000000] Initializing CPU#0
[    0.000000] Preemptible RCU implementation.
[    0.000000] NR_IRQS:288
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 498.018 MHz processor.
[    0.010000] Console: colour VGA+ 80x25
[    0.010000] console [ttyS0] enabled
[    0.010000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.010000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.010000] Memory: 230660k/237312k available (2295k kernel code, 6096k reserved, 1108k data, 248k init, 0k highmem)
[    0.010000] virtual kernel memory layout:
[    0.010000]     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
[    0.010000]     vmalloc : 0xcefc0000 - 0xfffa8000   ( 783 MB)
[    0.010000]     lowmem  : 0xc0000000 - 0xce7c0000   ( 231 MB)
[    0.010000]       .init : 0xc0554000 - 0xc0592000   ( 248 kB)
[    0.010000]       .data : 0xc043de87 - 0xc0552f58   (1108 kB)
[    0.010000]       .text : 0xc0200000 - 0xc043de87   (2295 kB)
[    0.010000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.010016] Calibrating delay loop (skipped), value calculated using timer frequency.. 996.03 BogoMIPS (lpj=4980180)
[    0.136378] Mount-cache hash table entries: 512
[    0.190998] CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
[    0.276411] CPU: L2 Cache: 128K (32 bytes/line)
[    0.330601] CPU: Geode(TM) Integrated Processor by AMD PCS stepping 02
[    0.408990] Checking 'hlt' instruction... OK.
[    0.497058] net_namespace: 960 bytes
[    0.540038] NET: Registered protocol family 16
[    0.593279] geode-mfgpt:  3 MFGPT timers available.
[    0.651678] geode-mfgpt:  Registered timer 0
[    0.702818] mfgpt-timer:  Registering MFGPT timer 0 as a clock event, using IRQ 11
[    0.797051] PCI: PCI BIOS revision 2.10 entry at 0xff8b7, last bus=0
[    0.800000] BUG: unable to handle kernel NULL pointer dereference at 00000034
[    0.800000] IP: [<c0233d54>] tick_periodic+0x59/0x6d
[    0.800000] *pde = 00000000 
[    0.800000] Oops: 0000 [#1] PREEMPT 
[    0.800000] last sysfs file: 
[    0.800000] Modules linked in:
[    0.800000] 
[    0.800000] Pid: 19, comm: IRQ-11 Not tainted (2.6.29.6-rt23 #8) 
[    0.800000] EIP: 0060:[<c0233d54>] EFLAGS: 00010246 CPU: 0
[    0.800000] EIP is at tick_periodic+0x59/0x6d
[    0.800000] EAX: 00000000 EBX: 00006206 ECX: 2faf0824 EDX: ffff8b20
[    0.800000] ESI: 00000000 EDI: c051c4a0 EBP: 00000000 ESP: ce041f78
[    0.800000]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 preempt:00000001
[    0.800000] Process IRQ-11 (pid: 19, ti=ce041000 task=ce03a7f0 task.ti=ce041000)
[    0.800000] Stack:
[    0.800000]  c0233d74 00006206 00000000 0000000b c0213339 c051c460 c023d43a 0000000b
[    0.800000]  00000000 c051f650 0000000b 0000000b c051c460 c023d7bb c051f650 0000000b
[    0.800000]  00000000 00000246 c023dd44 00000032 c051f650 c023dcb4 00000000 00000000
[    0.800000] Call Trace:
[    0.800000]  [<c0233d74>] ? tick_handle_periodic+0xc/0x60
[    0.800000]  [<c0213339>] ? mfgpt_tick+0x89/0x90
[    0.800000]  [<c023d43a>] ? handle_IRQ_event+0x3f/0xad
[    0.800000]  [<c023d7bb>] ? thread_simple_irq+0x3a/0x72
[    0.800000]  [<c023dd44>] ? do_irqd+0x90/0x23e
[    0.800000]  [<c023dcb4>] ? do_irqd+0x0/0x23e
[    0.800000]  [<c022c0eb>] ? kthread+0x38/0x5d
[    0.800000]  [<c022c0b3>] ? kthread+0x0/0x5d
[    0.800000]  [<c0202f43>] ? kernel_thread_helper+0x7/0x10
[    0.800000] Code: c0 b8 01 00 00 00 e8 ad 09 ff ff ff 05 40 31 5c c0 89 e0 25 00 f0 ff ff ff 48 14 f6 40 08 08 74 05 e8 39 84 20 00 a1 e8 92 51 c0 <8b> 40 34 83 e0 03 83 f8 03 0f 94 c0 0f b6 c0 e9 22 0c ff ff 57 
[    0.800000] EIP: [<c0233d54>] tick_periodic+0x59/0x6d SS:ESP 0068:ce041f78
[    0.800000] CR2: 0000000000000034
[    0.800000] ---[ end trace 4eaa2a86a8e2da22 ]---
[    0.800000] PCI: Using configuration type 1 for base access
[    0.800000] bio: create slab <bio-0> at 0
[    0.800000] ACPI: Interpreter disabled.
[    0.800000] SCSI subsystem initialized
[    0.800000] libata version 3.00 loaded.
[    0.800000] usbcore: registered new interface driver usbfs
[    0.800000] usbcore: registered new interface driver hub
[    0.800000] usbcore: registered new device driver usb
[    0.800000] PCI: Probing PCI hardware
[    0.800000] PCI: Probing PCI hardware (bus 00)
[    0.800000] pci 0000:00:01.0: reg 10 io port: [0xac1c-0xac1f]
[    0.800000] pci 0000:00:01.1: reg 10 32bit mmio: [0x90000000-0x91ffffff]
[    0.800000] pci 0000:00:01.1: reg 14 32bit mmio: [0x8fffc000-0x8fffffff]
[    0.800000] pci 0000:00:01.1: reg 18 32bit mmio: [0x8fff8000-0x8fffbfff]
[    0.800000] pci 0000:00:01.1: reg 1c 32bit mmio: [0x8fff4000-0x8fff7fff]
[    0.800000] pci 0000:00:01.1: reg 20 32bit mmio: [0x8fff0000-0x8fff3fff]
[    0.800000] pci 0000:00:01.2: reg 10 32bit mmio: [0xefe00000-0xefe03fff]
[    0.800000] pci 0000:00:08.0: reg 10 32bit mmio: [0xefd00000-0xefd00fff]
[    0.800000] pci 0000:00:08.0: reg 14 io port: [0xdfc0-0xdfff]
[    0.800000] pci 0000:00:08.0: reg 18 32bit mmio: [0xefc00000-0xefc1ffff]
[    0.800000] pci 0000:00:08.0: reg 30 32bit mmio: [0xefb00000-0xefb0ffff]
[    0.800000] pci 0000:00:08.0: supports D1 D2
[    0.800000] pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.800000] pci 0000:00:08.0: PME# disabled
[    0.800000] pci 0000:00:0e.0: reg 10 32bit mmio: [0xefa00000-0xefa00fff]
[    0.800000] pci 0000:00:0e.0: reg 14 io port: [0xdf80-0xdfbf]
[    0.800000] pci 0000:00:0e.0: reg 18 32bit mmio: [0xef900000-0xef91ffff]
[    0.800000] pci 0000:00:0e.0: reg 30 32bit mmio: [0xef800000-0xef80ffff]
[    0.800000] pci 0000:00:0e.0: supports D1 D2
[    0.800000] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.800000] pci 0000:00:0e.0: PME# disabled
[    0.800000] pci 0000:00:0f.0: reg 10 io port: [0x6000-0x6007]
[    0.800000] pci 0000:00:0f.0: reg 14 io port: [0x6100-0x61ff]
[    0.800000] pci 0000:00:0f.0: reg 18 io port: [0x6200-0x623f]
[    0.800000] pci 0000:00:0f.0: reg 1c io port: [0x00-0x1f]
[    0.800000] pci 0000:00:0f.0: reg 20 io port: [0x9d00-0x9d7f]
[    0.800000] pci 0000:00:0f.0: reg 24 io port: [0x9c00-0x9c3f]
[    0.800000] pci 0000:00:0f.2: reg 20 io port: [0xeff0-0xefff]
[    0.800000] pci 0000:00:0f.4: reg 10 32bit mmio: [0xeff00000-0xeff00fff]
[    0.800000] pci 0000:00:0f.4: PME# supported from D0 D3hot D3cold
[    0.800000] pci 0000:00:0f.4: PME# disabled
[    0.800000] pci 0000:00:0f.5: reg 10 32bit mmio: [0xef700000-0xef700fff]
[    0.800000] pci 0000:00:0f.5: PME# supported from D0 D3hot D3cold
[    0.800000] pci 0000:00:0f.5: PME# disabled
[    0.800000] pci 0000:00:0f.0: default IRQ router [1022:2090]

--------------070206030307070502010105--
