From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Clarification about IRQ terminology
Date: Thu, 6 Oct 2016 11:07:02 +0200
Message-ID: <20161006090702.no7idjvqxjl7yqjz@linutronix.de>
References: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40873 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967234AbcJFJHF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2016 05:07:05 -0400
Content-Disposition: inline
In-Reply-To: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-05 23:07:55 [-0700], Joel Fernandes wrote:
> Just to clarify and use the right terminology, I'd like to understand
> whether the "hard" in hard irq implies interrupt context?
it usually does.

> To further confuse the matter, with CONFIG_PREEMPT_RT_FULL, all IRQs
> previously executing in interrupt context are now threaded. Then in

not all but most. And also in !RT with the threadirqs command line
argument.

> this scenario, is it Ok to still call these irq handlers as hard irq
> handlers or should they now be strictly called threaded interrupt
> handlers now that the same handlers are forced to execute in a thread?

If they are threaded, they are threaded. A threaded handler can be
interrupted by an interrupt because it is invoked with interrupts
enabled. A non-threaded handler can not be interrupted.

> If the "hard" in hard irq means hardware interrupt, then it would make
> sense to still call them hardirq handlers even though they're now
> executing in process context?

you call them interrupt handler. You can request *explicit* a threaded
handler if your code needs to sleep (in order to reach hardware behind a
slow bus like i2c).

> So basically my questions are:
> 1. Does hard in hard irq mean hardware interrupt or does it imply
> interrupt context?

I would drop that hard part. It is an interrupt handler. It then can be
either threaded or not and it can be always threaded or sometimes.
hard is used to distinguish this kind of interrupts from the soft-irqs.

> 2. Can the terms "hard irq handler" still be used with CONFIG_PREEMPT_RT_FULL?

not all interrupts are threaded. perf and timer are just two examples of
interrupts which are never threaded. So some interrupts are handled with
interrupts disabled and some with interrupts enabled.

> Thanks a lot,
> 
> Joel

Sebastian
