From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH rt-3.6 3/3] preempt-rcu: untangle kconfig RT_FULL/PREEMPT_RCU relationship
Date: Thu, 21 Feb 2013 14:53:34 -0500
Message-ID: <1361476414-27352-4-git-send-email-paul.gortmaker@windriver.com>
References: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36859 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab3BUTx5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2013 14:53:57 -0500
In-Reply-To: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The intent of the rcu-force-preempt-rcu-for-rt.patch was to
ensure you weren't even asked about PREEMPT_RCU when RT_FULL
was =y.  However it tried to achieve this with a dependency,
and that just masks the option completely.  This wasn't noticed
since the patch was accidentally reverted, and misplaced (see
prev two commits) and hence the misuse of a dependency causing
the exact opposite of the desired effect went un-noticed.

By using a select PREEMPT_RCU in the RT_FULL block, we get
the desired effect, i.e. Kconfig will not ask the user whether
they want PREEMPT_RCU.  It will simply set it unconditionally
for anyone with RT_FULL=y

Since RT_FULL Kconfig control block doesn't even appear until
the kconfig-preempt-rt-full.patch - we insert the select line
into that patch.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kconfig-preempt-rt-full.patch      |  3 ++-
 rcu-force-preempt-rcu-for-rt.patch | 30 ------------------------------
 series                             |  1 -
 3 files changed, 2 insertions(+), 32 deletions(-)
 delete mode 100644 rcu-force-preempt-rcu-for-rt.patch

diff --git a/kconfig-preempt-rt-full.patch b/kconfig-preempt-rt-full.patch
index ca7261d..92fc433 100644
--- a/kconfig-preempt-rt-full.patch
+++ b/kconfig-preempt-rt-full.patch
@@ -23,7 +23,7 @@ Index: linux-stable/kernel/Kconfig.preempt
 ===================================================================
 --- linux-stable.orig/kernel/Kconfig.preempt
 +++ linux-stable/kernel/Kconfig.preempt
-@@ -73,6 +73,13 @@ config PREEMPT_RTB
+@@ -73,6 +73,14 @@ config PREEMPT_RTB
  	  enables changes which are preliminary for the full preemptiple
  	  RT kernel.
  
@@ -31,6 +31,7 @@ Index: linux-stable/kernel/Kconfig.preempt
 +	bool "Fully Preemptible Kernel (RT)"
 +	depends on IRQ_FORCED_THREADING
 +	select PREEMPT_RT_BASE
++	select PREEMPT_RCU
 +	help
 +	  All and everything
 +
diff --git a/rcu-force-preempt-rcu-for-rt.patch b/rcu-force-preempt-rcu-for-rt.patch
deleted file mode 100644
index 38eeb2a..0000000
diff --git a/series b/series
index 24902ef..67af1d8 100644
--- a/series
+++ b/series
@@ -435,7 +435,6 @@ timer-handle-idle-trylock-in-get-next-timer-irq.patch
 timer.c-fix-build-fail-for-RT_FULL.patch
 
 # RCU
-rcu-force-preempt-rcu-for-rt.patch
 peter_zijlstra-frob-rcu.patch
 rcu-merge-rcu-bh-into-rcu-preempt-for-rt.patch
 rcu-tiny-merge-bh.patch
-- 
1.8.1.2

