Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D13C64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C655C20855
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgK3KKg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 05:10:36 -0500
Received: from foss.arm.com ([217.140.110.172]:51594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbgK3KKg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A044930E;
        Mon, 30 Nov 2020 02:09:50 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0003F23F;
        Mon, 30 Nov 2020 02:09:47 -0800 (PST)
References: <20201122201904.30940-1-valentin.schneider@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
In-reply-to: <20201122201904.30940-1-valentin.schneider@arm.com>
Date:   Mon, 30 Nov 2020 10:09:41 +0000
Message-ID: <jhj4kl7upei.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 22/11/20 20:19, Valentin Schneider wrote:
> Booting a recent PREEMPT_RT kernel (v5.10-rc3-rt7-rebase) on my arm64 Juno
> leads to the idle task blocking on an RT sleeping spinlock down some
> notifier path:
>
>   [    1.809101] BUG: scheduling while atomic: swapper/5/0/0x00000002
>   [    1.809116] Modules linked in:
>   [    1.809123] Preemption disabled at:
>   [    1.809125] secondary_start_kernel (arch/arm64/kernel/smp.c:227)
>   [    1.809146] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W         5.10.0-rc3-rt7 #168
>   [    1.809153] Hardware name: ARM Juno development board (r0) (DT)
>   [    1.809158] Call trace:
>   [    1.809160] dump_backtrace (arch/arm64/kernel/stacktrace.c:100 (discriminator 1))
>   [    1.809170] show_stack (arch/arm64/kernel/stacktrace.c:198)
>   [    1.809178] dump_stack (lib/dump_stack.c:122)
>   [    1.809188] __schedule_bug (kernel/sched/core.c:4886)
>   [    1.809197] __schedule (./arch/arm64/include/asm/preempt.h:18 kernel/sched/core.c:4913 kernel/sched/core.c:5040)
>   [    1.809204] preempt_schedule_lock (kernel/sched/core.c:5365 (discriminator 1))
>   [    1.809210] rt_spin_lock_slowlock_locked (kernel/locking/rtmutex.c:1072)
>   [    1.809217] rt_spin_lock_slowlock (kernel/locking/rtmutex.c:1110)
>   [    1.809224] rt_spin_lock (./include/linux/rcupdate.h:647 kernel/locking/rtmutex.c:1139)
>   [    1.809231] atomic_notifier_call_chain_robust (kernel/notifier.c:71 kernel/notifier.c:118 kernel/notifier.c:186)
>   [    1.809240] cpu_pm_enter (kernel/cpu_pm.c:39 kernel/cpu_pm.c:93)
>   [    1.809249] psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:52 drivers/cpuidle/cpuidle-psci.c:129)
>   [    1.809258] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
>   [    1.809267] cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
>   [    1.809275] do_idle (kernel/sched/idle.c:132 kernel/sched/idle.c:213 kernel/sched/idle.c:273)
>   [    1.809282] cpu_startup_entry (kernel/sched/idle.c:368 (discriminator 1))
>   [    1.809288] secondary_start_kernel (arch/arm64/kernel/smp.c:273)
>

FWIW, still squealing under v5.10-rc5-rt11.
