Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CAC6379D
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36E521D7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCvWFlIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgK0QM5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgK0QM5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 11:12:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B5C0613D1;
        Fri, 27 Nov 2020 08:12:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id n137so4982610pfd.3;
        Fri, 27 Nov 2020 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TL8KQ54wkv9B/Yxs0RIOT3jGAuhhdh5kFSYV9oX00I=;
        b=SCvWFlIkhit55pRVpYXDApHZKpRq6cFW03mHL/4SQ8IB/P/BzXEckVbX2+5D7wCERF
         NVsh+LUHfAelgCMfmXkqkAZIyUZ/sLWJlLYs9n/D7OuauH2d7eTRby3GDMyjhsWYWDyc
         gyVUYEKQaO1YIyjBfPidnx1xAa9jHBboQl9vQMF26oG68b58zCq1kBcVE7Pp42lvLHCf
         euvQUKlpLG7bYyq1bPVqbPspzx8xnqBiy1qHuc8cDY/4PY8YZQuK+T2z/7EKxtF6mkri
         hCC5N4Ix5ru3FCUG8tSPeb6LrwimTzxtH9FWMsQA9qGT6lwJwBvut+zOEZWEVaAF4g0T
         Zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TL8KQ54wkv9B/Yxs0RIOT3jGAuhhdh5kFSYV9oX00I=;
        b=sPiYM7WhsRBfPaVC4vS5QwRu9t7g6SiEaAuWF0sPLH95/cUxIJopsCo4gPcTy6nGjL
         Yjz1qNhMtSgldkqF4GxvnSao31DcYg5mo1Zityg64zw3mxbSFv8sXP15j5zyFyAqjodJ
         ISEKEc8yCHuATCs3R4nBrqWRnoYweztdwlteQj7yTc3vdRpAZ4k/b+VHSfwWNMZ1VD0O
         +tr3Ozp0QgQphXcLgFqWhSC0lwoaI3n2UHMUZ+iZoDMJsxp3jnv5L5lkNmn3wQlNHzH6
         L3qJgcrsADryKe1N3Aebp6Lakz05DbFG5hzCQ6+TZOle3GrN304U8XUuKIUz78mss5qq
         GEoQ==
X-Gm-Message-State: AOAM532YDzLolzY5n6b24Nxzj4lUYC3Q8M5Q6X0R2vcWoBVT/x7vmTF5
        +QTxu8PJT6pdGKIsRrVATi8=
X-Google-Smtp-Source: ABdhPJzVV5tNNGMWhEp2yBE1o8Pr9aNKV/tWEC0ldgw3jRy+mSnNgZE4XFpqxCUwQUrDlLqMa5hfGQ==
X-Received: by 2002:a63:5d05:: with SMTP id r5mr7129700pgb.442.1606493576330;
        Fri, 27 Nov 2020 08:12:56 -0800 (PST)
Received: from localhost.localdomain ([115.192.120.179])
        by smtp.gmail.com with ESMTPSA id v126sm7992715pfb.137.2020.11.27.08.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:12:55 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 0/5] sched: support schedstats for RT sched class
Date:   Sat, 28 Nov 2020 00:12:24 +0800
Message-Id: <20201127161229.19336-1-laoar.shao@gmail.com>
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

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well. sched_stat_runtime can also be
supported in the future if it is helpful.

Yafang Shao (5):
  sched: don't include stats.h in sched.h
  sched, fair: use __schedstat_set() in set_next_entity()
  sched: make struct sched_statistics independent of fair sched class
  sched: make schedstats helpers independent of fair sched class
  sched, rt: support schedstats for RT sched class

 include/linux/sched.h    |   3 +-
 kernel/sched/core.c      |  25 +++--
 kernel/sched/deadline.c  |   5 +-
 kernel/sched/debug.c     |  82 +++++++--------
 kernel/sched/fair.c      | 209 +++++++++++++++------------------------
 kernel/sched/idle.c      |   1 +
 kernel/sched/rt.c        | 178 ++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h     |  13 ++-
 kernel/sched/stats.c     | 105 ++++++++++++++++++++
 kernel/sched/stats.h     |  80 +++++++++++++++
 kernel/sched/stop_task.c |   5 +-
 11 files changed, 517 insertions(+), 189 deletions(-)

-- 
2.18.4

