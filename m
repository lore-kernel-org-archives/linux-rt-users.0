From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Mon, 29 Feb 2016 19:42:54 -1000
Message-ID: <56D52BDE.7080104@sysnux.pf>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de> <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-pro1.mana.pf ([202.3.225.198]:55565 "EHLO
	smtp-pro1.mana.pf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcCAFty (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 00:49:54 -0500
In-Reply-To: <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Josh,

Le 29/02/2016 06:18, Josh Cartwright a =E9crit :
> I think your best bet will be to try to get early console output, wit=
h
> the hope that you can get visibility into what is going wrong.  I'm s=
ure
> there are many tutorials out there on how to build a kernel with this
> serial debugging information.  Do a search for DEBUG_LL, earlyprintk,
> and perhaps earlycon; these are not -rt specific.

Thanks for your advice. I managed to configure earlyprintk, this is wha=
t
I got:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.4.3-rt9 (jdg@tiare.sysnux.pf) (gcc version 5.2.1
20151104 (Red Hat Cross 5.2.1-4) (GCC) ) #10 PREEMPT RT Mon Feb 29
13:01:47 TAHT 2016
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D0005317f
CPU: VIVT data cache, VIVT instruction cache
Machine model: Acme Systems Arietta G25
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c0556448, node_mem_map c7ef9000
Normal zone: 256 pages used for memmap
Normal zone: 0 pages reserved
Normal zone: 32768 pages, LIFO batch:7
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on. Total pages: 325=
12
Kernel command line: mem=3D128M console=3DttyS0,115200 root=3D/dev/mmcb=
lk0p2
rootdelay=3D1 earlyprintk=3DttyS0,115200
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 124180K/131072K available (3870K kernel code, 139K rwdata, 1256=
K
rodata, 168K init, 137K bss, 6892K reserved, 0K cma-reserved)
Virtual kernel memory layout:
vector : 0xffff0000 - 0xffff1000 ( 4 kB)
fixmap : 0xffc00000 - 0xfff00000 (3072 kB)
vmalloc : 0xc8800000 - 0xff800000 ( 880 MB)
lowmem : 0xc0000000 - 0xc8000000 ( 128 MB)
modules : 0xbf000000 - 0xc0000000 ( 16 MB)
=2Etext : 0xc0008000 - 0xc0509c3c (5128 kB)
=2Einit : 0xc050a000 - 0xc0534000 ( 168 kB)
=2Edata : 0xc0534000 - 0xc0556d40 ( 140 kB)
=2Ebss : 0xc0556d40 - 0xc05793a8 ( 138 kB)
SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
Preemptible hierarchical RCU implementation.
Build-time adjustment of leaf fanout to 32.
NR_IRQS:16 nr_irqs:16 16
Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.3-rt9 #10
Hardware name: Atmel AT91SAM9
task: c0537dd0 ti: c0534000 task.ti: c0534000
PC is at try_to_wake_up+0x34/0x228
LR is at kthread_create_on_node+0x94/0x134
pc : [<c0030dfc>] lr : [<c002d084>] psr: 600000d3
sp : c0535ea0 ip : c7802264 fp : c0535ebc
r10: 00000010 r9 : c0040f80 r8 : 00000000
r7 : 00000000 r6 : 600000d3 r5 : 00000000 r4 : c7805060
r3 : c0534000 r2 : 00000002 r1 : 00000003 r0 : 00000000
=46lags: nZCv IRQs off FIQs off Mode SVC_32 ISA ARM Segment none
Control: 0005317f Table: 20004000 DAC: 00000053
Process swapper (pid: 0, stack limit =3D 0xc0534190)
Stack: (0xc0535ea0 to 0xc0536000)
5ea0: c7805060 c053aed4 c0535ec4 00000000 c7803080 c0040f80 c7ee5830
c002d084
5ec0: c0040f80 00000000 c0535ec8 c0535ec8 c7803080 c7803080 00000000
c0040144
5ee0: 00000010 c7803040 c0040668 c048dd00 00000010 c04bdd54 c03fb3d0
00000032
5f00: 00000000 c7803080 c7804cc0 c0041634 00000010 c7804cc0 00040080
c7803080
5f20: c7804cc0 c031ca74 00000000 c7803040 00000010 c0041c3c c7803040
c7ee5830
5f40: c7803048 c03fb3d0 fefffc00 c0570f50 00000010 c0520640 c04bdd54
c7803040
5f60: 00000000 c0535f88 c78050a0 00000001 c7805080 00000000 00000200
c05202bc
5f80: 00000000 00000000 c7805088 c78050a8 00000000 00000000 c0556e00
ffffffff
5fa0: c0536000 c7ee4020 c05298bc 20528248 00000000 c050c108 00000000
c050aafc
5fc0: ffffffff ffffffff 00000000 c050a66c 00000000 c05298bc 00000000
c0556f54
5fe0: c0536018 c05298b8 c0538d04 20004000 41069265 20008048 00000000
00000000
[<c0030dfc>] (try_to_wake_up) from [<c002d084>]
(kthread_create_on_node+0x94/0x134)
[<c002d084>] (kthread_create_on_node) from [<c0040668>]
(setup_irq_thread+0x38/0xd4)
[<c0040668>] (setup_irq_thread) from [<c0041634>] (__setup_irq+0x1a8/0x=
648)
[<c0041634>] (__setup_irq) from [<c0041c3c>]
(request_threaded_irq+0xe4/0x144)
[<c0041c3c>] (request_threaded_irq) from [<c0520640>]
(of_at91_pmc_setup+0xe0/0x16c)
[<c0520640>] (of_at91_pmc_setup) from [<c05202bc>] (of_clk_init+0xf4/0x=
1b8)
[<c05202bc>] (of_clk_init) from [<c050c108>] (time_init+0x20/0x2c)
[<c050c108>] (time_init) from [<c050aafc>] (start_kernel+0x248/0x35c)
[<c050aafc>] (start_kernel) from [<20008048>] (0x20008048)
Code: e3c3303f e5932004 e2822001 e5832004 (e5902000)
---[ end trace 0000000000000001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!

Attached is my .config.

I have no clue at what is wrong, and hope it makes sense to someone.
Should I send this trace under another subject?


Best regards
--=20
Jean-Denis Girard

SysNux Syst=E8mes Linux en Polyn=E9sie fran=E7aise
http://www.sysnux.pf/ T=E9l: +689 40.50.10.40 / GSM: +689 87.79.75.27




--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
