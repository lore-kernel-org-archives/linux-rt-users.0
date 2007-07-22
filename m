From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt] drop spurious rcu unlock
Date: Sun, 22 Jul 2007 10:22:37 -0700
Message-ID: <1185124958.2573.13.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:50815 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbXGVRc5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 Jul 2007 13:32:57 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Strange rcu_read_unlock() which causes a imbalance, and boot hang.. I
didn't notice a reason for it, and removing it allows my system to make
progress.

This should go into the preempt-realtime-sched.patch

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.22.1/kernel/sched.c
===================================================================
--- linux-2.6.22.1.orig/kernel/sched.c	2007-07-22 16:47:37.000000000 +0000
+++ linux-2.6.22.1/kernel/sched.c	2007-07-22 16:16:48.000000000 +0000
@@ -4900,7 +4900,6 @@ asmlinkage long sys_sched_yield(void)
 	 * no need to preempt or enable interrupts:
 	 */
 	spin_unlock_no_resched(&rq->lock);
-	rcu_read_unlock();
 
 	__schedule();
 
