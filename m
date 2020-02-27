Return-Path: <SRS0=oIgZ=4P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813FC76570
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348DB24656
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Feb 2020 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814082;
	bh=e5MYqZtODO7WjLL1XEqEIwDpwLcnPUwJiLmjVxiQX4M=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=GRTCOTqtZm/saVy3cvngYhCyniMA3S6pQoWrk94+an4y77fPAX6WTzucxnowTeHju
	 sXB99o6+8WiNKqBOTDhiLi4YzaHU0X8YYYrCYfWknNxJgstguSmWHqWhaS5VBZIwO/
	 ryRE8wsdnKTwuaPZL3O9Cl/4uH5EJ+8lfdgX2W3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbgB0OeU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbgB0OeT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:19 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ABA9246BD;
        Thu, 27 Feb 2020 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814059;
        bh=e5MYqZtODO7WjLL1XEqEIwDpwLcnPUwJiLmjVxiQX4M=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=yXu3ovRpe+iaynrcEZWSGrTnCs3lZolybS6rp3WxgLwPJWgYgVZvSvBQelxNpUrrN
         X3oxH6WUVyFJ0WXNX4U3YIYrNT2e7XiM0/yY9s/Nk8CI5HuhxcB9nJhusHaw1n7t+W
         +3sU5GWvNkyIT2bCywaAiUlKhMQ4VMWBKUJDircY=
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
Subject: [PATCH RT 20/23] lib/smp_processor_id: Adjust check_preemption_disabled()
Date:   Thu, 27 Feb 2020 08:33:31 -0600
Message-Id: <b0063a9a073a73c28d15a91336262922bac0dd9e.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit af3c1c5fdf177870fb5e6e16b24e374696ab28f5 ]

The current->migrate_disable counter is not always defined leading to
build failures with DEBUG_PREEMPT && !PREEMPT_RT_BASE.

Restrict the access to ->migrate_disable to same set where
->migrate_disable is modified.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[bigeasy: adjust condition + description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 lib/smp_processor_id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 7a0c19c282cc..3ceb2cc1516b 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,8 +23,10 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+#if defined(CONFIG_PREEMPT_RT_BASE) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
 	if (current->migrate_disable)
 		goto out;
+#endif
 
 	if (current->nr_cpus_allowed == 1)
 		goto out;
-- 
2.14.1

