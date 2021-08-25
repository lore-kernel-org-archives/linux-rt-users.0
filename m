Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175BCC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Aug 2021 13:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E931961103
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Aug 2021 13:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbhHYN2m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240616AbhHYN2m (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Aug 2021 09:28:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30CB76112D;
        Wed, 25 Aug 2021 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629898076;
        bh=dEZWd67W0cCylw8Z3+SFTbYcQCCEGp+ENmvhRLuwVsg=;
        h=Date:From:To:Cc:Subject:From;
        b=uAgbwPA4PwK0ajyScRSzJ7Zrajb1hzlh4oqH43QVZ5dfuCWfdDq7tB7RlwDV1EfZ3
         uQRsrA6omGlg3qIsd0qorGUaCy+i1PkBoRw03r9EBr4VqaSGqqGmlRaEeM9+awQaGT
         yiGI9kTgJycGKGm2Ih1MoQImgyyPXCh0bWmfSd5W9jJc4JoFU6d9194TCw9haPj3iE
         e++fUUavamIEM40FfYsPrp66S+maI9W+zJ1H2XAfGR0XKXcs2NTOvw41zLvvERVawH
         pfM45yj6+FvIyJ9yjF+MHuf6a7XdrxMBWAKBA/3NRKGYgY9VPlMNXWJkCALRpHFLDi
         PawcEAhFzE/qw==
Date:   Wed, 25 Aug 2021 15:27:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair in
 PREEMPT_RT
Message-ID: <20210825132754.GA895675@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Ok the patch is gross but at least this lets me start a discussion
about the issue.

---
From d9d66d650b3dac8947a34464dd2e0b546a8c6b63 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 25 Aug 2021 14:24:54 +0200
Subject: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair in PREEMPT_RT

The eventpoll lock has been converted to an rwlock some time ago with:

	a218cc491420 (epoll: use rwlock in order to reduce ep_poll
					callback() contention)

Unfortunately this can result in scenarios where a high priority caller
of epoll_wait() need to wait for the completion of lower priority wakers.

The typical scenario is:

1) epoll_wait() waits and sleeps for new events in the ep_poll() loop.

2) new events arrive in ep_poll_callback(), the waiter is awaken while
   ep->lock is read-acquired.

3) The high priority waiter preempts the waker but it can't acquire the
   write lock in epoll_wait() so it blocks waiting for the low prio waker
   without priority inheritance.

I guess making readlock writer fair is still not the plan so all I can
propose is to make that rwlock build-conditional.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/eventpoll.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1e596e1d0bba..c1fb4b01ea4f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1133,7 +1133,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
-	read_lock_irqsave(&ep->lock, flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		read_lock_irqsave(&ep->lock, flags);
+	else
+		write_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1197,7 +1200,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		pwake++;
 
 out_unlock:
-	read_unlock_irqrestore(&ep->lock, flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		read_unlock_irqrestore(&ep->lock, flags);
+	else
+		write_unlock_irqrestore(&ep->lock, flags);
 
 	/* We have to call this outside the lock */
 	if (pwake)
-- 
2.25.1

