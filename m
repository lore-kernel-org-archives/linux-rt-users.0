Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFADC3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB924650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320403;
	bh=MHumjK1yVCfvgQomt98dZYGGfD2i4oMOy7Azh3SPGE0=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=u8yuiYwKstdJ1V5ain/hjBsPdj+lX9fQgGUb4oGJE8h4ZSyDRdd/p4YXldlwgsnS8
	 /4XkFqnEhfDE8lnDeRElArTqsJXwxU1MtGVznPYq/wBIUfnUD30L/rJ05z1pMeXSkG
	 g0oK2oYLRFUFRPpJWG2uddUExE7OuhpYeO18Zd+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBUVZX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgBUVZV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:21 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4920924670;
        Fri, 21 Feb 2020 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320321;
        bh=MHumjK1yVCfvgQomt98dZYGGfD2i4oMOy7Azh3SPGE0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=L6LI9M2/U7k3Rw9vTL0DoWLZ/y9yWRSsjj+fxw/lMdOf56+Zx46Qn3Bw97pa9c5rr
         jhjzuXJFQ316oQ4tmgLNydJ6LZDEHVo9CqjMiNKrSdr0dkGrcDd60E+7tZFnCFWzWz
         oxMwaNN0C/7i4yqC+rQ0/uO4OEVqPa9Qr4CT+91U=
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
Subject: [PATCH RT 06/25] =?UTF-8?q?sched:=20migrate=5Fdis/enable:=20Use?= =?UTF-8?q?=20sleeping=5Flock=E2=80=A6()=20to=20annotate=20sleeping=20poin?= =?UTF-8?q?ts?=
Date:   Fri, 21 Feb 2020 15:24:34 -0600
Message-Id: <882928ccb55265cc9fd76858057faac2c132b280.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 4230dd3824c3e1785504e6f757ce79a4b55651fa ]

Without this, rcu_note_context_switch() will complain if an RCU read lock
is held when migrate_enable() calls stop_one_cpu().  Likewise when
migrate_disable() calls pin_current_cpu() which calls __read_rt_lock() --
which bypasses the part of the mutex code that calls sleeping_lock_inc().

Signed-off-by: Scott Wood <swood@redhat.com>
[bigeasy: use sleeping_lock_…() ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
---
 kernel/cpu.c        | 2 ++
 kernel/sched/core.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 05b93cfa6fd9..9be794896d87 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -314,7 +314,9 @@ void pin_current_cpu(void)
 	preempt_lazy_enable();
 	preempt_enable();
 
+	sleeping_lock_inc();
 	__read_rt_lock(cpuhp_pin);
+	sleeping_lock_dec();
 
 	preempt_disable();
 	preempt_lazy_disable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fde47216af94..fcff75934bdc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7045,7 +7045,10 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+
+			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			sleeping_lock_dec();
 			tlb_migrate_finish(p->mm);
 
 			return;
-- 
2.14.1

