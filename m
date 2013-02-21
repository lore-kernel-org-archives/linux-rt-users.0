From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH rt-3.6 2/3] rt: fix mispatch of Kconfig by rcu-force-preempt-rcu-for-rt.patch
Date: Thu, 21 Feb 2013 14:53:33 -0500
Message-ID: <1361476414-27352-3-git-send-email-paul.gortmaker@windriver.com>
References: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40268 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab3BUTx7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2013 14:53:59 -0500
In-Reply-To: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The patch was meant to tie things to an RCU Kconfig, but happened to
instead land in the RT_GROUP_SCHED Kconfig entry.  Put it back to
where it belongs (i.e. PREEMPT_RCU, as evident by the commit log).

The link in the long log is also broken so simply remove it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 rcu-force-preempt-rcu-for-rt.patch | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/rcu-force-preempt-rcu-for-rt.patch b/rcu-force-preempt-rcu-for-rt.patch
index 5de6462..38eeb2a 100644
--- a/rcu-force-preempt-rcu-for-rt.patch
+++ b/rcu-force-preempt-rcu-for-rt.patch
@@ -1,28 +1,30 @@
-Subject: RCU: Force PREEMPT_RCU for PREEMPT-RT
+From a014d7b0c472bf933ca7e570c2c1cd7c5ccdb92b Mon Sep 17 00:00:00 2001
 From: Ingo Molnar <mingo@elte.hu>
 Date: Fri, 3 Jul 2009 08:30:30 -0500
+Subject: [PATCH] RCU: Force PREEMPT_RCU for PREEMPT-RT
 
 PREEMPT_RT relies on PREEMPT_RCU - only allow RCU to be configured
 interactively in the !PREEMPT_RT case.
 
 Signed-off-by: Ingo Molnar <mingo@elte.hu>
 Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
-
 Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
-Link: http://lkml.kernel.org/n/tip-j1y0phicu6s6pu8guku2vca0@git.kernel.org
 ---
- init/Kconfig |    1 -
- 1 file changed, 1 deletion(-)
+ init/Kconfig | 1 +
+ 1 file changed, 1 insertion(+)
 
-Index: linux-stable/init/Kconfig
-===================================================================
---- linux-stable.orig/init/Kconfig
-+++ linux-stable/init/Kconfig
-@@ -806,7 +806,6 @@ config RT_GROUP_SCHED
- 	bool "Group scheduling for SCHED_RR/FIFO"
- 	depends on EXPERIMENTAL
- 	depends on CGROUP_SCHED
--	depends on !PREEMPT_RT_FULL
- 	default n
+diff --git a/init/Kconfig b/init/Kconfig
+index badd56f..dc99d20 100644
+--- a/init/Kconfig
++++ b/init/Kconfig
+@@ -437,6 +437,7 @@ endchoice
+ 
+ config PREEMPT_RCU
+ 	def_bool ( TREE_PREEMPT_RCU || TINY_PREEMPT_RCU )
++	depends on !PREEMPT_RT_FULL
  	help
- 	  This feature lets you explicitly allocate real CPU bandwidth
+ 	  This option enables preemptible-RCU code that is common between
+ 	  the TREE_PREEMPT_RCU and TINY_PREEMPT_RCU implementations.
+-- 
+1.8.1.2
+
-- 
1.8.1.2

