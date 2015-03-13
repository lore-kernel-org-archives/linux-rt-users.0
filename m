From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 17/31] rt-mutex: avoid a NULL pointer dereference on deadlock
Date: Fri, 13 Mar 2015 11:15:11 -0400
Message-ID: <20150313151517.785489999@goodmis.org>
References: <20150313151454.809081378@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0017-rt-mutex-avoid-a-NULL-pointer-dereference-on-deadloc.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.70-rt75-rc1 stable review patch.
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
 kernel/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index b7b1de2acf0b..5388ba98acaf 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1490,7 +1490,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
-- 
2.1.4
