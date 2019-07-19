Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A5C76196
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFD72184E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfGSVuf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388763AbfGSVt7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCDF2189E;
        Fri, 19 Jul 2019 21:49:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalJ-00082E-8e; Fri, 19 Jul 2019 17:49:57 -0400
Message-Id: <20190719214957.155151346@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 07/16] sched/core: Drop a preempt_disable_rt() statement
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 761126efdcbe3fa3e99c9079fa0ad6eca2f251f2 ]

The caller holds a lock which already disables preemption.
Drop the preempt_disable_rt() statement in get_nohz_timer_target().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 91a9b2556fb0..1b2503b87473 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -558,14 +558,11 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu;
+	int i, cpu = smp_processor_id();
 	struct sched_domain *sd;
 
-	preempt_disable_rt();
-	cpu = smp_processor_id();
-
 	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		goto preempt_en_rt;
+		return cpu;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -584,8 +581,6 @@ int get_nohz_timer_target(void)
 		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
 unlock:
 	rcu_read_unlock();
-preempt_en_rt:
-	preempt_enable_rt();
 	return cpu;
 }
 
-- 
2.20.1


