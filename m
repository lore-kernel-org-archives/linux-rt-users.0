Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE028C43214
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2BB60F92
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhHaM7U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhHaM7P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 08:59:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BFC061575;
        Tue, 31 Aug 2021 05:58:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b4so19793803ilr.11;
        Tue, 31 Aug 2021 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWS+Ij/B65eWiJaIgZALxxXVNQmfq8edX/IwCYp9o1A=;
        b=KiPA5qm2NcuzbK2V6DVsCrjTveYWaH9NIeo1a5PrjQyHagXTPtNFS9HEP1xr0abNrG
         Ull3Hfs9nzJ54H3/OiqrIc7YyXfQcMg5SAHarAovL2tYx87/2VngW308BOmtFQSrgZbf
         V5+K2u3N6vXRq/pYj7rZJGE4ORnyACoXLA9JBqfLPVsltkoB6qACP2WNKdctGG11wpex
         R/dEcOKc0KBXYJgGGAcayCHX/n+Y7sdbRKydg/fM4pbRLMKC/EHAyl8nebtJPPdaYg3v
         imTbM0MP5SjsiJ8AY368wwfQF71siJiM8lTAP0iCU50X56QEMWQlBr6qFjHP9l3zbfLt
         BwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWS+Ij/B65eWiJaIgZALxxXVNQmfq8edX/IwCYp9o1A=;
        b=QlRCu3RRvHISErNoTo0wChDwhclrY5+PLNCM7XjIY8ER+408d1NJyh1UnknDuQsqY6
         LtTwWaoDo54101WL4U2ozfnU8zLhwrmp6kGshY4IPMA+U68J7kchmeDzt8o+6CCP91wm
         goQ/HHRbC82I2zndYUcM0BJnPWp9zi1G+z5VUdvZbV41CjdKoF+zlBoxgdU7pzfrpFh4
         Zu6WzTA96TKS14L8aoMrWq4dttK/9ykO2sLUTJ1VstDlhG0uz+I4XcWfK94Gxc44TR5F
         3ENkzyXXqhvWaOaxsYV8psNWkkC7hKDcKdsZZct+UImFOqfTCp4qlHZW+8BuiHvtBV8i
         mswA==
X-Gm-Message-State: AOAM532VM945lclbuKUhufY3/n1tH1KT+SkbuTOFLmbS1ljaLwrLH1yk
        3igHyV5SuopZFph/O37ToaYv+ugTEdJBRVLQ1dw=
X-Google-Smtp-Source: ABdhPJzLlKuygTMvd9PBPrG14h3dujagX556AFct01JNN2BX7AGoWpjuYV0xNp0O4S2/7rdTkD2T51EtWCy7OF7s6NU=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr20142203ils.203.1630414699713;
 Tue, 31 Aug 2021 05:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
In-Reply-To: <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 20:57:43 +0800
Message-ID: <CALOAHbBve8h7r5YQfkp-652RY8oq3N8bwXDLVT7wVhnPJpZZdg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] sched: support schedstats for RT sched class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 31, 2021 at 6:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:29:39AM +0000, Yafang Shao wrote:
> > Hi Ingo, Peter,
> >
> > This feature is useful to trace the sched details of RT tasks. Hopefully
> > you can give some feedback on it.
> >
> > We want to measure the latency of RT tasks in our production
> > environment with schedstats facility, but currently schedstats is only
> > supported for fair sched class. In order to support if for other sched
> > classes, we should make it independent of fair sched class. The struct
> > sched_statistics is the schedular statistics of a task_struct or a
> > task_group, both of which are independent of sched class. So we can move
> > struct sched_statistics into struct task_struct and struct task_group to
> > achieve the goal.
>
> Do you really want schedstats or do you want the tracepoints?

I really want the schedstats, which is very helpful to help us profile
thread-level latency.
The tracepoints is a bonus.

> In general
> I really want to cut back on the built-in statistics crud we carry,

Pls. don't.
There are really use cases of statistics.
Our use case as follows,

Userspace Code Scope         Profiler

{
    user_func_abc();   <----      uprobe_begin() get the start statistics
    ...
    user_func_xyz();   <----       uprobe_end()  get the end statistics
}

Then with this profiler we can easily get what happened in this scope
and why its latency was great:
    scope_latency = Wait + Sleep + Blocked [1]  + Run (stime + utime)

If there is no schedstats, we have to trace the heavy sched::sched_switch.

[1]. With patch #5 and don't include sum_block_runtime in sum_sleep_runtime

> there's too much and it seems to keep growing forever :-(
>
> (as is the case here, you're extending it as well)
>
> That said; making schedstats cover the other classes can be seen as
> fixing an inconsistency, but then you forgot deadline.
>

There's no deadline task on our server, so I didn't support it for deadline.
But with this patchset, it is very easy to extend it to deadline and
any other sched classes.


> > After the patchset, schestats are orgnized as follows,
> > struct task_struct {
> >     ...
> >     struct sched_statistics statistics;
> >     ...
> >     struct sched_entity *se;
> >     struct sched_rt_entity *rt;
> >     ...
> > };
> >
> > struct task_group {                    |---> stats[0] : of CPU0
> >     ...                                |
> >     struct sched_statistics **stats; --|---> stats[1] : of CPU1
> >     ...                                |
> >                                        |---> stats[n] : of CPUn
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >     struct sched_entity **se;
> >  #endif
> >  #ifdef CONFIG_RT_GROUP_SCHED
> >     struct sched_rt_entity  **rt_se;
> >  #endif
> >     ...
> > };
>
> Yeah, this seems to give a terrible mess, let me see if I can come up
> with anything less horrible.



-- 
Thanks
Yafang
