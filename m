Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE7C63798
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF75238E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 17:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wvvP0LBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgKQRTz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 12:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgKQRTx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Nov 2020 12:19:53 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F70824655;
        Tue, 17 Nov 2020 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605633593;
        bh=GeHWRThaUcordSgxo06Ji3CTMDPOZcSeFjkaSz7xR1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wvvP0LBVCB3C/dEAdgC8glrgo/cvF2r/iuQX0LwsM09vJsOS8ETM039ZRbn0N0ZGL
         pB4Ztlaz9RgsFUiPrpdNTiZavf275CkS8do/eSspifWhJeBy6KujTzA/D6eR+k4/uc
         5WQW4+X8hxqPe2C+IanDxtGXvY1CExFG+JjvtffE=
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
Cc:     Oleg Nesterov <oleg@redhat.com>, stable-rt@vger.kernel.org
Subject: [PATCH RT 2/3] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Date:   Tue, 17 Nov 2020 11:19:47 -0600
Message-Id: <02d3ca5c665db3e291ab1100806c8b99cc12c080.1605633581.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
In-Reply-To: <cover.1605633581.git.zanussi@kernel.org>
References: <cover.1605633581.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

v4.19.152-rt66-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 0fdc91971b34cf6857b4cfd8c322ae936cfc189b ]

The patch "ptrace: fix ptrace vs tasklist_lock race" changed
ptrace_freeze_traced() to take task->saved_state into account, but
ptrace_unfreeze_traced() has the same problem and needs a similar fix:
it should check/update both ->state and ->saved_state.

Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Fixes: "ptrace: fix ptrace vs tasklist_lock race"
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/ptrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a38b304fb9fd..cbefb0234be3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -191,8 +191,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -201,12 +201,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
-- 
2.17.1

