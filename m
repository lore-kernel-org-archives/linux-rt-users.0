From: ankita@in.ibm.com (Ankita Garg)
Subject: [PATCH] Display -rt related stats in /proc/schedstat
Date: Mon, 23 Jul 2007 18:29:25 +0530
Message-ID: <20070723125925.GE8055@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:64703 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbXGWM7a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 08:59:30 -0400
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6ND0ct14173918
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 23:00:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6NCwqXF101312
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 22:58:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6NCxQfC031367
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Jul 2007 22:59:27 +1000
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

This patch adds support to display captured -rt stats under /proc/schedstat.


Signed-off-by: Ankita Garg <ankita@in.ibm.com>
--
 sched_stats.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.22.1/kernel/sched_stats.h
===================================================================
--- linux-2.6.22.1.orig/kernel/sched_stats.h	2007-07-23 18:15:57.000000000 +0530
+++ linux-2.6.22.1/kernel/sched_stats.h	2007-07-23 18:24:03.000000000 +0530
@@ -21,12 +21,15 @@
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %llu %lu",
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %lu %lu %lu %llu %lu",
 		    cpu, rq->yld_both_empty,
 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
 		    rq->ttwu_cnt, rq->ttwu_local,
 		    rq->rq_sched_info.cpu_time,
+#ifdef CONFIG_PREEMPT_RT
+		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled,
+#endif
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
 
 		seq_printf(seq, "\n");


-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
