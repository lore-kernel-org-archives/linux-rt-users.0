Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71996C0650F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8712184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294051;
	bh=L7znTwJ30DixZpr8AixSBt+yPmHFg5k/O5GZecApfmg=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=BA+Gf1C3H/MyvWReWhNZDnivnJwdJ8MhudgkNf0DehJhSvOcjDc5IBX1f/IduuL6f
	 kry0KAlaKoBji3rlthAHmYhTAL5SH4rceBJCIDHZjr+TPufKKxRqn0rDvRLqMnme0z
	 /29lTC92TJSzrYrLqcW3PSi76qgMRRublS/JOeRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbfHHTxW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404488AbfHHTxV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:21 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A02218BE;
        Thu,  8 Aug 2019 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294000;
        bh=L7znTwJ30DixZpr8AixSBt+yPmHFg5k/O5GZecApfmg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=k1owMLkaD9GoVmyw7TDvOoYdW0XYV1AQcFERL/HenE/KAwD9h5+CVYy9fg/EtBCe1
         hjqd2PkUm2KGNXCz5IqSGeqFzsbDjyZSmvZGFTKH7WCLj/OkhfYRIsvgMNHMaLg9Wg
         TPE0v55tRcLhRb5pMqM8CJQNEVer3DUtS07F5snA=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 11/19] sched/core: Drop a preempt_disable_rt() statement
Date:   Thu,  8 Aug 2019 14:52:39 -0500
Message-Id: <4739a43ec2cae31e82934622f4f63164f08bf03b.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 761126efdcbe3fa3e99c9079fa0ad6eca2f251f2 ]

The caller holds a lock which already disables preemption.
Drop the preempt_disable_rt() statement in get_nohz_timer_target().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
        kernel/sched/core.c
---
 kernel/sched/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d2cc0715114..17da1c1aba56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -583,14 +583,11 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu;
+	int i, cpu = smp_processor_id();
 	struct sched_domain *sd;
 
-	preempt_disable_rt();
-	cpu = smp_processor_id();
-
 	if (!idle_cpu(cpu) && is_housekeeping_cpu(cpu))
-		goto preempt_en_rt;
+		return cpu;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -609,8 +606,6 @@ int get_nohz_timer_target(void)
 		cpu = housekeeping_any_cpu();
 unlock:
 	rcu_read_unlock();
-preempt_en_rt:
-	preempt_enable_rt();
 	return cpu;
 }
 
-- 
2.14.1

