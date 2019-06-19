Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FCC31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481642085A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 01:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfFSBTP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbfFSBTP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 21:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D92673082E71;
        Wed, 19 Jun 2019 01:19:14 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1CE07D65A;
        Wed, 19 Jun 2019 01:19:13 +0000 (UTC)
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
Subject: [PATCH RT 2/4] sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
Date:   Tue, 18 Jun 2019 20:19:06 -0500
Message-Id: <20190619011908.25026-3-swood@redhat.com>
In-Reply-To: <20190619011908.25026-1-swood@redhat.com>
References: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 19 Jun 2019 01:19:14 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Without this, rcu_note_context_switch() will complain if an RCU read
lock is held when migrate_enable() calls stop_one_cpu().

Signed-off-by: Scott Wood <swood@redhat.com>
---
 include/linux/sched.h    | 4 ++--
 kernel/rcu/tree_plugin.h | 2 +-
 kernel/sched/core.c      | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e1ea2ea52feb..9b8334c24dad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -681,7 +681,7 @@ struct task_struct {
 	int				migrate_disable_atomic;
 # endif
 #endif
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 	int				sleeping_lock;
 #endif
 
@@ -1870,7 +1870,7 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
+#ifdef CONFIG_PREEMPT_RT_BASE
 static inline void sleeping_lock_inc(void)
 {
 	current->sleeping_lock++;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4bac3e5ee1ab..5d63914b3687 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -311,7 +311,7 @@ void rcu_note_context_switch(bool preempt)
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-#if defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_PREEMPT_RT_BASE)
 	sleeping_l = t->sleeping_lock;
 #endif
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a8493ff60b67..fce7d574ab5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7351,7 +7351,9 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			sleeping_lock_dec();
 			tlb_migrate_finish(p->mm);
 
 			return;
-- 
1.8.3.1

