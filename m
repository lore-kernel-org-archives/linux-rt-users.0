From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Mon, 23 Jul 2007 20:28:43 +0530
Message-ID: <20070723145843.GA7478@in.ibm.com>
References: <20070723125925.GE8055@in.ibm.com> <200707231424.35306.joachim.deguara@amd.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Joachim Deguara <joachim.deguara@amd.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:50180 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbXGWO7P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 10:59:15 -0400
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6NF02k34481170
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 01:00:03 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6NEwFsq128660
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 00:58:15 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6NEwo76022188
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 00:58:50 +1000
Content-Disposition: inline
In-Reply-To: <200707231424.35306.joachim.deguara@amd.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 23, 2007 at 02:24:34PM +0200, Joachim Deguara wrote:
> On Monday 23 July 2007 14:59:25 Ankita Garg wrote:
> > Hi,
> >
> > This patch adds support to display captured -rt stats under
> > /proc/schedstat.
> 
> You need to +1 SCHEDSTAT_VERSION if you are going to do this.  I would also 
> suggest the number of fields printed out it in schedstats is invariable of 
> CONFIG_PREEMPT_RT rather whether the fields have meaning data or zeros 
> depends on the define.  Finally an addition to Documentation/sched-stats.txt 
> is always desirable with such a change.

Yep, that sounds fine to me, because the fields are being defined
irrespective of CONFIG_PREEMPT_RT. Besides, it looks much cleaner!
Have updated the SCHEDSTAT_VERSION to 15.

As for documentation update, Documentation/sched-stats.txt seems to be a little old.
Under CPU statistics, it indicates 28 fields being printed, but version 14 
seems to be printing only 12 (iiuc). So, requires some update. Will send it along 
in the next patch.


Signed-off-by: Ankita Garg <ankita@in.ibm.com>
--
 sched_stats.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.22.1/kernel/sched_stats.h
===================================================================
--- linux-2.6.22.1.orig/kernel/sched_stats.h	2007-07-23 18:15:57.000000000 +0530
+++ linux-2.6.22.1/kernel/sched_stats.h	2007-07-23 20:19:21.000000000 +0530
@@ -4,7 +4,7 @@
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 14
+#define SCHEDSTAT_VERSION 15
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -21,12 +21,13 @@
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %llu %lu",
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %lu %lu %lu %llu %lu",
 		    cpu, rq->yld_both_empty,
 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
 		    rq->ttwu_cnt, rq->ttwu_local,
 		    rq->rq_sched_info.cpu_time,
+		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
 
 		seq_printf(seq, "\n");

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
