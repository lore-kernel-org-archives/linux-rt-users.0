Return-Path: <SRS0=nOM3=2G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A25C43603
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43733206E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 17:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLPReU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:34:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPReT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 12:34:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iguG8-0005iT-Dl; Mon, 16 Dec 2019 18:34:16 +0100
Date:   Mon, 16 Dec 2019 18:34:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.21-rt15
Message-ID: <20191216173416.2dcmfis4xza2dqf5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.21-rt15 patch set. 

Changes since v5.2.21-rt14:

  - Since the migrate_disable() rework, the kernel did not build on UP
    or without RT enabled. Patch by Daniel Wagner.

  - Since the migrate_disable() rework, with heave changing of the
    task's affinity mask the kernel could issue a warning in
    migrate_enable() and crash later.

Known issues
     - None

The delta patch against v5.2.21-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.21-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.21-rt15

The RT patch against v5.2.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.21-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.21-rt15.tar.xz

Sebastian

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef9621815f37e..ab04f5c48787d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7399,7 +7399,7 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { p };
+		struct migration_arg arg = { .task = p };
 		struct cpu_stop_work work;
 		struct rq_flags rf;
 
@@ -7411,7 +7411,10 @@ void migrate_enable(void)
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &arg, &work);
 		__schedule(true);
-		WARN_ON_ONCE(!arg.done && !work.disabled);
+		if (!work.disabled) {
+			while (!arg.done)
+				cpu_relax();
+		}
 	}
 
 out:
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 5f2618d346c42..c2f5b0f8cacd0 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,8 +23,10 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+#if defined(CONFIG_PREEMPT_RT_BASE) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
 	if (current->migrate_disable)
 		goto out;
+#endif
 
 	if (current->nr_cpus_allowed == 1)
 		goto out;
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
