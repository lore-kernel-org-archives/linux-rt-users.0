From: Andi Kleen <ak@suse.de>
Subject: [PATCH for 2.6.24rc2-rt1] Use real time pcp locking for page draining during cpu unplug
Date: Fri, 7 Dec 2007 12:42:27 +0100
Message-ID: <200712071242.27154.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:42073 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbXLGLmb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Dec 2007 06:42:31 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Use real time pcp locking for page draining during cpu unplug

Looks like a merging mistake that happened at some point. This
is the only place in the file that disables interrupts directly.

This fixes one case of CPU hotunplug failing on RT, but there 
are still more.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.24-rc2-rt1-hack/mm/page_alloc.c
===================================================================
--- linux-2.6.24-rc2-rt1-hack.orig/mm/page_alloc.c
+++ linux-2.6.24-rc2-rt1-hack/mm/page_alloc.c
@@ -4049,10 +4049,11 @@ static int page_alloc_cpu_notify(struct 
 	int cpu = (unsigned long)hcpu;
 
 	if (action == CPU_DEAD || action == CPU_DEAD_FROZEN) {
-		local_irq_disable();
+		unsigned long flags;
+		__lock_cpu_pcp(&flags, cpu);
 		__drain_pages(cpu);
 		vm_events_fold_cpu(cpu);
-		local_irq_enable();
+		unlock_cpu_pcp(flags, cpu);
 		refresh_cpu_vm_stats(cpu);
 	}
 	return NOTIFY_OK;
