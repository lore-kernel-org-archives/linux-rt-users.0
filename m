Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3540C10F14
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC45420879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750941;
	bh=6Lx4583STgCDyCXSV1BsTuehvVrGcCdehRXQyG8SLTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=GKbCdmG16C/zGhJ/b47mI8VTh+UxVPy8f2g8v8i9kzTgEVE57zrgo1pNZwWO9INWf
	 0tJzSnme7hygERNLE9xfztJIB2WsHpclbR0RhXoM0gXFEFQmTbElSpZjWFFcRgq5uO
	 MT+1Ssnm1ajhl49CbIfpGmvki5L8M+z8VcJDV/cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfDHTPk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDHTOX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:23 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7028821473;
        Mon,  8 Apr 2019 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750862;
        bh=6Lx4583STgCDyCXSV1BsTuehvVrGcCdehRXQyG8SLTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VapW0ZdoypTyN/S1s7ul5Ld89oMXhV3dfDWpSsldDS/307QQ5ezI5gqOpMY7nZpZH
         LseRX9TVKmKYMP6G3Lux4pl+eF3HYvDFcZOscVnZtfvAGaGnQ/6sMAMh5yRYmqT0Dl
         sGdfUA+3t9+rpo5qtSYijcxXN0otItpVMb+RQHFk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 02/13] sched/fair: Robustify CFS-bandwidth timer locking
Date:   Mon,  8 Apr 2019 14:14:04 -0500
Message-Id: <58367f713ac5e510319ed561e8aeea98b57d530b.1554737688.git.tom.zanussi@linux.intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit a44c9da61ad3334a9563102e0194d7197b222ec2 ]

Traditionally hrtimer callbacks were run with IRQs disabled, but with
the introduction of HRTIMER_MODE_SOFT it is possible they run from
SoftIRQ context, which does _NOT_ have IRQs disabled.

Allow for the CFS bandwidth timers (period_timer and slack_timer) to
be ran from SoftIRQ context; this entails removing the assumption that
IRQs are already disabled from the locking.

While mainline doesn't strictly need this, -RT forces all timers not
explicitly marked with MODE_HARD into MODE_SOFT and trips over this.
And marking these timers as MODE_HARD doesn't make sense as they're
not required for RT operation and can potentially be quite expensive.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Tom Putzeys <tom.putzeys@be.atlascopco.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190107125231.GE14122@hirez.programming.kicks-ass.net
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/sched/fair.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e6ca7d463c0..46403e462404 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4378,7 +4378,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
-		rq_lock(rq, &rf);
+		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -4395,7 +4395,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
-		rq_unlock(rq, &rf);
+		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
@@ -4411,7 +4411,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
  * used to track this state.
  */
-static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
+static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
 	u64 runtime, runtime_expires;
 	int throttled;
@@ -4453,11 +4453,11 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
-		raw_spin_lock(&cfs_b->lock);
+		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4566,17 +4566,18 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	unsigned long flags;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (cfs_b->distribute_running) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
@@ -4587,18 +4588,18 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
 		return;
 
 	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (expires == cfs_b->runtime_expires)
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
 	cfs_b->distribute_running = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -4676,20 +4677,21 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	unsigned long flags;
 	int overrun;
 	int idle = 0;
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun);
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
-- 
2.14.1

