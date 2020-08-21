Return-Path: <SRS0=gFqs=B7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CE3C433E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DBE20FC3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039260;
	bh=f3yVDNBJvnGh5Iokm9/PFcobvsO5ALwAD6QUltmqU44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=AnUXIv9LIxLHar+Bf6KogwwY3AOIkoDvZDU//CsWt8+idusMsgrFRsZI4YqiNkDHx
	 Iw9lDxsNo2p/MoUFFRLTB/BtlgCKXtUHE7XiqlY6dyPyVJaxPEQLGKpfuOtsuuPq3J
	 ppJ2jtPbv/nqCPTpouthtsdtOQQH9ioLBm+NGp/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHUTrK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgHUTrH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:07 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751F9207CD;
        Fri, 21 Aug 2020 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039227;
        bh=f3yVDNBJvnGh5Iokm9/PFcobvsO5ALwAD6QUltmqU44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ROw4/dA9/I7gR7iBcQaILUsDT3BjeLbI0NaqMjjSuJ6Hp1tnzfH43aW232ggfONWu
         klj1gm3NJFLaEepo/RXDEUtf9ERdfs/InGgqpGDxRsv4bjgQUVxLSxkSsIv6oArWuh
         8Zzr/3p8R7ywfPqL57iwZyHzya1i2lHYrbZRhIDE=
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
Cc:     Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH RT 1/5] signal: Prevent double-free of user struct
Date:   Fri, 21 Aug 2020 14:47:00 -0500
Message-Id: <544fad9036a21c60dc68278fa302cc5cdf477098.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Matt Fleming <matt@codeblueprint.co.uk>

v4.19.135-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upsteam commit 9567db2ebe566a93485e1a27d8759969d0002d7a ]

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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 45748993f777..05c9b5a6b3ae 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -488,8 +488,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
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
2.17.1

