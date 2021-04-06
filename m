Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA4C433B4
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Apr 2021 10:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9257F613C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Apr 2021 10:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhDFKl5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhDFKl4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Apr 2021 06:41:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11753C06174A;
        Tue,  6 Apr 2021 03:41:48 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d10so12627510ils.5;
        Tue, 06 Apr 2021 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqwLT9earkXIj3mKLKZrj+6hWxt8NrgkmSJhRhhjzAo=;
        b=sDnJNWn7Z2IewJKMiE7LngPEyfOX1AUQyJ0/yucjC1+WUEHGez3FNZiO1u+0F7ImG1
         2Cr2fS5v7V0g9ngBry9FuUmHNlVlwzXRf0WiAHde/ELtWf0HzHTb+9m2XxMidarWJPps
         eyQhIoNXARE28XD0qH9X5KnHbMNFQpxQk5HjF/lFvstqUdThh8nluS1zJM2/xF8lyWsN
         IKeaHgcD5c0ElpMhaegCTBGULOApasFOiZCFWe05Hd05JkNmoig2DOX5foPSflk5/sHj
         VA6+arofL8TsPQeGHQ1x94clDQAYcR++1nVte7Vrrbpyf4NvDmKFMrcAxUNdrgFETFeF
         4Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqwLT9earkXIj3mKLKZrj+6hWxt8NrgkmSJhRhhjzAo=;
        b=JHEs2h1DxYgjhz97vhDLV3DF3BrEkktxQEA9Ue0EUtbEmrnPSrwN+yy3q4vGKy8gjw
         S/Ngac0UC2YlutFiofNEBzSe11P/+eC/IxI6ykSSQ1bYqmrlZ2h6WxrqZS5RkhpGAsX5
         lpxeUXVHTohWbysCUb2TE0h5OiRH0uzd30hD3cXxK7gk/aLeHLqiAhziTChGBVyiThEx
         Tp4KC5Myc1zaKVTso6ilOS0pdcH+Nu4zV5OZQaWzeQFHe7DO6UWkLTtcsZIcmwNW528n
         /w45/TTfWONuXAThYHCuJIJRk1ifJWfjl2LkDHja0f6U/PRG/I7q0N1X9wRxEuXN9wEw
         SPkg==
X-Gm-Message-State: AOAM531pAJsDYtwByPlhXwu6YRPSlP4hM63uFdleoaLAk/q6eamXnZ39
        1HroBeCz9cncRYFObpv6bfVA+sS2uqtCyZ52jmQ=
X-Google-Smtp-Source: ABdhPJwUKY3YO+j9UScD0xU6VF/8JOy30l6n9KRq+55gtznilibWyOVPXz9J2I4HiITvypU+PyaqrAGdmRsMRvaeUvU=
X-Received: by 2002:a92:7f03:: with SMTP id a3mr23311252ild.203.1617705707486;
 Tue, 06 Apr 2021 03:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210327101254.56872-1-laoar.shao@gmail.com>
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 6 Apr 2021 18:41:11 +0800
Message-ID: <CALOAHbDZPo65Vc89sVCuYkJ6vr=zD-4ev=JN=j7ZAzKHzRibdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] sched: support schedstats for RT sched class
To:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, bristot@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Mar 27, 2021 at 6:13 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We want to measure the latency of RT tasks in our production
> environment with schedstats facility, but currently schedstats is only
> supported for fair sched class. In order to support if for other sched
> classes, we should make it independent of fair sched class. The struct
> sched_statistics is the schedular statistics of a task_struct or a
> task_group, both of which are independent of sched class. So we can move
> struct sched_statistics into struct task_struct and struct task_group to
> achieve the goal.
>
> After the patchset, schestats are orgnized as follows,
> struct task_struct {
>     ...
>     struct sched_statistics statistics;
>     ...
>     struct sched_entity *se;
>     struct sched_rt_entity *rt;
>     ...
> };
>
> struct task_group {                    |---> stats[0] : of CPU0
>     ...                                |
>     struct sched_statistics **stats; --|---> stats[1] : of CPU1
>     ...                                |
>                                        |---> stats[n] : of CPUn
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>     struct sched_entity **se;
>  #endif
>  #ifdef CONFIG_RT_GROUP_SCHED
>     struct sched_rt_entity  **rt_se;
>  #endif
>     ...
> };
>
> The sched_statistics members may be frequently modified when schedstats is
> enabled, in order to avoid impacting on random data which may in the same
> cacheline with them, the struct sched_statistics is defined as cacheline
> aligned.
>
> Then we can use schedstats to trace RT tasks as well, for example,
>                     Interface File
>  task schedstats :  /proc/[pid]/sched
>  group schedstats:  /proc/sched_debug
>  tracepoints     :  sched:sched_stat_{runtime, wait, sleep, iowait, blocked}
>
> As PATCH #2 and #3 changes the core struct in the scheduler, so I did
> 'perf bench sched pipe' to measure the sched performance before and after
> the change, suggested by Mel. Below is the data, which are all in
> usecs/op.
>                              Before             After
>   kernel.sched_schedstats=0  6.0~6.1            6.0~6.1
>   kernel.sched_schedstats=1  6.2~6.4            6.2~6.4
> No obvious difference after the change.
>
> Changes since v1:
> - Fix the build failure reported by kernel test robot.
> - Add the performance data with 'perf bench sched pipe', suggested by
>   Mel.
> - Make the struct sched_statistics cacheline aligned.
> - Introduce task block time in schedstats
>
> Changes since RFC:
> - improvement of schedstats helpers, per Mel.
> - make struct schedstats independent of fair sched class
>
> Yafang Shao (6):
>   sched, fair: use __schedstat_set() in set_next_entity()
>   sched: make struct sched_statistics independent of fair sched class
>   sched: make schedstats helpers independent of fair sched class
>   sched: introduce task block time in schedstats
>   sched, rt: support sched_stat_runtime tracepoint for RT sched class
>   sched, rt: support schedstats for RT sched class
>
>  include/linux/sched.h    |   7 +-
>  kernel/sched/core.c      |  24 +++--
>  kernel/sched/deadline.c  |   4 +-
>  kernel/sched/debug.c     |  90 +++++++++--------
>  kernel/sched/fair.c      | 210 ++++++++++++++++-----------------------
>  kernel/sched/rt.c        | 143 +++++++++++++++++++++++++-
>  kernel/sched/sched.h     |   3 +
>  kernel/sched/stats.c     | 104 +++++++++++++++++++
>  kernel/sched/stats.h     |  89 +++++++++++++++++
>  kernel/sched/stop_task.c |   4 +-
>  10 files changed, 489 insertions(+), 189 deletions(-)
>
> --
> 2.18.2
>

Peter, Ingo, Mel,

Any comments on this version ?

-- 
Thanks
Yafang
