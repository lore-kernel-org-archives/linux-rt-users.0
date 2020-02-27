Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE8C76565
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1924691
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814044;
	bh=LE1s5yPMNdQaEEEPZUrcN3OXyRfWgi9hGXZ7nKPERmA=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=VTPBhKxGW0vb0vkDX/sQfwwmqc54WifAds9hiM2Iz6i7ZRjEItzkhcYAXUR0l1BLd
	 zOOBqdrxxKpZuLBMuMmuO4cgh/viwi0Hle/GDgkFk0jmAiklUQIpr/OOwdAt7gmANK
	 xoW9GXcsXNC5t7fWpXj3aUxJ13gC/5u/izC92N60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgB0OeD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732777AbgB0OeC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:02 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E5F246A9;
        Thu, 27 Feb 2020 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814041;
        bh=LE1s5yPMNdQaEEEPZUrcN3OXyRfWgi9hGXZ7nKPERmA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=r8Wo7Zqto310oe21FtqiQUmtmZBhOE1s0PyTk3kttu0FHgDyGU6YvXjO9ZcW+7meo
         M3yjgC6m0dBenkxPdcZP1Pv63dpRv7VaqMDbhdEup+FS3ULDzIoS27OkavE5jtQ9XL
         0DWikifUMhTfDLhmak4uWTNiakx65o549makb844=
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
Subject: [PATCH RT 06/23] sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
Date:   Thu, 27 Feb 2020 08:33:17 -0600
Message-Id: <414ce6cf9d1dbe18cc4e9897cb958e9f1a2cb816.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit e5606fb7b042db634ed62b4dd733d62e050e468f ]

This function is concerned with the long-term cpu mask, not the
transitory mask the task might have while migrate disabled.  Before
this patch, if a task was migrate disabled at the time
__set_cpus_allowed_ptr() was called, and the new mask happened to be
equal to the cpu that the task was running on, then the mask update
would be lost.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcff75934bdc..8d6badac9225 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1192,7 +1192,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
-- 
2.14.1

