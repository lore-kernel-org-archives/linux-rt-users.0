From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] initialize the clock source to jiffies clock.
Date: Fri, 24 Aug 2007 13:57:14 -0400
Message-ID: <1187978234.2941.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40924 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765698AbXHXR6U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 13:58:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The latency tracer can call clocksource_read very early in bootup and
before the clock source variable has been initialized. This results in a
crash at boot up (even before earlyprintk is initialized). Since the
clock->read variable is points to NULL.

This patch simply initializes the clock to use clocksource_jiffies, so
that any early user of clocksource_read will not crash.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6-rt/kernel/time/timekeeping.c
===================================================================
--- linux-2.6-rt.orig/kernel/time/timekeeping.c	2007-08-24 11:38:11.000000000 -0400
+++ linux-2.6-rt/kernel/time/timekeeping.c	2007-08-24 13:41:03.000000000 -0400
@@ -43,7 +43,15 @@ struct timespec wall_to_monotonic __attr
 EXPORT_SYMBOL(xtime);
 
 
-static struct clocksource *clock; /* pointer to current clocksource */
+extern struct clocksource clocksource_jiffies;
+
+/*
+ * pointer to current clocksource
+ *  Just in case we use clocksource_read before we initialize
+ *  the actual clock source. Instead of calling a NULL read pointer
+ *  we return jiffies.
+ */
+static struct clocksource *clock = &clocksource_jiffies;
 
 
 #ifdef CONFIG_GENERIC_TIME
