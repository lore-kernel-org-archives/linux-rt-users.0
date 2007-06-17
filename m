From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21.5-rt14 wont'compile here
Date: Sun, 17 Jun 2007 15:10:41 +0200
Message-ID: <20070617131041.GD18095@elte.hu>
References: <46752AF7.10508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:55300 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbXFQNRI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Jun 2007 09:17:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1Hzucs-0000T9-Ot
	from <mingo@elte.hu>
	for <linux-rt-users@vger.kernel.org>; Sun, 17 Jun 2007 15:17:06 +0200
Content-Disposition: inline
In-Reply-To: <46752AF7.10508@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Dragan Noveski <perodog@gmx.net> wrote:

> hi list,
> since i am trying to compile 2.6.24/25 kernel with the rt-patches, no 
> one version will compile here and i always get the same output.
> this is how it looks like while trying to compile 2.6.21.4-rt13, but it 
> looks the same for 2.6.21.5-rt14 :

>  LD      .tmp_vmlinux1
> kernel/built-in.o:(.data+0x5d8): undefined reference to 
> `preempt_mark_thresh'
> make: *** [.tmp_vmlinux1] Fehler 1

does the patch below fix this?

	Ingo

Index: linux-rt.q/kernel/sysctl.c
===================================================================
--- linux-rt.q.orig/kernel/sysctl.c
+++ linux-rt.q/kernel/sysctl.c
@@ -382,6 +382,8 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
 	},
+#endif
+#ifdef CONFIG_EVENT_TRACE
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "preempt_mark_thresh",
@@ -390,8 +392,6 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_doulongvec_minmax,
 	},
-#endif
-#ifdef CONFIG_EVENT_TRACE
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "trace_enabled",
