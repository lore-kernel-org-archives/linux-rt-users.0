Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C7C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60F2085A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfFSBTO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26467 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFSBTO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 21:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D802130832F2;
        Wed, 19 Jun 2019 01:19:13 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E9B17C41;
        Wed, 19 Jun 2019 01:19:12 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 1/4] rcu: Acquire RCU lock when disabling BHs
Date:   Tue, 18 Jun 2019 20:19:05 -0500
Message-Id: <20190619011908.25026-2-swood@redhat.com>
In-Reply-To: <20190619011908.25026-1-swood@redhat.com>
References: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 01:19:14 +0000 (UTC)
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
 include/linux/rcupdate.h |  4 ++++
 kernel/rcu/update.c      |  4 ++++
 kernel/softirq.c         | 12 +++++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index fb267bc04fdf..aca4e5e25ace 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -637,10 +637,12 @@ static inline void rcu_read_unlock(void)
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
@@ -650,10 +652,12 @@ static inline void rcu_read_lock_bh(void)
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
index 3700b730ea55..eb653a329e0b 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -307,7 +307,11 @@ int rcu_read_lock_bh_held(void)
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
index 473369122ddd..eb46dd3ff92d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -121,8 +121,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	long soft_cnt;
 
 	WARN_ON_ONCE(in_irq());
-	if (!in_atomic())
+	if (!in_atomic()) {
 		local_lock(bh_lock);
+		rcu_read_lock();
+	}
 	soft_cnt = this_cpu_inc_return(softirq_counter);
 	WARN_ON_ONCE(soft_cnt == 0);
 
@@ -155,8 +157,10 @@ void _local_bh_enable(void)
 	local_irq_restore(flags);
 #endif
 
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 }
 
 void _local_bh_enable_rt(void)
@@ -189,8 +193,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(count < 0);
 	local_irq_enable();
 
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 
 	preempt_check_resched();
 }
-- 
1.8.3.1

