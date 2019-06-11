Return-Path: <SRS0=DAnd=UK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA3CC4321B
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D220673
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfFKLpW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:45:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403773AbfFKLpW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Jun 2019 07:45:22 -0400
Received: from [5.158.153.53] (helo=somnus.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1hafDJ-00013F-VQ; Tue, 11 Jun 2019 13:45:18 +0200
Date:   Tue, 11 Jun 2019 13:45:06 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
In-Reply-To: <alpine.DEB.2.21.1905311355180.4899@somnus>
Message-ID: <alpine.DEB.2.21.1906111340010.4366@somnus>
References: <20190415201213.600254019@amt.cnet> <20190415201429.427759476@amt.cnet> <alpine.DEB.2.21.1905291653120.1395@somnus> <20190530201455.GC23199@amt.cnet> <alpine.DEB.2.21.1905311355180.4899@somnus>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 31 May 2019, Anna-Maria Gleixner wrote:

[...]
> I will think about the problem and your solution a little bit more and
> give you feedback hopefully on monday.

I'm sorry for the delay. But now I'm able to give you a detailed feedback:

The general problem is, that your solution is customized to a single
use-case: preventing softirq raise but only if there is _no_ timer
pending. To reach this goal without using locks, overhead is added to the
formerly optimized add/mod path of a timer. With your code the timer
softirq is raised even when there is a pending timer which does not has to
be expired right now. But there have been requests in the past for this use
case already.

I discussed with Thomas several approaches during the last week how to
solve the unconditional softirq timer raise in a more general way without
loosing the fast add/mod path of a timer. The approach which seems to be
the best has a dependency on a timer code change from a push to pull model
which is still under developement (see v2 patchset:
http://lkml.kernel.org/r/20170418111102.490432548@linutronix.de). The
patchset v2 has several problems but we are working on a solution for those
problems right now. When the timer pull model is in place the approach to
solve the unconditional timer softirq raise could look like the following:

---8<---
The next_expiry value of timer_base struct is used to store the next expiry
value even if timer_base is not idle. Therefore it is udpated after adding
or modifying a timer and also at the end of timer softirq. In case timer
softirq does not has to be raised, the timer_base->clk is incremented to
prevent stale clocks. Checking whether timer softirq has to be raised
cannot be done lockless.

This code is not compile tested nor boot tested.

---
 kernel/time/timer.c |   60 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -552,37 +552,32 @@ static void
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
-	if (!is_timers_nohz_active())
-		return;
-
-	/*
-	 * TODO: This wants some optimizing similar to the code below, but we
-	 * will do that when we switch from push to pull for deferrable timers.
-	 */
-	if (timer->flags & TIMER_DEFERRABLE) {
-		if (tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
-		return;
+	if (is_timers_nohz_active()) {
+		/*
+		 * TODO: This wants some optimizing similar to the code
+		 * below, but we will do that when we switch from push to
+		 * pull for deferrable timers.
+		 */
+		if (timer->flags & TIMER_DEFERRABLE) {
+			if (tick_nohz_full_cpu(base->cpu))
+				wake_up_nohz_cpu(base->cpu);
+			return;
+		}
 	}
 
-	/*
-	 * We might have to IPI the remote CPU if the base is idle and the
-	 * timer is not deferrable. If the other CPU is on the way to idle
-	 * then it can't set base->is_idle as we hold the base lock:
-	 */
-	if (!base->is_idle)
-		return;
-
 	/* Check whether this is the new first expiring timer: */
 	if (time_after_eq(timer->expires, base->next_expiry))
 		return;
+	/* Update next expiry time */
+	base->next_expiry = timer->expires;
 
 	/*
-	 * Set the next expiry time and kick the CPU so it can reevaluate the
-	 * wheel:
+	 * We might have to IPI the remote CPU if the base is idle and the
+	 * timer is not deferrable. If the other CPU is on the way to idle
+	 * then it can't set base->is_idle as we hold the base lock:
 	 */
-	base->next_expiry = timer->expires;
-	wake_up_nohz_cpu(base->cpu);
+	if (is_timers_nohz_active() && base->is_idle)
+		wake_up_nohz_cpu(base->cpu);
 }
 
 static void
@@ -1684,6 +1679,7 @@ static inline void __run_timers(struct t
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+	base->next_expiry = __next_timer_interrupt(base);
 	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
 }
@@ -1716,8 +1712,24 @@ void run_local_timers(void)
 		base++;
 		if (time_before(jiffies, base->clk))
 			return;
+		base--;
+	}
+
+	/*
+	 * check for next expiry
+	 *
+	 * deferrable base is igonred here - it is only usable when
+	 * switching from push to pull model for deferrable timers
+	 */
+	raw_spin_lock_irq(&base->lock);
+	if (base->clk == base->next_expiry) {
+		raw_spin_unlock_irq(&base->lock);
+		raise_softirq(TIMER_SOFTIRQ);
+	} else {
+		base->clk++;
+		raw_spin_unlock_irq(&base->lock);
+		return;
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*
---8<---


Thanks,

	Anna-Maria
