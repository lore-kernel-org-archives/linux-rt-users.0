From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Clarification about IRQ terminology
Date: Fri, 7 Oct 2016 12:32:55 +0200
Message-ID: <20161007103254.p7cmyl4rmzsljddd@linutronix.de>
References: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
 <20161006090702.no7idjvqxjl7yqjz@linutronix.de>
 <CAD=GYpZ4awOVNkt1H0kYv4AOsnBYpHXoDjdeCGdd51zY2UBTaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbcJGK4B (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Oct 2016 06:56:01 -0400
Content-Disposition: inline
In-Reply-To: <CAD=GYpZ4awOVNkt1H0kYv4AOsnBYpHXoDjdeCGdd51zY2UBTaA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-06 20:15:16 [-0700], Joel Fernandes wrote:
> Hi Sebastian,
Hi Joel,

> > > So basically my questions are:
> > > 1. Does hard in hard irq mean hardware interrupt or does it imply
> > > interrupt context?
> >
> > I would drop that hard part. It is an interrupt handler. It then can be
> > either threaded or not and it can be always threaded or sometimes.
> > hard is used to distinguish this kind of interrupts from the soft-irqs.
> >
> 
> But with threaded interrupts, you do have a handler that wakes up the
> thread. In this case there are 2 handlers, one handler executes in
> interrupt context and wakes up the thread, and the other runs in the
> thread. In this case, the term "interrupt handler" is confusing since
> it isn't clear which handler we're referring to. "hard interrupt
> handler" is also confusing - since if hard means "hardware", then
> technically the thread is also a "hard interrupt handler" since the
> interrupt line is masked (forced threaded interrupts are also one
> shot) till the thread clears the interrupt reason.

so what is your point? You still have a primary handler and a secondary
/ threaded handler.
In -RT (!RT, too but I am not 100% sure) we can have three. Now I leave
it to your research to figure out when this might happen :)

> Thanks,
> Joel

Sebastian
