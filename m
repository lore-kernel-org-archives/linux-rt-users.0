Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1E75815;
	Mon,  6 May 2024 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993247; cv=none; b=SRDxJz1tYthxHq7Bnv/PYta/Q40fMN/GzAl+0QiBjfOezLoEt5QG0mgB3DA2R3jkBsWNt+JZe0shKNJQmZ5eD3ag8y7NqlsrqAeI7w9AawSt7Z6QsQRuCappwalfwqwpZpU5PSMjaj1oohC5ZzGBJZO0edkFiZhjm4y9NJJfOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993247; c=relaxed/simple;
	bh=aqZIiaSOq8JI0BUAzDvqll6WIagy+1ARhuwrGCWphRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hsto0Cug9G8agrrGZIgtOPXOymMfX3Hud6IzToo6AMJ86NhcHxVKuBlykDsIFmbjuKb37gp+DD4cILLb2oRjfL+1mifhvqvuzpOIB1UHL2VZ/tsOkYPOzRsT5twA6EvDrjQPhnIUT7E2ip7zIVHd5lAk47BGvV0Su/xKz5FieGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=Sq1ZmXIv; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="Sq1ZmXIv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAD94DB3C0;
	Mon,  6 May 2024 13:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1714993241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4G/9nk5R22HmS9ye766i7LpuXgMNMXiGm9iIuhEN1+c=;
	b=Sq1ZmXIvth7PsahANmO3qOxHo+6aJJu+MsQOWUMMKWrDXJEDYjOObys0a3qh7qjgrSzme4
	pjebTfyEUCaX2t0lXRZvHps3WWkmYsO1+PRUyq/iwXb/uxvpDuLCz6JOD/Qmw+mR0sJrYS
	hMgT6nAZkNrL+fnEVlxQWn+KBZ1IPZxZv5w8r/vQ69Jt9v4IUi6Uh+Eb83CX+euSlFTdlm
	7zPQQF8uCI1ln6QrBpM99BVOi+7H1rCFCk+4r3NHcaup/x4Zm6/nqkLHDpB16tR1767/7R
	QXcA9bOvIsEP8GFN6hCqzHxe2wBjm+g97d+nFCPJPPEh1XKrGgLdLNvvsDFhGQ==
Message-ID: <5c3ff133-6953-448b-a1e1-6bacbc210e4d@monom.org>
Date: Mon, 6 May 2024 13:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RT 0/1] Linux v4.19.312-rt134-rc2
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240506104602.16972-1-wagi@monom.org>
From: Daniel Wagner <wagi@monom.org>
Cc: stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Clark Williams <williams@redhat.com>
In-Reply-To: <20240506104602.16972-1-wagi@monom.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sebastian,

On 06.05.24 12:46, Daniel Wagner wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.19.312-rt134-rc2.
> 
> Please scream at me if I messed something up. Please test the patches
> too.

