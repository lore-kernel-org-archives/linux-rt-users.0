Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF9CC433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFB92184D
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHMBqV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgHMBp5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C4F20756;
        Thu, 13 Aug 2020 01:45:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JX-0074zW-Go; Wed, 12 Aug 2020 21:45:55 -0400
Message-ID: <20200813014555.384329363@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH RT 1/6] signal: Prevent double-free of user struct
References: <20200813014534.833107526@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.54-rt33-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Matt Fleming <matt@codeblueprint.co.uk>

The way user struct reference counting works changed significantly with,

  fda31c50292a ("signal: avoid double atomic counter increments for user accounting")

Now user structs are only freed once the last pending signal is
dequeued. Make sigqueue_free_current() follow this new convention to
avoid freeing the user struct multiple times and triggering this
warning:

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 0 PID: 6794 at lib/refcount.c:288 refcount_dec_not_one+0x45/0x50
 Call Trace:
  refcount_dec_and_lock_irqsave+0x16/0x60
  free_uid+0x31/0xa0
  __dequeue_signal+0x17c/0x190
  dequeue_signal+0x5a/0x1b0
  do_sigtimedwait+0x208/0x250
  __x64_sys_rt_sigtimedwait+0x6f/0xd0
  do_syscall_64+0x72/0x200
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Reported-by: Daniel Wagner <wagi@monom.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index def2e8e37f1f..aa924f0141cf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -494,8 +494,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
-- 
2.28.0


