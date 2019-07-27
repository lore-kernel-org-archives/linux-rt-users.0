Return-Path: <SRS0=S77f=VY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876FC7618B
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EC20869
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfG0F4q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfG0F4p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B6333E2CB;
        Sat, 27 Jul 2019 05:56:45 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3E719C79;
        Sat, 27 Jul 2019 05:56:44 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 1/8] sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
Date:   Sat, 27 Jul 2019 00:56:31 -0500
Message-Id: <20190727055638.20443-2-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 27 Jul 2019 05:56:45 +0000 (UTC)
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
index 4e218f8d8048..ad23ab939b35 100644
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
 
@@ -1873,7 +1873,7 @@ static __always_inline bool need_resched(void)
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
index d3c6542b306f..c3407707e367 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7405,7 +7405,9 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			sleeping_lock_dec();
 			return;
 		}
 	}
-- 
1.8.3.1

