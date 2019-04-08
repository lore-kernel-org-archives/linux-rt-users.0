Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E9C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7002220879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750922;
	bh=6eCzGmVks969R3cfYzDLxLHgQcXT9gF4bP0XIW3m3ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=cuxThrP30AEZvsYC5CYNe2DBcQtIKujG2IZQCjDpQbMLBcHgzN9qcJ2nDFkZbWt3o
	 13uJ6qyoIgVxrMB9mExsTHlkRXHdiDjfXZg41HtP6a0n/fhvJWz6MB8SaCFTn410Pl
	 UcWlBIapr6szeyMV7C8m7AtUFG/WXiQJcy2fGbBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfDHTPQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfDHTOc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:32 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04C221924;
        Mon,  8 Apr 2019 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750871;
        bh=6eCzGmVks969R3cfYzDLxLHgQcXT9gF4bP0XIW3m3ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=rmbdmkEPLoCYvC2UZGw+YOryhC73IxrICTjtihmTjcvflO9p1g0u10MUcWTVUqgq9
         SKaryVoX1QltDU46Ne1vdf0gtKfbs0m2Lko5zuFnnY0uRKVzgjy5N8G6gZb60yn+qn
         HGTtPTPrkNHsmDxhVyRvoONOLmlVTEtiAQ2QhFz0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 08/13] hrtimer: Don't lose state in cpu_chill()
Date:   Mon,  8 Apr 2019 14:14:10 -0500
Message-Id: <53a19e573f13967322ba8221fcf121948803ccf4.1554737688.git.tom.zanussi@linux.intel.com>
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

[ Upstream commit 585456236766349f692f9fbcc089d71411831f88 ]

In cpu_chill() the state is set to TASK_UNINTERRUPTIBLE and a timer is
programmed. On return the state is always TASK_RUNNING which means we
lose the state if it was something other than RUNNING. Also
set_current_state() sets ->task_state_change to within cpu_chill() which
is not expected.

Save the task state on entry and restore it on return. Simply set the
state in order to avoid updating ->task_state_change.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/time/hrtimer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c8d806126381..6da6b5dded3c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1866,15 +1866,18 @@ void cpu_chill(void)
 {
 	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
+	long saved_state;
 
+	saved_state = current->state;
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
+	__set_current_state_no_track(saved_state);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
-- 
2.14.1

