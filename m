Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58767C64E7B
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269892225B
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL/pa/uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgK0QNH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgK0QNG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 11:13:06 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECBC0613D1;
        Fri, 27 Nov 2020 08:13:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w16so4671349pga.9;
        Fri, 27 Nov 2020 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1Bdu1f8R9bBNbgeIXBGwkTBiP2EkZW/1Ka6vd1hK2g=;
        b=aL/pa/uo/iqqQe8qSpkEqEB/7dF+oov5f7krWHXnJtiA2eYt3qCKtpwImkQl78JsrS
         tnsiiHsMsmbXaB5DFneHJADpdHBtWlKsNx+mhX8Bm2uUTJhzW+2YqtMsFhYWc96648+d
         8Uv8Ml8DACTGeRaOiX8a3MEnLqqDo4s23YMu27V0AWLGvRjcrz/sz6oE4BH62GOV0lXR
         raOjtpt8VYuLJYk96ZVTpDmPaNkh7eD5zxUIVZ9b6OK8/7IS9Jm8SMYUyhZq7otBcmU4
         55BNpsMEfBV4Yl7oqaAUZMUnZMV2ClCdEUxrk0Sr5R6mdOZ6EclRqDSXmQkQZLdS82NZ
         S86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1Bdu1f8R9bBNbgeIXBGwkTBiP2EkZW/1Ka6vd1hK2g=;
        b=AOj4Pp9u1sipy38mXABesQhEskOxdCnld8tE2ar55S980++sy4Fmxry0MNxG/1FrJJ
         butZE5jEshsn0OGgTqE5g2ggo+t+IvxXCW68MTDOV6wfqmB5n4Ul1cX2mrZEy3ZiLRkA
         2TaBgaX/EH3o+l/vdDR5Ky1fhZrZ23wVvW01cc3c2dKQZFVXBJ4XCax6zNb34Pl6Z7E7
         VhJsWb9GjzQnuIadQzOAcegHeWvEZBotAN/N2+jIhjkNnPQi0zLCw94Dm/xkGsmulGDM
         1CrBr4Sdy0GrkZFFi5SKnpKV1hEpjVIngVC+r765HRZyQbdgmx+GxQGNfkc7PulissvL
         tkGA==
X-Gm-Message-State: AOAM531IgKv5TAMoLNN793RWG9gSic8jkDUTMmrAMr84FX1+zSKMwmKv
        41XY5ztAXNJgdKl8WN36YuM=
X-Google-Smtp-Source: ABdhPJyE5OPTP3TDAfhNXbNoB5H9dnI0PC73zLtinsk666NOpcSr2oWscmly1U2oSafHVVYbZmN7Dw==
X-Received: by 2002:a17:90a:c484:: with SMTP id j4mr5813490pjt.69.1606493584884;
        Fri, 27 Nov 2020 08:13:04 -0800 (PST)
Received: from localhost.localdomain ([115.192.120.179])
        by smtp.gmail.com with ESMTPSA id v126sm7992715pfb.137.2020.11.27.08.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:13:04 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qianjun.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 1/5] sched: don't include stats.h in sched.h
Date:   Sat, 28 Nov 2020 00:12:25 +0800
Message-Id: <20201127161229.19336-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201127161229.19336-1-laoar.shao@gmail.com>
References: <20201127161229.19336-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch is a preparation of the followup patches. In the followup
patches some common helpers will be defined in stats.h, and these common
helpers require some definitions in sched.h, so let's move stats.h out
of sched.h.

The source files which require stats.h include it specifically.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c      | 1 +
 kernel/sched/deadline.c  | 1 +
 kernel/sched/debug.c     | 1 +
 kernel/sched/fair.c      | 1 +
 kernel/sched/idle.c      | 1 +
 kernel/sched/rt.c        | 2 +-
 kernel/sched/sched.h     | 6 +++++-
 kernel/sched/stats.c     | 1 +
 kernel/sched/stats.h     | 2 ++
 kernel/sched/stop_task.c | 1 +
 10 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..fd76628778f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11,6 +11,7 @@
 #undef CREATE_TRACE_POINTS
 
 #include "sched.h"
+#include "stats.h"
 
 #include <linux/nospec.h>
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305dcefe..7a0124f81a4f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "stats.h"
 #include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2357921580f9..9758aa1bba1e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -7,6 +7,7 @@
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
 #include "sched.h"
+#include "stats.h"
 
 static DEFINE_SPINLOCK(sched_debug_lock);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8917d2d715ef..8ff1daa3d9bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "stats.h"
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 24d0ee26377d..95c02cbca04a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -7,6 +7,7 @@
  *        tasks which are handled in sched/fair.c )
  */
 #include "sched.h"
+#include "stats.h"
 
 #include <trace/events/power.h>
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..af772ac0f32d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -4,7 +4,7 @@
  * policies)
  */
 #include "sched.h"
-
+#include "stats.h"
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..871544bb9a38 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2,6 +2,9 @@
 /*
  * Scheduler internal types and methods:
  */
+#ifndef _KERNEL_SCHED_SCHED_H
+#define _KERNEL_SCHED_SCHED_H
+
 #include <linux/sched.h>
 
 #include <linux/sched/autogroup.h>
@@ -1538,7 +1541,6 @@ extern void flush_smp_call_function_from_idle(void);
 static inline void flush_smp_call_function_from_idle(void) { }
 #endif
 
-#include "stats.h"
 #include "autogroup.h"
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -2633,3 +2635,5 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#endif	/* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..844bd9dbfbf0 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -3,6 +3,7 @@
  * /proc/schedstat implementation
  */
 #include "sched.h"
+#include "stats.h"
 
 /*
  * Current schedstat API version.
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf83842..c23b653ffc53 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,6 +2,8 @@
 
 #ifdef CONFIG_SCHEDSTATS
 
+#include "sched.h"
+
 /*
  * Expects runqueue lock to be held for atomicity of update
  */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index ceb5b6b12561..a5d289049388 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -8,6 +8,7 @@
  * See kernel/stop_machine.c
  */
 #include "sched.h"
+#include "stats.h"
 
 #ifdef CONFIG_SMP
 static int
-- 
2.18.4

