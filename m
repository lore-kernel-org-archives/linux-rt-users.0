Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53FDC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jan 2022 12:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiARMjE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:39:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiARMjE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jan 2022 07:39:04 -0500
Date:   Tue, 18 Jan 2022 13:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642509542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcmW5+qIK/XDpkV9bC6ZwMt7Be6EY+3hAZsM335cobg=;
        b=Nojwfv1LSJKoJi9+4WKqjvlhA0yCDkMbwpMJNbxdUhnzYFAAL1lNEVGvZKJhnwqZir55yx
        LMlO/55dUwu1UOTfWI2eQ2Fi/9DAW0oqqNjHXHyzuThzTlL5ke2kOsP/A/Hi0ufapdnYqv
        K85kv/MEinnp0ffoZdGCvy5xWU4t29l2q5XT4qTosaT54HiXi3FWq+1O0XIPw4WLR/ZUAv
        uK1ogM5+k3hW+xpBb673Q+C58y2C9CMp7ESN2M78OO3akOeDLqH4PyoXSR8gqivMCpUQ8B
        9Vq4bGOrp2MyT0nUqb7k1qsfiL25SzHRAvufNCZpPfYUQF6xSmlZBhj+zZZwfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642509542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcmW5+qIK/XDpkV9bC6ZwMt7Be6EY+3hAZsM335cobg=;
        b=Su1eObrR15JdiZEmRlb7Qw6u4mSyi+pooeXpWC4sWmbHRnS1f9b3ZaAjGUV07zXBPi/I1o
        +uN5Tb8VjYkfKaCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Caine Chen <caine.chen@dji.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [Question] How to avoid irq delay caused by write_lock_bh() and
 rt thread preempt
Message-ID: <Yea05fybfdgp6CXO@linutronix.de>
References: <912ca51a30eb4a1c96c95009debec3ea@dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <912ca51a30eb4a1c96c95009debec3ea@dji.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-17 12:59:42 [+0000], Caine Chen wrote:
> Hi guys:
Hi,

> We found that some IRQ threads will block in local_bh_disable( ) for
> long time in some situation and we hope to get your valuable suggestions.
> My kernel version is 5.4 and the irq-delay is caused by the use of
> write_lock_bh().
> It can be described in the following figure:
> (1) Thread_1 which is a SCHED_NORMAL thread runs on CPU1,
>     and it uses read_lock_bh() to protect some data.
> (2) Thread_2 which is a SCHED_RR thread runs on CPU1 and it preempts thre=
ad_1
>     after thread_1 invoked read_lock_bh(). Thread_2 may run 60 ms in my s=
ystem.
> (3) Thread_3 which is a SCHED_NORMAL thread runs on CPU0. This thread acq=
uires
>     writer's lock by invoking write_lock_bh(). This function will disable
>     button-half firstly by invoking local_bh_disable( ). But it will bloc=
k in
>     rt_write_lock() , because read lock is held by thread_1.
> (4) At this time, if irq thread without IRQF_NO_THREAD flag on CPU0 trys =
to
>     acquire bh_lock(it has been renamed as softirq_ctrl.lock now), irq
>     thread will block because this lock is held by thread_3.

so far, everything as expected.

> In this case, if SCHED_RR thread_2 preempts thread_1 and runs too much ti=
me, all
> irq threads on CPU0 will be blocked.

All force-threaded IRQs on CPU0 will be blocked. If you request your
interrupt handler with
	request_threaded_irq(num, NULL, handler, =E2=80=A6)

then bottom halves won't be disabled upon entry of the handler. This is
okay as long as the handler does not rely on disabled BH for some reason
(network processing function expect BH to be disabled, timer can't
fire, =E2=80=A6). You should also not raise softirqs in your handler for la=
ter
processing.

> It looks like a priority reverse problem of real-time thread preempt.
> How can I avoid this problem?  I have a few thoughts:
> (1) The key point, I think, is that write_lock_bh()/read_lock_bh() will d=
isable
>     buttom half which will disable some irq threads too. Could I use
>     write_lock_irq()/read_lock_irq() instead?

It will disable processing of bottom halves. If your lock requires
disabling processing of softirqs then you must not replace it with the
_irq suffix because it does not have this guaranties on PREEMPT_RT.
If you don't have such requirements and the resource, you protect, can
be protected by the lock then avoiding the bh suffix is an option (and
then using the irq suffix in thread context is needed).

> (2) If my irq handler wants to get better performance, I should request a
>     threaded handler for the IRQ as Sebastian suggested in LKML
>     <RE: irq thread latency caused by softirq_ctrl.lock contention>.
>     Is threaded handler designed for low irq delay?

All interrupt handler are force-threaded (the handler are threaded)
except for a few which are marked as non-threaded.
The forced-threaded must disable BH. If you explicitly request a
threaded handler then BH is not disabled and you must not rely on it.
Performance wise, there is no difference since the primary handler
simply wakes the thread which runs by default at the same SCHED_FIFO
priority. I probably suggested to avoid the softirq-lock contention if
the requirements are not needed.

> (3) Thread_2 takes too long time for running. So it is not suitable to se=
t this
>     thread with high rt-priority. Should I reduce this thread's priority =
to
>     solve this problem?

I would suggest to first decouple locked resources before playing with
priorities.

> Are there better ways to avoid this problem? We hope to get your valuable
> suggestions. Thanks!
>=20
> Best regards,
> Caine.chen

Sebastian
