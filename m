From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 23 Apr 2015 09:19:26 +0200
Message-ID: <1429773566.3419.42.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>
	 <55389632.50308@siemens.com> <1429772482.3419.40.camel@gmail.com>
	 <55389B67.3000703@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37237 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbDWHT3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 03:19:29 -0400
In-Reply-To: <55389B67.3000703@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-04-23 at 09:12 +0200, Jan Kiszka wrote:
> On 2015-04-23 09:01, Mike Galbraith wrote:
> > On Thu, 2015-04-23 at 08:50 +0200, Jan Kiszka wrote:
> > > On 2015-04-23 08:11, Mike Galbraith wrote:
> > > > @@ -103,6 +98,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
> > > >  /* Enqueue the irq work @work on the current CPU */
> > > >  bool irq_work_queue(struct irq_work *work)
> > > >  {
> > > > +       bool realtime =3D IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> > > > +       bool raise =3D false;
> > > > +
> > > >         /* Only queue if not already pending */
> > > >         if (!irq_work_claim(work))
> > > >                 return false;
> > > > @@ -110,25 +108,22 @@ bool irq_work_queue(struct irq_work *wor
> > > >         /* Queue the entry and raise the IPI if needed. */
> > > >         preempt_disable();
> > > > =20
> > > > -#ifdef CONFIG_PREEMPT_RT_FULL
> > > > -       if (work->flags & IRQ_WORK_HARD_IRQ) {
> > > > +       if (realtime && (work->flags & IRQ_WORK_HARD_IRQ)) {
> > > >                 if (llist_add(&work->llnode,=20
> > > > this_cpu_ptr(&hirq_work_list)))
> > >=20
> > > This boils down to
> > >=20
> > > #ifdef CONFIG_X
> > > some_type x;
> > > #endif
> > > ...
> > >=20
> > > if (IS_ENABLED(CONFIG_X) && ...)
> > >       use(x);
> > >=20
> > > And here we even have an indirection for IS_ENABLED via that=20
> > > local=20
> > > bool
> > > variable. Is that pattern OK for Linux? Does it compile in all=20
> > > supported
> > > optimization levels of all supported compilers?
> >=20
> > I hope it all goes away, that being what IS_ENABLED() is there for.
>=20
> Hope is good - but not enough here: it breaks the build under
> !CONFIG_X, even the case without the bool var.
>=20
>   CC      kernel/irq_work.o
> In file included from ../include/asm-generic/percpu.h:6:0,
>                  from ../arch/x86/include/asm/percpu.h:522,
>                  from ../arch/x86/include/asm/current.h:5,
>                  from ../arch/x86/include/asm/processor.h:15,
>                  from ../arch/x86/include/asm/irq_work.h:4,
>                  from ../include/linux/irq_work.h:47,
>                  from ../kernel/irq_work.c:11:
> ../kernel/irq_work.c: In function =E2=80=98irq_work_queue_on=E2=80=99=
:
> ../kernel/irq_work.c:85:17: error: =E2=80=98hirq_work_list=E2=80=99 u=
ndeclared=20
> (first use in this function)
>         &per_cpu(hirq_work_list, cpu));

Aw poo, so that's just what I _thought_ it was for.

        -Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
