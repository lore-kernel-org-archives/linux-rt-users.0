From: Ankita Garg <ankita@in.ibm.com>
Subject: [RT] [PATCH 3/3] Update sched_debug with new RT related stats
Date: Sun, 23 Mar 2008 20:39:39 +0530
Message-ID: <20080323150939.GE15554@in.ibm.com>
References: <20080323145029.GB15554@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	Steven Rostedt <rostedt@goodm
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:56185 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbYCWPJl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Mar 2008 11:09:41 -0400
Content-Disposition: inline
In-Reply-To: <20080323145029.GB15554@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

o Update sched_debug to print values of the recently added fields to
rt_rq.


Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

Index: linux-2.6.24.3/kernel/sched_debug.c
===================================================================
--- linux-2.6.24.3.orig/kernel/sched_debug.c	2008-03-23 19:09:35.000000000 +0530
+++ linux-2.6.24.3/kernel/sched_debug.c	2008-03-23 19:47:52.000000000 +0530
@@ -188,8 +188,12 @@
 	P(cpu_load[4]);
 #ifdef CONFIG_PREEMPT_RT
 	/* Print rt related rq stats */
+	SEQ_printf(m, "\nrt_rq\n");
 	P(rt.nr_running);
 	P(rt.nr_uninterruptible);
+	P(rt.nr_migratory);
+	P(rt.highest_prio);
+	P(rt.overloaded);
 # ifdef CONFIG_SCHEDSTATS
 	P(rto_schedule);
 	P(rto_schedule_tail);

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
