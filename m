From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: Clarification about IRQ terminology
Date: Fri, 7 Oct 2016 08:57:36 -0700
Message-ID: <CAD=GYpabx96Eodx13d6YDPRHOxxCCyE7ZSyOp15-WX97prN4fQ@mail.gmail.com>
References: <CAD=GYpbv_okzpb22bHgmQZDhJzkyy+yJk_ZMaOc25e9Gks0A=w@mail.gmail.com>
 <20161006090702.no7idjvqxjl7yqjz@linutronix.de> <CAD=GYpZ4awOVNkt1H0kYv4AOsnBYpHXoDjdeCGdd51zY2UBTaA@mail.gmail.com>
 <20161007103254.p7cmyl4rmzsljddd@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36520 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933370AbcJGP5i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Oct 2016 11:57:38 -0400
Received: by mail-lf0-f44.google.com with SMTP id b75so44555890lfg.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Oct 2016 08:57:37 -0700 (PDT)
In-Reply-To: <20161007103254.p7cmyl4rmzsljddd@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 7, 2016 at 3:32 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-10-06 20:15:16 [-0700], Joel Fernandes wrote:
>> Hi Sebastian,
> Hi Joel,
>
>> > > So basically my questions are:
>> > > 1. Does hard in hard irq mean hardware interrupt or does it imply
>> > > interrupt context?
>> >
>> > I would drop that hard part. It is an interrupt handler. It then can be
>> > either threaded or not and it can be always threaded or sometimes.
>> > hard is used to distinguish this kind of interrupts from the soft-irqs.
>> >
>>
>> But with threaded interrupts, you do have a handler that wakes up the
>> thread. In this case there are 2 handlers, one handler executes in
>> interrupt context and wakes up the thread, and the other runs in the
>> thread. In this case, the term "interrupt handler" is confusing since
>> it isn't clear which handler we're referring to. "hard interrupt
>> handler" is also confusing - since if hard means "hardware", then
>> technically the thread is also a "hard interrupt handler" since the
>> interrupt line is masked (forced threaded interrupts are also one
>> shot) till the thread clears the interrupt reason.
>
> so what is your point? You still have a primary handler and a secondary
> / threaded handler.

My point is its hard (no pun intended) to find a set of terms to
describe a handler to clearly define its context (interrupt vs process
context). I see "hard IRQ handler" mentioned in different
documentation referring to interrupt context but as we discussed this
isn't the case.

Thanks for referring to primary and secondary, I will use these to
differentiate between the 2 handlers. :)

> In -RT (!RT, too but I am not 100% sure) we can have three. Now I leave
> it to your research to figure out when this might happen :)
>

I guess primary and secondary also don't accurately describe context
anymore because of force threading of primary handlers [1] (which I
think is what you meant about having 3 handlers? :)) so I will just be
explicit about the context if I need to mention it in conversation. So
like "threaded primary handler".

Thanks,
Joel

[1] https://lkml.org/lkml/2015/9/21/124
