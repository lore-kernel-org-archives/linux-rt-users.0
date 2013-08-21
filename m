From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Wed, 21 Aug 2013 19:24:31 +0200
Message-ID: <20130821172431.GD16913@linutronix.de>
References: <102271374683007@web8f.yandex.ru>
 <20130812164145.GJ23040@linutronix.de>
 <393831376342036@web15d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Alexander Fyodorov <halcy@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37943 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab3HURYd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Aug 2013 13:24:33 -0400
Content-Disposition: inline
In-Reply-To: <393831376342036@web15d.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexander Fyodorov | 2013-08-13 01:13:56 [+0400]:

>Hi Sebastian,
Hi Alexander,

>Is there a need to write a test?

It is nice to have so it can be checked if this bug is fixed "some place
else".

Now that I looked at it for a while, would this fix your trouble?

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -724,6 +724,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	struct task_struct *lock_owner, *self = current;
 	struct rt_mutex_waiter waiter, *top_waiter;
 	int ret;
+	int new_state;
 
 	rt_mutex_init_waiter(&waiter, true);
 
@@ -744,8 +745,11 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	 * try_to_wake_up().
 	 */
 	pi_lock(&self->pi_lock);
+	new_state = TASK_UNINTERRUPTIBLE;
+	if (task_is_traced(self))
+		new_state |= __TASK_TRACED;
 	self->saved_state = self->state;
-	__set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state(new_state);
 	pi_unlock(&self->pi_lock);
 
 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);

This should avoid that the trace state is lost while waiting on that
mutex and the checks for "is traced" may remain the same.

Sebastian
