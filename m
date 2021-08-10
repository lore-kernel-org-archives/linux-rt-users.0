Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D1C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7446F61077
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 13:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbhHJNnH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:43:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241711AbhHJNnE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 09:43:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E75106F;
        Tue, 10 Aug 2021 06:42:41 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF1143F70D;
        Tue, 10 Aug 2021 06:42:40 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
Date:   Tue, 10 Aug 2021 14:41:26 +0100
Message-Id: <20210810134127.1394269-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810134127.1394269-1-valentin.schneider@arm.com>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[    0.134518] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[    0.134520] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[    0.134522] 1 lock held by swapper/1/0:
[    0.134523] #0: ffff008f3624f728 ((lock).lock){+.+.}-{2:2}, at: get_page_from_freelist (mm/page_alloc.c:3673 mm/page_alloc.c:3704 mm/page_alloc.c:4166) 
[    0.134533] irq event stamp: 0
[    0.134534] hardirqs last enabled at (0): 0x0 
[    0.134538] hardirqs last disabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084) 
[    0.134542] softirqs last enabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084) 
[    0.134545] softirqs last disabled at (0): 0x0 
[    0.134547] Preemption disabled at:
[    0.134547] rt_mutex_slowunlock (kernel/locking/rtmutex.c:1223) 
[    0.134552] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-rc4-rt6-torture+ #56
[    0.134555] Call trace:
[    0.134556] dump_backtrace (arch/arm64/kernel/stacktrace.c:151) 
[    0.134558] show_stack (arch/arm64/kernel/stacktrace.c:217) 
[    0.134559] dump_stack_lvl (lib/dump_stack.c:106) 
[    0.134563] dump_stack (lib/dump_stack.c:113) 
[    0.134565] ___might_sleep (kernel/sched/core.c:9306) 
[    0.134567] rt_spin_lock (kernel/locking/rtmutex.c:1641 (discriminator 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlock_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator 4)) 
[    0.134569] get_page_from_freelist (mm/page_alloc.c:3673 mm/page_alloc.c:3704 mm/page_alloc.c:4166) 
[    0.134571] __alloc_pages (mm/page_alloc.c:5391) 
[    0.134573] alloc_page_interleave (mm/mempolicy.c:2119) 
[    0.134576] alloc_pages (mm/mempolicy.c:2249) 
[    0.134577] new_slab (mm/slub.c:1740 mm/slub.c:1877 mm/slub.c:1940) 
[    0.134580] ___slab_alloc (mm/slub.c:2951) 
[    0.134582] __slab_alloc.isra.0 (mm/slub.c:3038) 
[    0.134584] kmem_cache_alloc_trace (mm/slub.c:3129 mm/slub.c:3171 mm/slub.c:3188) 
[    0.134587] efi_mem_reserve_iomem (drivers/firmware/efi/efi.c:905) 
[    0.134590] efi_mem_reserve_persistent (drivers/firmware/efi/efi.c:952) 
[    0.134593] its_cpu_init (drivers/irqchip/irq-gic-v3-its.c:3074 drivers/irqchip/irq-gic-v3-its.c:5196) 
[    0.134596] gic_starting_cpu (drivers/irqchip/irq-gic.c:798) 
[    0.134599] cpuhp_invoke_callback (kernel/cpu.c:180) 
[    0.134601] cpuhp_invoke_callback_range (kernel/cpu.c:656) 
[    0.134603] notify_cpu_starting (kernel/cpu.c:1270) 
[    0.134605] secondary_start_kernel (arch/arm64/kernel/smp.c:243) 
[    0.134608] __secondary_switched (arch/arm64/kernel/head.S:661) 
