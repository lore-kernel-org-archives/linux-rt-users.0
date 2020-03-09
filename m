Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA6C10F29
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B1924654
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783326;
	bh=t5E4LYaQi3hLF0ZQnDleGqngq0///iKC3muWnbwhvos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ErSCZwwSZYS2hAY3Izu8evEFOkpAAOVBmdN4O4bY1Vf6fNe0frz3z42NUQzMLgDcS
	 VhmVs/O2+D0heqP8d1rHQ+Ou/PxGL5wMZIsb5Sh7kE4MiU93y2kstAmpYHJkXYGEbB
	 6MO9Bv7NuOFx5VKaQKgoky+CoLUIXyFFDDtoviaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCITsm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCITsS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:18 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0ED124676;
        Mon,  9 Mar 2020 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783297;
        bh=t5E4LYaQi3hLF0ZQnDleGqngq0///iKC3muWnbwhvos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=G9pFhIVSforCc9xPpZFfoKmL0cEmzc1qDZ6RmU/cCg85aAsvHSeLjn3jTCGrx8SnH
         vZpUjOFYkdDfsus9ROEJvg3v4+z9wR9JKgHM3C0d/UVwj19esUYY0WAPxgVNgrn54H
         My8oK5vREsjuTtnX/SlnhJWORuaGDJ9eiRiMVc9o=
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
Cc:     Scott Wood <swood@redhat.com>
Subject: [PATCH RT 3/8] sched: migrate_enable: Remove __schedule() call
Date:   Mon,  9 Mar 2020 14:47:48 -0500
Message-Id: <f0a8c1fd33e6f0311487e055bb8318f265628f60.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit b8162e61e9a33bd1de6452eb838fbf50a93ddd9a ]

We can rely on preempt_enable() to schedule.  Besides simplifying the
code, this potentially allows sequences such as the following to be
permitted:

migrate_disable();
preempt_disable();
migrate_enable();
preempt_enable();

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Scott Wood <swood@redhat.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 960daa6bc7f04..3ff48df25cff8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7024,7 +7024,6 @@ void migrate_enable(void)
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    arg, work);
 		tlb_migrate_finish(p->mm);
-		__schedule(true);
 	}
 
 out:
-- 
2.14.1

