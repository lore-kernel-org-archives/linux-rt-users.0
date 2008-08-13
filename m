From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] rt: shorten posix_cpu_timers/<CPU> kernel thread names
Date: Wed, 13 Aug 2008 15:42:11 -0300
Message-ID: <20080813184211.GD2240@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	Luiz =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lgoncalv@redhat.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYHMSoZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Aug 2008 14:44:25 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Shorten the softirq kernel thread names because they always overflow the
limited comm length, appearing as "posix_cpu_timer" CPU# times.

Done on 2.6.24.7, but probably applicable to later kernels.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

--- linux-2.6.24.7.orig/kernel/posix-cpu-timers.c	2008-08-12 20:40:58.000000000 -0300
+++ linux-2.6.24.7/kernel/posix-cpu-timers.c	2008-08-12 20:52:27.000000000 -0300
@@ -1473,7 +1473,7 @@ static int posix_cpu_thread_call(struct 
 	switch (action) {
 	case CPU_UP_PREPARE:
 		p = kthread_create(posix_cpu_timers_thread, hcpu,
-					"posix_cpu_timers/%d",cpu);
+					"posixcputmr/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
 		p->flags |= PF_NOFREEZE;
