From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Tue, 19 Jan 2016 03:29:57 +0100
Message-ID: <1453170597.3740.7.camel@gmail.com>
References: <1453108103.4123.4.camel@gmail.com>
	 <20160118201828.GE12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36657 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744AbcASCaF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 21:30:05 -0500
In-Reply-To: <20160118201828.GE12309@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-01-18 at 21:18 +0100, Sebastian Andrzej Siewior wrote:

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3542,6 +3542,15 @@ asmlinkage __visible void __sched notrac
> > 	if (likely(!preemptible()))
> > 		return;
> >=20
> > +#ifdef CONFIG_PREEMPT_LAZY
> > +	/*
> > +	 * Check for lazy preemption
> > +	 */
> > +	if (current_thread_info()->preempt_lazy_count &&
> > +	    !test_thread_flag(TIF_NEED_RESCHED))
> > +		return;
> > +#endif
> > +
>=20
> And this is a new piece. So you forbid that tasks leave the CPU if
> lazy_count > 0. Let me look closed why this is happening and if this =
is
> v4.1 =E2=80=A6 v4.4 or not.

We should probably just add the lazy bits to preemptible().

	-Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
