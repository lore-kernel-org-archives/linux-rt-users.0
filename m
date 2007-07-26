From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH rt[78]] Update externs in wait.h
Date: Thu, 26 Jul 2007 01:20:39 -0700
Message-ID: <1185438039.17414.64.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT Users List <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:42469 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbXGZIUn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 04:20:43 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch syncs up the extern declarations with the changes in sched.c
made in rt7 (drop FASTCALL, change signed long to long)

This fixes a compile error in my debug config for i386.

Thanks

Sven

Subject: 2.6.22.1-rt[78] wait.h extern declarations update

Synchronize extern sleep_on declarations with changes 
to sched.c introduced between 2.6.22.1-rt6 and 2.6.22.1-rt7

signed-off-by: Sven-Thorsten Dietrich <sdietrich@novell.com>

Index: linux-2.6.22/include/linux/wait.h
===================================================================
--- linux-2.6.22.orig/include/linux/wait.h
+++ linux-2.6.22/include/linux/wait.h
@@ -369,12 +369,10 @@ static inline void remove_wait_queue_loc
  * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
  * We plan to remove these interfaces during 2.7.
  */
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
-				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
-						    signed long timeout));
+extern void sleep_on(wait_queue_head_t *q);
+extern long sleep_on_timeout(wait_queue_head_t *q, long timeout);
+extern void interruptible_sleep_on(wait_queue_head_t *q);
+extern long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout);
 
 /*
  * Waitqueues which are removed from the waitqueue_head at wakeup time
