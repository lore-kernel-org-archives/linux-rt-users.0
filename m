Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28EC47080
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6777660E0B
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEaVav (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 17:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhEaVar (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 17:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622496546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMvZIAiScihdfx/8ZwwEevov7qSyfL9hw1Y7XqQCmBM=;
        b=EzRP+qdLEzxXXLAc0fz0bsiGg1nOXN9O72NT/YSBo3JTWR+3yXq4zWzPxQTdb7m3Ru7Nyx
        rQYc4jJj2cdrNKFBtIvHmweJbQHLDY1yBMjt34khEdfDd6R1TS9IclANabkwHUVGO2jq26
        jhYtH2OwK+udAHH5MLHFDkUBTUEarUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-cPl-nCX7M_i8IKMouHAXtQ-1; Mon, 31 May 2021 17:29:04 -0400
X-MC-Unique: cPl-nCX7M_i8IKMouHAXtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A61668030A1;
        Mon, 31 May 2021 21:29:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E0C5D6B1;
        Mon, 31 May 2021 21:29:01 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 20C0C3C0176; Mon, 31 May 2021 18:29:00 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 2/3] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Date:   Mon, 31 May 2021 18:28:59 -0300
Message-Id: <20210531212900.37969-3-lgoncalv@redhat.com>
In-Reply-To: <20210531212900.37969-1-lgoncalv@redhat.com>
References: <20210531212900.37969-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

v4.9.268-rt180-rc1 stable review patch.
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
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/ptrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 7245160f37801..809840af4ab60 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -187,8 +187,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -197,12 +197,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
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
2.31.1

