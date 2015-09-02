From: Philipp Schrader <philipp@peloton-tech.com>
Subject: Re: RCU splat on boot from an idle CPU
Date: Wed, 2 Sep 2015 15:10:04 -0700
Message-ID: <CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
	<alpine.DEB.2.11.1509011721510.15006@nanos>
	<20150902153823.749a9f73@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35989 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbIBWKG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 18:10:06 -0400
Received: by lanb10 with SMTP id b10so16555808lan.3
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Sep 2015 15:10:04 -0700 (PDT)
In-Reply-To: <20150902153823.749a9f73@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 2, 2015 at 12:38 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 1 Sep 2015 17:35:23 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Mon, 31 Aug 2015, Philipp Schrader wrote:

>> > rcu_dereference_check() usage!
>> > [    0.055093]
>> > [    0.055093] other info that might help us debug this:
>> > [    0.055093]
>> > [    0.055097]
>> > [    0.055097] RCU used illegally from idle CPU!
>> > [    0.055097] rcu_scheduler_active = 1, debug_locks = 1
>> > [    0.055100] RCU used illegally from extended quiescent state!
>> > [    0.055104] no locks held by swapper/0/0.
>> > [    0.055106]
>> > [    0.055106] stack backtrace:
>> > [    0.055112] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.6+ #2
>> > [    0.055116] Hardware name: Generic DRA74X (Flattened Device Tree)
>> > [    0.055130] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
>> > (show_stack+0x20/0x24)
>> > [    0.055146] [<c001515c>] (show_stack) from [<c07bc408>]
>> > (dump_stack+0x84/0xa0)
>> > [    0.055160] [<c07bc408>] (dump_stack) from [<c009bc38>]
>> > (lockdep_rcu_suspicious+0xb0/0x110)
>> > [    0.055172] [<c009bc38>] (lockdep_rcu_suspicious) from [<c01246c4>]
>> > (time_hardirqs_off+0x2b8/0x3c8)
>> > [    0.055184] [<c01246c4>] (time_hardirqs_off) from [<c009a218>]
>> > (trace_hardirqs_off_caller+0x2c/0xf4)
>> > [    0.055194] [<c009a218>] (trace_hardirqs_off_caller) from
>> > [<c009a2f4>] (trace_hardirqs_off+0x14/0x18)
>> > [    0.055204] [<c009a2f4>] (trace_hardirqs_off) from [<c00c7ecc>]
>> > (rcu_idle_enter+0x78/0xcc)
>> > [    0.055213] [<c00c7ecc>] (rcu_idle_enter) from [<c0093eb0>]
>> > (cpu_startup_entry+0x190/0x518)
>> > [    0.055222] [<c0093eb0>] (cpu_startup_entry) from [<c07b95b4>]
>> > (rest_init+0x13c/0x17c)
>> > [    0.055231] [<c07b95b4>] (rest_init) from [<c0b32c74>]
>> > (start_kernel+0x320/0x380)
>> > [    0.055238] [<c0b32c74>] (start_kernel) from [<8000807c>] (0x8000807c)
>> >
>> > I'm not sure how to debug this; I'm still reading up on RCUs. Pretty
>> > nifty ideas.
>> >
>> > Looking at include/trace/events/hist.h it appears line 31 is the end
>> > of a TRACE_EVENT macro usage.
>> > Does that mean the macro is using RCU improperly somehow?
>
> I think this needs to be a trace_*_rcu_idle() call. That is, I bet the
> tracepoint was triggered when rcu wasn't watching.

Thank you for your reply Steve.
I've got the following patch now that makes the splat disappear:

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index aaade2e..d0e1d0e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -450,7 +450,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-       trace_preemptirqsoff_hist(IRQS_ON, 0);
+       trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
        if (!preempt_trace() && irq_trace())
                stop_critical_timing(a0, a1);
 }
@@ -459,7 +459,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
        if (!preempt_trace() && irq_trace())
                start_critical_timing(a0, a1);
-       trace_preemptirqsoff_hist(IRQS_OFF, 1);
+       trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }

 #else /* !CONFIG_PROVE_LOCKING */

Does that look reasonable?
Or could this cause a problem down the road?

Still reading up on RCUs and how they work.

Thanks!
Philipp
