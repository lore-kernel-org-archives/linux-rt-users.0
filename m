Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22836C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 11:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C649216C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 11:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Mh7PpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgKCLjK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgKCLjK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 06:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604403548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeztd93XJ6fIVRe2Nhpf4Efvu2ru9Gy8dWiHvCYzV1A=;
        b=V4Mh7PpQhn7TB5cOWNgm/0YcUQYD2FvEOS6vbs4qugWSvfo2JyPky9UU4M9gJzJyhmdr1N
        1O+TK0JE83MDcIOe2ig4wbHxPk0ZxEvvZlreH3mnZyFjQ7CqX1A1KqZ3kLymtmNPuBsFAU
        WufzpwatFjiN2zF+kY+2bQiDqr7d6ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-qrOjZ6kiMwKwx9NV8MW5Qg-1; Tue, 03 Nov 2020 06:39:07 -0500
X-MC-Unique: qrOjZ6kiMwKwx9NV8MW5Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 025316415B;
        Tue,  3 Nov 2020 11:39:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A3695D9CC;
        Tue,  3 Nov 2020 11:39:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Nov 2020 12:39:05 +0100 (CET)
Date:   Tue, 3 Nov 2020 12:39:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201103113901.GA29800@redhat.com>
References: <20201102155001.GA18313@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102155001.GA18313@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 kernel/ptrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3075006d720e..3f7156f06b6c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,8 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -207,12 +207,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
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
2.25.1.362.g51ebf55


