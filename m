From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] preempt: Define preempt_check_resched_rt() for non
 PREEMPT config
Date: Mon, 12 Mar 2012 22:50:58 -0400
Message-ID: <1331607058.25686.660.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2447 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab2CMCvA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Mar 2012 22:51:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fix compiler error when CONFIG_PREEMPT is not set.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 4125456..11412d7 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -95,6 +95,7 @@ do { \
 #define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
+#define preempt_check_resched_rt()	do { } while (0)
 
 #define preempt_disable_notrace()		do { } while (0)
 #define preempt_enable_no_resched_notrace()	do { } while (0)


