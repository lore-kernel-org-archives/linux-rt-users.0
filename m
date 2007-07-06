From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] don't BUG_ON in exit for in_interrupt
Date: Fri, 06 Jul 2007 09:19:19 -0400
Message-ID: <1183727959.17319.126.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:60970 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXGFNT7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2007 09:19:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

For some reason, in the RT kernel, we have in exit.c a
BUG_ON(in_interrupt()) just before a check of in_interrupt() then panic.
With the panic, we get a nice output of what happened (considering that
the panic gives us a backtrace).

But a BUG_ON will cause a fault, and then try to bug again. This causes
a recursive fault which eventually eats up the stack.  Twice have we
lost information on a crash because of this recursive faulting.

This patch undoes the adding the BUG_ON in exit.c.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21.5-rt17/kernel/exit.c
===================================================================
--- linux-2.6.21.5-rt17.orig/kernel/exit.c
+++ linux-2.6.21.5-rt17/kernel/exit.c
@@ -863,7 +863,6 @@ fastcall NORET_TYPE void do_exit(long co
 
 	WARN_ON(atomic_read(&tsk->fs_excl));
 
-	BUG_ON(in_interrupt());
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
