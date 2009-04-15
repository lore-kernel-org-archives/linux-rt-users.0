From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] preempt-rt: implement rt_downgrade_write
Date: Wed, 15 Apr 2009 11:44:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0904151142420.31828@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:47842 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZDOPoL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Apr 2009 11:44:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


From: Steven Rostedt <srostedt@redhat.com>
Subject: preempt-rt: implement rt_downgrade_write

The current code of rt_downgrade_write simply does a BUG(). There
are places in the kernel that uses this code, and will crash a runnning
preempt-rt kernel.

The rt_downgrade_write converts a rwsem held for write into a rwsem
held for read without ever releasing the semaphore. In -rt, the rwsems
are simply a mutex. There is nothing different between a rwsem held
for write, and one held for read. The difference is that one held for
read can nest.

This patch changes the BUG_ON() to simply BUG if the caller is not
the owner of the semaphore.

This patch comes from my rt-git repo, and has been tested there.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-rt/kernel/rt.c
===================================================================
--- linux-2.6-rt.orig/kernel/rt.c	2009-04-15 10:02:37.000000000 -0400
+++ linux-2.6-rt/kernel/rt.c	2009-04-15 11:28:13.000000000 -0400
@@ -316,7 +316,7 @@ EXPORT_SYMBOL(rt_up_read);
  */
 void  rt_downgrade_write(struct rw_semaphore *rwsem)
 {
-	BUG();
+	BUG_ON(rt_mutex_real_owner(&rwsem->lock) != current);
 }
 EXPORT_SYMBOL(rt_downgrade_write);
 

