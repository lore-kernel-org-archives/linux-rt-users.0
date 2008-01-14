From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] fix up leak_check calls
Date: Mon, 14 Jan 2008 09:46:39 -0800
Message-ID: <20080114174639.214586398@mvista.com>
Cc: rostedt@goodmis.org, mingo@elte.hu, peterz@infradead.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:10663 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750839AbYANRrq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 12:47:46 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If lockdep is enabled the lock_aquire() calls with trigger the leak_check().

We need to check prior to calling lock_aquire/lock_release, so we're only
checking locks taken in the workqueue function.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 kernel/workqueue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.23/kernel/workqueue.c
===================================================================
--- linux-2.6.23.orig/kernel/workqueue.c
+++ linux-2.6.23/kernel/workqueue.c
@@ -326,13 +326,13 @@ again:
 
 		BUG_ON(get_wq_data(work) != cwq);
 		work_clear_pending(work);
+		leak_check(NULL);
 		lock_acquire(&cwq->wq->lockdep_map, 0, 0, 0, 2, _THIS_IP_);
 		lock_acquire(&lockdep_map, 0, 0, 0, 2, _THIS_IP_);
-		leak_check(NULL);
 		f(work);
-		leak_check(f);
 		lock_release(&lockdep_map, 1, _THIS_IP_);
 		lock_release(&cwq->wq->lockdep_map, 1, _THIS_IP_);
+		leak_check(f);
 
 		spin_lock_irq(&cwq->lock);
 		cwq->current_work = NULL;
-- 

-- 
