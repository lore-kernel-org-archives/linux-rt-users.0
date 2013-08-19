From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] swait: Add memory barrier before checking list empty
Date: Mon, 19 Aug 2013 11:35:32 -0400
Message-ID: <20130819153618.983248997@goodmis.org>
References: <20130819153530.409041534@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9345 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3HSPgV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Aug 2013 11:36:21 -0400
Content-Disposition: inline; filename=0002-swait-Add-memory-barrier-before-checking-list-empty.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <rostedt@goodmis.org>

There's a race condition with swait wakeups and adding to the list. The
__swait_wake() does a check for swait_head_has_waiters(), and if it is
empty it will exit without doing any wake ups. The problem is that the
check does not include any memory barriers before it makes a decision
to wake up or not.

	CPU0				CPU1
	----				----

  condition = 1

  load h->list (is empty)
				    raw_spin_lock(hlist->lock)
				    hlist_add();
				    __set_current_state();
				    raw_spin_unlock(hlist->lock)
  swait_wake()
   swait_head_has_waiters()
   (sees h->list as empty and returns)

				    check_condition (sees condition = 0)

   store condition = 1

				    schedule()

Now the task on CPU1 has just missed its wakeup. By adding a memory
barrier before the list empty check, we fix the problem of miss seeing
the list not empty as well as pushing out the condition for the other
task to see.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/wait-simple.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/wait-simple.c b/kernel/wait-simple.c
index 4b9a0b5..9725a11 100644
--- a/kernel/wait-simple.c
+++ b/kernel/wait-simple.c
@@ -27,6 +27,8 @@ static inline void __swait_dequeue(struct swaiter *w)
 /* Check whether a head has waiters enqueued */
 static inline bool swait_head_has_waiters(struct swait_head *h)
 {
+	/* Make sure the condition is visible before checking list_empty() */
+	smp_mb();
 	return !list_empty(&h->list);
 }
 
-- 
1.7.10.4


