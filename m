Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8434C32771
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiHSJZD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348133AbiHSJY7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0DEF2CBF;
        Fri, 19 Aug 2022 02:24:58 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udujVCWVV7TO3KVKSezokpOIul8ZuTYW1g0IoZEV1rk=;
        b=l7Z0SoP9hALv/i6DLmbUYujc7kfd7IkK3DKLivxlBkKS3LXXx7qq8IfHBCjg88x66UI6oe
        FeO4womhETVpG8CrgANr4p4cPcqKi8nhgMw2J82EcdcMhHZOIpghGU5ye7Bj0eFBZlAGvb
        tsab3sSMN0AQcN5iu2wH6XErTxKiBaLRyjtukm82ACBU6ViFv9fSstFOGR4ehJHRidYULq
        sQi/VCo7iMR0dVS8IbFGOKVFlZ7w5g8hQfEd5kX/aPMHee4l9/eWjaMFKFFrI9UwE0TaBu
        WmLVB3ItQJwsIxmWCFfb0B0TpE27XgbqCTmo3Zlx3RXNp6QWgw2HGLDfYUtLZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udujVCWVV7TO3KVKSezokpOIul8ZuTYW1g0IoZEV1rk=;
        b=x9ytpraf0PxRJnzCLL63siosAV6B0fWbxOuCG5VP3kG/SmukCzp8hfSiQuYiTSqRtwWodl
        2sqSbWRhQ7wdXfCA==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 8/9] workqueue: Use rcuwait for wq_manager_wait
Date:   Fri, 19 Aug 2022 11:24:45 +0200
Message-Id: <20220819092446.980320-9-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Upstream commit d8bb65ab70f702531aaaa11d9710f9450078e295

The workqueue code has it's internal spinlock (pool::lock) and also
implicit spinlock usage in the wq_manager waitqueue. These spinlocks
are converted to 'sleeping' spinlocks on a RT-kernel.

Workqueue functions can be invoked from contexts which are truly atomic
even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
contexts is forbidden.

pool::lock can be converted to a raw spinlock as the lock held times
are short. But the workqueue manager waitqueue is handled inside of
pool::lock held regions which again violates the lock nesting rules
of raw and regular spinlocks.

The manager waitqueue has no special requirements like custom wakeup
callbacks or mass wakeups. While it does not use exclusive wait mode
explicitly there is no strict requirement to queue the waiters in a
particular order as there is only one waiter at a time.

This allows to replace the waitqueue with rcuwait which solves the
locking problem because rcuwait relies on existing locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6b3f3f54a05e9..f494ffe3551fe 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,7 @@
 #include <linux/uaccess.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/rcuwait.h>
=20
 #include "workqueue_internal.h"
=20
@@ -301,7 +302,8 @@ static struct workqueue_attrs *wq_update_unbound_numa_a=
ttrs_buf;
=20
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list =
*/
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go=
 away */
+/* wait for manager to go away */
+static struct rcuwait manager_wait =3D __RCUWAIT_INITIALIZER(manager_wait);
=20
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -1995,7 +1997,7 @@ static bool manage_workers(struct worker *worker)
=20
 	pool->manager =3D NULL;
 	pool->flags &=3D ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
=20
@@ -3258,6 +3260,18 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
=20
+/* This returns with the lock held on success (pool manager is inactive). =
*/
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3293,10 +3307,11 @@ static void put_unbound_pool(struct worker_pool *po=
ol)
 	 * Become the manager and destroy all workers.  This prevents
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
+	 * Because of how wq_manager_inactive() works, we will hold the
+	 * spinlock after a successful wait.
 	 */
-	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
+			   TASK_UNINTERRUPTIBLE);
 	pool->flags |=3D POOL_MANAGER_ACTIVE;
=20
 	while ((worker =3D first_idle_worker(pool)))
--=20
2.37.2

