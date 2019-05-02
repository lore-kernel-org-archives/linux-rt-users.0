Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD01C04AAA
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6621479
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556824580;
	bh=fcb4msStXC3Ap5YAsbn6nLQE6ltIQYu318xJUZ3j7kM=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=NCnyZmCKCm6c4PAB2vn9IfVb25fVqZclkN80G/iMbzg2QCufUe0HQbNg6EISkObtw
	 xe1W18BVYhr0NUKU2Dhqsi1MR/BWJxqI8pdyrRnC1XItSQuuShDff9B7pzeA4da2uM
	 s8vwYzOVQucxLz/R3GlJQQkcioGKDi5PWhF/OW2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfEBTQE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTQE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:16:04 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3CB2085A;
        Thu,  2 May 2019 19:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824562;
        bh=fcb4msStXC3Ap5YAsbn6nLQE6ltIQYu318xJUZ3j7kM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=N+yTcO77cyzbWnRzXD/gIqJe6mOd+Lksd5MOu5wStaKZ9UiGuQdQNHR0fqGiQEOa6
         YHBw6rQadzRRsElItzVWjWsxU227kq1q1wtMachA/mjMby9DeQcE5U30gf1kXT91eR
         JBfPBuWgn0FT5g5UeqZxe6QIR+SGZJSegFbVKyPo=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 1/4] softirq: Avoid "local_softirq_pending" messages if ksoftirqd is blocked
Date:   Thu,  2 May 2019 14:15:36 -0500
Message-Id: <50d1b547a71fb5f400ad39e2f78698ce2cbb3de4.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v3.18.138-rt116-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 2cf32c1a3d9352df8017dbf84a1462c4a60a1826 ]

If the ksoftirqd thread has a softirq pending and is blocked on the
`local_softirq_locks' lock then softirq_check_pending_idle() won't
complain because the "lock owner" will mask away this softirq from the
mask of pending softirqs.
If ksoftirqd has an additional softirq pending then it won't be masked
out because we never look at ksoftirqd's mask.

If there are still pending softirqs while going to idle check
ksoftirqd's and ktimersfotd's mask before complaining about unhandled
softirqs.

Cc: stable-rt@vger.kernel.org
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/softirq.c | 57 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 89c490b405ad..47d228982a58 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -91,6 +91,31 @@ static inline void softirq_clr_runner(unsigned int sirq)
 	sr->runner[sirq] = NULL;
 }
 
+static bool softirq_check_runner_tsk(struct task_struct *tsk,
+				     unsigned int *pending)
+{
+	bool ret = false;
+
+	if (!tsk)
+		return ret;
+
+	/*
+	 * The wakeup code in rtmutex.c wakes up the task
+	 * _before_ it sets pi_blocked_on to NULL under
+	 * tsk->pi_lock. So we need to check for both: state
+	 * and pi_blocked_on.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+		/* Clear all bits pending in that task */
+		*pending &= ~(tsk->softirqs_raised);
+		ret = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+
+	return ret;
+}
+
 /*
  * On preempt-rt a softirq running context might be blocked on a
  * lock. There might be no other runnable task on this CPU because the
@@ -103,6 +128,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = &__get_cpu_var(softirq_runners);
 	u32 warnpending;
@@ -112,24 +138,23 @@ void softirq_check_pending_idle(void)
 		return;
 
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
-		struct task_struct *tsk = sr->runner[i];
+		tsk = sr->runner[i];
 
-		/*
-		 * The wakeup code in rtmutex.c wakes up the task
-		 * _before_ it sets pi_blocked_on to NULL under
-		 * tsk->pi_lock. So we need to check for both: state
-		 * and pi_blocked_on.
-		 */
-		if (tsk) {
-			raw_spin_lock(&tsk->pi_lock);
-			if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
-				/* Clear all bits pending in that task */
-				warnpending &= ~(tsk->softirqs_raised);
-				warnpending &= ~(1 << i);
-			}
-			raw_spin_unlock(&tsk->pi_lock);
-		}
+		if (softirq_check_runner_tsk(tsk, &warnpending))
+			warnpending &= ~(1 << i);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ksoftirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ktimer_softirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
 	}
 
 	if (warnpending) {
-- 
2.14.1

