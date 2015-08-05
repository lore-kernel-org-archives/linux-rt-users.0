From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/7] ipc/mqueue: Implement lockless pipelined wakeups
Date: Tue, 04 Aug 2015 21:18:31 -0400
Message-ID: <20150805011853.050798492@goodmis.org>
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
	George Spelvin <linux@horizon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Chris Mason <clm@fb.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Manfred Spraul <manfred@colorfullife.com>, <dave@stgolabs.net>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-ipc-mqueue-Implement-lockless-pipelined-wakeups.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.18-rt16-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

This patch moves the wakeup_process() invocation so it is not done under
the info->lock by making use of a lockless wake_q. With this change, the
waiter is woken up once it is STATE_READY and it does not need to loop
on SMP if it is still in STATE_PENDING. In the timeout case we still need
to grab the info->lock to verify the state.

This change should also avoid the introduction of preempt_disable() in -rt
which avoids a busy-loop which pools for the STATE_PENDING -> STATE_READY
change if the waiter has a higher priority compared to the waker.

Additionally, this patch micro-optimizes wq_sleep by using the cheaper
cousin of set_current_state(TASK_INTERRUPTABLE) as we will block no
matter what, thus get rid of the implied barrier.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: George Spelvin <linux@horizon.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris Mason <clm@fb.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: dave@stgolabs.net
Link: http://lkml.kernel.org/r/1430748166.1940.17.camel@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 ipc/mqueue.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 516902313dc3..79351b5dd0a1 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -47,8 +47,7 @@
 #define RECV		1
 
 #define STATE_NONE	0
-#define STATE_PENDING	1
-#define STATE_READY	2
+#define STATE_READY	1
 
 struct posix_msg_tree_node {
 	struct rb_node		rb_node;
@@ -571,15 +570,12 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
 	wq_add(info, sr, ewp);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_unlock(&info->lock);
 		time = schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
 
-		while (ewp->state == STATE_PENDING)
-			cpu_relax();
-
 		if (ewp->state == STATE_READY) {
 			retval = 0;
 			goto out;
@@ -907,11 +903,15 @@ out_name:
  * list of waiting receivers. A sender checks that list before adding the new
  * message into the message array. If there is a waiting receiver, then it
  * bypasses the message array and directly hands the message over to the
- * receiver.
- * The receiver accepts the message and returns without grabbing the queue
- * spinlock. Therefore an intermediate STATE_PENDING state and memory barriers
- * are necessary. The same algorithm is used for sysv semaphores, see
- * ipc/sem.c for more details.
+ * receiver. The receiver accepts the message and returns without grabbing the
+ * queue spinlock:
+ *
+ * - Set pointer to message.
+ * - Queue the receiver task for later wakeup (without the info->lock).
+ * - Update its state to STATE_READY. Now the receiver can continue.
+ * - Wake up the process after the lock is dropped. Should the process wake up
+ *   before this wakeup (due to a timeout or a signal) it will either see
+ *   STATE_READY and continue or acquire the lock to check the state again.
  *
  * The same algorithm is used for senders.
  */
@@ -919,7 +919,8 @@ out_name:
 /* pipelined_send() - send a message directly to the task waiting in
  * sys_mq_timedreceive() (without inserting message into a queue).
  */
-static inline void pipelined_send(struct mqueue_inode_info *info,
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
 				  struct msg_msg *message,
 				  struct ext_wait_queue *receiver)
 {
@@ -929,16 +930,23 @@ static inline void pipelined_send(struct mqueue_inode_info *info,
 	preempt_disable_rt();
 	receiver->msg = message;
 	list_del(&receiver->list);
-	receiver->state = STATE_PENDING;
-	wake_up_process(receiver->task);
-	smp_wmb();
+	wake_q_add(wake_q, receiver->task);
+	/*
+	 * Rely on the implicit cmpxchg barrier from wake_q_add such
+	 * that we can ensure that updating receiver->state is the last
+	 * write operation: As once set, the receiver can continue,
+	 * and if we don't have the reference count from the wake_q,
+	 * yet, at that point we can later have a use-after-free
+	 * condition and bogus wakeup.
+	 */
 	receiver->state = STATE_READY;
 	preempt_enable_rt();
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
  * gets its message and put to the queue (we have one free place for sure). */
-static inline void pipelined_receive(struct mqueue_inode_info *info)
+static inline void pipelined_receive(struct wake_q_head *wake_q,
+				     struct mqueue_inode_info *info)
 {
 	struct ext_wait_queue *sender = wq_get_first_waiter(info, SEND);
 
@@ -953,9 +961,7 @@ static inline void pipelined_receive(struct mqueue_inode_info *info)
 	preempt_disable_rt();
 	if (!msg_insert(sender->msg, info)) {
 		list_del(&sender->list);
-		sender->state = STATE_PENDING;
-		wake_up_process(sender->task);
-		smp_wmb();
+		wake_q_add(wake_q, sender->task);
 		sender->state = STATE_READY;
 	}
 	preempt_enable_rt();
@@ -975,6 +981,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	struct timespec ts;
 	struct posix_msg_tree_node *new_leaf = NULL;
 	int ret = 0;
+	WAKE_Q(wake_q);
 
 	if (u_abs_timeout) {
 		int res = prepare_timeout(u_abs_timeout, &expires, &ts);
@@ -1059,7 +1066,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	} else {
 		receiver = wq_get_first_waiter(info, RECV);
 		if (receiver) {
-			pipelined_send(info, msg_ptr, receiver);
+			pipelined_send(&wake_q, info, msg_ptr, receiver);
 		} else {
 			/* adds message to the queue */
 			ret = msg_insert(msg_ptr, info);
@@ -1072,6 +1079,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	}
 out_unlock:
 	spin_unlock(&info->lock);
+	wake_up_q(&wake_q);
 out_free:
 	if (ret)
 		free_msg(msg_ptr);
@@ -1159,14 +1167,17 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 			msg_ptr = wait.msg;
 		}
 	} else {
+		WAKE_Q(wake_q);
+
 		msg_ptr = msg_get(info);
 
 		inode->i_atime = inode->i_mtime = inode->i_ctime =
 				CURRENT_TIME;
 
 		/* There is now free space in queue. */
-		pipelined_receive(info);
+		pipelined_receive(&wake_q, info);
 		spin_unlock(&info->lock);
+		wake_up_q(&wake_q);
 		ret = 0;
 	}
 	if (ret == 0) {
-- 
2.1.4
