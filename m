From: Jim Barlow <jbarlow@ivl.com>
Subject: ARM RT - "scheduling with irqs disabled" can occur when a break point is set
Date: Fri, 15 Aug 2008 20:35:05 +0000 (UTC)
Message-ID: <loom.20080815T201146-359@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60345 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbYHOUkI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Aug 2008 16:40:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KU65b-0002jU-08
	for linux-rt-users@vger.kernel.org; Fri, 15 Aug 2008 20:40:03 +0000
Received: from S01060013461abac3.gv.shawcable.net ([24.108.12.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Aug 2008 20:40:02 +0000
Received: from jbarlow by S01060013461abac3.gv.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Aug 2008 20:40:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I encountered the following bug on 2.6.22.6-rt9, although it might occur on the
most recent RT patch as well.

It appears that breakpoints are set in ARM by inserting an invalid instruction
at the breakpoint.  (This is probably to work around the ARM architecture having
about 2 hardware breakpoints.)  arch/arm/kernel/traps.c installs a undefined
instruction handler do_undefinstr, walks through the list undef_hook to test the
instruction against a list of registered invalid instructions.

ptrace_break is one these handlers.  It uses force_sig_info to send the
offending process a SIGTRAP, which implies locking the task signal handler. 
What is making the kernel unhappy is that the undef_hook is locked with a raw
spinlock.  For some reason, the real-time patch explicitly changes undef_lock to
a raw spinlock and has done so for a very long time.  Any ideas why?

I don't think it would be a good idea to turn the task signal handler into a raw
spinlock, because it affects so much code -- it's used in a few hundred places.

It could be that a regular spinlock is sufficient. Alternately, might it be safe
to unlock the spinlock before invoking hook->fn()?  In practice, no one every
calls unregister_undef_hook, so the risk is limited.  Another option would be to
somehow defer the call to force_sig_info, i.e. with a kernel thread or something.

Can anyone suggest a solution?

Thanks.

Jim Barlow
jbarlow@ivl.com


Relevant code:

arch/arm/kernel/traps.c about line 291:
asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
{
        [..snip..]
        spin_lock_irqsave(&undef_lock, flags);
        list_for_each_entry(hook, &undef_hook, node) {
                if ((instr & hook->instr_mask) == hook->instr_val &&
                   (regs->ARM_cpsr & hook->cpsr_mask) == hook->cpsr_val) {
                        if (hook->fn(regs, instr) == 0) {
                                spin_unlock_irqrestore(&undef_lock, flags);
                                return;
                        }
                }
        }
        spin_unlock_irqrestore(&undef_lock, flags);

        [..snip..]
        info.si_signo = SIGILL;
        info.si_errno = 0;
        info.si_code  = ILL_ILLOPC;
        info.si_addr  = pc;

        arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
}

Stack trace:


BUG: scheduling with irqs disabled: damixer/0x00000001/2737
caller is rt_spin_lock_slowlock+0x130/0x1f4
[<c0029dac>] (dump_stack+0x0/0x14) from [<c02b19ac>] (schedule+0x78/0x118)
[<c02b1934>] (schedule+0x0/0x118) from [<c02b2b94>]
(rt_spin_lock_slowlock+0x130/0x1f4)
 r4:a0000093
[<c02b2a64>] (rt_spin_lock_slowlock+0x0/0x1f4) from [<c02b2ee4>]
(__rt_spin_lock+0x40/0x44)
[<c02b2ea4>] (__rt_spin_lock+0x0/0x44) from [<c02b2ef8>] (rt_spin_lock+0x10/0x14)
[<c02b2ee8>] (rt_spin_lock+0x0/0x14) from [<c0047a64>] (force_sig_info+0x28/0xbc)
[<c0047a3c>] (force_sig_info+0x0/0xbc) from [<c00273cc>] (ptrace_break+0x4c/0x58)
 r7:c6de1fb0 r6:e7f001f0 r5:c753ce60 r4:c6de1fb0
[<c0027380>] (ptrace_break+0x0/0x58) from [<c0027890>] (break_trap+0x20/0x28)
 r5:60000093 r4:c037ff10
[<c0027870>] (break_trap+0x0/0x28) from [<c0025134>] (do_undefinstr+0xd0/0x198)
[<c0025064>] (do_undefinstr+0x0/0x198) from [<c0025ea8>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc6de1fb0 to 0xc6de1ff8)
1fa0:                                     00000000 40023db8 40024058 40024724
1fc0: 00000001 00000000 0000000e 00000000 43e77440 00000000 40024000 43e773fc
1fe0: 00000000 43e772f8 4000622c 4000e114 60000010 ffffffff
 r8:43e77440 r7:00000000 r6:0000000e r5:00000000 r4:4000e114
BUG: scheduling while atomic: damixer/0x00000002/2737, CPU#0
[<c0029dac>] (dump_stack+0x0/0x14) from [<c00376c8>] (__schedule_bug+0x3c/0x48)
[<c003768c>] (__schedule_bug+0x0/0x48) from [<c02b1258>] (__schedule+0x8c/0x47c)
[<c02b11cc>] (__schedule+0x0/0x47c) from [<c02b1a04>] (schedule+0xd0/0x118)
[<c02b1934>] (schedule+0x0/0x118) from [<c02b2b94>]
(rt_spin_lock_slowlock+0x130/0x1f4)
 r4:a0000093
[<c02b2a64>] (rt_spin_lock_slowlock+0x0/0x1f4) from [<c02b2ee4>]
(__rt_spin_lock+0x40/0x44)
[<c02b2ea4>] (__rt_spin_lock+0x0/0x44) from [<c02b2ef8>] (rt_spin_lock+0x10/0x14)
[<c02b2ee8>] (rt_spin_lock+0x0/0x14) from [<c0047a64>] (force_sig_info+0x28/0xbc)
[<c0047a3c>] (force_sig_info+0x0/0xbc) from [<c00273cc>] (ptrace_break+0x4c/0x58)
 r7:c6de1fb0 r6:e7f001f0 r5:c753ce60 r4:c6de1fb0
[<c0027380>] (ptrace_break+0x0/0x58) from [<c0027890>] (break_trap+0x20/0x28)
 r5:60000093 r4:c037ff10
[<c0027870>] (break_trap+0x0/0x28) from [<c0025134>] (do_undefinstr+0xd0/0x198)
[<c0025064>] (do_undefinstr+0x0/0x198) from [<c0025ea8>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc6de1fb0 to 0xc6de1ff8)
1fa0:                                     00000000 40023db8 40024058 40024724
1fc0: 00000001 00000000 0000000e 00000000 43e77440 00000000 40024000 43e773fc
1fe0: 00000000 43e772f8 4000622c 4000e114 60000010 ffffffff
 r8:43e77440 r7:00000000 r6:0000000e r5:00000000 r4:4000e114



