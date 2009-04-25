From: Remy Bohmer <linux@bohmer.net>
Subject: [patch 1/1] PREEMPT_RT: Fix compile error in case high-res-timers
 are not configured.
Date: Sat, 25 Apr 2009 20:47:45 +0200
Message-ID: <49f35c6f.1818d00a.3b20.ffff95d3@mx.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Remy Bohmer <linux@bohmer.net>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:27543 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbZDYSyl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Apr 2009 14:54:41 -0400
Content-Disposition: inline; filename=repair-build-failure-in-case-hrtimers-are-disabled.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2.6.29.1-rt does not compile if high-res-timers are not configured
It can, for example, be reproduced by using at91sam9261ek_defconfig (ARM)

Signed-off-by: Remy Bohmer <linux@bohmer.net>
---
 kernel/hrtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.29/kernel/hrtimer.c
===================================================================
--- linux-2.6.29.orig/kernel/hrtimer.c	2009-04-25 18:32:54.000000000 +0200
+++ linux-2.6.29/kernel/hrtimer.c	2009-04-25 18:36:27.000000000 +0200
@@ -1230,7 +1230,7 @@ static void __run_hrtimer(struct hrtimer
 	timer->state &= ~HRTIMER_STATE_CALLBACK;
 }
 
-#ifdef CONFIG_PREEMPT_RT
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_HIGH_RES_TIMERS)
 
 
 static void hrtimer_rt_reprogram(int restart, struct hrtimer *timer,

-- 

