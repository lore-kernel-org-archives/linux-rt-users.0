From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix compilation of 2.6.23rc4-rt1 without CONFIG_PREEMPT_RT
Date: Mon, 17 Sep 2007 17:52:37 +0200
Message-ID: <200709171752.37772.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41097 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbXIQPwm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 11:52:42 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


count_active_rt_tasks() is undefined otherwise.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rc4-rt1/kernel/timer.c
===================================================================
--- linux-2.6.23-rc4-rt1.orig/kernel/timer.c
+++ linux-2.6.23-rc4-rt1/kernel/timer.c
@@ -919,18 +919,20 @@ static unsigned long count_active_tasks(
 #endif
 }
 
-#ifdef CONFIG_PREEMPT_RT
 /*
  * Nr of active tasks - counted in fixed-point numbers
  */
 static unsigned long count_active_rt_tasks(void)
 {
+#ifdef CONFIG_PREEMPT_RT
 	extern unsigned long rt_nr_running(void);
 	extern unsigned long rt_nr_uninterruptible(void);
 
 	return (rt_nr_running() + rt_nr_uninterruptible()) * FIXED_1;
-}
+#else
+	return 0;
 #endif
+}
 
 /*
  * Hmm.. Changed this, as the GNU make sources (load.c) seems to
