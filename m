From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 1/9] Coccinelle: locks: identify callers of
 spin_lock{,_irq,_irqsave}() in irqchip implementations
Date: Wed, 22 Mar 2017 22:45:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703222245050.2132@hadrien>
References: <cover.1490135047.git.julia@ni.com> <48a11ad61edb4bec130f2ae0d46fc4e7d4855044.1490135047.git.julia@ni.com> <alpine.DEB.2.20.1703221053550.3413@hadrien> <20170322161856.GJ10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>, cocci@systeme.lip6.fr
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16155 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbdCVVpu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 17:45:50 -0400
In-Reply-To: <20170322161856.GJ10423@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 22 Mar 2017, Julia Cartwright wrote:

> On Wed, Mar 22, 2017 at 10:54:15AM +0100, Julia Lawall wrote:
> > On Tue, 21 Mar 2017, Julia Cartwright wrote:
> > > On PREEMPT_RT, the spinlock_t type becomes an object which sleeps under
> > > contention.  The codepaths used to support scheduling (irq dispatching, arch
> > > code, the scheduler, timers) therefore must make use of the
> > > raw_spin_lock{,_irq,_irqsave}() variations which preserve the non-sleeping
> > > spinlock behavior.
> > >
> > > Because the irq_chip callbacks are invoked in the process of interrupt
> > > dispatch, they cannot therefore make use of spin_lock_t type.  Instead, the
> > > usage of raw_spinlock_t is appropriate.
> > >
> > > Provide a spatch to identify (and attempt to patch) such problematic irqchip
> > > implementations.
> > >
> > > Note to those generating patches using this spatch; in order to maintain
> > > correct semantics w/ PREEMPT_RT, it is necessary to audit the
> > > raw_spinlock_t-protected codepaths to ensure their execution is bounded and
> > > minimal.  This is a manual audit process.
> > >
> > > See commit 47b03ca903fb0 ("pinctrl: qcom: Use raw spinlock variants") as an
> > > example of _one_ such instance, which fixed a real bug seen in the field.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Julia Cartwright <julia@ni.com>
> >
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>
> Thanks, Julia.
>
> How do these semantic patches normally land?  It looks like they quite a
> few have gone through the kbuild tree, is this the norm?

Michal Marek takes care of them.

julia

>
> Thanks,
>    Other Julia
>
