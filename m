Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13DC54EEB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24016214AF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588015826;
	bh=QejvvNubgTxnvktUUjj0URNakT/Ja62I4z2sqNkG2LY=;
	h=Subject:From:To:Date:List-ID:From;
	b=XdC0I82Dxx1EF9wMQN84lHnMkI/8eaDVITjCjvC49wR/BcD8MUzLNZxzA3YY8fVTR
	 zVzxD36Q9jccgNy3+euyBnrdWxuR+blQQYCcmiqoaemvtVUPW7JjwHGRppeMhqI9Xp
	 cdqWt8w56JTQmg+no6D7Qik8HtivDd6aI8HcPbww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD0TaX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0TaV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 15:30:21 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63156205C9;
        Mon, 27 Apr 2020 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588015820;
        bh=QejvvNubgTxnvktUUjj0URNakT/Ja62I4z2sqNkG2LY=;
        h=Subject:From:To:Date:From;
        b=r5R137852oAyQylydzqiV+0V/L6VBFgu7RPXXkHttsX4iKCwafGp/KBFPYWlyXwHz
         yT+HkmdyjFGXAAF7dnB0cKcTr2m831QyTPNHBVGHXoP0L5VhDyrUGMzbuZi9RJpwsd
         ICV4AZCBdebzFcXOHqVrYTqAuAwolkNuQ935qSVk=
Message-ID: <32d4e162c6771bd0e0e161e992a7beb5396cdad7.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.115-rt49
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 27 Apr 2020 14:30:18 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.115-rt49 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 7ef3100b1ce706450de2fa2b76003b1e47e12131

Or to build 4.19.115-rt49 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.115-rt49.patch.xz

You can also build from 4.19.115-rt48 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.115-rt48-rt49.patch.xz

Enjoy!

   Tom

Changes from v4.19.115-rt48:
---

Tom Zanussi (1):
      Linux 4.19.115-rt49

Zhang Xiao (1):
      tasklet: Address a race resulting in double-enqueue
---
include/linux/interrupt.h | 5 ++++-
 kernel/softirq.c          | 6 +++++-
 localversion-rt           | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)
---
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 97d9ba26915e..a3b5edb26bc5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -579,12 +579,15 @@ enum
 {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
 	TASKLET_STATE_RUN,	/* Tasklet is running (SMP only) */
-	TASKLET_STATE_PENDING	/* Tasklet is pending */
+	TASKLET_STATE_PENDING,	/* Tasklet is pending */
+	TASKLET_STATE_CHAINED	/* Tasklet is chained */
 };
 
 #define TASKLET_STATEF_SCHED	(1 << TASKLET_STATE_SCHED)
 #define TASKLET_STATEF_RUN	(1 << TASKLET_STATE_RUN)
 #define TASKLET_STATEF_PENDING	(1 << TASKLET_STATE_PENDING)
+#define TASKLET_STATEF_CHAINED	(1 << TASKLET_STATE_CHAINED)
+#define TASKLET_STATEF_RC	(TASKLET_STATEF_RUN | TASKLET_STATEF_CHAINED)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 static inline int tasklet_trylock(struct tasklet_struct *t)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 25bcf2f2714b..73dae64bfc9c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -947,6 +947,10 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	 * is locked before adding it to the list.
 	 */
 	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
+			tasklet_unlock(t);
+			return;
+		}
 		t->next = NULL;
 		*head->tail = t;
 		head->tail = &(t->next);
@@ -1040,7 +1044,7 @@ static void tasklet_action_common(struct softirq_action *a,
 again:
 		t->func(t->data);
 
-		while (!tasklet_tryunlock(t)) {
+		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
 			/*
 			 * If it got disabled meanwhile, bail out:
 			 */
diff --git a/localversion-rt b/localversion-rt
index 24707986c321..4b7dca68a5b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt48
+-rt49

