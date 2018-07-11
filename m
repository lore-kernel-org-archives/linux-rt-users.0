Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:56931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeGKPY5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Jul 2018 11:24:57 -0400
Message-ID: <1531322399.12761.37.camel@gmx.de>
Subject: [rfc 4.16-rt patch] crypto: cryptd - serialize RT request
 enqueue/dequeue with a local lock
From: Mike Galbraith <efault@gmx.de>
Date: Wed, 11 Jul 2018 17:19:59 +0200
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

Note: patch is the result of code inspection...

cryptod disables preemption to provide request enqueue/dequeue exclusion,
use a LOCAL_IRQ_LOCK to do the same for RT, keeping preemption enabled.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 crypto/cryptd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -31,10 +31,12 @@
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 
 static unsigned int cryptd_max_cpu_qlen = 1000;
 module_param(cryptd_max_cpu_qlen, uint, 0);
 MODULE_PARM_DESC(cryptd_max_cpu_qlen, "Set cryptd Max queue depth");
+static DEFINE_LOCAL_IRQ_LOCK(cryptod_request_lock);
 
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
@@ -141,7 +143,7 @@ static int cryptd_enqueue_request(struct
 	struct cryptd_cpu_queue *cpu_queue;
 	atomic_t *refcnt;
 
-	cpu = get_cpu();
+	cpu = local_lock_cpu(cryptod_request_lock);
 	cpu_queue = this_cpu_ptr(queue->cpu_queue);
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
@@ -158,7 +160,7 @@ static int cryptd_enqueue_request(struct
 	atomic_inc(refcnt);
 
 out_put_cpu:
-	put_cpu();
+	local_unlock_cpu(cryptod_request_lock);
 
 	return err;
 }
@@ -179,10 +181,10 @@ static void cryptd_queue_worker(struct w
 	 * cryptd_enqueue_request() being accessed from software interrupts.
 	 */
 	local_bh_disable();
-	preempt_disable();
+	local_lock(cryptod_request_lock);
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
-	preempt_enable();
+	local_unlock(cryptod_request_lock);
 	local_bh_enable();
 
 	if (!req)
