From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 1/2] cyclictest: fix priviledge test
Date: Sat, 28 Mar 2009 12:18:52 -0000
Message-ID: <20090328121805.106328691@linutronix.de>
References: <20090328121720.138287980@linutronix.de>
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37800 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbZC1MWP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Mar 2009 08:22:15 -0400
Content-Disposition: inline; filename=fix-priviledge-test.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Switching back to SCHED_OTHER in check_priv() fails due to the param
argument of sched_setscheduler() set to NULL.

Set the priority to 0 and hand in params.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 src/cyclictest/cyclictest.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -955,7 +955,8 @@ check_privs(void)
 	}
 
 	/* we're good; change back and return success */
-	sched_setscheduler(0, policy, NULL);
+	param.sched_priority = 0;
+	sched_setscheduler(0, policy, &param);
 	return 0;
 }
 


