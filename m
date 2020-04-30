Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD161C83009
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 07:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4D6214D8
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 07:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTntdA1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD3Hoe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgD3Hod (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 03:44:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D0C035495
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 00:44:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so5364918ljj.11
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Me2gp8RxPqDFf1rj2uLX6ZZDuLWQfRcDDy0cz86Ar4=;
        b=HTntdA1e6qLCVEhkkCFcGCJFM/M5KjS7mWSAH3SEPWbOK3uPptqOf+qIOqMPLPLeqh
         lZSU14ZbKzzz2QrUYiNs3ll80ddlnMRvpwO1wprzjl4zd7obM6COomWvByQVqBSS7z1Q
         7WBC770BX5/8rNcU+77BpzBYcooj9v+XjPFyvxu1hbvJP7zCsT5yvMC/RIhh1LASnWBj
         XiaOEAwFxyl4Z6H0nMIhTSoPvfa9BLyopZH4M1DTInw4JO+GjFx4pUuRF85G1stw9+3e
         B+sY+43awFa5UKl2edbGLFGwZsZiWudYeFERlsz5qzJ/+1/SQDrh05/9CpELzZiawho4
         kqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Me2gp8RxPqDFf1rj2uLX6ZZDuLWQfRcDDy0cz86Ar4=;
        b=luyJKjigWV0dROMTiJxEsiMRHiIqoNSu1mGWa4NlemUaXoXNxN02qygBvD4svsvAXK
         LghCIlYmV2e93LAcYHq9AqzpiyeoHLfhkwMwXlmgZt6iaA3QJlePW2qoa3GILmYOfobu
         GpeZuYkibxhJyFbYsrc9VAtqZZqfcbEz9rVxmf4CD4wuLkZ0tqCPm0wVxIvTURwcZbCg
         PbbEh+g3ymaStYIze7erm8+LGLDJclLUgtBEi8xlpUTUCOPJtzI/0fknKaatFlQb4ZqM
         mJkfY/ou/HBy8QIwstDmPNrliRM4/cxDp4TJXBzyCtpIukxgef9T3mUnobAtnO1qI0Lf
         uAuw==
X-Gm-Message-State: AGi0PuY32uAlbBPfMOTZnRREZsUxULdiE7gZg5SbKGv5JiTV3nqHbxXt
        jzfr+sIgAaepAT3x/+G+vzVFRUnRj1EsVzN1kVjGKQ==
X-Google-Smtp-Source: APiQypK82t2gXDGONISJjaTmvRdMLE6WOtWDUR09M9YTvpevPtKquD8diJqwzUaS5wYBPvII8R71cTCBPZpJRYM2eeM=
X-Received: by 2002:a2e:740f:: with SMTP id p15mr1348569ljc.151.1588232671090;
 Thu, 30 Apr 2020 00:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200428050242.17717-1-swood@redhat.com> <jhjzhatdgxh.mognet@arm.com>
In-Reply-To: <jhjzhatdgxh.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Apr 2020 09:44:19 +0200
Message-ID: <CAKfTPtDktpTB7d6qhmcX0HtryezzFygk4kOC22Qf=OM77QpLYg@mail.gmail.com>
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

On Thu, 30 Apr 2020 at 01:13, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 28/04/20 06:02, Scott Wood wrote:
> > These patches mitigate latency caused by newidle_balance() on large
> > systems, by enabling interrupts when the lock is dropped, and exiting
> > early at various points if an RT task is runnable on the current CPU.
> >
> > When applied to an RT kernel on a 72-core machine (2 threads per core), I
> > saw significant reductions in latency as reported by rteval -- from
> > over 500us to around 160us with hyperthreading disabled, and from
> > over 1400us to around 380us with hyperthreading enabled.
> >
> > This isn't the first time something like this has been tried:
> > https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
> > That attempt ended up being reverted:
> > https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
> >
> > The problem in that case was the failure to keep BH disabled, and the
> > difficulty of fixing that when called from the post_schedule() hook.
> > This patchset uses finish_task_switch() to call newidle_balance(), which
> > enters in non-atomic context so we have full control over what we disable
> > and when.
> >
> > There was a note at the end about wanting further discussion on the matter --
> > does anyone remember if that ever happened and what the conclusion was?
> > Are there any other issues with enabling interrupts here and/or moving
> > the newidle_balance() call?
> >
>
> Random thought that just occurred to me; in the grand scheme of things,
> with something in the same spirit as task-stealing (i.e. don't bother with
> a full fledged balance at newidle, just pick one spare task somewhere),
> none of this would be required.

newly idle load balance already stops after picking 1 task
Now if your proposal is to pick one random task on one random cpu, I'm
clearly not sure that's a good idea


>
> Sadly I don't think anyone has been looking at it any recently.
