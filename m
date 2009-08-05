From: Darren Hart <dvhltc@us.ibm.com>
Subject: [PATCH 2/2][RT] Avoid deadlock in rt_mutex_start_proxy_lock()
Date: Wed, 05 Aug 2009 15:04:12 -0700
Message-ID: <4A7A01DC.2010909@us.ibm.com>
References: <4A7A009E.2000202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
	mingo@elte.hu, dino@in.ibm.com, johnstul@us.ibm.com,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:35549 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZHEWEQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Aug 2009 18:04:16 -0400
In-Reply-To: <4A7A009E.2000202@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In the event of a lock steal or owner died, rt_mutex_start_proxy_lock() will
give the rt_mutex to the waiting task, but it fails to release the wait_lock.
This leads to subsequent deadlocks when other tasks try to acquire the
rt_mutex.

I also removed a few extra blank lines that really spaced this routine out.
I must have been high on the \n when I wrote this originally...

Note: this is the -rt version, I'll send another for mainline.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>
CC: Dinakar Guniguntala <dino@in.ibm.com>
CC: John Stultz <johnstul@us.ibm.com>
CC: John Kacur <jkacur@redhat.com>

Index: 2.6.31-rc4-rt1/kernel/rtmutex.c
===================================================================
--- 2.6.31-rc4-rt1.orig/kernel/rtmutex.c	2009-08-05 10:29:39.000000000 -0700
+++ 2.6.31-rc4-rt1/kernel/rtmutex.c	2009-08-05 11:10:22.000000000 -0700
@@ -1517,9 +1517,8 @@ int rt_mutex_start_proxy_lock(struct rt_
 	    try_to_steal_lock(lock, task, STEAL_NORMAL)) {
 		/* We got the lock for task. */
 		debug_rt_mutex_lock(lock);
-
 		rt_mutex_set_owner(lock, task, 0);
-
+		atomic_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		rt_mutex_deadlock_account_lock(lock, task);
 		return 1;
 	}
@@ -1527,7 +1526,6 @@ int rt_mutex_start_proxy_lock(struct rt_
 	ret = task_blocks_on_rt_mutex(lock, waiter, task, detect_deadlock,
 				      flags);
 
