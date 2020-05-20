Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02001C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 14:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A3320756
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7mZU9ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETOEY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 10:04:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbgETOEY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 10:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589983461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xTGlqq0w081BobQNfRL2NqghydaELJw3UKoGzWbyJpk=;
        b=f7mZU9nem8GE+fqjbTzU9AuKvQuXyZhtnrg8MOrGpIoqaBXwyW9k8fxtQ0bVyVraOOQbjB
        Y+DoswVj8s8pjO3qpoEqLukj6AJboxm4XpJwm/clxcHrWwR1jOJgbS0vp+QZD9csjk6KPE
        nKZSiQZ96G+CEP7R2PSMtwOZVGHJIZ4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-h7SmPQBpMOKtJ1irtGaH_g-1; Wed, 20 May 2020 10:04:19 -0400
X-MC-Unique: h7SmPQBpMOKtJ1irtGaH_g-1
Received: by mail-wr1-f70.google.com with SMTP id h12so1440230wrr.19
        for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2020 07:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTGlqq0w081BobQNfRL2NqghydaELJw3UKoGzWbyJpk=;
        b=WmT1gp+oOItOWQynEHyXKqUUz3/cv3cN981PvzMUK+IMVx6Pt3mGVSh5/wg63lTtKc
         BngVAXwP1NrALCDc8FXwrbdc+n/RQfUlKqW1ejlcQ4bQVzVfpwvGkDKk1cn3UdjEmbzy
         ulFVzucDcmwEo84GU5srBd96iA9v1uquiLn1I0oYV/jCxtXacSWygfaIFSY7eRg14Chq
         pABph0zJuqd0dz5w/2gWPcDLLNQb9p+oOcQqkjxaYRnPrnEgHsoWRvb3ipAf02uK8w/f
         blMhITyN5WJ554Ug2yx06sMxhv7t4jA+Dvn01FjnipjuYy5RCBwU+/Udua8YTY4+DFgb
         2lUQ==
X-Gm-Message-State: AOAM53221amci+gS1dafDC8MYDQNdv1uktFjsLPlqwDHruHg5oZ2bewA
        +k0Uz9VbYe3dGHXRAQIYnT12V43lydND63PwIn/Z05o1n6kcStJU6iBiJk4kAqjvQDnUbqDfS4B
        684JuIPr/rntIgwhCuiJasT+4MRw=
X-Received: by 2002:adf:82ab:: with SMTP id 40mr1435268wrc.85.1589983458488;
        Wed, 20 May 2020 07:04:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu0MqZibcZwm0TugA9lSrlYHRFVkt44fdqu7Gy6ljrDMmGQ6iF6IJ+Tw+6grygO2EOUDDaFA==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr1435250wrc.85.1589983458178;
        Wed, 20 May 2020 07:04:18 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id q4sm3293174wma.9.2020.05.20.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:04:17 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep is cleared
Date:   Wed, 20 May 2020 16:04:02 +0200
Message-Id: <20200520140402.358880-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After tasks enter or leave a runqueue (wakeup/block) SCHED full_nohz
dependency is checked (via sched_update_tick_dependency()). In case tick
can be stopped on a CPU (see sched_can_stop_tick() for details), SCHED
dependency for such CPU is cleared. However, this new information is not
used right away to actually stop the tick.

In CONFIG_PREEMPT systems booted with threadirqs option, sched clock
tick is serviced by an actual task (ksoftirqd corresponding to the CPU
where tick timer fired). So, in case a CPU was running a single task,
servicing the timer involves exiting full nozh mode. Problem at this
point is that we might lose chances to enter back into full nozh mode,
since info about ksoftirqd thread going back to sleep is not used (as
mentioned above).

Fix it by calling tick_nozh_full_update_tick(_cpu)() right after SCHED
dependency is cleared, so that tick can be promptly stopped.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

I noticed what seems to be the problem described in the changelog while
running sysjitter [1] on a PREEMPT system setup for isolation and full
nozh, i.e. ... skew_tick=1 nohz=on nohz_full=4-35 rcu_nocbs=4-35
threadirqs (36 CPUs box).

Starting sysjitter with something like the following

perf stat -C 4-35 -e irq_vectors:local_timer_entry taskset \
--cpu-list 4-35 ./sysjitter/sysjitter --runtime 30 200

with vanilla kernel was returning ~5k local_timer_entry events, while
that number goes down to ~100 or so with the proposed patch applied.

The following trace snippet also highlight the problematic situation:

