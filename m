From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] rt: sysctl compile fix for when profiling is off
Date: Mon, 29 Sep 2008 10:32:53 -0400
Message-ID: <dd82952098475b55a2e24cccaaeac37dc00edf76.1222698507.git.paul.gortmaker@windriver.com>
References: <1222698773-5920-1-git-send-email-paul.gortmaker@windriver.com>
 <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
 <2207c74a6dd86a8c88b6c0adfac45e7852f8b99b.1222698507.git.paul.gortmaker@windriver.com>
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44178 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbYI2OdF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Sep 2008 10:33:05 -0400
In-Reply-To: <2207c74a6dd86a8c88b6c0adfac45e7852f8b99b.1222698507.git.paul.gortmaker@windriver.com>
In-Reply-To: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
References: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

prof_pid will be an unresolved symbol if you don't enable
profiling, and the final link of the kernel will fail. Make
the sysctl entry conditional on the appropriate Kconfig option.

This patch should be considered for merge into the existing
preempt-realtime-debug-sysctl.patch.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/sysctl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 584969c..ba2239e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -366,6 +366,7 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_PROFILING
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "prof_pid",
@@ -374,6 +375,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif
 #ifdef CONFIG_PREEMPT
 	{
 		.ctl_name	= CTL_UNNUMBERED,
-- 
1.6.0

