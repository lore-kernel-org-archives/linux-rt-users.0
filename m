From: John Blackwood <john.blackwood@ccur.com>
Subject: force_sig() CONFIG_PREMPT_RT x86_64 issue in do_int3() and do_debug()
Date: Thu, 30 Aug 2007 10:51:05 -0400
Message-ID: <46D6D959.1080603@ccur.com>
Reply-To: john.blackwood@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ccur.com ([66.10.65.12]:27197 "EHLO mail.ccur.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbXH3OvG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Aug 2007 10:51:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Ingo and Andi,

I've run into an issue with x86_64 CONFIG_PREEMPT_RT kernels that I
would like to mention.  I'm afraid that I have no ideas for a solution.

I created a kernel with the following items:

     linux-2.6.22.tar.bz2
     patch-2.6.23-rc2.bz
     patch-2.6.23-rc2-rt2

And I enabled CONFIG_PREEMPT_RT along with the various DEBUG parameters,
such as CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_SPINLOCK_SLEEP, etc.

When I run some ptrace-base tests that make use of int3 breakpoints,
singlesteps or hardware debug registers on x86_64 systems, I see BUG
messages that indicate an issue with calling force_sig()/force_sig_info()
from do_debug()/do_int3()->do_trap() since we're running on the IST
kernel stack with preemptions disabled.

[ It's interesting that the i386 version of do_trap() has
   some CONFIG_PREEMPT_RT code in it that does a
   local_irq_enable() and preempt_check_resched() before
   it gets to the force_sig() code,  but that won't work
   for x86_64 due to the per-cpu IST stack. ]

Below is an example of the output from a ptrace singlestep test where
we actually end up switching away from the current task:


    BUG: scheduling while atomic: ssdd/0x00000002/5333, CPU#1
    Call Trace:
    <#DB>  [<ffffffff8057f304>] __sched_text_start+0xcc/0x90a
    [<ffffffff80236634>] release_console_sem+0x17f/0x1ae
    [<ffffffff80236a06>] printk+0x8d/0x95
    [<ffffffff80252887>] __rt_mutex_adjust_prio+0x9/0x1b
    [<ffffffff80253134>] task_blocks_on_rt_mutex+0x17d/0x1d0
    [<ffffffff8057fe0f>] schedule+0xdf/0xff
    [<ffffffff80580fb9>] rt_spin_lock_slowlock+0xed/0x18a
    [<ffffffff80282459>] kmem_cache_alloc+0x56/0x118
    [<ffffffff8023f669>] __sigqueue_alloc+0x32/0x5d
    [<ffffffff8023fd79>] send_signal+0x65/0x149
    [<ffffffff8023febf>] specific_send_sig_info+0x62/0x96
    [<ffffffff8023ff72>] force_sig_info+0x7f/0x9b
    [<ffffffff8020e445>] do_debug+0xf2/0x141
    [<ffffffff8023fb7a>] signal_wake_up+0x1e/0x2d
    [<ffffffff8023fee8>] specific_send_sig_info+0x8b/0x96
    [<ffffffff8023ff87>] force_sig_info+0x94/0x9b
    [<ffffffff80581fb3>] debug+0x93/0x9f


and here's one more example of an int3 breakpoint:


    BUG: sleeping function called from invalid context de5(4222) at
         kernel/rtmutex.c:636
    in_atomic():1 [00000001], irqs_disabled():0
    Call Trace:
    <#DB>  [<ffffffff80225608>] __might_sleep+0xf8/0xfa
    [<ffffffff8068bfae>] __rt_spin_lock+0x2c/0x4e
    [<ffffffff8068bfd9>] rt_spin_lock+0x9/0xb
    [<ffffffff8023ad82>] force_sig_info+0x25/0xa9
    [<ffffffff8023b3a1>] force_sig+0x11/0x13
    [<ffffffff8020bdd4>] do_trap+0x1dd/0x27b
    [<ffffffff8023dfdf>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8023dff0>] raw_notifier_call_chain+0xf/0x11
    [<ffffffff8020c911>] do_int3+0x6a/0x7e
    [<ffffffff8068cfe3>] int3+0x93/0xb0
    <<EOE>>
    ---------------------------
    | preempt count: 00000001 ]
    | 1-level deep critical section nesting:
    ----------------------------------------
    .. [<ffffffff8020c8e8>] .... do_int3+0x41/0x7e
    .....[<ffffffff8068cfe3>] ..   ( <= int3+0x93/0xb0)

    BUG: de5:4222 task might have lost a preemption check!

    Call Trace:
    <#DB>  [<ffffffff8022d343>] preempt_enable_no_resched+0x5c/0x5e
    [<ffffffff8020c920>] do_int3+0x79/0x7e
    [<ffffffff8068cfe3>] int3+0x93/0xb0
    <<EOE>>
    ---------------------------
    | preempt count: 00000000 ]
    | 0-level deep critical section nesting:
    ----------------------------------------


Thanks in advance for any input or comments.


John Blackwood		john.blackwood@ccur.com
