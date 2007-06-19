From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] disable preemption on running show all regs.
Date: Tue, 19 Jun 2007 16:17:56 -0400
Message-ID: <1182284276.15228.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:46351 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062AbXFSUSd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 16:18:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The show all regs sysrq uses the nmi function to do it. But this
function expects preemption to be off, or funny things happen.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21-rt9/drivers/char/sysrq.c
===================================================================
--- linux-2.6.21-rt9.orig/drivers/char/sysrq.c
+++ linux-2.6.21-rt9/drivers/char/sysrq.c
@@ -213,7 +213,9 @@ static struct sysrq_key_op sysrq_showreg
 
 static void sysrq_handle_showallregs(int key, struct tty_struct *tty)
 {
+        preempt_disable();
 	nmi_show_all_regs();
+        preempt_enable();
 }
 
 static struct sysrq_key_op sysrq_showallregs_op = {
