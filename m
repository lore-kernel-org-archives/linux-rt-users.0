Return-Path: <SRS0=4Gh9=CW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B006C433E2
	for <linux-rt-users@archiver.kernel.org>; Sun, 13 Sep 2020 19:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB4E21655
	for <linux-rt-users@archiver.kernel.org>; Sun, 13 Sep 2020 19:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l/kgAkiK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1U8zk/F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgIMTIx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 13 Sep 2020 15:08:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTIw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 13 Sep 2020 15:08:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600024130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOZs2hWl6sjb+PNiSc9jNHa39SNQKuwpkNrnS0nI/1g=;
        b=l/kgAkiKfyhVWliThcNrKcPiu2FqcGwizbD6S7RYY5nyCbpZsjvjluD2u551vjUVEXXLWd
        x+gpspOdxYCsgh0tW/c+ltqQEms4cnta5zGCQYgRaQX+XIHuTbJeKlZAjGyn2WLiqTqGnx
        DnQvZIaQ3YxC4VYj2INPN7lslmC5TPFGe1vTu1YcWtj1qPTg5PFByqMbmZWmnjWbsbnd3O
        vth6UOq74SrqigeTGh88eGxbnQEF6ZT5ltk/2L0gtzKIJTE6rhysiaWZ9XJcURKPemhqEQ
        IS3Dj3iCsfrUkQQTqd5q3mN5yzprZKkMMT7Y88JICpc6+9iqozUNTBrFOAkONQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600024130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOZs2hWl6sjb+PNiSc9jNHa39SNQKuwpkNrnS0nI/1g=;
        b=1U8zk/F4EUy6NbzfT3hQNfWR5d9M9WPvgUMgRU+Q/biuH0C68fxug/p3uas8dUli3TJXJw
        h5f/b8hyDiDkmrBQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Bo Gan <ganb@vmware.com>, Sharath George <sharathg@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>
Subject: Re: [REGRESSION] Needless shutting down of oneshot timer in nohz mode
In-Reply-To: <20200911234816.474ad4bd@oasis.local.home>
References: <20200911234816.474ad4bd@oasis.local.home>
Date:   Sun, 13 Sep 2020 21:08:49 +0200
Message-ID: <871rj5qyta.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi!,

On Fri, Sep 11 2020 at 23:48, Steven Rostedt wrote:
> The VMware PhotonOS team is evaluating 4.19-rt compared to CentOS
> 3.10-rt (franken kernel from Red Hat). They found a regression between
> the two kernels that was found to be introduced by:
>
>  d25408756accb ("clockevents: Stop unused clockevent devices")
>
> The issue is running this on a guest, and it causes a noticeable wake
> up latency in cyclictest. The 4.19-rt kernel has two extra apic
> instructions causing for two extra VMEXITs to occur over the 3.10-rt
> kernel. I found out the reason why, and this is true for vanilla 5.9-rc
> as well.
>
> When running isocpus with NOHZ_FULL, I see the following.
>
>   tick_nohz_idle_stop_tick() {
> 	hrtimer_start_range_ns() {
> 		remove_hrtimer(timer)
> 			/* no more timers on the base */
> 			expires = KTIME_MAX;
> 			tick_program_event() {
> 				clock_switch_state(ONESHOT_STOPPED);
> 				/* call to apic to shutdown timer */
> 			}
> 		}
> 		[..]
> 		hrtimer_reprogram(timer) {
> 			tick_program_event() {
> 				clock_switch_state(ONESHOT);
> 				/* call to apic to enable timer again! */
> 		}
> 	}
>  }
>
>
> Thus, we are needlessly shutting down and restarting the apic every
> time we call tick_nohz_stop_tick() if there is a timer still on the
> queue.
>
> I'm not exactly sure how to fix this. Is there a way we can hold off
> disabling the clock here until we know that it isn't going to be
> immediately enabled again?

For the hrtimer_start_range_ns() case we can do that. Something like the
completely untested below.

Thanks,

        tglx
---
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95b6a708b040..9931a7f66e47 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -209,6 +209,9 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
 	return base;
 }
 
+static void
+hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal);
+
 /*
  * We switch the timer base to a power-optimized selected CPU target,
  * if:
@@ -223,7 +226,7 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
  */
 static inline struct hrtimer_clock_base *
 switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
-		    int pinned)
+		    int pinned, bool *reprogram_old_base)
 {
 	struct hrtimer_cpu_base *new_cpu_base, *this_cpu_base;
 	struct hrtimer_clock_base *new_base;
@@ -247,6 +250,23 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		if (unlikely(hrtimer_callback_running(timer)))
 			return base;
 
+		/*
+		 * The caller has removed the first expiring timer from
+		 * @base, but avoided reprogramming the clocksource as it
+		 * immediately enqueues a timer again. If the base stays
+		 * the same and the removed timer was the only timer on
+		 * that CPU base then reprogramming in hrtimer_remove()
+		 * would shut down the clock event device just to restart
+		 * it when the timer is enqueued.
+		 *
+		 * timer->base->lock is about to be dropped. Check whether
+		 * the current base needs an update.
+		 */
+		if (*reprogram_old_base) {
+			*reprogram_old_base = false;
+			hrtimer_force_reprogram(base->cpu_base, 1);
+		}
+
 		/* See the comment in lock_hrtimer_base() */
 		WRITE_ONCE(timer->base, &migration_base);
 		raw_spin_unlock(&base->cpu_base->lock);
@@ -288,7 +308,12 @@ lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 	return base;
 }
 
-# define switch_hrtimer_base(t, b, p)	(b)
+static inline struct hrtimer_clock_base *
+switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
+		    int pinned, bool *reprogram_old_base)
+{
+	return base;
+}
 
 #endif	/* !CONFIG_SMP */
 
@@ -1090,9 +1115,20 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    struct hrtimer_clock_base *base)
 {
 	struct hrtimer_clock_base *new_base;
+	bool reprogram_old_base;
+	int ret;
+
+	/*
+	 * If this is the first expiring timer then after removing the
+	 * timer the clock event needs to be reprogrammed. But if the timer
+	 * stays on the same base then this might be a pointless exercise
+	 * because it's immediately enqueued again. Store the state and
+	 * delay reprogramming. See below.
+	 */
+	reprogram_old_base = timer == base->cpu_base->next_timer;
 
 	/* Remove an active timer from the queue: */
-	remove_hrtimer(timer, base, true);
+	remove_hrtimer(timer, base, false);
 
 	if (mode & HRTIMER_MODE_REL)
 		tim = ktime_add_safe(tim, base->get_time());
@@ -1101,10 +1137,21 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
 
-	/* Switch the timer base, if necessary: */
-	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+	/*
+	 * Switch the timer base, if necessary. It the timer was the first
+	 * expiring timer and the timer base is switched then the old base
+	 * is reprogrammed before dropping the cpu base lock. In that case
+	 * reprogram_old_base is then set to false.
+	 */
+	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED,
+				       &reprogram_old_base);
 
-	return enqueue_hrtimer(timer, new_base, mode);
+	ret = enqueue_hrtimer(timer, new_base, mode);
+	if (reprogram_old_base) {
+		hrtimer_force_reprogram(base->cpu_base, 1);
+		ret = 0;
+	}
+	return ret;
 }
 
 /**