...
ksoftirqd/19-125   [019]   170.700754: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.700755: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.700756: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.700757: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.700759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
   sysjitter-2459  [019]   170.701740: local_timer_entry:    vector=236
   sysjitter-2459  [019]   170.701742: softirq_raise:        vec=1 [action=TIMER]
   sysjitter-2459  [019]   170.701743: softirq_raise:        vec=7 [action=SCHED]
   sysjitter-2459  [019]   170.701744: local_timer_exit:     vector=236
   sysjitter-2459  [019]   170.701747: sched_wakeup:         ksoftirqd/19:125 [120] success=1 CPU:019
   sysjitter-2459  [019]   170.701748: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.701749: irq_work_entry:       vector=246
   sysjitter-2459  [019]   170.701750: irq_work_exit:        vector=246
   sysjitter-2459  [019]   170.701751: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.701753: sched_switch:         sysjitter:2459 [120] R ==> ksoftirqd/19:125 [120]
ksoftirqd/19-125   [019]   170.701754: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.701756: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.701756: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.701758: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.701759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
   sysjitter-2459  [019]   170.702740: local_timer_entry:    vector=236
   sysjitter-2459  [019]   170.702742: softirq_raise:        vec=1 [action=TIMER]
   sysjitter-2459  [019]   170.702743: softirq_raise:        vec=7 [action=SCHED]
   sysjitter-2459  [019]   170.702744: local_timer_exit:     vector=236
   sysjitter-2459  [019]   170.702747: sched_wakeup:         ksoftirqd/19:125 [120] success=1 CPU:019
   sysjitter-2459  [019]   170.702748: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.702749: irq_work_entry:       vector=246
   sysjitter-2459  [019]   170.702750: irq_work_exit:        vector=246
   sysjitter-2459  [019]   170.702751: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.702753: sched_switch:         sysjitter:2459 [120] R ==> ksoftirqd/19:125 [120]
ksoftirqd/19-125   [019]   170.702755: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.702756: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.702757: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.702758: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.702760: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
   sysjitter-2459  [019]   170.703740: local_timer_entry:    vector=236
   sysjitter-2459  [019]   170.703742: softirq_raise:        vec=1 [action=TIMER]
   sysjitter-2459  [019]   170.703743: softirq_raise:        vec=7 [action=SCHED]
   sysjitter-2459  [019]   170.703745: local_timer_exit:     vector=236
   sysjitter-2459  [019]   170.703747: sched_wakeup:         ksoftirqd/19:125 [120] success=1 CPU:019
   sysjitter-2459  [019]   170.703748: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.703749: irq_work_entry:       vector=246
   sysjitter-2459  [019]   170.703750: irq_work_exit:        vector=246
   sysjitter-2459  [019]   170.703751: tick_stop:            success=0 dependency=SCHED
   sysjitter-2459  [019]   170.703753: sched_switch:         sysjitter:2459 [120] R ==> ksoftirqd/19:125 [120]
ksoftirqd/19-125   [019]   170.703755: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.703756: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/19-125   [019]   170.703757: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.703758: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/19-125   [019]   170.703759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
   sysjitter-2459  [019]   170.704500: call_function_single_entry: vector=251
   sysjitter-2459  [019]   170.704502: call_function_single_exit: vector=251
   sysjitter-2459  [019]   170.704504: tick_stop:            success=1 dependency=NONE
...

Luckily sometimes it happens (like in the above) that an interrupt fires
on a CPU while ksoftirqd is not executing, SCHED dep is seen as cleared
and the CPU enters full nohz. I've however observed pathological cases
where CPUs aren't able to enter back full nohz for a long time.

Hope my understanding is correct. Please find below a naive attempt to
fix the problem. I'm pretty sure I'm missing details, e.g. I'm not sure
it is safe to possibly stop the tick remotely. Consider the following as
not more than another way of pointing the problem out. :-)

Best,

Juri

1 - https://github.com/alexeiz/sysjitter
---
 kernel/time/tick-sched.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..0d696e55d774 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -342,11 +342,16 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_cpu);
 
+static void tick_nohz_full_update_tick_cpu(struct tick_sched *ts, int cpu);
+
 void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 {
 	struct tick_sched *ts = per_cpu_ptr(&tick_cpu_sched, cpu);
 
 	atomic_andnot(BIT(bit), &ts->tick_dep_mask);
+
+	if (!in_irq())
+		tick_nohz_full_update_tick_cpu(ts, cpu);
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
@@ -870,11 +875,9 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void tick_nohz_full_update_tick_cpu(struct tick_sched *ts, int cpu)
 {
 #ifdef CONFIG_NO_HZ_FULL
-	int cpu = smp_processor_id();
-
 	if (!tick_nohz_full_cpu(cpu))
 		return;
 
@@ -888,6 +891,15 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 #endif
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
+#ifdef CONFIG_NO_HZ_FULL
+	int cpu = smp_processor_id();
+
+	tick_nohz_full_update_tick_cpu(ts, cpu);
+#endif
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
-- 
2.25.3

