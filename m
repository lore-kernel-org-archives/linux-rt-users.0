Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152AC35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BB32465D
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320366;
	bh=FBWGjyXidMULYGa15uWHx+4ZyipPXjJ6LzI1BAff1CU=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=fbqf+J8jnHM5MCx6X7GtjIJwlGX7jrc8TWb9Gq1RDDY3XWf9JfcJXcq/APAEbo2NM
	 CP+GFTG4dPnPb9X9TJc2ykbBScIDeYwteakEzlLBD2ajVE4TA9q9rwbluGVkC6nYUF
	 +DnH+TqvwofyHBprBPQbP5QkuxxBnHXv2RqX0GkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgBUVZh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbgBUVZg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:36 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E297524690;
        Fri, 21 Feb 2020 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320335;
        bh=FBWGjyXidMULYGa15uWHx+4ZyipPXjJ6LzI1BAff1CU=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=0Jn+Y/b6tr5Zbo+LHBLKSr7m+AGlpT8IhMck6v8DfKF1v22F/AWuhIo5ELBdellgm
         +ZK9uFcc6avja1mwcs4yUBHpAs66ZhliUZZxq9bAEpdBHaNaHnhYdAaib3aAOCCMNE
         YeTRPEc3ZJZCPLvB76xL5rl1sx2hchimajfP+bSs=
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
Subject: [PATCH RT 21/25] smp: Use smp_cond_func_t as type for the conditional function
Date:   Fri, 21 Feb 2020 15:24:49 -0600
Message-Id: <c7bd8ba713f3e67bf77ea6847ab85ab47f8168a2.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 0c2799d2b9cd2e314298c68b81fbdc478f552ad4 ]

Use a typdef for the conditional function instead defining it each time in
the function prototype.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	include/linux/smp.h
	kernel/smp.c
	kernel/up.c
---
 include/linux/smp.h | 6 +++---
 kernel/smp.c        | 5 ++---
 kernel/up.c         | 5 ++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 5801e516ba63..af05a63e4c06 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -15,6 +15,7 @@
 #include <linux/llist.h>
 
 typedef void (*smp_call_func_t)(void *info);
+typedef bool (*smp_cond_func_t)(int cpu, void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
@@ -49,9 +50,8 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
  * cond_func returns a positive value. This may include the local
  * processor.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags);
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index c94dd85c8d41..00fbb6aa948a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -667,9 +667,8 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	cpumask_var_t cpus;
 	int cpu, ret;
diff --git a/kernel/up.c b/kernel/up.c
index 42c46bf3e0a5..a0276ba75270 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,8 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	unsigned long flags;
 
-- 
2.14.1

