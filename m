Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732022AbeGZSQN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jul 2018 14:16:13 -0400
Date: Thu, 26 Jul 2018 18:58:30 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc 4.16-rt patch] crypto: cryptd - serialize RT request
 enqueue/dequeue with a local lock
Message-ID: <20180726165830.in44kaomyv2grfjr@linutronix.de>
References: <1531322399.12761.37.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531322399.12761.37.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On 2018-07-11 17:19:59 [+0200], Mike Galbraith wrote:
> Note: patch is the result of code inspection...
> 
> cryptod disables preemption to provide request enqueue/dequeue exclusion,
> use a LOCAL_IRQ_LOCK to do the same for RT, keeping preemption enabled.

What about this:

-------- >8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 26 Jul 2018 18:52:00 +0200
Subject: [PATCH] crypto: cryptd - add a lock instead
 preempt_disable/local_bh_disable

cryptd has a per-CPU lock which protected with local_bh_disable() and
preempt_disable().
Add an explicit spin_lock to make the locking context more obvious and
visible to lockdep. Since it is a per-CPU lock, there should be no lock
contention on the actual spinlock.
There is a small race-window where we could be migrated to another CPU
after the cpu_queue has been obtain. This is not a problem because the
actual ressource is protected by the spinlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 crypto/cryptd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index addca7bae33f..8ad657cddc0a 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -39,6 +39,7 @@ MODULE_PARM_DESC(cryptd_max_cpu_qlen, "Set cryptd Max queue depth");
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -117,6 +118,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	pr_info("cryptd: max_cpu_qlen set to %d\n", max_cpu_qlen);
 	return 0;
@@ -141,8 +143,10 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	struct cryptd_cpu_queue *cpu_queue;
 	atomic_t *refcnt;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
+
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
@@ -158,7 +162,7 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_inc(refcnt);
 
 out_put_cpu:
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -174,16 +178,11 @@ static void cryptd_queue_worker(struct work_struct *work)
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

