From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Locking test suite (CONFIG_DEBUG_LOCKING_API_SELFTESTS) crash on
	2.6.29.4-rt16-omap1
Date: Wed, 3 Jun 2009 14:45:04 +1200
Message-ID: <5a7b8b7b0906021945h9c670a4k9fd683c0805ea82d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:42230 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbZFCCpC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2009 22:45:02 -0400
Received: by gxk10 with SMTP id 10so15067915gxk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2009 19:45:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Argh, sorry, I meant CONFIG_DEBUG_LOCKING_API_SELFTESTS not
CONFIG_PROVE_LOCKING!!
Not sure how I made that mistake; not enough coffee...

If I'm reading that log correctly, something is wrong with
double-unlock handling in rlocks. And it's something new since -rt6.
Any ideas?

On Wed, Jun 3, 2009 at 2:34 PM, Hugo Vincent <hugo.vincent@gmail.com> w=
rote:
> On a OMAP3503 (Gumstix Overo) I see a rather nasty-looking crash earl=
y
> in bootup, that is triggered by CONFIG_PROVE_LOCKING. The same config
> minus CONFIG_PROVE_LOCKING doesn't crash, and seems to work correctly
> in use. This kernel and similar config worked and passed the
> PROVE_LOCKING test last time I checked it, which would have been
> shortly after -rt6 was released.
>
> Kernel config attached.
>
> Here is the bootup log:
>
> <5>Linux version 2.6.29.4-rt16-omap1 (hugo@hugo) (gcc version 4.3.3
> (GCC) ) #1 PREEMPT RT Wed Jun 3 14:22:13 NZST 2009
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: Gumstix Overo
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 65536
> <7>free_area_init_node: node 0, pgdat c042d8a4, node_mem_map c0874000
> <7> =A0Normal zone: 512 pages used for memmap
> <7> =A0Normal zone: 0 pages reserved
> <7> =A0Normal zone: 65024 pages, LIFO batch:15
> <6>OMAP3430 ES2.1
> <6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
> Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages=
: 65024
> <5>Kernel command line: console=3DttyS6,115200n8 root=3D/dev/mmcblk0p=
2 rw
> rootfstype=3Dext3 rootwait
> <5>Preemptible RCU implementation.
> <6>NR_IRQS:402
> <6>Clocking rate (Crystal/DPLL/ARM core): 26.0/331/600 MHz
> <6>GPMC revision 5.0
> <6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> <6>Total of 96 interrupts on 1 active controller
> <6>OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> <6>OMAP clockevent source: GPTIMER1 at 13000000 Hz
> Console: colour dummy device 80x30
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Mol=
nar
> ... MAX_LOCKDEP_SUBCLASSES: =A08
> ... MAX_LOCK_DEPTH: =A0 =A0 =A0 =A0 =A048
> ... MAX_LOCKDEP_KEYS: =A0 =A0 =A0 =A08191
> ... CLASSHASH_SIZE: =A0 =A0 =A0 =A0 =A04096
> ... MAX_LOCKDEP_ENTRIES: =A0 =A0 8192
> ... MAX_LOCKDEP_CHAINS: =A0 =A0 =A016384
> ... CHAINHASH_SIZE: =A0 =A0 =A0 =A0 =A08192
> =A0memory used by lock dependency info: 2911 kB
> =A0per task-struct memory footprint: 1152 bytes
> ------------------------
> | Locking API testsuite:
> ---------------------------------------------------------------------=
-------
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | spi=
n |wlock |rlock |mutex | wsem | rsem |
> =A0------------------------------------------------------------------=
--------
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A-A deadlock: =A0ok =A0| =A0o=
k =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A-B-B-A deadlock: =A0ok =A0| =A0ok =A0=
| =A0ok =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 A-B-B-C-C-A deadlock: =A0ok =A0| =A0ok =A0| =A0=
ok =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 A-B-C-A-B-C deadlock: =A0ok =A0| =A0ok =A0| =A0=
ok =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 A-B-B-C-C-D-D-A deadlock: =A0ok =A0| =A0ok =A0| =A0ok=
 =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 A-B-C-D-B-D-D-A deadlock: =A0ok =A0| =A0ok =A0| =A0ok=
 =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 A-B-C-D-B-C-D-A deadlock: =A0ok =A0| =A0ok =A0| =A0ok=
 =A0| =A0ok =A0| =A0ok =A0| =A0ok =A0|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0double unlock: =A0ok =A0| =A0o=
