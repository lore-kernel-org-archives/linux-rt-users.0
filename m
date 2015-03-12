From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 16/39] locking/rt-mutex: avoid a NULL pointer dereference on deadlock
Date: Thu, 12 Mar 2015 15:13:23 -0400
Message-ID: <20150312191409.707856750@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:16561 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755353AbbCLTP2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:15:28 -0400
Content-Disposition: inline; filename=0016-locking-rt-mutex-avoid-a-NULL-pointer-dereference-on.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With task_blocks_on_rt_mutex() returning early -EDEADLK we never add the
waiter to the waitqueue. Later, we try to remove it via remove_waiter()
and go boom in rt_mutex_top_waiter() because rb_entry() gives a NULL
pointer.
Tested on v3.18-RT where rtmutex is used for regular mutex and I tried
to get one twice in a row.

Not sure when this started but I guess 397335f00 ("rtmutex: Fix deadlock
detector for real") or commit 3d5c9340 ("rtmutex: Handle deadlock
detection smarter").

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index a0d9eadcfe02..ec72272ab73a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1697,7 +1697,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
-- 
2.1.4


