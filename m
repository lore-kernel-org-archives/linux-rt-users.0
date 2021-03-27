Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0664C433E0
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DBC619A0
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhC0KNt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhC0KNs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:13:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED9C0613B1;
        Sat, 27 Mar 2021 03:13:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y5so7823940qkl.9;
        Sat, 27 Mar 2021 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qNeqETV76d28UTNh020+mUw1Cui4SQ8Va46+JqCFHU=;
        b=Y7Awmlsj4ZaiMkm2Q4s6W9FGRek/c2vZ7hX6ijJID6TneKCs2IXq/jHWD/MGfB5HBa
         Ie+LM5cJcsbzuV2b4slv0QT8ugX+ZDmv7yQY8i6KT5CV77w46brsnZ14nU3bLU1x3ezu
         XIrbWy8S8lqhqsRFH5uOrjYsQROXrmPGtQCAPWNdCaxHUeHvU5v9igwymz/Xe9xtWVGT
         nH/oMgy7ayn3o1ENtylNlhV2eek3vM7oiYvIMaSJNAVscD+0ksINFtfHYJsteSSIfgek
         yh4jFaMmDDIMk7Te4/4FRgNDqJEk8tKBMydGOiEJaHQh/HQBIRJn+zEGc5ct0UJx0xK4
         +ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qNeqETV76d28UTNh020+mUw1Cui4SQ8Va46+JqCFHU=;
        b=Efs4V8sXq9nNrboAF3TNXET0v1RTb76NenrST2+D/GyZt3sBG04RYihUdypgcpMoqS
         Ihh+G6LbEKCIinJK8Fzw77Gbl4XmdFZzyrgWrSFt19Aw+fgz5hSs8673TBIqfPyuT0Az
         ITmeAw7/NzRN8FRAS3sUNrP/R88IUrTu/hhd4B613owLATfhQx6039S8rx6g4tKYvsr7
         ALhi6v73MIeq5Bri+cc/JM323XnSk0ndjF4ZNm0/+SvisX0U4cRQgmaxwyfkIpZeOsMa
         zi9sJx22mM/bxtXE7D3RF7uzR9XvT7oZpTLpD25finqZsQhWLX1R8eImaB2Z18j64I1k
         J5rg==
X-Gm-Message-State: AOAM530B319Fh5Y4O/sG0wObAyEY3WGPi6dAX6x1ydyij7a5V1ZJNpM3
        Ftu35PLuryI4UUJF5EYCOGs=
X-Google-Smtp-Source: ABdhPJwB4P7d1/04Vb6BSepSrSmahPBlbI5LKLb6+XWn68NFBbOOlFTt6ROeJi/RJkbRKvKG47WJQA==
X-Received: by 2002:a37:9a0b:: with SMTP id c11mr16603152qke.190.1616840027499;
        Sat, 27 Mar 2021 03:13:47 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:13:46 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/6] sched: support schedstats for RT sched class 
Date:   Sat, 27 Mar 2021 18:12:47 +0800
Message-Id: <20210327101254.56872-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstats facility, but currently schedstats is only
supported for fair sched class. In order to support if for other sched
classes, we should make it independent of fair sched class. The struct
sched_statistics is the schedular statistics of a task_struct or a
task_group, both of which are independent of sched class. So we can move
struct sched_statistics into struct task_struct and struct task_group to
achieve the goal.

After the patchset, schestats are orgnized as follows,
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

The sched_statistics members may be frequently modified when schedstats is
enabled, in order to avoid impacting on random data which may in the same
cacheline with them, the struct sched_statistics is defined as cacheline
aligned.

Then we can use schedstats to trace RT tasks as well, for example,
                    Interface File
 task schedstats :  /proc/[pid]/sched
 group schedstats:  /proc/sched_debug
 tracepoints     :  sched:sched_stat_{runtime, wait, sleep, iowait, blocked}

As PATCH #2 and #3 changes the core struct in the scheduler, so I did
'perf bench sched pipe' to measure the sched performance before and after
the change, suggested by Mel. Below is the data, which are all in
usecs/op.
                             Before             After
  kernel.sched_schedstats=0  6.0~6.1            6.0~6.1
  kernel.sched_schedstats=1  6.2~6.4            6.2~6.4
No obvious difference after the change. 

Changes since v1:
- Fix the build failure reported by kernel test robot.
- Add the performance data with 'perf bench sched pipe', suggested by
  Mel.
- Make the struct sched_statistics cacheline aligned.
- Introduce task block time in schedstats

Changes since RFC:
- improvement of schedstats helpers, per Mel.
- make struct schedstats independent of fair sched class

Yafang Shao (6):
  sched, fair: use __schedstat_set() in set_next_entity()
  sched: make struct sched_statistics independent of fair sched class
  sched: make schedstats helpers independent of fair sched class
  sched: introduce task block time in schedstats
  sched, rt: support sched_stat_runtime tracepoint for RT sched class
  sched, rt: support schedstats for RT sched class

 include/linux/sched.h    |   7 +-
 kernel/sched/core.c      |  24 +++--
 kernel/sched/deadline.c  |   4 +-
 kernel/sched/debug.c     |  90 +++++++++--------
 kernel/sched/fair.c      | 210 ++++++++++++++++-----------------------
 kernel/sched/rt.c        | 143 +++++++++++++++++++++++++-
 kernel/sched/sched.h     |   3 +
 kernel/sched/stats.c     | 104 +++++++++++++++++++
 kernel/sched/stats.h     |  89 +++++++++++++++++
 kernel/sched/stop_task.c |   4 +-
 10 files changed, 489 insertions(+), 189 deletions(-)

-- 
2.18.2

