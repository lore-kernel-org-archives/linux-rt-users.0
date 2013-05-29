From: Mike Galbraith <bitbucket@online.de>
Subject: [patch] rt,mce: fix mce timer interval
Date: Wed, 29 May 2013 13:52:13 +0200
Message-ID: <1369828333.6089.133.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57666 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965645Ab3E2LwX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 May 2013 07:52:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Seems mce timer fire at the wrong frequency in -rt kernels since roughly
forever due to 32 bit overflow.  3.8-rt is also missing a multiplier.

Add missing us -> ns conversion and 32 bit overflow prevention.

Signed-off-by: Mike Galbraith <bitbucket@online.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1295,7 +1295,7 @@ static enum hrtimer_restart mce_timer_fn
 	__this_cpu_write(mce_next_interval, iv);
 	/* Might have become 0 after CMCI storm subsided */
 	if (iv) {
-		hrtimer_forward_now(timer, ns_to_ktime(jiffies_to_usecs(iv)));
+		hrtimer_forward_now(timer, ns_to_ktime((u64)jiffies_to_usecs(iv) * 1000));
 		return HRTIMER_RESTART;
 	}
 	return HRTIMER_NORESTART;
@@ -1323,7 +1323,7 @@ void mce_timer_kick(unsigned long interv
 		}
 	} else {
 		hrtimer_start_range_ns(t,
-				ns_to_ktime(jiffies_to_usecs(interval) * 1000),
+				ns_to_ktime((u64)jiffies_to_usecs(interval) * 1000),
 				0, HRTIMER_MODE_REL_PINNED);
 	}
 	if (interval < iv)
@@ -1691,7 +1691,7 @@ static void mce_start_timer(unsigned int
 	if (mca_cfg.ignore_ce || !iv)
 		return;
 
-	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000),
+	hrtimer_start_range_ns(t, ns_to_ktime((u64)jiffies_to_usecs(iv) * 1000),
 			0, HRTIMER_MODE_REL_PINNED);
 }
 


