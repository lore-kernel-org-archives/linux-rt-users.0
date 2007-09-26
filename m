From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] just rename call_rcu_bh instead of making it a macro
Date: Wed, 26 Sep 2007 14:17:47 -0400
Message-ID: <1190830667.20235.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58849 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbXIZSUS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 14:20:18 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Seems that I found a box that has a config that passes call_rcu_bh as a
function pointer (see net/sctp/sm_make_chunk.c), so declaring the
call_rcu_bh has a macro function isn't good enough.

This patch makes it just another name of call_rcu for rcupreempt.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.23-rc8-rt1/include/linux/rcupreempt.h
===================================================================
--- linux-2.6.23-rc8-rt1.orig/include/linux/rcupreempt.h
+++ linux-2.6.23-rc8-rt1/include/linux/rcupreempt.h
@@ -42,9 +42,14 @@
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
 
-#define rcu_qsctr_inc(cpu)
-#define rcu_bh_qsctr_inc(cpu)
-#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
+#define rcu_qsctr_inc(cpu)	do { } while (0)
+#define rcu_bh_qsctr_inc(cpu)	do { } while (0)
+/*
+ * Someone might want to pass call_rcu_bh as a function pointer.
+ * So this needs to just be a rename and not a macro function.
+ *  (no parentheses)
+ */
+#define call_rcu_bh		 call_rcu
 
 extern void __rcu_read_lock(void);
 extern void __rcu_read_unlock(void);
