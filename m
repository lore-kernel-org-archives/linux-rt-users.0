From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 23:32:59 +0200
Message-ID: <20070516213259.GC19850@elte.hu>
References: <20070516180447.GA17922@elte.hu> <1179348842.20519.20.camel@imap.mvista.com> <20070516210104.GA17240@elte.hu> <1179350448.20519.25.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:39598 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963AbXEPVdS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 17:33:18 -0400
Content-Disposition: inline
In-Reply-To: <1179350448.20519.25.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > > http://lkml.org/lkml/2007/5/3/368
> > 
> > hm - trace_hardirqs_on() should never be called with irqs on - 
> > lockdep could break for example. Could you try to fix the call site 
> > instead?
> 
> If that's the case why check if they're enabled inside 
> trace_hardirqs_on() ? If that check fails you still still get the 
> warning in my original release ..

yeah, indeed you are right - it checks the soft flag. But even then, the 
better fix is to check for hardirqs-off first and not to flip around the 
preempt count check in irqs_off_preempt_count() - i.e. something like 
the patch below. Does this solve the warning you've triggered with 
irqsoff-tracing enabled?

	Ingo

Index: linux-rt.q/kernel/latency_trace.c
===================================================================
--- linux-rt.q.orig/kernel/latency_trace.c
+++ linux-rt.q/kernel/latency_trace.c
@@ -1963,7 +1963,7 @@ void notrace trace_hardirqs_on(void)
 
 	local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (irqs_disabled_flags(flags) && !irqs_off_preempt_count())
 		__stop_critical_timing(CALLER_ADDR0, 0 /* CALLER_ADDR1 */);
 }
 
@@ -1975,7 +1975,7 @@ void notrace trace_hardirqs_off(void)
 
 	local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (irqs_disabled_flags(flags) && !irqs_off_preempt_count())
 		__start_critical_timing(CALLER_ADDR0, 0 /* CALLER_ADDR1 */,
 					INTERRUPT_LATENCY);
 }
@@ -1989,7 +1989,7 @@ void notrace trace_hardirqs_on_caller(un
 
 	local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (irqs_disabled_flags(flags) && !irqs_off_preempt_count())
 		__stop_critical_timing(caller_addr, 0 /* CALLER_ADDR1 */);
 }
 
@@ -1999,7 +1999,7 @@ void notrace trace_hardirqs_off_caller(u
 
 	local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (irqs_disabled_flags(flags) && !irqs_off_preempt_count())
 		__start_critical_timing(caller_addr, 0 /* CALLER_ADDR1 */,
 					INTERRUPT_LATENCY);
 }
