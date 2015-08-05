From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/7] futex: Implement lockless wakeups
Date: Tue, 04 Aug 2015 21:18:30 -0400
Message-ID: <20150805011852.899106598@goodmis.org>
References: <20150805011826.881627614@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>, Davidlohr Bueso <dbueso@suse.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Chris Mason <clm@fb.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	George Spelvin <linux@horizon.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-futex-Implement-lockless-wakeups.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.18-rt16-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

Given the overall futex architecture, any chance of reducing
hb->lock contention is welcome. In this particular case, using
wake-queues to enable lockless wakeups addresses very much real
world performance concerns, even cases of soft-lockups in cases
of large amounts of blocked tasks (which is not hard to find in
large boxes, using but just a handful of futex).

At the lowest level, this patch can reduce latency of a single thread
attempting to acquire hb->lock in highly contended scenarios by a
up to 2x. At lower counts of nr_wake there are no regressions,
confirming, of course, that the wake_q handling overhead is practically
non existent. For instance, while a fair amount of variation,
the extended pef-bench wakeup benchmark shows for a 20 core machine
the following avg per-thread time to wakeup its share of tasks:

	nr_thr	ms-before	ms-after
	16 	0.0590		0.0215
	32 	0.0396		0.0220
	48 	0.0417		0.0182
	64 	0.0536		0.0236
	80 	0.0414		0.0097
	96 	0.0672		0.0152

Naturally, this can cause spurious wakeups. However there is no core code
that cannot handle them afaict, and furthermore tglx does have the point
that other events can already trigger them anyway.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris Mason <clm@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: George Spelvin <linux@horizon.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/1430494072-30283-3-git-send-email-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/futex.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 647ff4b3a150..f9172a5ee332 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1092,9 +1092,11 @@ static void __unqueue_futex(struct futex_q *q)
 
 /*
  * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
  */
-static void wake_futex(struct futex_q *q)
+static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p = q->task;
 
@@ -1102,14 +1104,10 @@ static void wake_futex(struct futex_q *q)
 		return;
 
 	/*
-	 * We set q->lock_ptr = NULL _before_ we wake up the task. If
-	 * a non-futex wake up happens on another CPU then the task
-	 * might exit and p would dereference a non-existing task
-	 * struct. Prevent this by holding a reference on p across the
-	 * wake up.
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
 	 */
-	get_task_struct(p);
-
+	wake_q_add(wake_q, p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as
@@ -1119,9 +1117,6 @@ static void wake_futex(struct futex_q *q)
 	 */
 	smp_wmb();
 	q->lock_ptr = NULL;
-
-	wake_up_state(p, TASK_NORMAL);
-	put_task_struct(p);
 }
 
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this)
@@ -1219,6 +1214,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
 	int ret;
+	WAKE_Q(wake_q);
 
 	if (!bitset)
 		return -EINVAL;
@@ -1246,13 +1242,14 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
 	}
 
 	spin_unlock(&hb->lock);
+	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
 out:
@@ -1271,6 +1268,7 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	int ret, op_ret;
+	WAKE_Q(wake_q);
 
 retry:
 	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, VERIFY_READ);
@@ -1322,7 +1320,7 @@ retry_private:
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -1336,7 +1334,7 @@ retry_private:
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				wake_futex(this);
+				mark_wake_futex(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
@@ -1346,6 +1344,7 @@ retry_private:
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 out_put_keys:
 	put_futex_key(&key2);
 out_put_key1:
@@ -1505,6 +1504,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_pi_state *pi_state = NULL;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
+	WAKE_Q(wake_q);
 
 	if (requeue_pi) {
 		/*
@@ -1681,7 +1681,7 @@ retry_private:
 		 * woken by futex_unlock_pi().
 		 */
 		if (++task_count <= nr_wake && !requeue_pi) {
-			wake_futex(this);
+			mark_wake_futex(&wake_q, this);
 			continue;
 		}
 
@@ -1731,6 +1731,7 @@ retry_private:
 out_unlock:
 	free_pi_state(pi_state);
 	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
 
 	/*
-- 
2.1.4
