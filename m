Return-Path: <SRS0=F/kx=7Y=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F86C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jun 2020 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C34420792
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Jun 2020 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591899031;
	bh=EUPHwUS07JP1xvRUY7ltnNN+mSj0mZfTfT4GGwpSIAc=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=rSHoVUnrA5RfK5Nk4r3LW1wf/NC1Hhbggfx2B4bgVsefJbAeLxFzYrZ9RcOdwplsL
	 PAn3OeTOtiqRo+UOlfcdCuImw1kNoyjJar2iU88fbjFrrj6xIx3SCXBbA5lc7ThJ0P
	 +bXyj4bSQdq2QcTbLXhodkCfeNdKbYpQqEEXmXJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgFKSK0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgFKSKX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Jun 2020 14:10:23 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F143B2084D;
        Thu, 11 Jun 2020 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899022;
        bh=EUPHwUS07JP1xvRUY7ltnNN+mSj0mZfTfT4GGwpSIAc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SoqdUfzoj82fwCVVzGsCzeCh0eiUWdCQeqSaK00Xq1/DB4FtrQDY+Y8NPzkIrD8db
         IVuzs6IcoX9zB8OeYsJkCpTNjhCeVJNSNL+4tzJ0c5ctDhfyEE7OY+vrtpaeh72aZ8
         guGAdq/1daNK/O2cTtS3Sjyctdkipx56s+hLYGHw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 3/4] tasklet: Fix UP case for tasklet CHAINED state
Date:   Thu, 11 Jun 2020 13:10:16 -0500
Message-Id: <2262ed0571ef9c2f24752189b55c965ce9c16d2f.1591898986.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.19.127-rt55-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


commit 62d0a2a30cd0 (tasklet: Address a race resulting in
double-enqueue) addresses a problem that can result in a tasklet being
enqueued on two cpus at the same time by combining the RUN flag with a
new CHAINED flag, and relies on the combination to be present in order
to zero it out, which can never happen on (!SMP and !PREEMPT_RT_FULL)
because the RUN flag is SMP/PREEMPT_RT_FULL-only.

So make sure the above commit is only applied for the SMP ||
PREEMPT_RT_FULL case.

Fixes: 62d0a2a30cd0 ("tasklet: Address a race resulting in double-enqueue")
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Reported-by: Ramon Fried <rfried.dev@gmail.com>
Tested-By: Ramon Fried <rfried.dev@gmail.com>
---
 kernel/softirq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 73dae64bfc9c..9bad7a16dc61 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	 * is locked before adding it to the list.
 	 */
 	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
 			tasklet_unlock(t);
 			return;
 		}
+#endif
 		t->next = NULL;
 		*head->tail = t;
 		head->tail = &(t->next);
@@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct softirq_action *a,
 again:
 		t->func(t->data);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
+#else
+		while (!tasklet_tryunlock(t)) {
+#endif
 			/*
 			 * If it got disabled meanwhile, bail out:
 			 */
-- 
2.17.1

