From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: Clarification about IRQ terminology
Date: Thu, 6 Oct 2016 20:15:16 -0700
Message-ID: <CAD=GYpZ4awOVNkt1H0kYv4AOsnBYpHXoDjdeCGdd51zY2UBTaA@mail.gmail.com>
References: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
 <20161006090702.no7idjvqxjl7yqjz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33904 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935898AbcJGDPU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2016 23:15:20 -0400
Received: by mail-lf0-f54.google.com with SMTP id b81so31175387lfe.1
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Oct 2016 20:15:18 -0700 (PDT)
In-Reply-To: <20161006090702.no7idjvqxjl7yqjz@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

Thanks a lot for your quick reply. I agree with all your points, I had
a comment about one of them:

> > So basically my questions are:
> > 1. Does hard in hard irq mean hardware interrupt or does it imply
> > interrupt context?
>
> I would drop that hard part. It is an interrupt handler. It then can be
> either threaded or not and it can be always threaded or sometimes.
> hard is used to distinguish this kind of interrupts from the soft-irqs.
>

But with threaded interrupts, you do have a handler that wakes up the
thread. In this case there are 2 handlers, one handler executes in
interrupt context and wakes up the thread, and the other runs in the
thread. In this case, the term "interrupt handler" is confusing since
it isn't clear which handler we're referring to. "hard interrupt
handler" is also confusing - since if hard means "hardware", then
technically the thread is also a "hard interrupt handler" since the
interrupt line is masked (forced threaded interrupts are also one
shot) till the thread clears the interrupt reason.

Thanks,
Joel
