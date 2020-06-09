Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDBC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FF52072F
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591733467;
	bh=ohGw8kMdhKYeKVKhlHpuW6SWQnB57Ond0AifttEhW8I=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=AhAPu7yQd46Z5N3HZe8/bfpKfMQhEqDCAIKSpJo7icR7JQZ2qzcLSZQiKrJVgsbk4
	 mI0aEx0tpf3H4p0F3IFdqt6xbDwPncNRU1E1SzgGc7uFRSiE+e4uqz9Vzv07Q+mO5o
	 PkHj98TwRzh6CwscgStv2lswVKAhU4VWiMZbQgQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgFIULD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731802AbgFIULD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 16:11:03 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F1D20734;
        Tue,  9 Jun 2020 20:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591733462;
        bh=ohGw8kMdhKYeKVKhlHpuW6SWQnB57Ond0AifttEhW8I=;
        h=Subject:From:To:Cc:Date:From;
        b=WWEQCDQ+4fZigo5z5SX1Vqlru0ATpAF1uJlJjBdcLQqCHpO1f/mFHN0F8TLvqJmUw
         2he8y6YOnENJHyfXw8GlbQVacoBKFG3l87nvI79dJysn+k9emymlBVLQ9guVod/o3y
         ikMIev7yhDOQyUNhPoxIyGEWmwWpO5DQukIlBnZQ=
Message-ID: <80faed97279876cafddb79541c1578b7113d7f04.camel@kernel.org>
Subject: [4.19 stable-rt PATCH v2] tasklet: Fix UP case for tasklet CHAINED
 state
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     rfried.dev@gmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 15:11:01 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

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


