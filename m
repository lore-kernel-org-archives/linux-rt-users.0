Return-Path: <SRS0=sFXS=XG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5DC49ED6
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC50208E4
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfIKQ5u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQ5t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Sep 2019 12:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63DA8A3719F;
        Wed, 11 Sep 2019 16:57:49 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-113.phx2.redhat.com [10.3.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F12A60C05;
        Wed, 11 Sep 2019 16:57:44 +0000 (UTC)
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
Subject: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Date:   Wed, 11 Sep 2019 17:57:27 +0100
Message-Id: <20190911165729.11178-4-swood@redhat.com>
In-Reply-To: <20190911165729.11178-1-swood@redhat.com>
References: <20190911165729.11178-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 16:57:49 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Without this, rcu_note_context_switch() will complain if an RCU read lock
is held when migrate_enable() calls stop_one_cpu().  Likewise when
migrate_disable() calls pin_current_cpu() which calls __read_rt_lock() --
which bypasses the part of the mutex code that calls rt_invol_sleep_inc().

Signed-off-by: Scott Wood <swood@redhat.com>
---
v3: Add to pin_current_cpu as well

 include/linux/sched.h    | 4 ++--
 kernel/cpu.c             | 2 ++
 kernel/rcu/tree_plugin.h | 2 +-
 kernel/sched/core.c      | 4 ++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index edc93b74f7d8..ecf5cbb23335 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -673,7 +673,7 @@ struct task_struct {
 	int				migrate_disable_atomic;
 # endif
 #endif
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 	/* Task is blocking due to RT-specific mechanisms, not voluntarily */
 	int				rt_invol_sleep;
 #endif
@@ -1882,7 +1882,7 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 static inline void rt_invol_sleep_inc(void)
 {
 	current->rt_invol_sleep++;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 885a195dfbe0..32c6175b63b6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -308,7 +308,9 @@ void pin_current_cpu(void)
 	preempt_lazy_enable();
 	preempt_enable();
 
+	rt_invol_sleep_inc();
 	__read_rt_lock(cpuhp_pin);
+	rt_invol_sleep_dec();
 
 	preempt_disable();
 	preempt_lazy_disable();
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0da4b975cd71..6d92dafeeca5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -292,7 +292,7 @@ void rcu_note_context_switch(bool preempt)
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-#if defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_PREEMPT_RT_BASE)
 	rt_invol = t->rt_invol_sleep;
 #endif
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !rt_invol);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1bdd7f9be05..a151332474d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7405,7 +7405,11 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+
+			rt_invol_sleep_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			rt_invol_sleep_dec();
+
 			return;
 		}
 	}
-- 
1.8.3.1

