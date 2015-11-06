From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel BUG at kernel/rtmutex_common.h:75
Date: Fri, 6 Nov 2015 15:41:16 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511061215400.4032@nanos>
References: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-145069621-1446813427=:4032"
Cc: linux-rt-users@vger.kernel.org
To: Yimin Deng <yimin11.deng@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60214 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161212AbbKFOl7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 09:41:59 -0500
In-Reply-To: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com>
Content-ID: <alpine.DEB.2.11.1511061540380.4032@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-145069621-1446813427=:4032
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1511061540381.4032@nanos>

B1;2802;0cOn Wed, 4 Nov 2015, Yimin Deng wrote:
> It seems that the purpose to call the remove_waiter() is to remove the
> waiter added by “plist_add(&waiter->list_entry, &lock->wait_list);” in
> the task_blocks_on_rt_mutex(). But in the scenario above there's no
> waiter on the lock yet and
> the waiter has not been added into the wait list of the lock in the
> task_blocks_on_rt_mutex() due to the failure “-EAGAIN”. So it reported
> kernel BUG in the rt_mutex_top_waiter().
> 
> I modified it as below and the issue seems disappear.
> - if (unlikely(ret))
> + if (unlikely(ret && (-EAGAIN != ret)))
>        remove_waiter(lock, waiter);
> 
> Could the scenario above be possible? If so, how to resolve this issue?
> Thanks!

Yes it is possible. Nice detective work!

Your solution is correct, but actually it's not sufficient, because we
have another possibility to return early without being queued
(-EDEADLOCK). Find the full solution below.

Thanks for tracking that down!

       tglx
---
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 7601c1332a88..0e6505d5ce4a 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1003,11 +1003,18 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
 static void remove_waiter(struct rt_mutex *lock,
 			  struct rt_mutex_waiter *waiter)
 {
-	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock = NULL;
+	bool is_top_waiter = false;
 	unsigned long flags;
 
+	/*
+	 * @waiter might be not queued when task_blocks_on_rt_mutex()
+	 * returned early so @lock might not have any waiters.
+	 */
+	if (rt_mutex_has_waiters())
+		is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
+
 	raw_spin_lock_irqsave(&current->pi_lock, flags);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;


--8323329-145069621-1446813427=:4032--
