Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A553C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Mar 2022 20:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiCWUF3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCWUF2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Mar 2022 16:05:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA68564A
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 13:03:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648065834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN9700pZV265xYmqz7H8IRQB/3R2K9XKpJcHCK1o8PI=;
        b=vwOsV3VH7P5Vwu966VBotqiOhotpiXz+3OwtCeeBiD14BLcrC9cXT5O8BkPTIWY+hR+E+K
        AgM0af8NGsXM/iRTu7CIhqax6A+hxtJ+qVqPLeqepi18C3Wu0svuatLG8d0uHKMMVvRfx6
        qV+h/5guPY0hFKeYM5MIYk2jaxEBjyiF2FVAKu8HQu9bW5RkTjUsLW6f2BsWPHP71WcmqZ
        CUVyauYLwmPENQY9hhkKQwNrFQ2jmvGiC7TunKoZyVFsm6aZm8vgI84e2+k3B8V+HEEPx+
        ZYv3mqGMweArp86WM+Sw760xLIzxooyAFQKxwGEx4xjYnzYq163UbitxZ3ZooA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648065834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN9700pZV265xYmqz7H8IRQB/3R2K9XKpJcHCK1o8PI=;
        b=R3YwRhNwKbd5M7Ceqq9/p/vWfTpiOvso7q01rEhrzLqmheSZY93OONhGwOfRLogCbQGefs
        xooV45atw8pJ9WAQ==
To:     Gautam Thaker <ghthaker@gmail.com>, linux-rt-users@vger.kernel.org
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
In-Reply-To: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
Date:   Wed, 23 Mar 2022 21:09:53 +0106
Message-ID: <871qyse8ra.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-23, Gautam Thaker <ghthaker@gmail.com> wrote:
> I built 5.15.28-rt35 #2 SMP PREEMPT_RT  with  =E2=80=9CFully Preemptible
> Kernel" option and otherwise using .config from  a stock Ubuntu 20.04
>  5.4.0 kernel.
>
> Quick question: I see scheduling/wake_up latencies around 800 usec and
> this is confirmed by cyclictest.
[...]
> node-0> grep -i preempt /boot/config-5.15.28-rt35
> node-0> grep -i debug  /boot/config-5.15.28-rt35 |grep  =3Dy
[...]
> processor       : 31
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 63
> model name      : Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz
> stepping        : 2
> microcode       : 0x46
> cpu MHz         : 1200.000
> cache size      : 20480 KB

Your CPU is running at 1.2GHz although it is capable of 2.4GHz. This
looks like you have CPU frequency scaling activated. Investigate:

grep -i cpu_freq /boot/config-5.15.28-rt35

The configuration of your tick may also be interesting:

grep -i hz /boot/config-5.15.28-rt35

John Ogness
