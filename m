Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD87AC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A587F61360
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHXLal (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhHXLak (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B38C061757;
        Tue, 24 Aug 2021 04:29:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e7so19481435pgk.2;
        Tue, 24 Aug 2021 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsdgxIajsLvyVXx8QcFLfpT4UU3Qk94eKj1fu3Cdnaw=;
        b=J3ekKR18f6EpfnXFMKOiNoVDKE9K1qm0B5w7HFPwkzzrx5ce4ur4+XKjQgQrZdPVMA
         G5K5pEmPRVvdao/miOhvVJZzh6bCUBCwlfZNxPbyBbqjXFD1bKujeeZMCFREoLGGvmOl
         Z9MUtkgK51i2bo2Z55z/2IcXruBsWAgdnRv7csJezdK0ptRz6VdjYdSMTMZd1YMOyv6Q
         295iUMfB12hYVzU25/413G7K0LghwJeaB46gZ5TboN+IC5zue6/5Dwd1SlNCznVFW9ko
         ix7/6NKCm+uB9vfWN2jPzQcfl8frL4wj9V5em1vDcszreDGNUr9K0eYhJKvIQg4mHMF0
         3wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsdgxIajsLvyVXx8QcFLfpT4UU3Qk94eKj1fu3Cdnaw=;
        b=Qxi1FPORavyNmt+RGT7Ct9py8LSseUVXA4bkOj0I/SC1W+WiNhegMhrRHu/VPW/yGj
         SjsL+gayjAceZdqzcQY6Dd3vuiZlprh+LzYuZs+WgXBA61neVqXjbDkSYOJenuiNDTNq
         p+c4PPdjtlu1KZuWGx1M6kjplcwgpcxtDXrYjRqmZfHq+rHfxB/dBw1Yd6DHLOQYkkWs
         ngkCilZ+XWwdch8Gxl81ZMV650VXZJnS8Qb1LeX0dNeIaXe08x+nOFzZAaxAhCOAVoFl
         Lx0PfP10sWFEkDD0bemMBO0TwQNhiItO2ET8y8Bevzp13WyxowsCVfzQW9LTUWJfyby3
         /QFw==
X-Gm-Message-State: AOAM531w1Hs8L7BPKkqkGW0eS6tfWAgom+dfABBZ7JnTrUoOkI9qfXpt
        xfVF8hJLcj6zyNHGRikMYwrFnxch9IDpIxfm
X-Google-Smtp-Source: ABdhPJxZDe0Vn3bPAlX2uXZ17tJveBRj/XZO7Fu54rsB2WSLFgimsBcrrKKeI7tXQt3Fyo9qhZrRCQ==
X-Received: by 2002:a05:6a00:150d:b0:3e2:13fc:dd2b with SMTP id q13-20020a056a00150d00b003e213fcdd2bmr38430712pfu.71.1629804595943;
        Tue, 24 Aug 2021 04:29:55 -0700 (PDT)
Received: from localhost.localdomain ([45.77.24.247])
        by smtp.gmail.com with ESMTPSA id on15sm2128732pjb.19.2021.08.24.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:29:55 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, achaiken@aurora.tech
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/7] sched: support schedstats for RT sched class 
Date:   Tue, 24 Aug 2021 11:29:39 +0000
Message-Id: <20210824112946.9324-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ingo, Peter,

This feature is useful to trace the sched details of RT tasks. Hopefully
you can give some feedback on it.

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

                                  Before               After
      kernel.sched_schedstats=0  ~5.6                 ~5.6
      kernel.sched_schedstats=1  ~5.7                 ~5.7
    [These data is a little difference with the prev version, that is
     because my old test machine is destroyed so I have to use a new
     different test machine.]
No obvious difference after the change.

Changes Since v2:
- Fixes the output format in /proc/[pid]/sched  
- Rebase it on the latest code
- Redo the performance test

Changes since v1:
- Fix the build failure reported by kernel test robot.
- Add the performance data with 'perf bench sched pipe', suggested by
  Mel.
- Make the struct sched_statistics cacheline aligned.
- Introduce task block time in schedstats

Changes since RFC:
- improvement of schedstats helpers, per Mel.
- make struct schedstats independent of fair sched class 


Yafang Shao (7):
  sched, fair: use __schedstat_set() in set_next_entity()
  sched: make struct sched_statistics independent of fair sched class
  sched: make schedstats helpers independent of fair sched class
  sched: make the output of schedstats independent of fair sched class
  sched: introduce task block time in schedstats
  sched, rt: support sched_stat_runtime tracepoint for RT sched class
  sched, rt: support schedstats for RT sched class

 include/linux/sched.h    |   7 +-
 kernel/sched/core.c      |  24 +++--
 kernel/sched/deadline.c  |   4 +-
 kernel/sched/debug.c     | 136 +++++++++++++++----------
 kernel/sched/fair.c      | 210 ++++++++++++++++-----------------------
 kernel/sched/rt.c        | 147 ++++++++++++++++++++++++++-
 kernel/sched/sched.h     |   3 +
 kernel/sched/stats.c     | 104 +++++++++++++++++++
 kernel/sched/stats.h     |  89 +++++++++++++++++
 kernel/sched/stop_task.c |   4 +-
 10 files changed, 531 insertions(+), 197 deletions(-)

-- 
2.18.2

