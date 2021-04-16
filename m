Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4DCC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4908D6113B
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Apr 2021 09:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbhDPJJh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhDPJJg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Apr 2021 05:09:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B467C061574;
        Fri, 16 Apr 2021 02:09:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618564150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXhVcknuH7vRZ8Cv/x2IzlKP8UQuZLhEE+jqIDvzBq8=;
        b=GBzS2yJfcnoBznVCvFFDpzAXFOpnQVzFnixFQFU0/rG+8GlCWCmN+AL48sDYbWI99x6zmQ
        YAqnLUDtMWQCxqMwJ+l13PG5SHYuSgm1Loty033hg8qQwEyZiZM2eeQeUaTr9/RR4jcD2g
        VeOd8I6ohaqaOT1gtteUjL71LBYbnEEfFt7h4FDdkdxm0IEkNijgI9SOPOxAhQZ7knr3Q2
        CJdqIJrLXyVvc7cLXrlhH6H+toi44LA46bt2+MEM9cfSii9m8kj29KaYzPgmCbVkvG+zYZ
        2u0dXabluk1ca3f2DdFQrJvtAGgIwwMilGSaIa0hMAN0B6YuCDOU82zBkyg8Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618564150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXhVcknuH7vRZ8Cv/x2IzlKP8UQuZLhEE+jqIDvzBq8=;
        b=AokndKAbOjooNwgG2WB8jPqJmg/CJgLobKCHlN0NXUMLGOxlIOBQ8FUIB1S6ZMX0Knmw7I
        wG9K+soas1N2uSBg==
To:     chensong <chensong_2000@189.cn>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, maz@kernel.org, joe@perches.com,
        romain.perier@gmail.com, john.garry@huawei.com
Subject: Re: [PATCH] kernel:irq:manage: request threaded irq with a specified priority
In-Reply-To: <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
References: <1618294774-24370-1-git-send-email-chensong_2000@189.cn> <875z0qzigk.ffs@nanos.tec.linutronix.de> <4a355b66-3803-586b-56c7-ce715b5e59cc@189.cn>
Date:   Fri, 16 Apr 2021 11:09:09 +0200
Message-ID: <87fszqvbnu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Apr 16 2021 at 12:57, chensong wrote:
> On 2021/4/13 =E4=B8=8B=E5=8D=884:39, Thomas Gleixner wrote:
>> It breaks because the system designer failed to assign proper priorities
>> to the irq threads int_a, int_b and to the user space process task_a.
>
> yes, it's designers' responsibility to assign proper priorities, but=20
> kernel is also obliged to provide interfaces for those designers.

The interface exists. sched_setscheduler(2)

> chrt can help designers in this case, however, the truth is lot of=20
> customers are not familiar with it.

The truth is that real-time systems need to be carefully designed and
parametrized. And that's only possible when _all_ of the system
components and their constraints are known. Trying to solve it at the
device driver level of a single device is impossible and a guarantee for
fail.

If the customer does not know how to do it, then I really have to ask
why he's trying to use a real-time system at all. There is no real-time
system which magically tunes itself by pulling the overall system
constraints out of thin air.
=20
> what's more, chrt can also apply to userspace rt task, but userspace
> also has sched_setscheduler to assgin proper priority inside code like
> cyclictest, why can't driver writers have another choice?

There is a very simple reason: The driver writer cannot know about the
requirements of the complete system which is composed of kernel, drivers
and user space applications, unless the driver writer is fully aware of
the overall system design and constraints.

How is that supposed to work on a general purpose kernel which is
utilized for a gazillion of different use cases which all have different
expectations?

It simply cannot work because default A will only work for usecase A and
be completely wrong for all others.

> Further, what if irq handlear thread has to run on the expected priority=
=20
> at the very beginning? This patch helps.

There is no such thing as the expected priority of an interrupt thread
which can be applied upfront.

There are ~5400 instances of request*irq() in the kernel source and
there is no way to make priority decisions for them which work for every
RT system out there.

The kernel sets a default and the system designer, admin, user has to
take care of tuning it to match the expectations and constraints of his
particular application scenario.

The kernel provides an userspace interface to do that. That interface
might be a bit awkward to use, but there are tools out there which help
with that, and if at all we can think about providing a better and
easier to use interface for this.

Trying to solve that at the kernel level is putting the cart before the
horse.

Thanks,

        tglx
