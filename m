From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Tue, 19 Jan 2016 06:14:43 +0100
Message-ID: <1453180483.3516.1.camel@gmail.com>
References: <1453108103.4123.4.camel@gmail.com>
	 <20160118201828.GE12309@linutronix.de> <1453178516.4217.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33635 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcASFOq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jan 2016 00:14:46 -0500
In-Reply-To: <1453178516.4217.2.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2016-01-19 at 05:41 +0100, Mike Galbraith wrote:
> On Mon, 2016-01-18 at 21:18 +0100, Sebastian Andrzej Siewior wrote:
>=20
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3542,6 +3542,15 @@ asmlinkage __visible void __sched notrac
> > > 	if (likely(!preemptible()))
> > > 		return;
> > >=20
> > > +#ifdef CONFIG_PREEMPT_LAZY
> > > +	/*
> > > +	 * Check for lazy preemption
> > > +	 */
> > > +	if (current_thread_info()->preempt_lazy_count &&
> > > +	    !test_thread_flag(TIF_NEED_RESCHED))
> > > +		return;
> > > +#endif
> > > +
> >=20
> > And this is a new piece. So you forbid that tasks leave the CPU if
> > lazy_count > 0. Let me look closed why this is happening and if
> > this is
> > v4.1 =E2=80=A6 v4.4 or not.
>=20
> That check wants a !rt_task(current) qualifier anyway.

(bah, -ESWILLMORECOFFEE)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
