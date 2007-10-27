From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt4
Date: Sat, 27 Oct 2007 11:40:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710271139500.28617@gandalf.stny.rr.com>
References: <1193454991.5623.27.camel@localhost.localdomain> <47234994.5040503@gmx.net>
 <ffvku3$6s4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: trem <tremyfr@yahoo.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43158 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbXJ0Pkc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 11:40:32 -0400
In-Reply-To: <ffvku3$6s4$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 27 Oct 2007, trem wrote:
> Dragan Noveski wrote:
> >   LD      arch/i386/crypto/built-in.o
> >   AS [M]  arch/i386/crypto/aes-i586-asm.o
> >   CC [M]  arch/i386/crypto/aes.o
> >   LD [M]  arch/i386/crypto/aes-i586.o
> >   CC      kernel/sched.o
> > In file included from kernel/sched.c:863:
> > kernel/sched_rt.c: In function 'rt_overloaded':
> > kernel/sched_rt.c:21: error: 'struct rq' has no member named 'cpu'
> > kernel/sched_rt.c: In function 'rt_overload':
> > kernel/sched_rt.c:25: error: 'struct rq' has no member named 'cpu'
> > kernel/sched_rt.c: In function 'rt_set_overload':
> > kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
> > kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
> > kernel/sched_rt.c: In function 'rt_clear_overload':
> > kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
> > kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
> > make[1]: *** [kernel/sched.o] Fehler 1
> > make: *** [kernel] Fehler 2
> > nowhiskey@murija2:/usr/src/linux-2.6.23.1$
> >
> >
> > ............
> >
> > thanks and cheers,
> > doc
>
> HI
>
> I've got the same error with one on my config. I've investigated a bit,
>  and I've seen that cpu is only defined in struct rq on SMP kernel. So I
> think that you have a .config without SMP. To fix this problem, I
> propose this patch :
>
>
> Index: linux-2.6.23/kernel/sched_rt.c
> ===================================================================
> --- linux-2.6.23/kernel/sched_rt.c
> +++ linux-2.6.23/kernel/sched_rt.c      2007-10-27 11:04:08.000000000 -0400
> @@ -18,19 +18,35 @@
>
>  static inline int rt_overloaded(struct rq *rq)
>  {
> +#ifdef CONFIG_SMP
>         return !cpus_empty(*rt_overload_mask(rq->cpu));
> +#else
> +       return !cpus_empty(*rt_overload_mask(0));
> +#endif
>  }
>  static inline cpumask_t *rt_overload(struct rq *rq)
>  {
> +#ifdef CONFIG_SMP
>         return rt_overload_mask(rq->cpu);
> +#else
> +       return rt_overload_mask(0);
> +#endif
>  }
>  static inline void rt_set_overload(struct rq *rq)
>  {
> +#ifdef CONFIG_SMP
>         cpu_set(rq->cpu, *rt_overload_mask(rq->cpu));
> +#else
> +       cpu_set(0, *rt_overload_mask(0));
> +#endif
>  }
>  static inline void rt_clear_overload(struct rq *rq)
>  {
> +#ifdef CONFIG_SMP
>         cpu_clear(rq->cpu, *rt_overload_mask(rq->cpu));
> +#else
> +       cpu_clear(0, *rt_overload_mask(0));
> +#endif
>  }
>
>  /*

Thanks trem for pointing out the problem. I'll write up a little cleaner
patch.

-- Steve
