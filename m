Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2586CC10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0320879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750917;
	bh=JG90UWfofGiDYArY3foPNNP/83mL300dpR7a22DFY4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=eyU8k47K2gxx6L7ZurC5PJ1Eo8pbKGbpzIdFGGWr7vdd3A8fA3aBKOyDrtFNJKRZA
	 18uq2AnFlJ+oDE1z6PmhQGtffaueAQta/+1gnQ0f03Ho5qb5vi4kqjrE9wlvJJb4N/
	 GBPPZ0bF3y6yA35V3wRTZ61pAxpY/jCFqsEW2c4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfDHTOb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfDHTOb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:31 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62EAF218FC;
        Mon,  8 Apr 2019 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750870;
        bh=JG90UWfofGiDYArY3foPNNP/83mL300dpR7a22DFY4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=T5Mbf4RVoG0DL6zHWAavK65iGOKIgMpqMMQcbz+7I0q9Pc2bQMvRBg3oCLBCvIIi2
         w7FoiHn5sMMec1O50StIQkUVvLOSdLLSsPA/c4YqU1kEDsWJK6OJl+NXmizsGqE94o
         g83c6qQ4He06Ig4iViVZ12pJAoj1bvNAn2FifTSk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 07/13] softirq: Avoid "local_softirq_pending" messages if task is in cpu_chill()
Date:   Mon,  8 Apr 2019 14:14:09 -0500
Message-Id: <adb5c111156a6945e65ed2ebe214625034923ceb.1554737688.git.tom.zanussi@linux.intel.com>
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

[ Upstream commit a3429e0147dfd3fc585f989aa49a76579c2b6565 ]

If the softirq thread enters cpu_chill() then ->state is UNINTERRUPTIBLE
and has no ->pi_blocked_on set and so its mask is not taken into account.

->sleeping_lock is increased by cpu_chill() since it is also requried to
avoid a splat by RCU in case cpu_chill() is used while a RCU-read lock
is held. Use the same mechanism for the softirq-pending check.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/softirq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index be752eadfc68..e42ee95fccda 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -105,9 +105,12 @@ static bool softirq_check_runner_tsk(struct task_struct *tsk,
 	 * _before_ it sets pi_blocked_on to NULL under
 	 * tsk->pi_lock. So we need to check for both: state
 	 * and pi_blocked_on.
+	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
+	 * task does cpu_chill().
 	 */
 	raw_spin_lock(&tsk->pi_lock);
-	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
 		/* Clear all bits pending in that task */
 		*pending &= ~(tsk->softirqs_raised);
 		ret = true;
-- 
2.14.1

