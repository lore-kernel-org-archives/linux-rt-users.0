From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Fri, 22 Aug 2008 16:39:21 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0808221619080.3243@apollo.tec.linutronix.de>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, tinytim@us.ibm.com,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net
To: Gilles Carry <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47477 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbYHVOml (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Aug 2008 10:42:41 -0400
In-Reply-To: <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 18 Aug 2008, Gilles Carry wrote:
> This patch makes hrtimers initialized with hrtimer_init_sleeper
> to use another mode and then not be stuck in waitqueues when
> hrtimer_interrupt is very busy.
> 
> The new mode is HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
> The above-mentionned timers have been moved from
> HRTIMER_CB_IRQSAFE_NO_SOFTIRQ to
> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
> 
> HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ timers use a slightly different
> state machine from HRTIMER_CB_IRQSAFE_NO_SOFTIRQ's as when removing the
> timer, __run_hrtimer sets the status to INACTIVE _then_
> wakes up the thread. This way, an awakened thread cannot enter
> hrtimer_cancel before the timer's status has changed.

NAK. That solution is racy.

     CPU 0                        CPU 1

     timer interrupt runs         signal wakeup for task which sleeps
     timer->state = INACTIVE;

-> Race window start
     base->lock is dropped
				  hrtimer_cancel()
				  data structure on stack is destroyed

     timer function called
     	   data structure access --> POOOF

-> Race window end

     base->lock is locked

The race is extremly narrow and requires an SMI or some other delay
(bus stall, cache miss ...) on CPU 0, but it exists.

Fix below.

Thanks,
	tglx

---------------->
Subject: hrtimer: avoid waitqueue starvation
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 22 Aug 2008 16:27:13 +0200

Garry Gilles found that when a hrtimer callback runs in interrupt
context, then the woken up thread might end up on the timer wakequeue,
which might be blocked for a long time due to interrupts, higher
priority threads and no timers in the softirq list.

For timers which run their callback function in the hard irq context
we can safely spin and wait for the state to become inactive. The
waitqueue is only necessary for timers which run their callback
function in softirq context.

Debugged-by: Gilles Carry <gilles.carry@bull.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/hrtimer.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.24.7/kernel/hrtimer.c
===================================================================
--- linux-2.6.24.7.orig/kernel/hrtimer.c
+++ linux-2.6.24.7/kernel/hrtimer.c
@@ -990,7 +990,14 @@ int hrtimer_cancel(struct hrtimer *timer
 
 		if (ret >= 0)
 			return ret;
-		hrtimer_wait_for_timer(timer);
+		switch (timer->cb_mode) {
+		case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
+		case HRTIMER_CB_IRQSAFE_NO_RESTART:
+			cpu_relax();
+			break;
+		default:
+			hrtimer_wait_for_timer(timer);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
