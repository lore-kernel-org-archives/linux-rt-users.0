Return-Path: <SRS0=sFXS=XG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D2C5ACAE
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90FE2089F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfIKQ5l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQ5l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Sep 2019 12:57:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9701D30833BE;
        Wed, 11 Sep 2019 16:57:40 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-113.phx2.redhat.com [10.3.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74C7960BEC;
        Wed, 11 Sep 2019 16:57:36 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v3 1/5] rcu: Acquire RCU lock when disabling BHs
Date:   Wed, 11 Sep 2019 17:57:25 +0100
Message-Id: <20190911165729.11178-2-swood@redhat.com>
In-Reply-To: <20190911165729.11178-1-swood@redhat.com>
References: <20190911165729.11178-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 11 Sep 2019 16:57:40 +0000 (UTC)
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
v3: Remove change to rcu_read_lock_bh_held(), and move debug portions
of rcu_read_[un]lock_bh() to separate functions
---
 include/linux/rcupdate.h | 40 ++++++++++++++++++++++++++++++++--------
 kernel/softirq.c         | 12 +++++++++---
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 388ace315f32..9ce7c5006a5e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -600,6 +600,36 @@ static inline void rcu_read_unlock(void)
 	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * On RT, local_bh_disable() calls rcu_read_lock() -- no need to
+ * track it twice.
+ */
+static inline void rcu_bh_lock_acquire(void)
+{
+}
+
+static inline void rcu_bh_lock_release(void)
+{
+}
+#else
+static inline void rcu_bh_lock_acquire(void)
+{
+	__acquire(RCU_BH);
+	rcu_lock_acquire(&rcu_bh_lock_map);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(),
+			 "rcu_read_lock_bh() used illegally while idle");
+}
+
+static inline void rcu_bh_lock_release(void)
+{
+	RCU_LOCKDEP_WARN(!rcu_is_watching(),
+			 "rcu_read_unlock_bh() used illegally while idle");
+	rcu_lock_release(&rcu_bh_lock_map);
+	__release(RCU_BH);
+}
+#endif
+
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
@@ -615,10 +645,7 @@ static inline void rcu_read_unlock(void)
 static inline void rcu_read_lock_bh(void)
 {
 	local_bh_disable();
-	__acquire(RCU_BH);
-	rcu_lock_acquire(&rcu_bh_lock_map);
-	RCU_LOCKDEP_WARN(!rcu_is_watching(),
-			 "rcu_read_lock_bh() used illegally while idle");
+	rcu_bh_lock_acquire();
 }
 
 /*
@@ -628,10 +655,7 @@ static inline void rcu_read_lock_bh(void)
  */
 static inline void rcu_read_unlock_bh(void)
 {
-	RCU_LOCKDEP_WARN(!rcu_is_watching(),
-			 "rcu_read_unlock_bh() used illegally while idle");
-	rcu_lock_release(&rcu_bh_lock_map);
-	__release(RCU_BH);
+	rcu_bh_lock_release();
 	local_bh_enable();
 }
 
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

