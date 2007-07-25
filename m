From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Wed, 25 Jul 2007 16:59:24 +0530
Message-ID: <20070725112924.GC7745@in.ibm.com>
References: <20070723125925.GE8055@in.ibm.com> <20070725080504.GD5125@elte.hu>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:56793 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759409AbXGYLaA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 07:30:00 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6PBUdj31310792
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 21:30:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6PBWxNv100726
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 21:32:59 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6PBTPk2002606
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 21:29:26 +1000
Content-Disposition: inline
In-Reply-To: <20070725080504.GD5125@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jul 25, 2007 at 10:05:04AM +0200, Ingo Molnar wrote:
> 
> * Ankita Garg <ankita@in.ibm.com> wrote:
> 
> > Hi,
> > 
> > This patch adds support to display captured -rt stats under 
> > /proc/schedstat.
> 
> hm, could you add it to /proc/sched_debug instead? That's where all the 
> runqueue values are showing up normally. I'm also a bit wary about 
> introducing a new schedstats version for -rt.

So, I have merged my previous patch (to display rt_nr_running info in
sched_debug.c) with this one.


Signed-off-by: Ankita Garg <ankita@in.ibm.com>
--
 sched_debug.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6.22.1/kernel/sched_debug.c
===================================================================
--- linux-2.6.22.1.orig/kernel/sched_debug.c	2007-07-25 14:26:53.000000000 +0530
+++ linux-2.6.22.1/kernel/sched_debug.c	2007-07-25 14:58:07.000000000 +0530
@@ -161,6 +161,15 @@
 	P(cpu_load[2]);
 	P(cpu_load[3]);
 	P(cpu_load[4]);
+#ifdef CONFIG_PREEMPT_RT
+	/* Print rt related rq stats */
+	P(rt_nr_running);
+	P(rt_nr_uninterruptible);
+	P(rto_schedule);
+	P(rto_wakeup);
+	P(rto_pulled);
+#endif
+
 #undef P
 
 	print_cfs_stats(m, cpu, now);


-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
