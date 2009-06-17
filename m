From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NOHZ: local_softirq_pending
Date: Thu, 18 Jun 2009 01:46:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906180133220.2800@localhost.localdomain>
References: <4A35171C.9090800@albentia.com>  <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>  <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>  <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com>
 <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com> <4A37E6D1.5010207@albentia.com> <alpine.LFD.2.00.0906180001210.2800@localhost.localdomain> <4A396FB8.3020807@albentia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-15?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>,
	"'Rodrigo Partearroyo'" <rpartearroyo@albentia.com>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:52691 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbZFQXqx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 19:46:53 -0400
In-Reply-To: <4A396FB8.3020807@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 18 Jun 2009, Iratxo Pichel Ortiz wrote:
> I have not tried this with the function tracer enabled, I will build the
> kernel again and enable this tracer. Which function should I trace? Any hint
> about this? I have a couple of systems running so I can make any trace you
> would like. I will try to figure out something and give feedback later.

The point is not which function to trace. I don't know. The point is
whether the problem is reproducible with function tracer and nohz
enabled.

Please apply following patch and enable NOHZ and function tracer in
.config. After bootup enable the function tracer in debugfs and start
your load test. 

Once the NOHZ.... message appears the function tracer is frozen and
you can read the trace from mountpoint_of_debugfs/tracing/trace.

Please bzip2 it and upload it somewhere as it's probably too large for
the mailinglist.

Thanks,

	tglx
-------------->
Subject: debug-nohz-issue.patch
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 18 Jun 2009 01:41:01 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-tip/kernel/time/tick-sched.c
===================================================================
--- linux-2.6-tip.orig/kernel/time/tick-sched.c
+++ linux-2.6-tip/kernel/time/tick-sched.c
@@ -250,6 +250,8 @@ void tick_nohz_stop_sched_tick(int inidl
 	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
 		static int ratelimit;
 
+		tracing_off();
+
 		if (ratelimit < 10) {
 			printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 			       local_softirq_pending());
