Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82551C77B75
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 May 2023 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjEPLAA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 May 2023 07:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjEPK77 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 May 2023 06:59:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5493593
        for <linux-rt-users@vger.kernel.org>; Tue, 16 May 2023 03:59:54 -0700 (PDT)
Date:   Tue, 16 May 2023 12:59:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684234792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F81kd2RSRctZw98mrg44FcD68uQQiQ/6Jhq74YzbNsw=;
        b=UcfV3DDPJPekyiI2aulQs0jHUWdiWAsj8/kPTGr9dj/ouflSsQPRDMGx+m3xk6q5fcRMQh
        6lu38EbUkbvB/ZyxMOl+PwTOrXkQXjK0okFUxG8Kvf43iVo9I3wwuPziW2WFZiDFIOL8P7
        j+VPR44+GIB34SEjmvrGbizgyVwFQfqDxR+ox2+35g5Bxjy5zR99pK9FGAiVWfcw/5f0OI
        lFGyBKwevEKeIKZQ6FIavp1WGplp0bHCho0+E61pd+muPhEsktgXpl1MAipSSsN0rAaXyJ
        xn7zARFLD/nFaKcfzOTQ/X0XWrwwyQeNDe1g9yU3hAp70rd5AG93cCwXnZ/lAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684234792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F81kd2RSRctZw98mrg44FcD68uQQiQ/6Jhq74YzbNsw=;
        b=nTTQ52ykCTOlSbftVvh++wWsJjJenS06RTSmOIYvsXaaiHu7xubb2QdKtmOhYckvL3naXM
        mz7zzaZcFSOTFpAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rod Webster <rod@vmn.com.au>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <20230516105950.kSgA5y-v@linutronix.de>
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de>
 <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de>
 <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-04-29 07:37:25 [+1000], Rod Webster wrote:
Sorry for the break.

> > Is the vendor driver better than in the tree? This is not obvious from
> > what you are writing.
> I have been unable to compile the R8168 driver from source on the
> Realtek website.
> They are behind with supported kernels and the build process is
> invariably broken for me.
> On the Hardkernel Odroid forum, it has been reported that compilng the
> R8125 from Realtek source offers 15-35% improvement over the in-tree
> driver.
>  I have one of their  PC's (H2+). It's currently running v5.10 and the
> in-tree R8168 driver (which must be the Debian default).
>  It is affected and I plan to upgrade to v6.3 with the R8125-dkms driver

That is interesting. 15%-35% improvement for the in-tree driver would be
certainly welcomed. :)

> > Two things you could do:
> > - enabling tracing to see what is causing the delays/ latency spike. You
> >   will need a trigger to notice the latency and then stop the trace at
> >   this point. If so, I could provide additional steps unless you can do
> >   it yourself.
> Please advise additional steps to do this.
> We might  be able to modify our hardware device driver to stop the
> trace as it reports latency incursions if they occur.

Either with a tool like trace-cmd or manual.
- trace-cmd
  - Enable events:
    trace-cmd start -e sched:* -e irq:* -e irq_vectors:*
  - Start the test
  - Once the error happens, stop the trace
    trace-cmd stop
  - Extract the trace
    trace-cmd extract
  - The command produces a trace.dat file. It can viewed in text via
    "trace-cmd report" or kernelshark.
  - Disable the events
    trace-cmd reset

- Manual
  - Enable events
    cd /sys/kernel/debug/tracing/
    echo 1 > events/sched/enable
    echo 1 > events/irq/enable
    echo 1 > events/irq_vectors/enable
  - Start the test
  - Once the error happens, stop the trace (assume you are still in the
    previous folder)
    echo 0 > tracing_on
  - Extract the trace
    cat trace > ~/trace.txt
  - The average editor can be used.
  - Disable the events (and reset).
    echo 0 > events/enable
    echo 1 > tracing_on

> > - You could try to isolate the realtek driver on one CPU and moving
> >   everything else to another.
> This sounds interesting. Please advise how.
> On a 4 core machine we typically add isolcpus=3D2,3 for best RT performan=
ce.

So this isolcpus CPU thingy is already going in that direction. If you
have two NICs, say one with RT traffic and one without, then the RT
traffic should go the RT CPUs while the non-RT traffic to the non-RT
CPUs. The isolcpus option works only for tasks. You should do the same
interrupts. See the irqaffinity option.
Lets first look at the trace and what the problem is and what can be
done=E2=80=A6

> Thanks for your support.
>=20
> -end
> -Rod Webster

Sebastian
