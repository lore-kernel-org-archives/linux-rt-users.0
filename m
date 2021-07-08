Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA34C07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC683616EA
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 13:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGHNcK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHNcJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 09:32:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF27C061574
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jul 2021 06:29:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625750966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNUFWO5XcVBaysFlMcBybWawF50c8pa5CzrPK5gQMdY=;
        b=mhP+RJbmR1c/SoXQHkvgAiutw015EHy/JjuVWHpQZ10i6mB6q8w5wr/+36+foF6NWfzKwm
        c2Dsc1nVSGab5AY764BGYSQLonCet1e8HIptIXJAvEfpz6j4qBt70L0uJHHEKKWRD0Q4Ji
        w4mT5JWc+d0ROgqpVpF3a5XHFuafmOAkulZgzs6LkkaPY8LrXWD2nWEnPchQ0jNPcxT/U+
        cEtZrOq22Rvi2VkV+xQIJvZ/FAK0PWMATWtyrlP8t8Dxup2B5BsAQDOffEf3QPSdGbuKge
        ZlYSJ6Ri4zr4j/WkUedcT2GyhiAWyR8JF4/xv07QMUGxCpxgp9Sf7gPhbYajOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625750966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNUFWO5XcVBaysFlMcBybWawF50c8pa5CzrPK5gQMdY=;
        b=3wpLoVnLQhhrnQS2twAvpQTWOE4t8X2Z13AY2TfidEAwexKd7K8fZZlE9LzGarShfs6Uao
        BjfxZARjDRyPhVAw==
To:     manty kuma <mantykuma@gmail.com>, linux-rt-users@vger.kernel.org
Subject: Re: Questions related to nano_sleep()/hrtimer
In-Reply-To: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
References: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
Date:   Thu, 08 Jul 2021 15:29:26 +0200
Message-ID: <87czrtorwp.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Manty,

On Tue, Jun 29 2021 at 13:54, manty kuma wrote:
> - What is the clock source for HRTimers and what is the frequency of
> this clock device?

Depends on your hardware.

> - with timer subsystem CONFIG_HZ can go to a max of 1000 meaning at
> the maximum only 1 ms latency can be reliably established. I
> understand that hrtimers are not using CONFIG_HZ but i am just curious
> as to what their clock source is and how 1 ns precision is achieved?

1ns is the theoretical precision and depending on the frequency of the
clock source (for reading the time) and the frequency of the clock event
device (for arming the next event) the resulting precision might be >
1ns, but all calculations are at the 1ns level.

> - I am using a RT kernel and I see that interrupt handlers are
> executed as threaded-irqs. Is it possible to configure the priority of
> the interrupt handler hrtimer_interrupt()? for a FF process, the

The timer interrupt which ends up in hrtimer_interrupt() is never
threaded.

> wakeup() is called from interrupt context(called by threaded irq)

I seriously doubt that. If at all then the wakeup() happens from
ksoftirqd().

> which is actually having lesser priority than my higher priority
> process. If possible I would like to change the priority of the
> threaded_irq  process that handles timer interrupts. I believe this
> way sleep() will not take longer than expected.(I am debugging issues
> where even my FF process with prio 110 sometimes fails to wake up back
> in time)

Prio 110? FIFO maximum priority for user space is 99.

If you talk about the kernel internal priority view, then 110 is _not_
FIFO.

Thanks,

        tglx
