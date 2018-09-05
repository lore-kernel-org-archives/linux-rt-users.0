From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 16/22] crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
Date: Wed, 05 Sep 2018 08:28:10 -0400
Message-ID: <20180905122836.928502373@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 21aedb30d85979697f79a72a084e5d781e323663 ]

cryptd has a per-CPU lock which protected with local_bh_disable() and
preempt_disable().
Add an explicit spin_lock to make the locking context more obvious and
visible to lockdep. Since it is a per-CPU lock, there should be no lock
contention on the actual spinlock.
There is a small race-window where we could be migrated to another CPU
after the cpu_queue has been obtain. This is not a problem because the
actual ressource is protected by the spinlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 crypto/cryptd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 248f6ba41688..54b7985c8caa 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -37,6 +37,7 @@
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -115,6 +116,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	return 0;
 }
@@ -139,8 +141,10 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_t *refcnt;
 	bool may_backlog;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
+
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
@@ -157,7 +161,7 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_inc(refcnt);
 
 out_put_cpu:
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -173,16 +177,11 @@ static void cryptd_queue_worker(struct work_struct *work)
 	cpu_queue = container_of(work, struct cryptd_cpu_queue, work);
 	/*
 	 * Only handle one request at a time to avoid hogging crypto workqueue.
-	 * preempt_disable/enable is used to prevent being preempted by
-	 * cryptd_enqueue_request(). local_bh_disable/enable is used to prevent
-	 * cryptd_enqueue_request() being accessed from software interrupts.
 	 */
-	local_bh_disable();
-	preempt_disable();
+	spin_lock_bh(&cpu_queue->qlock);
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
-	preempt_enable();
-	local_bh_enable();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	if (!req)
 		return;
-- 
2.18.0
