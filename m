From: Darren Hart <dvhltc@us.ibm.com>
Subject: [PATCH 2/4] rtmutex: add BUG_ON if a task attempts to block on two locks
Date: Fri,  9 Jul 2010 15:32:58 -0700
Message-ID: <1278714780-788-3-git-send-email-dvhltc@us.ibm.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

rtmutex proxy locking complicates the logic a bit and opens up
the possibility for a task to wake and attempt to take another
sleeping lock without knowing it has been enqueued on another
lock already. Add a BUG_ON to catch this scenario early.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Galbraith <efault@gmx.de>
---
 kernel/rtmutex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index baac7d9..22f9d18 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -459,6 +459,9 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		top_waiter = rt_mutex_top_waiter(lock);
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
+	/* Tasks can only block on one lock at a time. */
+	BUG_ON(task->pi_blocked_on != NULL);
+
 	task->pi_blocked_on = waiter;
 
 	raw_spin_unlock(&task->pi_lock);
-- 
1.7.0.4
