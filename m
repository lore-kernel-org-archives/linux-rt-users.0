From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.12.14-rt23
Date: Fri, 21 Mar 2014 21:13:53 +0100
Message-ID: <20140321201353.GB28289@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52908 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaCUUNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Mar 2014 16:13:55 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v3.12.14-rt23 patch set.

Changes since v3.12.14-rt22
- Helmut Buchsbaum run into OOM because RCU did not have enough time to
  free memory. The problem appeared while the RCU softirq has been
  replaced by the RCU thread. The problem can be "fixed" by giving a
  higher priority to the RCU thread or by just enabled the "RCU_BOOST"
  kernel option. The kernel option is now enabled by default on an -RT
  enabled system and can be disabled by the user if desired.

Known issues:

      - bcache is disabled.

The delta patch against v3.12.14-rt22 is appended below and can be found
here:
   https://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.14-rt22-rt23.patch.xz

The RT patch against 3.12.14 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.14-rt23.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patches-3.12.14-rt23.tar.xz

Sebastian

diff --git a/init/Kconfig b/init/Kconfig
index 4dea595..f6aeea6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -642,7 +642,7 @@ config TREE_RCU_TRACE
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
 	depends on RT_MUTEXES && PREEMPT_RCU
-	default n
+	default y if PREEMPT_RT_FULL
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
diff --git a/localversion-rt b/localversion-rt
index c29508d..9a218ca 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt22
+-rt23
