Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD26C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3470120770
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 11:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDdd+JCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbgLALza (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbgLALza (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 06:55:30 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A9C0613D6;
        Tue,  1 Dec 2020 03:54:50 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id t142so326928oot.7;
        Tue, 01 Dec 2020 03:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+difrXmtbLteqVpNCchCmfcy5oFstbJ0wJIdrMVXC6k=;
        b=vDdd+JCuyhL/5IFnULP4Z36PBiW0ZIQJb7UDWcgfamDosKdMfRzpgVvCjJ3LQzWoBc
         sjQSPt5jOx0B0TDWvOiMXmMeqrjqUMp5Mt+G3XO0ABV2Jh3m2gY3bLI1llK7749cfXLF
         vOLXL7Awu/vq9MI0iOgIZrejFbcEaF1Sf2CtmA3+XREOPbftnPGkrrkxoKHk/SusFx+A
         dFSj8W8ybKpdNJ9JxTD6c2RCNP/T3XbjxoeHXg8CxONHYS0OrWDZ69VvE8jsZhB0VadA
         VM7GIki4JWX8glIuLVl25BEQ6NRmCX16Uj2pkvCbf0qy1BuXLLLJWGM1/UVVDjwYLUiA
         JrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+difrXmtbLteqVpNCchCmfcy5oFstbJ0wJIdrMVXC6k=;
        b=k7Q2eMThSwO/FvHVeTWnV/uIzGi7ihs5euAV3yFMwmVvjn/0XACKf/HhPTwCwXNT0F
         wAkezvlROOnSHMvSsk7aFk31kHzoxe9nqV/QMq2s8O11liDAqFwknzzNsudNAsZGgm5z
         zL0RrgAUTQ2V/iuIaPMOQumRHhJMOzGKWk8qRfLIiiKRl6NlrsZMsDn9SS/sOn3TOPjE
         Oe2YuAUutMV0xzC9HNAzc0E8IPBRR5BHitOo628tuWt8Kr93FnAQU4GiWcN6NhB8OEg+
         PJSxIpXZikiOP5KtGukqk69pHZNbRjlfTGGfFuwlv+XBZbYsK1tai2zDD5hczJ7WflNy
         utfw==
X-Gm-Message-State: AOAM530AVnjx8q6oh5M/V1RAuWOUu9wuthNoMhrdRVVCDA6coq2OYAW0
        +PNU5zILR+W1N+MObhM63y4=
X-Google-Smtp-Source: ABdhPJyiupzAMniwxTmeu5I9mbPrOaTp/4VhwRayouXHorsZwyGGeMVfCLx7+0IAQ9ULCEW60s0F5Q==
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr1514485oot.61.1606823689785;
        Tue, 01 Dec 2020 03:54:49 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id o6sm342592oon.7.2020.12.01.03.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:54:49 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/6] sched: support schedstats for RT sched class 
Date:   Tue,  1 Dec 2020 19:54:10 +0800
Message-Id: <20201201115416.26515-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstats facility, but currently schedstats is only
supported for fair sched class. This patch enable it for RT sched class
as well.

- Structure

Before we make schedstats available for RT sched class, we should make
struct sched_statistics independent of fair sched class first.


The struct sched_statistics is the schedular statistics of a task_struct
or a task_group. So we can move it into struct task_struct and
struct task_group to achieve the goal.

Below is the detailed explaination of the change in the structs.

The struct before this patch:

struct task_struct {            |-> struct sched_entity {
    ...                         |       ...
    struct sched_entity *se; ---|       struct sched_statistics statistics;
    struct sched_rt_entity *rt;         ...
    ...                                 ...
};                                  };

struct task_group {             |--> se[0]->statistics : schedstats of CPU0
    ...                         |
 #ifdef CONFIG_FAIR_GROUP_SCHED |
    struct sched_entity **se; --|--> se[1]->statistics : schedstats of CPU1
                                |
 #endif                         |
                                |--> se[N]->statistics : schedstats of CPUn

 #ifdef CONFIG_FAIR_GROUP_SCHED
    struct sched_rt_entity  **rt_se; (N/A)
 #endif
    ...
};

The '**se' in task_group is allocated in the fair sched class, which is
hard to be reused by other sched class.

The struct after this patch:
struct task_struct {
    ...
    struct sched_statistics statistics;
    ...
    struct sched_entity *se;
    struct sched_rt_entity *rt;
    ...
};

struct task_group {                    |---> stats[0] : of CPU0
    ...                                |
    struct sched_statistics **stats; --|---> stats[1] : of CPU1
    ...                                |
                                       |---> stats[n] : of CPUn
 #ifdef CONFIG_FAIR_GROUP_SCHED
    struct sched_entity **se;
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
    struct sched_rt_entity  **rt_se;
 #endif
    ...
};

After the patch it is clearly that both of se or rt_se can easily get the
sched_statistics by a task_struct or a task_group.

- Function Interface

The original prototype of the schedstats helpers are

update_stats_wait_*(struct cfs_rq *cfs_rq, struct sched_entity *se)

The cfs_rq in these helpers is used to get the rq_clock, and the se is
used to get the struct sched_statistics and the struct task_struct. In
order to make these helpers available by all sched classes, we can pass
the rq, sched_statistics and task_struct directly.

Then the new helpers are

update_stats_wait_*(struct rq *rq, struct task_struct *p,
                    struct sched_statistics *stats)

which are independent of fair sched class.

To avoid vmlinux growing too large or introducing ovehead when
!schedstat_enabled(), some new helpers after schedstat_enabled() are also
introduced, Suggested by Mel. These helpers are in sched/stats.c,

__update_stats_wait_*(struct rq *rq, struct task_struct *p,
                      struct sched_statistics *stats)

- Implementation

After we make the struct sched_statistics and the helpers of it
independent of fair sched class, we can easily use the schedstats
facility for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
                fair                            RT
enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
put_prev_task   update_stats_wait_start         update_stats_wait_start
set_next_task   update_stats_wait_end           update_stats_wait_end

- Usage
 
The user can get the schedstats information in the same way in fair sched
class. For example,
		fair				RT
task show	/proc/[pid]/sched               /proc/[pid]/sched
group show	cpu.stat in cgroup		cpu.stat in cgroup

The sched:sched_stat_{wait, sleep, iowait, blocked, runtime} tracepoints
can be used to trace RT tasks as well.

Detailed examples of the output of schedstats for RT tasks are in patch #6.


Changes since RFC:
- improvement of schedstats helpers, per Mel.
- make struct schedstats independent of fair sched class

Yafang Shao (6):
  sched: don't include stats.h in sched.h
  sched, fair: use __schedstat_set() in set_next_entity()
  sched: make struct sched_statistics independent of fair sched class
  sched: make schedstats helpers independent of fair sched class
  sched, rt: support sched_stat_runtime tracepoint for RT sched class
  sched, rt: support schedstats for RT sched class

 include/linux/sched.h    |   3 +-
 kernel/sched/core.c      |  25 +++--
 kernel/sched/deadline.c  |   5 +-
 kernel/sched/debug.c     |  82 +++++++--------
 kernel/sched/fair.c      | 209 +++++++++++++++------------------------
 kernel/sched/idle.c      |   1 +
 kernel/sched/rt.c        | 142 +++++++++++++++++++++++++-
 kernel/sched/sched.h     |   9 +-
 kernel/sched/stats.c     | 105 ++++++++++++++++++++
 kernel/sched/stats.h     |  80 +++++++++++++++
 kernel/sched/stop_task.c |   5 +-
 11 files changed, 476 insertions(+), 190 deletions(-)

-- 
2.18.4

