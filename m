Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036AEC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C90A2074B
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAuEhlbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgKWM6n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgKWM6j (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 07:58:39 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60564C0613CF;
        Mon, 23 Nov 2020 04:58:37 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id m16so9048826vsl.8;
        Mon, 23 Nov 2020 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd5Mhav9UmazYcFKU1cQG/3qnylePWCgMlUJxAGwt1Q=;
        b=LAuEhlbAE9tFO6A6KYvZBVgoZiwn31I5kvLsReYwSoLo6bmInj1PEGe4Ht9uu8HrG8
         6k9ZTME2RxPvYflUoPslsgEHSU7eYjfk5Uv4j1hq4LMRr9tMO9epE92gswool2MJ/WSS
         +dlooA1Fp+qITHZAKIhH5AI749qcy4IZmM6pPF41mvxH/1rtm9P1QZ9qbxRKc55gk0AM
         StcQH9fJVS5R6gbcFBTGKKaEkST/RWTVGdopLOhPGv5VGyl0VCaLy2W7W8bRwoVE8W0v
         DIREimQ84cpihNDv9IjgxvHi6rtMbbPesfDLMhqRXOIuOWFGVkE4oG/qrRU2rzIRWjNr
         OBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd5Mhav9UmazYcFKU1cQG/3qnylePWCgMlUJxAGwt1Q=;
        b=WJ/USKWaw5HkZRvbQrXu5fSIx0AQlxFKKumatzu6jlCQLpPlU32kIjN2w7XJMFhZ/l
         JQV4Dzsxnu22KqMz/mCDIpercLq7wEufxp88Q6BclEgrVmDy6f9JEHRs/5yM7d38bf44
         WdVDg9sKl/7CZo/7WDvBgUCCZwUVBfvQltJoTieD1riyi9JGJNSFkkEsJK6y6hquD4U6
         CWDm9H0CYbKzuzWaI7zrfbxTPB3Kff8D2USs17iPuYLwXq4D20v5uTKWiIMexUuRmI6F
         Ewf/brDXv89cj9XcfwUmqBGcu8XSOH8JlkcMz+hPfdOwn/lpJQs876XLIB/nLr82DZwt
         O1Mg==
X-Gm-Message-State: AOAM532ocTTIJ84GFTlyvUxmWA1z1BtnMwJMo35iuc7+dGREEELw9AmR
        7waNXnJdLEd6BuSogjocATs=
X-Google-Smtp-Source: ABdhPJwMIlHW8Ni0cguURZELwIbQkDSLcEdQ89EhtbvpK4qFVu+v5zxkZ0aWSjI1p24c4sszuFCq/g==
X-Received: by 2002:a05:6102:73a:: with SMTP id u26mr17985938vsg.18.1606136316551;
        Mon, 23 Nov 2020 04:58:36 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id h16sm1579091uaw.7.2020.11.23.04.58.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:58:35 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/5] sched: support schedstat for RT sched class 
Date:   Mon, 23 Nov 2020 20:58:03 +0800
Message-Id: <20201123125808.50896-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstat facility, but currently schedstat is only
supported for fair sched class. This patchset enable it for RT sched class
as well.

The schedstat statistics are defined in struct sched_entity, which is a
member of struct task_struct, so we can resue it for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
                fair                            RT
enqueue         update_stats_enqueue_fair       update_stats_enqueue_rt
dequeue         update_stats_dequeue_fair       update_stats_dequeue_rt
put_prev_task   update_stats_wait_start         update_stats_wait_start
set_next_task   update_stats_wait_end           update_stats_wait_end
show            /proc/[pid]/sched               /proc/[pid]/sched

The sched:sched_stats_* tracepoints can be used to trace RT tasks as
well after that patchset.

PATCH #1 ~ #4 are the preparation of PATCH #5.

- v2:
keep the schedstats functions inline, per Mel.

Yafang Shao (5):
  sched: don't include stats.h in sched.h
  sched: define task_of() as a common helper
  sched: make schedstats helper independent of cfs_rq
  sched: define update_stats_curr_start() as a common helper
  sched, rt: support schedstat for RT sched class

 kernel/sched/core.c      |   1 +
 kernel/sched/deadline.c  |   1 +
 kernel/sched/debug.c     |   1 +
 kernel/sched/fair.c      | 174 ++-------------------------------------
 kernel/sched/idle.c      |   1 +
 kernel/sched/rt.c        |  94 ++++++++++++++++++++-
 kernel/sched/sched.h     |  30 ++++++-
 kernel/sched/stats.c     |   1 +
 kernel/sched/stats.h     | 146 ++++++++++++++++++++++++++++++++
 kernel/sched/stop_task.c |   1 +
 10 files changed, 280 insertions(+), 170 deletions(-)

-- 
2.18.4

