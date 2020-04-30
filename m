Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C8C8300B
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6570B20870
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdDsdhzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD3MnE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgD3MnD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 08:43:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B4C035495
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 05:43:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so1088314lfc.5
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yumFUMI4249WSXzPR5V8YGUqtmGI9DD0x2OLnA0cDLs=;
        b=KdDsdhzGLrYgimJfZZEx2eF9JO3+vXrJDCCyg2oLnXyV21m1T5GaQnN9reCiJZLVeU
         SFS+4h4iZ3hVadXJCwKLrbUOBvVEP8R0kSWGduLVKwuQeNAzrHW76gFSq0HwXyd/L8V9
         /GfHGAaHyBl7SO2CWZqNCVw7ogKQ6cUYCtq+1+xSTHDhjefdtltnpdNrxTK961Kf1T7j
         O2qsrBiIKIeUWxrIME5UQ0zDVN36ratrdn7Nxq7HmPJV51QZXoABVzTf5xxb1jRLDF7h
         lQGM7JTRIsFXKDn7jTV+XFm5+oQRHIU8q7tZw+RIPO0+BsOQOAqhcJ0lOmTNB0Gthear
         Z1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yumFUMI4249WSXzPR5V8YGUqtmGI9DD0x2OLnA0cDLs=;
        b=dCF4pOiKMU7CwP3ruhh+rO/XrIsIYlaf1k7NC7AEmJE2kleOhPDLNqxj3Kvj0vnqW+
         d0vLEbpHInpDLWbT8Wk8yRnYkkWzYDrFZL8+5/VV0gFsBeZzoEV1FpiWXn3VrIFEj6Sx
         sh3MAYGSRaiSKbB/bMQXvNTXWI5nJoY2LtpB2pyvFbeXuy4vEWUBl7/bivuOxBCkYLQ7
         S65J9uCznuy0E+201ictxmJTb0USTz8X0eyQSl0bhDr8LebmFA+PcYI5tlooOBxXz4qh
         Ov06V+m4XhXxNnSVeMTWZv2+IUN4kcqbpkPMgxbSyHhqPtsgPzb1bmrZSGwqIx28Sl09
         gZsA==
X-Gm-Message-State: AGi0PuaNJkRBuu5QHKKgT6KTpBNO9813yO1Wpb300BFF9oLazuOIjhzd
        V38bhpkg5IyhHmxAsXwMFOeHPt6AXmtHSCPFatgS7Q==
X-Google-Smtp-Source: APiQypJekjcGgPXZsen7oTWtrMSl8LNdd5NgzZz+7x/cBDOlIlwEtuDvRS04xXh/mklX3ikBcToqDcSTP+2TCkhdBo4=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr2039989lfr.189.1588250581343;
 Thu, 30 Apr 2020 05:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200428050242.17717-1-swood@redhat.com> <jhjzhatdgxh.mognet@arm.com>
 <CAKfTPtDktpTB7d6qhmcX0HtryezzFygk4kOC22Qf=OM77QpLYg@mail.gmail.com> <jhjy2qdcmc2.mognet@arm.com>
In-Reply-To: <jhjy2qdcmc2.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Apr 2020 14:42:50 +0200
Message-ID: <CAKfTPtA_duZpnvMx+czAosCikVL=cESKhPQcRrQUdKWKobZBaA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 30 Apr 2020 at 12:14, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 30/04/20 08:44, Vincent Guittot wrote:
> > On Thu, 30 Apr 2020 at 01:13, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >>
> >> On 28/04/20 06:02, Scott Wood wrote:
> >> > These patches mitigate latency caused by newidle_balance() on large
> >> > systems, by enabling interrupts when the lock is dropped, and exiting
> >> > early at various points if an RT task is runnable on the current CPU.
> >> >
> >> > When applied to an RT kernel on a 72-core machine (2 threads per core), I
> >> > saw significant reductions in latency as reported by rteval -- from
> >> > over 500us to around 160us with hyperthreading disabled, and from
> >> > over 1400us to around 380us with hyperthreading enabled.
> >> >
> >> > This isn't the first time something like this has been tried:
> >> > https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
> >> > That attempt ended up being reverted:
> >> > https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
> >> >
> >> > The problem in that case was the failure to keep BH disabled, and the
> >> > difficulty of fixing that when called from the post_schedule() hook.
> >> > This patchset uses finish_task_switch() to call newidle_balance(), which
> >> > enters in non-atomic context so we have full control over what we disable
> >> > and when.
> >> >
> >> > There was a note at the end about wanting further discussion on the matter --
> >> > does anyone remember if that ever happened and what the conclusion was?
> >> > Are there any other issues with enabling interrupts here and/or moving
> >> > the newidle_balance() call?
> >> >
> >>
> >> Random thought that just occurred to me; in the grand scheme of things,
> >> with something in the same spirit as task-stealing (i.e. don't bother with
> >> a full fledged balance at newidle, just pick one spare task somewhere),
> >> none of this would be required.
> >
> > newly idle load balance already stops after picking 1 task
>
> Mph, I had already forgotten your changes there. Is that really always the
> case for newidle? In e.g. the busiest->group_type == group_fully_busy case,
> I think we can pull more than one task.

for newly_idle load balance, detach_tasks stops after finding 1 suitable task

>
> > Now if your proposal is to pick one random task on one random cpu, I'm
> > clearly not sure that's a good idea
> >
>
> IIRC Steve's implementation was to "simply" pull one task from any CPU
> within the LLC domain that had > 1 runnable tasks. I quite like this since
> picking any one task is almost always better than switching to the idle
> task, but it wasn't a complete newidle_balance() replacement just yet.
>
> >
> >>
> >> Sadly I don't think anyone has been looking at it any recently.
