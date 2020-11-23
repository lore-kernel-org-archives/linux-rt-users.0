Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C220AC6379D
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D86920781
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fkk+hIx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbgKWOOt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388656AbgKWOOs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 09:14:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AEBC0613CF;
        Mon, 23 Nov 2020 06:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9zrAJU63/joUGfOxjbmgaT8aAf1T2pusnJOhGAt7XLY=; b=Fkk+hIx1hyfr0owGcsjoxBSKPl
        DOnMuN3wSKFfabAw+VMMqZm8J1/6eBH7adLR3RZkq459UyQH4wNYuvuApujUAp4jjBTT2tmfltqIa
        M6Rv3aGmuY8veCNp3Uc4vAbUsTFaeWbERg4A4djaY8Ua+aR4+9z/yEq27ufaZcE9Zd7QV1XgTRshm
        Sxf2fuJB1+wWzdTkcSX7+j+lGDdIZW4w+5l2o2D8PEPwL7oFZEvGGuzstk+Rjn1RVIoAQd2Pa1Jtx
        Ox238LzxsKCnW7i6hJ2i8ZU944Y5lyNnGM6p8UzCHXnSvo9v5qNFcOzkT8umbJLSTOIqqZKplpCin
        mGPWAUNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCbi-0007na-0k; Mon, 23 Nov 2020 14:14:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8514306E0C;
        Mon, 23 Nov 2020 15:14:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97875201D16D7; Mon, 23 Nov 2020 15:14:16 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:14:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20201123141416.GO3021@hirez.programming.kicks-ass.net>
References: <20201122201904.30940-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122201904.30940-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Nov 22, 2020 at 08:19:04PM +0000, Valentin Schneider wrote:
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
> Two points worth noting:
> 
> 1) That this is conceptually the same issue as pointed out in:
>    313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
> 2) Only the _robust() variant of atomic_notifier callchains suffer from
>    this
> 
> AFAICT only the cpu_pm_notifier_chain really needs to be changed, but
> singling it out would mean introducing a new (truly) non-blocking API. At
> the same time, callers that are fine with any blocking within the call
> chain should use blocking notifiers, so patching up all atomic_notifier's
> doesn't seem *too* crazy to me.

How long are these notifier chains?, and all this pcs_enter_idle_state()
is still horribly broken vs RCU, witness the RCU_NONIDLE() there and the
rcu_irq_enter_irqson() in the pm_notifier code.

That said, we're running these notifiers from the idle path with IRQs
disabled, so taking that spinlock isn't going to make it worse..
