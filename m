Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CECCC00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3186F22258
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1qkSN5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKBPuM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgKBPuK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604332209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZCMXIm1Yw7j8B5CvIsnr4WYnVLHEIx4rsvb/ca7dssY=;
        b=Q1qkSN5F6G4GQY9nsz4hcYEr58ZGE+QTEpEkYq12neeJzWc6mNMSyX7UA6paZ38ajgLwrL
        pKd2rm1oS6r2OuEgNfu4jfrhCk0vROqTyFvqSadGBfrtC3GhUhM93eJlXbK3fuhju05J3l
        ej+AiKPpKB606qkAxRjoF+g0FEPSdfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-_J5sbszIPSe9HugLW-Angw-1; Mon, 02 Nov 2020 10:50:07 -0500
X-MC-Unique: _J5sbszIPSe9HugLW-Angw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D4961009E23;
        Mon,  2 Nov 2020 15:50:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0CC4E6EF73;
        Mon,  2 Nov 2020 15:50:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Nov 2020 16:50:05 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:50:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102155001.GA18313@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The commit 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
changed ptrace_freeze_traced() to take task->saved_state into account,
but ptrace_unfreeze_traced() has the same problem and needs a similar
fix: it should check/update both ->state and ->saved_state.

Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Fixes: 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3075006d720e..7e004f998233 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,8 +197,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -207,12 +206,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
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
+	raw_spin_lock(&task->pi_lock);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock(&task->pi_lock);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
-- 
2.25.1.362.g51ebf55


