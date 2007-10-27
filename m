From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt4
Date: Sat, 27 Oct 2007 11:50:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710271148040.28617@gandalf.stny.rr.com>
References: <1193454991.5623.27.camel@localhost.localdomain> <47234994.5040503@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	trem <tremyfr@yahoo.fr>
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41238 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbXJ0PuX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 11:50:23 -0400
In-Reply-To: <47234994.5040503@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> In file included from kernel/sched.c:863:
> kernel/sched_rt.c: In function 'rt_overloaded':
> kernel/sched_rt.c:21: error: 'struct rq' has no member named 'cpu'
> kernel/sched_rt.c: In function 'rt_overload':
> kernel/sched_rt.c:25: error: 'struct rq' has no member named 'cpu'
> kernel/sched_rt.c: In function 'rt_set_overload':
> kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
> kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
> kernel/sched_rt.c: In function 'rt_clear_overload':
> kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
> kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
> make[1]: *** [kernel/sched.o] Fehler 1
> make: *** [kernel] Fehler 2
> nowhiskey@murija2:/usr/src/linux-2.6.23.1$
>
>

Here's a proper fix.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.23.1-rt4/kernel/sched_rt.c
===================================================================
--- linux-2.6.23.1-rt4.orig/kernel/sched_rt.c	2007-10-27 11:45:32.000000000 -0400
+++ linux-2.6.23.1-rt4/kernel/sched_rt.c	2007-10-27 11:47:22.000000000 -0400
@@ -3,6 +3,7 @@
  * policies)
  */

+#ifdef CONFIG_SMP
 /* Is this defined somewhere? */
 #define CACHE_ALIGN_SPACE(sz)  (L1_CACHE_ALIGN(sz) - (sz))

@@ -32,6 +33,7 @@ static inline void rt_clear_overload(str
 {
 	cpu_clear(rq->cpu, *rt_overload_mask(rq->cpu));
 }
+#endif /* CONFIG_SMP */

 /*
  * Update the current task's runtime statistics. Skip current tasks that
