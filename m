Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA0C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA12339E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfHUXTM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHUXTL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 19:19:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9358680F7C;
        Wed, 21 Aug 2019 23:19:11 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA8A600CD;
        Wed, 21 Aug 2019 23:19:10 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Date:   Wed, 21 Aug 2019 18:19:04 -0500
Message-Id: <20190821231906.4224-2-swood@redhat.com>
In-Reply-To: <20190821231906.4224-1-swood@redhat.com>
References: <20190821231906.4224-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 21 Aug 2019 23:19:11 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A plain local_bh_disable() is documented as creating an RCU critical
section, and (at least) rcutorture expects this to be the case.  However,
in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
preempt_count() directly.  Even if RCU were changed to check
in_softirq(), that wouldn't allow blocked BH disablers to be boosted.

Fix this by calling rcu_read_lock() from local_bh_disable(), and update
rcu_read_lock_bh_held() accordingly.

Signed-off-by: Scott Wood <swood@redhat.com>
---
Another question is whether non-raw spinlocks are intended to create an
RCU read-side critical section due to implicit preempt disable.  If they
are, then we'd need to add rcu_read_lock() there as well since RT doesn't
disable preemption (and rcutorture should explicitly test with a
spinlock).  If not, the documentation should make that clear.

 include/linux/rcupdate.h |  4 ++++
 kernel/rcu/update.c      |  4 ++++
 kernel/softirq.c         | 12 +++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 388ace315f32..d6e357378732 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
 static inline void rcu_read_lock_bh(void)
 {
 	local_bh_disable();
+#ifndef CONFIG_PREEMPT_RT_FULL
 	__acquire(RCU_BH);
 	rcu_lock_acquire(&rcu_bh_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock_bh() used illegally while idle");
+#endif
 }
 
 /*
@@ -628,10 +630,12 @@ static inline void rcu_read_lock_bh(void)
  */
 static inline void rcu_read_unlock_bh(void)
 {
+#ifndef CONFIG_PREEMPT_RT_FULL
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock_bh() used illegally while idle");
 	rcu_lock_release(&rcu_bh_lock_map);
 	__release(RCU_BH);
+#endif
 	local_bh_enable();
 }
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 016c66a98292..a9cdf3d562bc 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -296,7 +296,11 @@ int rcu_read_lock_bh_held(void)
 		return 0;
 	if (!rcu_lockdep_current_cpu_online())
 		return 0;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	return lock_is_held(&rcu_lock_map) || irqs_disabled();
+#else
 	return in_softirq() || irqs_disabled();
+#endif
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d16d080a74f7..6080c9328df1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -115,8 +115,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	long soft_cnt;
 
 	WARN_ON_ONCE(in_irq());
-	if (!in_atomic())
+	if (!in_atomic()) {
 		local_lock(bh_lock);
+		rcu_read_lock();
+	}
 	soft_cnt = this_cpu_inc_return(softirq_counter);
 	WARN_ON_ONCE(soft_cnt == 0);
 	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
@@ -151,8 +153,10 @@ void _local_bh_enable(void)
 #endif
 
 	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 }
 
 void _local_bh_enable_rt(void)
@@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(count < 0);
 	local_irq_enable();
 
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 
 	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
 	preempt_check_resched();
-- 
1.8.3.1

