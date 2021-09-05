Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014FC433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36482600D0
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhIEOhK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEOhJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9306C061575;
        Sun,  5 Sep 2021 07:36:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2849362pjq.4;
        Sun, 05 Sep 2021 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDYxy+Qwv9cFLFs0Fp8IBwRajJ9Sbuyqg6B6IJ6uKvg=;
        b=M27pzR6sK3ma6JFa8hekO0SprvDmWm9jfoO473LC3TfE0isfaL66pzRT7bjV1by650
         9aGsYavgITIbCm9u08rgZcIZibTMQzat5HEL785pbYlwU3LV5Xeksxv2xH38G6YHJJSP
         TIT8P6M8DuhzCt/ZsAXe6xKZ18VYkqWQ04tJ1DwG0w+o+XW+FQ/One77ppwtPHpGppba
         VnoX4B1xUXgwsHWRNCyW4s7Vz15sGrrNb2yhRgsXlzK7iCs1uLPMR6lDO0QDuqaynZkY
         PrpGqTqWoN6XL8bazbjREmJ1C7YeRl5wgvW3NLFR9bO/egw53Yml/cbebWRGDiHAOyu7
         9OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDYxy+Qwv9cFLFs0Fp8IBwRajJ9Sbuyqg6B6IJ6uKvg=;
        b=dqb7fvaI14sgyFEW40UJAhd+G5d+DOqMu82GnRyqPSyNYCXMVOSCgetvdB41U9hLIL
         ieYHZNvUek7cl81OIGMO9JOyooNkQreLCUwrVGmmhl+fJ2outMvrWStGfSULhv50nTQE
         k9Y7zHTZudL4CUQvSvHOxT2ICFpaTyp5C9uj6Ob2xtIm3FGLtLSmz22qgmuhPLms1CvK
         /u5x3CocetO2BCZAAqOU280Lq0LPce7dmWfSUvdJrbyFXhY0blhGVrNkCYbczkMz2v7G
         PgHhG1emuBS+cAysWO91f6nfkouSlAEfqu1lxSTnADNQoVR2KGIpega6QnRe8X8FhdzV
         fWsQ==
X-Gm-Message-State: AOAM530uQmHiFsNHewds5NEjB9A09VHr4Z1AjRYPsqbBb/qHxtBJjWbG
        ZpBpIRwKUDwllmCgo0szkyU=
X-Google-Smtp-Source: ABdhPJyUoMTUFiNfX/4bRKo4ylfdhIXs6MLEU6U7PLg/xvM4+3wSMXmCFpUbN31HDLxTBj1jb5+kSg==
X-Received: by 2002:a17:90b:3603:: with SMTP id ml3mr9147909pjb.96.1630852566375;
        Sun, 05 Sep 2021 07:36:06 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/8] sched: support schedstats for RT sched class 
Date:   Sun,  5 Sep 2021 14:35:39 +0000
Message-Id: <20210905143547.4668-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Why do we need schedstats ?
==========================

schedstats is a useful feature to do thread-level latency analysis. Our
usecase as follows,

  Userspace Code Scope         Profiler

  {
      user_func_abc(); <----   uprobe_scope_begin() get start schedstats 
      ...
      user_func_xyz(); <----   uprobe_scope_end() get end schedstats
  }

Then with the result of (end - begin) we can get below latency details
in a specific user scope,

  scope_latency = Wait + Sleep + Blocked [1]  + Run (stime + utime)

If there's no schedstats we have to trace the heavy sched::sched_switch
and do a lot more stuff. 

[1]. With patch #4 and don't include sum_block_runtime in sum_sleep_runtime

Support schedstats for RT sched class
=====================================

If we want to use the schedstats facility to trace other sched classes, we
should make it independent of fair sched class. The struct sched_statistics
is the schedular statistics of a task_struct or a task_group. So we can
move it into struct task_struct and struct task_group to achieve the goal.

After the patch, schestats are orgnized as follows,

    struct task_struct {
       ...
       struct sched_entity se;
       struct sched_rt_entity rt;
       struct sched_dl_entity dl;
       ...
       struct sched_statistics stats;
       ...
   };

Regarding the task group, schedstats is only supported for fair group
sched, and a new struct sched_entity_stats is introduced, suggested by
Peter -

    struct sched_entity_stats {
        struct sched_entity     se;
        struct sched_statistics stats;
    } __no_randomize_layout;

Then with the se in a task_group, we can easily get the stats.

The sched_statistics members may be frequently modified when schedstats is
enabled, in order to avoid impacting on random data which may in the same
cacheline with them, the struct sched_statistics is defined as cacheline
aligned.

As this patch changes the core struct of scheduler, so I verified the
performance it may impact on the scheduler with 'perf bench sched
pipe', suggested by Mel. Below is the result, in which all the values
are in usecs/op.
                                  Before               After
      kernel.sched_schedstats=0  5.2~5.4               5.2~5.4
      kernel.sched_schedstats=1  5.3~5.5               5.3~5.5
[These data is a little difference with the earlier version, that is
 because my old test machine is destroyed so I have to use a new
 different test machine.]

Almost no impact on the sched performance.

The user can get the schedstats information in the same way in fair sched
class. For example,
       fair                            RT
       /proc/[pid]/sched               /proc/[pid]/sched

schedstats is not supported for RT group.

The sched:sched_stat_{wait, sleep, iowait, blocked} tracepoints can
be used to trace RT tasks as well.

Support schedstats for any other sched classes
==============================================

After this patchset, it is very easy to extend the schedstats to any
other sched classes. The deadline sched class is also supported in this
patchset.

Changes Since v3:
Various code improvement per Peter,
- don't support schedstats for rt group
- introduce struct sched_entity_stats for fair group 
- change the position of 'struct sched_statistics stats'
- fixes indent issue
- change the output format in /proc/[pid]/sched
- add the usecase of schedstats
- support schedstats for deadline task
- and other suggestions

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

Yafang Shao (8):
  sched, fair: use __schedstat_set() in set_next_entity()
  sched: make struct sched_statistics independent of fair sched class
  sched: make schedstats helpers independent of fair sched class
  sched: introduce task block time in schedstats
  sched, rt: support sched_stat_runtime tracepoint for RT sched class
  sched, rt: support schedstats for RT sched class
  sched, dl: support sched_stat_runtime tracepoint for deadline sched
    class
  sched, dl: support schedstats for deadline sched class

 include/linux/sched.h    |   8 +-
 kernel/sched/core.c      |  25 +++---
 kernel/sched/deadline.c  |  99 +++++++++++++++++++++-
 kernel/sched/debug.c     |  97 +++++++++++----------
 kernel/sched/fair.c      | 177 +++++++++++----------------------------
 kernel/sched/rt.c        | 130 +++++++++++++++++++++++++++-
 kernel/sched/stats.c     | 104 +++++++++++++++++++++++
 kernel/sched/stats.h     |  49 +++++++++++
 kernel/sched/stop_task.c |   4 +-
 9 files changed, 500 insertions(+), 193 deletions(-)

-- 
2.18.2

