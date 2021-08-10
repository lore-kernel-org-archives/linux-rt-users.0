Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2483BC43214
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8D161077
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhHJNnG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:43:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241574AbhHJNnC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 09:43:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798BB1063;
        Tue, 10 Aug 2021 06:42:40 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42FA13F70D;
        Tue, 10 Aug 2021 06:42:39 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
Date:   Tue, 10 Aug 2021 14:41:25 +0100
Message-Id: <20210810134127.1394269-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810134127.1394269-1-valentin.schneider@arm.com>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[    4.172817] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[    4.172820] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 19, name: cpuhp/0
[    4.172822] 3 locks held by cpuhp/0/19:
[    4.172824] #0: ffff800011cf8690 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun (kernel/cpu.c:739) 
[    4.172833] #1: ffff800011cf86e0 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun (kernel/cpu.c:739) 
[    4.172838] #2: ffff008f36237c08 (&(&c->lock)->lock){+.+.}-{0:0}, at: ___slab_alloc (mm/slub.c:2872) 
[    4.172844] irq event stamp: 40
[    4.172845] hardirqs last enabled at (39): finish_task_switch (./arch/arm64/include/asm/irqflags.h:35 kernel/sched/sched.h:1319 kernel/sched/core.c:4531 kernel/sched/core.c:4649) 
[    4.172849] hardirqs last disabled at (40): cpuhp_thread_fun (kernel/cpu.c:761 (discriminator 1)) 
[    4.172851] softirqs last enabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084) 
[    4.172855] softirqs last disabled at (0): 0x0 
[    4.172860] CPU: 0 PID: 19 Comm: cpuhp/0 Tainted: G        W         5.14.0-rc4-rt6-torture+ #56
[    4.172863] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
[    4.172864] Call trace:
[    4.172865] dump_backtrace (arch/arm64/kernel/stacktrace.c:151) 
[    4.172867] show_stack (arch/arm64/kernel/stacktrace.c:217) 
[    4.172869] dump_stack_lvl (lib/dump_stack.c:106) 
[    4.172872] dump_stack (lib/dump_stack.c:113) 
[    4.172874] ___might_sleep (kernel/sched/core.c:9306) 
[    4.172877] rt_spin_lock (kernel/locking/rtmutex.c:1641 (discriminator 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlock_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator 4)) 
[    4.172879] ___slab_alloc (mm/slub.c:2872) 
[    4.172882] __slab_alloc.isra.0 (mm/slub.c:3038) 
[    4.172884] kmem_cache_alloc_trace (mm/slub.c:3129 mm/slub.c:3171 mm/slub.c:3188) 
[    4.172886] __armpmu_alloc (./include/linux/slab.h:591 ./include/linux/slab.h:721 drivers/perf/arm_pmu.c:869) 
[    4.172889] armpmu_alloc_atomic (drivers/perf/arm_pmu.c:927) 
[    4.172891] arm_pmu_acpi_cpu_starting (drivers/perf/arm_pmu_acpi.c:202 drivers/perf/arm_pmu_acpi.c:264) 
[    4.172893] cpuhp_invoke_callback (kernel/cpu.c:180) 
[    4.172895] cpuhp_thread_fun (kernel/cpu.c:762 (discriminator 3)) 
[    4.172896] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3)) 
[    4.172900] kthread (kernel/kthread.c:327) 
[    4.172902] ret_from_fork (arch/arm64/kernel/entry.S:783) 
