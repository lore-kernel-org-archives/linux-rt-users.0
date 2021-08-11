Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41868C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DB260E9B
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 13:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhHKNxH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhHKNxH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Aug 2021 09:53:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742AC0613D3;
        Wed, 11 Aug 2021 06:52:43 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:52:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628689961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+po5gf8jHuASk+gb5PucRf3XYpq18Ok7HBa/bnQhWQM=;
        b=2HglHNwaUUhmNVUTvzPYQ/S+NvEwKJuoPDFw9Or37fsK/V6udr6eLIKg3fN+sS2ha9VrW+
        2boTkp9n1w1Jb+APHNNzMi15c6duPdoFZKm57G4McORl/pwauMvuTHdxA1W1kD+/FN2nVn
        yfRMFKT2ilLxaRrG0caiiwSmvtYS5Qz7z434WmBpgxU+T8TbHfYHu1jN6qkaaoBLcVJLGB
        BZyR4x/r879ylIkj7pnzlmAv09B23MbqbqOMItN9BJxY1LTDBNV4q6EL+UAh2YSdAk3gve
        P+tewzZH6mFomfYh7mDWDkivC532UeyCKkF0Yo4AK6YtpjFzMm4akTxgzHseUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628689961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+po5gf8jHuASk+gb5PucRf3XYpq18Ok7HBa/bnQhWQM=;
        b=Xx5wSLiKXE2OrzlMXbw2FcA5zw00ITFVrg7yD2MJv0/s9pVo060Iz1/U5ULTc8iKEK4zcn
        J0mSysJgmZ0ANRCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] cpu_pm: Make notifier chain use a raw spinlock
Message-ID: <20210811135240.7zyywd47lpttuuj4@linutronix.de>
References: <20210811131405.1731576-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210811131405.1731576-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-11 14:14:05 [+0100], Valentin Schneider wrote:
> Booting a recent PREEMPT_RT kernel (v5.14-rc5-rt8 with the previous versi=
on
> of this fix reverted) on my arm4 Juno leads to the idle task blocking on a
> sleeping spinlock down some notifier path:
>=20
> [    5.163034] BUG: sleeping function called from invalid context at kern=
el/locking/spinlock_rt.c:35
> [    5.163042] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0=
, name: swapper/1
> [    5.163049] 1 lock held by swapper/1/0:
> [    5.163053] #0: ffff8000120950e8 (cpu_pm_notifier_chain.lock){+.+.}-{2=
:2}, at: atomic_notifier_call_chain_robust (kernel/notifier.c:186)
> [    5.163133] Preemption disabled at:
> [    5.163136] rt_mutex_slowunlock (kernel/locking/rtmutex.c:1242)
> [    5.163148] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-rc5-rt8-0=
0001-ga7cd9160688d #202
> [    5.163158] Hardware name: ARM Juno development board (r0) (DT)
> [    5.163162] Call trace:
> [    5.163165] dump_backtrace (arch/arm64/kernel/stacktrace.c:161)
> [    5.163177] show_stack (arch/arm64/kernel/stacktrace.c:217)
> [    5.163187] dump_stack_lvl (lib/dump_stack.c:106)
> [    5.163195] dump_stack (lib/dump_stack.c:113)
> [    5.163202] ___might_sleep (kernel/sched/core.c:9286)
> [    5.163210] rt_spin_lock (kernel/locking/rtmutex.c:1668 (discriminator=
 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlo=
ck_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator=
 4))
> [    5.163216] atomic_notifier_call_chain_robust (kernel/notifier.c:186)
> [    5.163225] cpu_pm_notify_robust (kernel/cpu_pm.c:39)
> [    5.163233] cpu_pm_enter (kernel/cpu_pm.c:94)
> [    5.163239] psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:53 d=
rivers/cpuidle/cpuidle-psci.c:154)
> [    5.163250] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
> [    5.163258] cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
> [    5.163266] call_cpuidle (kernel/sched/idle.c:159)
> [    5.163272] do_idle (kernel/sched/idle.c:243 kernel/sched/idle.c:306)
> [    5.163277] cpu_startup_entry (kernel/sched/idle.c:402 (discriminator =
1))
> [    5.163285] secondary_start_kernel (arch/arm64/kernel/smp.c:266)
> [    5.163294] __secondary_switched (arch/arm64/kernel/head.S:661)

I would shrink that part above. The important part is that the CPU-idle
code runs with disabled interrupts. Then cpu_pm_notify_robust() invokes
the notifier which requires to acquire the spinlock_t. On PREEMPT_RT the
spinlock_t becomes a sleeping spinlock and must not be acquired with
disabled interrupts.

> Making *all* atomic_notifiers use a raw_spinlock is too big of a hammer, =
as
> only notifications issued by the idle task are problematic.
>=20
> Special-case cpu_pm_notifier_chain by kludging a raw_notifier and
> raw_spinlock together, matching the atomic_notifier behavior with a
> raw_spinlock.
>=20
> Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
=E2=80=A6
>  kernel/cpu_pm.c | 49 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 12 deletions(-)
>=20
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index f7e1d0eccdbc..707b8ace9fc7 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
=E2=80=A6
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
> =20
> -static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
> +/*
> + * atomic_notifiers use a regular spinlock, but notifications for this c=
hain
> + * will be issued by the idle task which cannot block.

Maybe + a few details and make it more explicit

 * atomic_notifiers use a spinlock_t, but notifications for this chain
 * will be issued by the idle task with disabled interrupts which cannot
 * block on PREEMPT_RT.

?

=E2=80=A6
> @@ -33,10 +45,13 @@ static int cpu_pm_notify(enum cpu_pm_event event)
> =20
>  static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_=
event event_down)
>  {
> +	unsigned long flags;
>  	int ret;
> =20
>  	rcu_irq_enter_irqson();
> -	ret =3D atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event=
_up, event_down, NULL);

could we get rid of atomic_notifier_call_chain_robust() now that we have
zero users?

> +	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
> +	ret =3D raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up=
, event_down, NULL);
> +	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
>  	rcu_irq_exit_irqson();
> =20
>  	return notifier_to_errno(ret);

Sebastian
