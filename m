From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: [RT-PATCH] v2.6.23-rc1-rt0 Add missing header in sch_generic.c
Date: Tue, 24 Jul 2007 21:03:41 +0200
Message-ID: <200707242103.41880.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55282 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755430AbXGXTDp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 15:03:45 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v2.6.23-rc1-rt0 adds an msleep(1) in net/sched/sch_generic.c
without including the neceessary header. This patches fixes it.

Signed-off-by: Hans J. Koch <hjk@linutronix.de>

----
Index: linux-2.6.23-rc/net/sched/sch_generic.c
===================================================================
--- linux-2.6.23-rc.orig/net/sched/sch_generic.c	2007-07-24 20:09:18.000000000 +0200
+++ linux-2.6.23-rc/net/sched/sch_generic.c	2007-07-24 20:10:13.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 #include <net/pkt_sched.h>
 
 /* Main transmission queue. */