My announce script is not attaching any conflict resolve diffs
(eventually, I'll fix this). Could have a look if I got the
kernel/time/timer.c upddate right? This was caused by stable
including the 030dcdd197d7 ("timers: Prepare support for
PREEMPT_RT") patch.

commit 2c1a32c5e05fd75885186793bc0d26e0a65b473d
Merge: 4790d0210f19 3d86e7f5bdf3
Author: Daniel Wagner <wagi@monom.org>
Date:   Wed Apr 17 16:31:21 2024 +0200

     Merge tag 'v4.19.312' into v4.19-rt-next

     This is the 4.19.312 stable release

     Conflicts:
             include/linux/timer.h
             kernel/time/timer.c

diff --git a/include/linux/timer.h b/include/linux/timer.h
remerge CONFLICT (content): Merge conflict in include/linux/timer.h
index b70c5168a346..aef40cac2add 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -173,13 +173,6 @@ extern void add_timer(struct timer_list *timer);
  extern int try_to_del_timer_sync(struct timer_list *timer);
  extern int timer_delete_sync(struct timer_list *timer);

-<<<<<<< 4790d0210f19 (Linux 4.19.307-rt133)
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define del_timer_sync(t)		del_timer(t)
-#endif
-=======
  /**
   * del_timer_sync - Delete a pending timer and wait for a running callback
   * @timer:	The timer to be deleted
@@ -192,7 +185,6 @@ static inline int del_timer_sync(struct timer_list 
*timer)
  {
  	return timer_delete_sync(timer);
  }
->>>>>>> 3d86e7f5bdf3 (Linux 4.19.312)

  #define del_singleshot_timer_sync(t) del_timer_sync(t)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
remerge CONFLICT (content): Merge conflict in kernel/time/timer.c
index 911191916df1..bc5ce0cf9488 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1250,6 +1250,25 @@ int del_timer(struct timer_list *timer)
  }
  EXPORT_SYMBOL(del_timer);

+static int __try_to_del_timer_sync(struct timer_list *timer,
+				   struct timer_base **basep)
+{
+	struct timer_base *base;
+	unsigned long flags;
+	int ret = -1;
+
+	debug_assert_init(timer);
+
+	*basep = base = lock_timer_base(timer, &flags);
+
+	if (base->running_timer != timer)
+		ret = detach_if_pending(timer, base, true);
+
+	raw_spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
+}
+
  /**
   * try_to_del_timer_sync - Try to deactivate a timer
   * @timer:	Timer to deactivate
@@ -1269,19 +1288,8 @@ EXPORT_SYMBOL(del_timer);
  int try_to_del_timer_sync(struct timer_list *timer)
  {
  	struct timer_base *base;
-	unsigned long flags;
-	int ret = -1;
-
-	debug_assert_init(timer);
-
-	base = lock_timer_base(timer, &flags);
-
-	if (base->running_timer != timer)
-		ret = detach_if_pending(timer, base, true);
-
-	raw_spin_unlock_irqrestore(&base->lock, flags);

-	return ret;
+	return __try_to_del_timer_sync(timer, &base);
  }
  EXPORT_SYMBOL(try_to_del_timer_sync);

@@ -1303,7 +1311,6 @@ static inline void timer_base_unlock_expiry(struct 
timer_base *base)

  /*
   * The counterpart to del_timer_wait_running().
-<<<<<<< 4790d0210f19 (Linux 4.19.307-rt133)
   *
   * If there is a waiter for base->expiry_lock, then it was waiting for the
   * timer callback to finish. Drop expiry_lock and reaquire it. That allows
@@ -1359,64 +1366,35 @@ static inline void 
timer_sync_wait_running(struct timer_base *base) { }
  static inline void del_timer_wait_running(struct timer_list *timer) { }
  #endif

-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
-/**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
-=======
->>>>>>> 3d86e7f5bdf3 (Linux 4.19.312)
- *
- * If there is a waiter for base->expiry_lock, then it was waiting for the
- * timer callback to finish. Drop expiry_lock and reaquire it. That allows
- * the waiter to acquire the lock and make progress.
- */
-static void timer_sync_wait_running(struct timer_base *base)
+static int __del_timer_sync(struct timer_list *timer)
  {
-	if (atomic_read(&base->timer_waiters)) {
-		spin_unlock(&base->expiry_lock);
-		spin_lock(&base->expiry_lock);
-	}
-}
+	struct timer_base *base;
+	int ret;

-/*
- * This function is called on PREEMPT_RT kernels when the fast path
- * deletion of a timer failed because the timer callback function was
- * running.
- *
- * This prevents priority inversion, if the softirq thread on a remote CPU
- * got preempted, and it prevents a life lock when the task which tries to
- * delete a timer preempted the softirq thread running the timer callback
- * function.
- */
-static void del_timer_wait_running(struct timer_list *timer)
-{
-	u32 tf;
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+#if 0
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+#endif

-	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
-		struct timer_base *base = get_timer_base(tf);
+	for (;;) {
+		ret = __try_to_del_timer_sync(timer, &base);
+		if (ret >= 0)
+			return ret;
+
+		if (READ_ONCE(timer->flags) & TIMER_IRQSAFE)
+			continue;

  		/*
-		 * Mark the base as contended and grab the expiry lock,
-		 * which is held by the softirq across the timer
-		 * callback. Drop the lock immediately so the softirq can
-		 * expire the next timer. In theory the timer could already
-		 * be running again, but that's more than unlikely and just
-		 * causes another wait loop.
+		 * When accessing the lock, timers of base are no longer expired
+		 * and so timer is no longer running.
  		 */
-		atomic_inc(&base->timer_waiters);
-		spin_lock_bh(&base->expiry_lock);
-		atomic_dec(&base->timer_waiters);
-		spin_unlock_bh(&base->expiry_lock);
+		timer_sync_wait_running(base);
  	}
  }
-#else
-static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
-static inline void timer_base_lock_expiry(struct timer_base *base) { }
-static inline void timer_base_unlock_expiry(struct timer_base *base) { }
-static inline void timer_sync_wait_running(struct timer_base *base) { }
-static inline void del_timer_wait_running(struct timer_list *timer) { }
-#endif

  /**
   * timer_delete_sync - Deactivate a timer and wait for the handler to 
finish.
@@ -1459,8 +1437,6 @@ static inline void del_timer_wait_running(struct 
timer_list *timer) { }
   */
  int timer_delete_sync(struct timer_list *timer)
  {
-	int ret;
-
  #ifdef CONFIG_LOCKDEP
  	unsigned long flags;

@@ -1478,43 +1454,14 @@ int timer_delete_sync(struct timer_list *timer)
  	 * could lead to deadlock.
  	 */
  	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-<<<<<<< 4790d0210f19 (Linux 4.19.307-rt133)
-
  	/*
  	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
-	 * del_timer_wait_running().
+	 * __del_timer_sync().
  	 */
-#if 0
  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
-		lockdep_assert_preemption_enabled();
-#endif
-
-	do {
-		ret = try_to_del_timer_sync(timer);
+		might_sleep();

-		if (unlikely(ret < 0)) {
-			del_timer_wait_running(timer);
-			cpu_relax();
-		}
-	} while (ret < 0);
-
-	return ret;
-}
-EXPORT_SYMBOL(del_timer_sync);
-#endif
-=======
->>>>>>> 3d86e7f5bdf3 (Linux 4.19.312)
-
-	do {
-		ret = try_to_del_timer_sync(timer);
-
-		if (unlikely(ret < 0)) {
-			del_timer_wait_running(timer);
-			cpu_relax();
-		}
-	} while (ret < 0);
-
-	return ret;
+	return __del_timer_sync(timer);
  }
  EXPORT_SYMBOL(timer_delete_sync);

@@ -1585,14 +1532,11 @@ static void expire_timers(struct timer_base 
*base, struct hlist_head *head)
  		if (timer->flags & TIMER_IRQSAFE) {
  			raw_spin_unlock(&base->lock);
  			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
  			raw_spin_lock(&base->lock);
  			base->running_timer = NULL;
  		} else {
  			raw_spin_unlock_irq(&base->lock);
  			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
-			timer_sync_wait_running(base);
  			raw_spin_lock_irq(&base->lock);
  			base->running_timer = NULL;
  			timer_sync_wait_running(base);
