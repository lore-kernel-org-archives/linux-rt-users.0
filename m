From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/rt-mutex: avoid a NULL pointer dereference on deadlock
Date: Tue, 17 Feb 2015 16:43:43 +0100
Message-ID: <1424187823-19600-1-git-send-email-bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With task_blocks_on_rt_mutex() returning early -EDEADLK we never add the
waiter to the waitqueue. Later, we try to remove it via remove_waiter()
and go boom in rt_mutex_top_waiter() because rb_entry() gives a NULL
pointer.
Tested on v3.18-RT where rtmutex is used for regular mutex and I tried
to get one twice in a row.

Not sure when this started but I guess 397335f00 ("rtmutex: Fix deadlock
detector for real") or commit 3d5c9340 ("rtmutex: Handle deadlock
detection smarter").

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5906c14a4e64..2f95e56ed33e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1700,7 +1700,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
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
