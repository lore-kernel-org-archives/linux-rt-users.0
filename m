From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Tue, 21 May 2013 16:20:20 +0100
Message-ID: <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
	<CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
	<20130503160546.GF8230@linutronix.de>
	<CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
	<519B57A7.1010901@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:43426 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3EUPUV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 May 2013 11:20:21 -0400
Received: by mail-vb0-f47.google.com with SMTP id x13so499408vbb.20
        for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2013 08:20:20 -0700 (PDT)
In-Reply-To: <519B57A7.1010901@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 21, 2013 at 12:16 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> please CC the list.

Sorry.

>
> On 05/11/2013 06:43 PM, Tom Cook wrote:
[snip]
>
> Not known until you brought that up. I just booted x86 with kgdb=y and
> did "echo function > current_tracer" with no side effects. I don't have
> ARM at hand right now. Do you do anything kgdb related besides enabling
> it in the kernel?

No.  I've also tried compiling without kgdb and enabling tracers still
causes a crash (see below).

Again, I'm far from expert here, but as near as I can tell, a fast
interrupt exception handler is causing a data abort exception.  Do the
tracers use fast interrupts to wake up?  Is there some tracer-related
memory that's getting swapped out?

pi@raspberrypi:~/rt-tests$ sudo ./cyclictest -p95 -m -f -b 2000
# /dev/cpu_dma_latency set to 0us
[  199.186167] Bad mode in data abort handler detected
[  199.186194] Internal error: Oops - bad mode: 0 [#1] PREEMPT ARM
[  199.186246] Modules linked in: snd_bcm2835 snd_pcm snd_seq
snd_timer snd_seq_device snd snd_page_alloc
[  199.186260] CPU: 0    Not tainted  (3.6.11-rt31+ #1)
[  199.186297] PC is at ring_buffer_lock_reserve+0x7c/0x144
[  199.186326] LR is at vfs_write+0x140/0x188
[  199.186341] pc : [<c009486c>]    lr : [<c00efda4>]    psr: 600001d1
[  199.186341] sp : da645ef8  ip : da645e28  fp : da645f6c
[  199.186348] r10: 00000000  r9 : 00000000  r8 : 00000008
[  199.186357] r7 : 200001d1  r6 : c030226c  r5 : c012cd64  r4 : c0732000
[  199.186366] r3 : 200001d1  r2 : 00000018  r1 : 00000000  r0 : db801420
[  199.186375] Flags: nZCv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM
Segment user
[  199.186384] Control: 00c5387d  Table: 1a7f8008  DAC: 00000015
[  199.186396] Process cyclictest (pid: 2035, stack limit = 0xda644268)
[  199.186406] Stack: (0xda645ef8 to 0xda646000)
[  199.186417] 5ee0:
    db801420 00000000
[  199.186434] 5f00: 00000018 200001d1 c0732000 c012cd64 c030226c
200001d1 00000008 00000000
[  199.186451] 5f20: 00000000 da645f6c da645e28 da645ef8 c00efda4
c009486c 600001d1 ffffffff
[  199.186467] 5f40: db408988 da6e52c8 da6e52c0 0000fc10 00000008
00000004 00000000 00000000
[  199.186483] 5f60: da645fa4 da645f70 c00f002c c00efc70 00000008
00000000 00000001 00000000
[  199.186499] 5f80: 00000004 00000004 00000001 0000001a c000e248
da644000 00000000 da645fa8
[  199.186515] 5fa0: c000dfc0 c00effec 00000004 00000001 00000004
0000fc10 00000008 00000063
[  199.186531] 5fc0: 00000004 00000001 0000001a 00000004 00019798
0000fc10 00000008 00000001
[  199.186547] 5fe0: 0000000e beca42c0 0000b7bc b6f7a6fc 60000010
00000004 00000000 00000000
[  199.186595] [<c009486c>] (ring_buffer_lock_reserve+0x7c/0x144) from
[<c00f002c>] (sys_write+0x4c/0x78)
[  199.186639] [<c00f002c>] (sys_write+0x4c/0x78) from [<c000dfc0>]
(ret_fast_syscall+0x0/0x48)
[  199.186659] Code: eb0df889 e3a00000 e89da830 e5941010 (e591cd4c)
[  199.497152] ---[ end trace 0000000000000002 ]---
[  199.497169] Kernel panic - not syncing: Fatal exception
[  199.515555] Bad mode in prefetch abort handler detected
[  199.515584] Internal error: Oops - bad mode: 0 [#2] PREEMPT ARM
[  199.515632] Modules linked in: snd_bcm2835 snd_pcm snd_seq
snd_timer snd_seq_device snd snd_page_alloc
[  199.515644] CPU: 0    Tainted: G      D       (3.6.11-rt31+ #1)
[  199.515660] PC is at 0xbe6f00b0
[  199.515671] LR is at 0xb6ee67d4
[  199.515684] pc : [<be6f00b0>]    lr : [<b6ee67d4>]    psr: 800001d1
[  199.515684] sp : da46ffb0  ip : 00000000  fp : b5ca8fac
[  199.515691] r10: b5ca96a4  r9 : b5ca8fb0  r8 : 00000000
[  199.515700] r7 : 00000003  r6 : b5ca9684  r5 : b6cf62dc  r4 : b6cf42e4
[  199.515708] r3 : 00000000  r2 : 00000fff  r1 : b6cf42e4  r0 : 000008fe
[  199.515717] Flags: Nzcv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM
Segment user
[  199.515725] Control: 00c5387d  Table: 1a434008  DAC: 00000015
[  199.515735] Process rsyslogd (pid: 1700, stack limit = 0xda46e268)
[  199.515744] Stack: (0xda46ffb0 to 0xda470000)
[  199.515759] ffa0:                                     000008fe
b6cf42e4 00000fff 00000000
[  199.515776] ffc0: b6cf42e4 b6cf62dc b5ca9684 00000003 00000000
b5ca8fb0 b5ca96a4 b5ca8fac
[  199.515793] ffe0: 00000000 da46ffb0 b6ee67d4 be6f00b0 800001d1
ffffffff 1bffe821 1bffec21
[  199.515900] Code: 00000000 00000000 00000000 00000000 (00000000)
