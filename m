From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH - cyclictest] sched_switch not sched-switch
Date: Tue, 3 Jun 2008 12:11:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806031209550.22839@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:54485 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbYFCQLQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jun 2008 12:11:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I noticed I had a typo on sched_switch. I tested this on linux-tip tree
and it works there.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c	2008-06-03 11:52:18.000000000 -0400
+++ rt-tests/src/cyclictest/cyclictest.c	2008-06-03 12:08:45.000000000 -0400
@@ -396,7 +396,7 @@ void *timerthread(void *param)
 					if (ftrace)
 						ret = settracer("ftrace");
 					else
-						ret = settracer("sched-switch");
+						ret = settracer("sched_switch");
 				}
 			}