k =A0|<2>kernel BUG at
> kernel/rt.c:257!
> <1>Unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
> <1>pgd =3D c0004000
> <1>[00000000] *pgd=3D00000000
> Internal error: Oops: 805 [#1] PREEMPT
> Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(2.6.29.4-rt16-omap1 #1)
> PC is at __bug+0x20/0x2c
> LR is at rt_up+0x48/0x64
> pc : [<c002c214>] =A0 =A0lr : [<c007d11c>] =A0 =A0psr: 00000153
> sp : c03e9f40 =A0ip : c03e9e68 =A0fp : c03e9f4c
> r10: 0000001f =A0r9 : 411fc082 =A0r8 : 00000001
> r7 : 00000002 =A0r6 : 00000001 =A0r5 : 00000000 =A0r4 : c041c8b0
> r3 : 00000000 =A0r2 : 00000001 =A0r1 : 00000001 =A0r0 : 00000022
> Flags: nzcv =A0IRQs on =A0FIQs off =A0Mode SVC_32 =A0ISA ARM =A0Segme=
nt kernel
> Control: 10c5387f =A0Table: 80004019 =A0DAC: 00000017
> Process swapper (pid: 0, stack limit =3D 0xc03e82f0)
> Stack: (0xc03e9f40 to 0xc03ea000)
> 9f40: c03e9f64 c03e9f50 c02f8e50 c002c200 c041c8b0 c041c8b0 c03e9f7c =
c03e9f68
> 9f60: c01c4a58 c02f8e20 c03e9f58 c01c4a2c c03e9fa4 c03e9f80 c01c2d5c =
c01c4a38
> 9f80: c02f61f8 c042e650 c042e644 c041c008 c03ecd58 80023094 c03e9fc4 =
c03e9fa8
> 9fa0: c01c35e8 c01c2d18 c03929ef c042e650 c042e644 c0024d58 c03e9ff4 =
c03e9fc8
> 9fc0: c0008b1c c01c320c c00086c4 00000000 00000000 c0024d58 00000000 =
10c5387d
> 9fe0: c042e6c0 c002515c 00000000 c03e9ff8 80008034 c0008974 00000000 =
00000000
> Backtrace:
> [<c002c1f4>] (__bug+0x0/0x2c) from [<c02f8e50>] (rt_read_unlock+0x3c/=
0x5c)
> [<c02f8e14>] (rt_read_unlock+0x0/0x5c) from [<c01c4a58>]
> (double_unlock_rlock+0x2c/0x34)
> =A0r4:c041c8b0
> [<c01c4a2c>] (double_unlock_rlock+0x0/0x34) from [<c01c2d5c>]
> (dotest+0x50/0x4f4)
> =A0r4:c01c4a2c
> [<c01c2d0c>] (dotest+0x0/0x4f4) from [<c01c35e8>] (locking_selftest+0=
x3e8/0x8b0)
> =A0r8:80023094 r7:c03ecd58 r6:c041c008 r5:c042e644 r4:c042e650
> [<c01c3200>] (locking_selftest+0x0/0x8b0) from [<c0008b1c>]
> (start_kernel+0x1b4/0x294)
> =A0r6:c0024d58 r5:c042e644 r4:c042e650
> [<c0008968>] (start_kernel+0x0/0x294) from [<80008034>] (0x80008034)
> =A0r6:c002515c r5:c042e6c0 r4:10c5387d
> Code: e1a01000 e59f000c eb0b27f2 e3a03000 (e5833000)
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <0>Kernel panic - not syncing: Attempted to kill the idle task!
> [<c02f609c>] (dump_stack+0x0/0x14) from [<c02f60f4>] (panic+0x44/0x12=
c)
> [<c02f60b0>] (panic+0x0/0x12c) from [<c00536cc>] (do_exit+0x70/0x764)
> =A0r3:00000000 r2:c03e8000 r1:00000001 r0:c0390942
> [<c005365c>] (do_exit+0x0/0x764) from [<c002c74c>] (die+0x2a4/0x304)
> [<c002c4a8>] (die+0x0/0x304) from [<c002e068>] (__do_kernel_fault+0x6=
c/0x7c)
> [<c002dffc>] (__do_kernel_fault+0x0/0x7c) from [<c002e2b8>]
> (do_page_fault+0x240/0x260)
> =A0r7:c03e9ef8 r6:00000805 r5:c03eb0c8 r4:ffffffff
> [<c002e078>] (do_page_fault+0x0/0x260) from [<c002e37c>]
> (do_translation_fault+0x18/0x7c)
> [<c002e364>] (do_translation_fault+0x0/0x7c) from [<c00281fc>]
> (do_DataAbort+0x38/0x9c)
> =A0r7:c03e9ef8 r6:00000805 r5:c03ed150 r4:ffffffff
> [<c00281c4>] (do_DataAbort+0x0/0x9c) from [<c0028a2c>] (__dabt_svc+0x=
4c/0x60)
> Exception stack(0xc03e9ef8 to 0xc03e9f40)
> 9ee0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000022 00000001
> 9f00: 00000001 00000000 c041c8b0 00000000 00000001 00000002 00000001 =
411fc082
> 9f20: 0000001f c03e9f4c c03e9e68 c03e9f40 c007d11c c002c214 00000153 =
ffffffff
> =A0r8:00000001 r7:00000002 r6:00000001 r5:c03e9f2c r4:ffffffff
> [<c002c1f4>] (__bug+0x0/0x2c) from [<c02f8e50>] (rt_read_unlock+0x3c/=
0x5c)
> [<c02f8e14>] (rt_read_unlock+0x0/0x5c) from [<c01c4a58>]
> (double_unlock_rlock+0x2c/0x34)
> =A0r4:c041c8b0
> [<c01c4a2c>] (double_unlock_rlock+0x0/0x34) from [<c01c2d5c>]
> (dotest+0x50/0x4f4)
> =A0r4:c01c4a2c
> [<c01c2d0c>] (dotest+0x0/0x4f4) from [<c01c35e8>] (locking_selftest+0=
x3e8/0x8b0)
> =A0r8:80023094 r7:c03ecd58 r6:c041c008 r5:c042e644 r4:c042e650
> [<c01c3200>] (locking_selftest+0x0/0x8b0) from [<c0008b1c>]
> (start_kernel+0x1b4/0x294)
> =A0r6:c0024d58 r5:c042e644 r4:c042e650
> [<c0008968>] (start_kernel+0x0/0x294) from [<80008034>] (0x80008034)
> =A0r6:c002515c r5:c042e6c0 r4:10c5387d
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
