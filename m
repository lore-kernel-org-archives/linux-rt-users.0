From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 3/9] crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
Date: Fri, 21 Dec 2018 09:21:15 -0600
Message-ID: <903494438e80f44195b30fe8c383b18337910d62.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

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
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	crypto/cryptd.c
---
 crypto/cryptd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 828ead458c09..ec32d9bf4651 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -36,6 +36,7 @@
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -97,6 +98,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	return 0;
 }
@@ -119,11 +121,12 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	int cpu, err;
 	struct cryptd_cpu_queue *cpu_queue;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 	queue_work_on(cpu, kcrypto_wq, &cpu_queue->work);
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -139,16 +142,11 @@ static void cryptd_queue_worker(struct work_struct *work)
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
2.14.1
