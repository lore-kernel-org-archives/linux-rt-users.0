From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 17/27] rt-mutex: avoid a NULL pointer dereference on deadlock
Date: Fri, 13 Mar 2015 11:17:58 -0400
Message-ID: <20150313151757.724517846@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
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
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:33859 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756136AbbCMPSC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 11:18:02 -0400
Content-Disposition: inline; filename=0017-rt-mutex-avoid-a-NULL-pointer-dereference-on-deadloc.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.106-rt132-rc1 stable review patch.
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
index 1889aedfad86..4cc273b85beb 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1487,7 +1487,8 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(ret)) {
-		remove_waiter(lock, &waiter);
+		if (rt_mutex_has_waiters(lock))
+			remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	}
 
-- 
2.1.4


