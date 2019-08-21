Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD6C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA52339E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfHUXTN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbfHUXTN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 19:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAF8F1801584;
        Wed, 21 Aug 2019 23:19:12 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2642600CD;
        Wed, 21 Aug 2019 23:19:11 +0000 (UTC)
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
Subject: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
Date:   Wed, 21 Aug 2019 18:19:05 -0500
Message-Id: <20190821231906.4224-3-swood@redhat.com>
In-Reply-To: <20190821231906.4224-1-swood@redhat.com>
References: <20190821231906.4224-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 23:19:12 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Without this, rcu_note_context_switch() will complain if an RCU read
lock is held when migrate_enable() calls stop_one_cpu().

Signed-off-by: Scott Wood <swood@redhat.com>
---
v2: Added comment.

If my migrate disable changes aren't taken, then pin_current_cpu()
will also need to use sleeping_lock_inc() because calling
__read_rt_lock() bypasses the usual place it's done.

 include/linux/sched.h    | 4 ++--
 kernel/rcu/tree_plugin.h | 2 +-
 kernel/sched/core.c      | 8 ++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e892e727f12..1ebc97f28009 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -673,7 +673,7 @@ struct task_struct {
 	int				migrate_disable_atomic;
 # endif
 #endif
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 	int				sleeping_lock;
 #endif
 
@@ -1881,7 +1881,7 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 static inline void sleeping_lock_inc(void)
 {
 	current->sleeping_lock++;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 23a54e4b649c..7a3aa085ce2c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -292,7 +292,7 @@ void rcu_note_context_switch(bool preempt)
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-#if defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_PREEMPT_RT_BASE)
 	sleeping_l = t->sleeping_lock;
 #endif
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1bdd7f9be05..0758ee85634e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7405,7 +7405,15 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+
+			/*
+			 * sleeping_lock_inc suppresses a debug check for
+			 * sleeping inside an RCU read side critical section
+			 */
+			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			sleeping_lock_dec();
+
 			return;
 		}
 	}
-- 
1.8.3.1

