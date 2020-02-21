Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE66C35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3B224692
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320336;
	bh=uW3tfUlR4IC1gt95wVGRNkZwAxUbH/UJHPnIk28PIYo=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=dA8zHe9u8bnfF+oehxWnXmg0TA1eggxtiL4qrXM7n05XF/P0q+7K0Rt9d9p4NtfEJ
	 Oj36itpslD2ZH5HqchHHLBNefzo3kjT3bY3FCexmzmRVjC0FM+8R0i139YpBU/3MCh
	 5TovpWhwiZdxNKQUkOqC4dKSiXQ7+quea3Y9KuAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgBUVZf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbgBUVZe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:34 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B192468C;
        Fri, 21 Feb 2020 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320333;
        bh=uW3tfUlR4IC1gt95wVGRNkZwAxUbH/UJHPnIk28PIYo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TCnwDtU5tuAUa2J6/tovhTcWZziCvRkKAITd6zsleuKVAHBezHAjQxTqwv/hQ/J1L
         qjqJCj1w/dapVD//F4ngQPjL/xs7nrAhMO+a06MbkEwlDMvtTR/oRfxKrnS/3jFpDp
         a8f3zmqNfmoOMIpo+AZqPjv2jP/pd3/53B/9GExw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 19/25] userfaultfd: Use a seqlock instead of seqcount
Date:   Fri, 21 Feb 2020 15:24:47 -0600
Message-Id: <889f5b989b28eb7b29f21092432948cd12d97c48.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit dc952a564d02997330654be9628bbe97ba2a05d3 ]

On RT write_seqcount_begin() disables preemption which leads to warning
in add_wait_queue() while the spinlock_t is acquired.
The waitqueue can't be converted to swait_queue because
userfaultfd_wake_function() is used as a custom wake function.

Use seqlock instead seqcount to avoid the preempt_disable() section
during add_wait_queue().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/userfaultfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e2b2196fd942..71886a8e8f71 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -51,7 +51,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqlock_t refile_seq;
 	/* pseudo fd refcounting */
 	atomic_t refcount;
 	/* userfaultfd syscall flags */
@@ -1047,7 +1047,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqcount_begin(&ctx->refile_seq);
+			write_seqlock(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1073,7 +1073,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			__add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_seqcount_end(&ctx->refile_seq);
+			write_sequnlock(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1246,11 +1246,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	 * sure we've userfaults to wake.
 	 */
 	do {
-		seq = read_seqcount_begin(&ctx->refile_seq);
+		seq = read_seqbegin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
 		cond_resched();
-	} while (read_seqcount_retry(&ctx->refile_seq, seq));
+	} while (read_seqretry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
 }
@@ -1915,7 +1915,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqlock_init(&ctx->refile_seq);
 }
 
 /**
-- 
2.14.1

