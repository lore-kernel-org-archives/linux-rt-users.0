Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C3C25B0E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiHSJZA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbiHSJY5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F8F2CB9;
        Fri, 19 Aug 2022 02:24:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPHeq4RNydcP1Zj7V7ZVDQttvvlz4xawCIwHeAas5Sk=;
        b=WJv5ivRDcGYt04HUU4/qmrpD6NtYNRqC83WK8iLVu0sw3zxYWx80b8qaSV4s5XLXEpBf41
        19NaOU1iW5hBPJ7bCUMRmABJk7Ux58guGX/HbupIKH0zDd9/Zkmugd6H9wW8MsR9fk3gIO
        8anchtdhoWHSK/4BJfCqOpzvdRhgJazmwTcfpC9Teq8UthGSoLZgVugOQ3WUZfKmzyT4tC
        IOyaCGgk9q1dbshJVoq3dJkG/fByQIkBHxTb4FiQsOW6Qi0HuiDM9LirlxqVk2BJRyithn
        hGrJcGrwbXA8MmJ7C+qvFwYNm+R4UgUFNFpfoGVuNWLlFDm2Da0XSym4muzTug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPHeq4RNydcP1Zj7V7ZVDQttvvlz4xawCIwHeAas5Sk=;
        b=h6dAgI5yu57SwIUP59/BzhmkJubjAuTpddxucxsPWc5RY+/T55NKckmUnI/ztOwfoxMmho
        3uK7xq/rY30o4/DA==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 3/9] Revert "workqueue: Use local irq lock instead of irq disable regions"
Date:   Fri, 19 Aug 2022 11:24:40 +0200
Message-Id: <20220819092446.980320-4-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This reverts the PREEMPT_RT related changes to workqueue. It reverts the
usage of local_locks() and cpu_chill().

This is a preparation to pull in the PREEMPT_RT related changes which
were merged upstream.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a4bb53e2e26a1..0c2c383eb7d0e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -48,8 +48,6 @@
 #include <linux/nodemask.h>
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
-#include <linux/locallock.h>
-#include <linux/delay.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
=20
@@ -360,8 +358,6 @@ EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __read_mostly;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
=20
-static DEFINE_LOCAL_IRQ_LOCK(pendingb_lock);
-
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
=20
@@ -1132,11 +1128,9 @@ static void put_pwq_unlocked(struct pool_workqueue *=
pwq)
 		 * As both pwqs and pools are RCU protected, the
 		 * following lock operations are safe.
 		 */
-		rcu_read_lock();
-		local_spin_lock_irq(pendingb_lock, &pwq->pool->lock);
+		spin_lock_irq(&pwq->pool->lock);
 		put_pwq(pwq);
-		local_spin_unlock_irq(pendingb_lock, &pwq->pool->lock);
-		rcu_read_unlock();
+		spin_unlock_irq(&pwq->pool->lock);
 	}
 }
=20
@@ -1240,7 +1234,7 @@ static int try_to_grab_pending(struct work_struct *wo=
rk, bool is_dwork,
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
=20
-	local_lock_irqsave(pendingb_lock, *flags);
+	local_irq_save(*flags);
=20
 	/* try to steal the timer if it exists */
 	if (is_dwork) {
@@ -1304,10 +1298,10 @@ static int try_to_grab_pending(struct work_struct *=
work, bool is_dwork,
 	spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
-	local_unlock_irqrestore(pendingb_lock, *flags);
+	local_irq_restore(*flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
-	cpu_chill();
+	cpu_relax();
 	return -EAGAIN;
 }
=20
@@ -1409,7 +1403,7 @@ static void __queue_work(int cpu, struct workqueue_st=
ruct *wq,
 	 * queued or lose PENDING.  Grabbing PENDING and queueing should
 	 * happen with IRQ disabled.
 	 */
-	WARN_ON_ONCE_NONRT(!irqs_disabled());
+	WARN_ON_ONCE(!irqs_disabled());
=20
=20
 	/* if draining, only works from the same workqueue are allowed */
@@ -1517,14 +1511,14 @@ bool queue_work_on(int cpu, struct workqueue_struct=
 *wq,
 	bool ret =3D false;
 	unsigned long flags;
=20
-	local_lock_irqsave(pendingb_lock,flags);
+	local_irq_save(flags);
=20
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_work(cpu, wq, work);
 		ret =3D true;
 	}
=20
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_work_on);
@@ -1592,14 +1586,14 @@ bool queue_delayed_work_on(int cpu, struct workqueu=
e_struct *wq,
 	unsigned long flags;
=20
 	/* read the comment in __queue_work() */
-	local_lock_irqsave(pendingb_lock, flags);
+	local_irq_save(flags);
=20
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret =3D true;
 	}
=20
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_delayed_work_on);
@@ -1634,7 +1628,7 @@ bool mod_delayed_work_on(int cpu, struct workqueue_st=
ruct *wq,
=20
 	if (likely(ret >=3D 0)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
-		local_unlock_irqrestore(pendingb_lock, flags);
+		local_irq_restore(flags);
 	}
=20
 	/* -ENOENT from try_to_grab_pending() becomes %true */
@@ -2963,7 +2957,7 @@ static bool __cancel_work_timer(struct work_struct *w=
ork, bool is_dwork)
=20
 	/* tell other tasks trying to grab @work to back off */
 	mark_work_canceling(work);
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
=20
 	/*
 	 * This allows canceling during early boot.  We know that @work
@@ -3024,10 +3018,10 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 bool flush_delayed_work(struct delayed_work *dwork)
 {
-	local_lock_irq(pendingb_lock);
+	local_irq_disable();
 	if (del_timer_sync(&dwork->timer))
 		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_unlock_irq(pendingb_lock);
+	local_irq_enable();
 	return flush_work(&dwork->work);
 }
 EXPORT_SYMBOL(flush_delayed_work);
@@ -3045,7 +3039,7 @@ static bool __cancel_work(struct work_struct *work, b=
ool is_dwork)
 		return false;
=20
 	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
-	local_unlock_irqrestore(pendingb_lock, flags);
+	local_irq_restore(flags);
 	return ret;
 }
=20
--=20
2.37.2

