Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E908821;
	Tue,  7 May 2024 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075658; cv=none; b=d4tuuNWJ99YPl3fzC/cOE0QTYmHAKUgGEh5wKWbP+BgWWWVnujYYH5weKY3aJVBnnWkTzX45aTN77MlSn+676R/TzDuJQbjqJsCvn3RkhpLu7db9iIaQTKgesvIKbekZPTdOgtO7dG8/yXjtRV1FMIxOkyfIZYY/+PCk9z2SQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075658; c=relaxed/simple;
	bh=uKaZhoCgy4PjMfGWQKs4PUabUhXvrCkQZiCNI9+NxiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdvmFcUQO1XCdjBM0rFVHsqwXdmWOurA+4wP/Ne/hA9P/F4BAEp6IMz9IqJoRFoAtYosasOk9/x6UH3dFV93+b1++2eUJN25TUuhtUEZhhxg+B2L0ip2HWXbo8tHWX3n+Qf96U3nx9sno7ox8tcU8jQGnbdHb4zJBLYIFziMMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHRn3pqR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ZLUVfRM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHRn3pqR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ZLUVfRM"
Date: Tue, 7 May 2024 11:54:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715075648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dn18k4EvF/6jk0OatfXWNU7+Fp10dMattfndBIVFTzY=;
	b=dHRn3pqRXvhbWDjlDzo76dKBg8YfKGRY4nnUsSCB/oARjwACJPUI/UqVJMe43wyiXYT+Pz
	LhE+V9NM/S7WsZGkGtsp7aeC9Rke9ppiZ3K/Dbwd6UoSHRJojVYH8woJ1LBza6AYV0SuIW
	m6zWSPeyifM/VlVZ+RdcILA7r/LQg3vEaY/VhllHrOr5+rHwJ/XRIKTZlHKj1DwMGKC2f3
	tHZfSuwfQqQQuXxR+5JLk40sJFBsrt9HsHKdPkDtr8FCX+RHilHS74EQYHOCGg/lNTmCzM
	XyV9du+eLKTR65Cc3JKRoRto2oI21fldu73RBoXPXJ9UsRtATkNZtFbv3LY89A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715075648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dn18k4EvF/6jk0OatfXWNU7+Fp10dMattfndBIVFTzY=;
	b=/ZLUVfRMrZubwZx0YMBQskGtbFjriVXAkTZLrvcNTb/M6h59jkac8FNW+dk51hnE9Q4PqG
	AA8hY1uTe5Q/x2Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.312-rt134-rc2
Message-ID: <20240507095407.jAjEuCJ8@linutronix.de>
References: <20240506104602.16972-1-wagi@monom.org>
 <5c3ff133-6953-448b-a1e1-6bacbc210e4d@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c3ff133-6953-448b-a1e1-6bacbc210e4d@monom.org>

On 2024-05-06 13:00:39 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi Daniel,

> On 06.05.24 12:46, Daniel Wagner wrote:
> > Dear RT Folks,
> > 
> > This is the RT stable review cycle of patch 4.19.312-rt134-rc2.
> > 
> > Please scream at me if I messed something up. Please test the patches
> > too.
> 
> My announce script is not attaching any conflict resolve diffs
> (eventually, I'll fix this). Could have a look if I got the
> kernel/time/timer.c upddate right? This was caused by stable
> including the 030dcdd197d7 ("timers: Prepare support for
> PREEMPT_RT") patch.

I compared mine outcome vs v4.19-rt-next and the diff at the bottom came
out:

- timer_delete_sync() used to have "#if 0" block around
  lockdep_assert_preemption_enabled() because the function is not part
  of v4.19. You ended up with might_sleep() which is a minor change.
  Your queue as of a previous release had the if0 block (in
  __del_timer_sync()).
  I would say this is minor but looks like a miss-merge. Therefore I
  would say it should go back for consistency vs previous release and
  not change it due to conflicts.

- The timer_delete_sync() is structured differently with
  __del_timer_sync(). That function invokes timer_sync_wait_running()
  which drops two locks which are not acquired. That is wrong. It should
  have been del_timer_wait_running().

I suggest you apply the diff below to align it with later versions. It
also gets rid of the basep argument in __try_to_del_timer_sync() which
is not really used.

As an alternative I can send you my rebased queue if this makes it
easier for you.

Sebastian

------------------>8-----------------

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1250,25 +1250,6 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-static int __try_to_del_timer_sync(struct timer_list *timer,
-				   struct timer_base **basep)
-{
-	struct timer_base *base;
-	unsigned long flags;
-	int ret = -1;
-
-	debug_assert_init(timer);
-
-	*basep = base = lock_timer_base(timer, &flags);
-
-	if (base->running_timer != timer)
-		ret = detach_if_pending(timer, base, true);
-
-	raw_spin_unlock_irqrestore(&base->lock, flags);
-
-	return ret;
-}
-
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
  * @timer:	Timer to deactivate
@@ -1288,8 +1269,19 @@ static int __try_to_del_timer_sync(struct timer_list *timer,
 int try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
+	unsigned long flags;
+	int ret = -1;
 
-	return __try_to_del_timer_sync(timer, &base);
+	debug_assert_init(timer);
+
+	base = lock_timer_base(timer, &flags);
+
+	if (base->running_timer != timer)
+		ret = detach_if_pending(timer, base, true);
+
+	raw_spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
@@ -1366,36 +1358,6 @@ static inline void timer_sync_wait_running(struct timer_base *base) { }
 static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
-static int __del_timer_sync(struct timer_list *timer)
-{
-	struct timer_base *base;
-	int ret;
-
-	/*
-	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
-	 * del_timer_wait_running().
-	 */
-#if 0
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
-		lockdep_assert_preemption_enabled();
-#endif
-
-	for (;;) {
-		ret = __try_to_del_timer_sync(timer, &base);
-		if (ret >= 0)
-			return ret;
-
-		if (READ_ONCE(timer->flags) & TIMER_IRQSAFE)
-			continue;
-
-		/*
-		 * When accessing the lock, timers of base are no longer expired
-		 * and so timer is no longer running.
-		 */
-		timer_sync_wait_running(base);
-	}
-}
-
 /**
  * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
  * @timer:	The timer to be deactivated
@@ -1437,6 +1399,8 @@ static int __del_timer_sync(struct timer_list *timer)
  */
 int timer_delete_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1454,14 +1418,26 @@ int timer_delete_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+
 	/*
 	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
-	 * __del_timer_sync().
+	 * del_timer_wait_running().
 	 */
+#if 0
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
-		might_sleep();
+		lockdep_assert_preemption_enabled();
+#endif
 
-	return __del_timer_sync(timer);
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(timer_delete_sync);
 
