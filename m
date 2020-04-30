Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E548C8300A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFAF2074A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d29VIYMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3Ms2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgD3MsZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 08:48:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A65C035495
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 05:48:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so6290291ljj.11
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2020 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnO667q5c5E7TSSxaDJD1U38vb/xALkbQXSs3IL9b34=;
        b=d29VIYMn01wGpc1r/vfro9ApyZNaBYF3i+SxZZyi12h4HX6RzcOIQ6KfYrlUzsqqBA
         3XDTMLY3AMK+tn6GAuWbrbqlxxAG0z5/hHr0T4Rs/PV34bcQNSX9yxHFOAlZXnUAA8ls
         8hdsBwfWbtzOU+qRvpDOpr+srM6wrn2YA9oBjWb0X6uXZOmtbkPktRVaJUi0VhNEx/qr
         CtwhZ9cxUVfGldn7kxVWBnMm+1OwmoYQA/q2Y8Fx0WeXyAVe4piDrWkg7wyNdNijkE1J
         W3sJDCnpeOn44Osjqq/klQLUAAbXnNfQze1e8+tn6d+DXlmneIpxILPKMklLOsv91P+r
         1/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnO667q5c5E7TSSxaDJD1U38vb/xALkbQXSs3IL9b34=;
        b=aT1tx6xY1VLUwAnAVrhBKcbpEDee5f3itPPpXmBK5yFsAOIMuY+sVFBpi4uCFBrKA6
         rodiZvjdOxzf22QpxPgz2DoWsVwEZNQEm1xri8WnshIEL7p8EoXUekC33fEsfaZmG2X7
         Wzu3PINUIocwV4LmDdsDT+9+fuQvWyxkAQOelgxU7I2gheJn8fjdCcSNL8TCbPhvRTQ6
         6SKgm7OfvvS8Y6KGuG8F5i42iYoDT6z/CWHfFhI/p1slLDscQXnOXBCyI915gRqjDhgK
         Nm6aiGvmygkybRxEuexZyngDbekgoab6ShAjX/oyzNHgPC2i2zN1ZXh8PvsAUCNcCfN9
         vJww==
X-Gm-Message-State: AGi0PuYLsyzKqasdqwZQ+vpuDqkFM2M3AGedpe0I/VDtmmuh6FOrF5OK
        b5iwRqowrLr23PXO2Stt3YsbiFx5JgmOHdJ9HxES0NHQ
X-Google-Smtp-Source: APiQypK5f0ixXmra0GXhuiax3wj9oASqR/v35hM1Y2OypnXRwuvd+a02m5i8KuNhlCYPTunNiv/q34DZvAXy3ITgzNI=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr1984790ljp.209.1588250902213;
 Thu, 30 Apr 2020 05:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200428050242.17717-1-swood@redhat.com>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Apr 2020 14:48:11 +0200
Message-ID: <CAKfTPtDfk-aq7PTVmMgJcZSOupXb0SGHS8Fc2k+qTZTsnfiV=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Tue, 28 Apr 2020 at 07:02, Scott Wood <swood@redhat.com> wrote:
>
> These patches mitigate latency caused by newidle_balance() on large
> systems, by enabling interrupts when the lock is dropped, and exiting
> early at various points if an RT task is runnable on the current CPU.
>
> When applied to an RT kernel on a 72-core machine (2 threads per core), I
> saw significant reductions in latency as reported by rteval -- from
> over 500us to around 160us with hyperthreading disabled, and from
> over 1400us to around 380us with hyperthreading enabled.

Do you know how each patch contributes to the decrease ? Because patch
3 not only impacts newly idle lb but each and every lb. So most of the
decrease might come from aborting the busy or idle lb at the highest
sched_domai level which scan all cpus and moving newly idle load
balance is not a major part.

>
> This isn't the first time something like this has been tried:
> https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
> That attempt ended up being reverted:
> https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
>
> The problem in that case was the failure to keep BH disabled, and the
> difficulty of fixing that when called from the post_schedule() hook.
> This patchset uses finish_task_switch() to call newidle_balance(), which
> enters in non-atomic context so we have full control over what we disable
> and when.
>
> There was a note at the end about wanting further discussion on the matter --
> does anyone remember if that ever happened and what the conclusion was?
> Are there any other issues with enabling interrupts here and/or moving
> the newidle_balance() call?
>
> Rik van Riel (1):
>   sched,rt: break out of load balancing if an RT task appears
>
> Scott Wood (2):
>   sched/fair: Call newidle_balance() from finish_task_switch()
>   sched/fair: Enable interrupts when dropping lock in newidle_balance()
>
>  kernel/sched/core.c  |  7 +++--
>  kernel/sched/fair.c  | 72 +++++++++++++++++++++++---------------------
>  kernel/sched/sched.h | 12 +++++---
>  3 files changed, 49 insertions(+), 42 deletions(-)
>
> --
> 2.18.2
>
