From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Mon, 29 Apr 2013 08:16:35 +0100
Message-ID: <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:52655 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3D2HQg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 03:16:36 -0400
Received: by mail-vc0-f179.google.com with SMTP id hz10so2699600vcb.10
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2013 00:16:35 -0700 (PDT)
In-Reply-To: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

No ideas?

On Fri, Apr 26, 2013 at 9:04 AM, Tom Cook <tom.k.cook@gmail.com> wrote:
> I'm running 3.6.11-rt31 on a Raspberry Pi.  Running cyclictest like this:
>
>   sudo ./cyclictest -p95 -m -W -b 1000
>   # /dev/cpu_dma_latency set to 0us
>   policy: fifo: loadavg: 0.72 0.28 0.10 2/137 2054
>
> causes this:
>
> Entering kdb (current=0xca78e0a0, pid 2058) Oops: (null)
> due to oops @ 0xc009f654
>
> Pid: 2058, comm:           cyclictest
> CPU: 0    Not tainted  (3.6.11-rt31+ #10)
> PC is at ring_buffer_lock_reserve+0x7c/0x144
> LR is at ftrace_test_stop_func+0x28/0x34
> pc : [<c009f654>]    lr : [<c0097684>]    psr: 600001d1
> sp : ca7bfa78  ip : ca7bfaf0  fp : ca7bfaec
> r10: 00000000  r9 : c088ece0  r8 : ca7be000
> r7 : 200001d1  r6 : c030dd28  r5 : c00ab928  r4 : c0786000
> r3 : 200001d1  r2 : 00000018  r1 : 00000000  r0 : cb8013a0
> Flags: nZCv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM  Segment user
> Control: 00c5387d  Table: 0a7b8008  DAC: 00000015
> [<c0015188>] (unwind_backtrace+0x0/0xfc) from [<c041953c>]
> (dump_stack+0x20/0x24)
> [<c041953c>] (dump_stack+0x20/0x24) from [<c000f720>] (show_regs+0x4c/0x58)
> [<c000f720>] (show_regs+0x4c/0x58) from [<c0086c48>] (kdb_dumpregs+0x38/0x60)
> [<c0086c48>] (kdb_dumpregs+0x38/0x60) from [<c00897d8>]
> (kdb_main_loop+0x348/0x77c)
> [<c00897d8>] (kdb_main_loop+0x348/0x77c) from [<c008c3d8>]
> (kdb_stub+0x2f0/0x3f8)
> [<c008c3d8>] (kdb_stub+0x2f0/0x3f8) from [<c0082b24>]
> (kgdb_handle_exception+0x164/0x6fc)
> [<c0082b24>] (kgdb_handle_exception+0x164/0x6fc) from [<c00147e0>]
> (kgdb_notify+0x3c/0x74)
> [<c00147e0>] (kgdb_notify+0x3c/0x74) from [<c0421e84>]
> (notifier_call_chain+0x54/0x94)
> [<c0421e84>] (notifier_call_chain+0x54/0x94) from [<c0421f0c>]
> (__atomic_notifier_call_chain+0x48/0x5c)
> [<c0421f0c>] (__atomic_notifier_call_chain+0x48/0x5c) from
> [<c0421f48>] (atomic_notifier_call_chain+0x28/0x30)
> [<c0421f48>] (atomic_notifier_call_chain+0x28/0x30) from [<c0421f90>]
> (notify_die+0x40/0x4c)
> [<c0421f90>] (notify_die+0x40/0x4c) from [<c0011de8>] (die+0xd8/0x3c0)
> [<c0011de8>] (die+0xd8/0x3c0) from [<c0012480>] (bad_mode+0x4c/0x70)
> [<c0012480>] (bad_mode+0x4c/0x70) from [<c0097684>]
> (ftrace_test_stop_func+0x28/0x34)
>
> AFAICT, this is actually kgdb encountering a problem while trying to
> unwind the stack trace from the real problem - is that right?
>
> The problem seems to be caused by cyclictest setting up the tracer,
> not triggering it - it doesn't matter what I set the latency threshold
> to, the same thing happens.
>
> Is there a known cause for this?  Any tips on how to start debugging it?
>
> Thanks,
> Tom
