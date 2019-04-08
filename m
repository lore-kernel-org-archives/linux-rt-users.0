Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B82C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A17B20879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750925;
	bh=MKxnJ5skaoaSquHjNRTW1TOhmckqz7DGje7Pnp2Deis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=PiyJ0YJ8bUNw4uJoeg4RWEwwsyL0oHMb5qtFB73jo0s+1a+4dX1gXmHehfrD6KNwS
	 i+G3BoWZSbVW6mICUWAr0HF+hkw6z1VJLqGw/cRsf6f0FRDRW3fdZJ2U07gb4dkB2x
	 j8J93H5WEiBEZynI8QZTl0Huv7bWUkcFsnP6wEQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfDHTOa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfDHTOa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:30 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C3821874;
        Mon,  8 Apr 2019 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750868;
        bh=MKxnJ5skaoaSquHjNRTW1TOhmckqz7DGje7Pnp2Deis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=srOl5P6BKmhkmOEl/h+cPhpAI4vGCEU7ODYWgr5g3S+A7yP3u9GbHrCOafXnF+1JY
         m3nJMEunjHgmPjgO0PJXwnAoybzuss7tOIsCMO1aWbJQBvMucmQTquGJXEMbRSzwCb
         ulBeQ6+KD0mzbdjhQNVxcLg6svoo2tF+ZcEpRTKo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 06/13] softirq: Avoid "local_softirq_pending" messages if ksoftirqd is blocked
Date:   Mon,  8 Apr 2019 14:14:08 -0500
Message-Id: <07c2c239ec6a9cc26b4d4c149dc76e88462c68d9.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
index 583c9ecf04e3..be752eadfc68 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,31 @@ static inline void softirq_clr_runner(unsigned int sirq)
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
@@ -104,6 +129,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
 	u32 warnpending;
@@ -113,24 +139,23 @@ void softirq_check_pending_idle(void)
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

