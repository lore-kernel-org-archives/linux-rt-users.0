Return-Path: <SRS0=Gh4n=3G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA2C33CB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024424691
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgAQRmJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgAQRld (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B3524683;
        Fri, 17 Jan 2020 17:41:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVci-000QbZ-0K; Fri, 17 Jan 2020 12:41:32 -0500
Message-Id: <20200117174131.893547195@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RT 30/32] lib/smp_processor_id: Adjust check_preemption_disabled()
References: <20200117174111.282847363@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.94-rt39-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit af3c1c5fdf177870fb5e6e16b24e374696ab28f5 ]

The current->migrate_disable counter is not always defined leading to
build failures with DEBUG_PREEMPT && !PREEMPT_RT_BASE.

Restrict the access to ->migrate_disable to same set where
->migrate_disable is modified.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: adjust condition + description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/smp_processor_id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 0c80992aa337..2e7398534b66 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -22,8 +22,10 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
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
2.24.1


