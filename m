From: ankita@in.ibm.com (Ankita Garg)
Subject: [PATCH] Display information about # of -rt processes in sched_debug.c
Date: Mon, 23 Jul 2007 18:15:26 +0530
Message-ID: <20070723124526.GD8055@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:35926 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbXGWMpn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 08:45:43 -0400
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6ND8rcK222132
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 23:08:53 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6NCirZI038482
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 22:44:53 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6NCjRO0020590
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 22:45:28 +1000
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

This patch enables printing of rt_nr_running & rt_nr_uninterruptible
fields from sched_debug.c. Right now, this information in not being
captured in either sched_debug or schedstats. Infact, rt stats like
rto_pulled, rto_wakeup, etc are being captured at the runqueue level,
but not displayed under /proc/schedstats (a patch to this effect follows).


Signed-off-by: Ankita Garg <ankita@in.ibm.com>
--
 sched_debug.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.22.1/kernel/sched_debug.c
===================================================================
--- linux-2.6.22.1.orig/kernel/sched_debug.c	2007-07-23 16:28:50.000000000 +0530
+++ linux-2.6.22.1/kernel/sched_debug.c	2007-07-23 16:29:06.000000000 +0530
@@ -147,6 +147,10 @@
 	P(nr_switches);
 	P(nr_load_updates);
 	P(nr_uninterruptible);
+#ifdef CONFIG_PREEMPT_RT
+	P(rt_nr_running);
+	P(rt_nr_uninterruptible);
+#endif
 	SEQ_printf(m, "  .%-30s: %lu\n", "jiffies", jiffies);
 	P(next_balance);
 	P(curr->pid);


-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
