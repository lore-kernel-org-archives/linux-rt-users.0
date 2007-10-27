From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt4
Date: Sat, 27 Oct 2007 18:18:18 +0200
Message-ID: <472364CA.5020604@gmx.net>
References: <1193454991.5623.27.camel@localhost.localdomain> <47234994.5040503@gmx.net> <Pine.LNX.4.58.0710271148040.28617@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753720AbXJ0QUo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 12:20:44 -0400
In-Reply-To: <Pine.LNX.4.58.0710271148040.28617@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> Here's a proper fix.
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>
> Index: linux-2.6.23.1-rt4/kernel/sched_rt.c
> ===================================================================
> --- linux-2.6.23.1-rt4.orig/kernel/sched_rt.c	2007-10-27 11:45:32.000000000 -0400
> +++ linux-2.6.23.1-rt4/kernel/sched_rt.c	2007-10-27 11:47:22.000000000 -0400
> @@ -3,6 +3,7 @@
>   * policies)
>   */
>
> +#ifdef CONFIG_SMP
>  /* Is this defined somewhere? */
>  #define CACHE_ALIGN_SPACE(sz)  (L1_CACHE_ALIGN(sz) - (sz))
>
> @@ -32,6 +33,7 @@ static inline void rt_clear_overload(str
>  {
>  	cpu_clear(rq->cpu, *rt_overload_mask(rq->cpu));
>  }
> +#endif /* CONFIG_SMP */
>
>  /*
>   * Update the current task's runtime statistics. Skip current tasks that
>
>   

hallo, i am writing from my 'just-compiled-2.6.23.1-rt4-kernel' now, 
what means that steves patch really did it!

i like to say thanks one more time for this great 'realtime' support.

cheers,
doc
