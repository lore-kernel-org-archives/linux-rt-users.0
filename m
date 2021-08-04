Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B7C4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693DC60243
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhHDKR4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:17:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235527AbhHDKRz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 06:17:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820A713A1;
        Wed,  4 Aug 2021 03:17:42 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F853F66F;
        Wed,  4 Aug 2021 03:17:40 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] rcutorture: Don't disable softirqs with preemption disabled when PREEMPT_RT
In-Reply-To: <20210803234352.GX4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain
References: <20210803225437.3612591-1-valentin.schneider@arm.com> <20210803225437.3612591-2-valentin.schneider@arm.com> <20210803234352.GX4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 04 Aug 2021 11:17:33 +0100
Message-ID: <87v94la4zm.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


+Cc Scott, Sebastian

On 03/08/21 16:43, Paul E. McKenney wrote:
> On Tue, Aug 03, 2021 at 11:54:36PM +0100, Valentin Schneider wrote:
>> Running RCU torture with CONFIG_PREEMPT_RT under v5.13-rt1 triggers:
>>
>> [   10.821700] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
>> [   10.821716] WARNING: CPU: 5 PID: 137 at kernel/softirq.c:173 __local_bh_disable_ip (kernel/softirq.c:173 (discriminator 31))
>> [   10.821739] Modules linked in:
>> [   10.821749] CPU: 5 PID: 137 Comm: rcu_torture_rea Not tainted 5.13.0-rt1-00005-g08bbda29766a #129
>> [   10.821759] Hardware name: ARM Juno development board (r0) (DT)
>> [   10.821765] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>> [   10.821938] Call trace:
>> [   10.821941] __local_bh_disable_ip (kernel/softirq.c:173 (discriminator 31))
>> [   10.821950] rcutorture_one_extend (./include/linux/rcupdate.h:274 ./include/linux/rcupdate.h:737 kernel/rcu/rcutorture.c:1443)
>> [   10.821960] rcu_torture_one_read (kernel/rcu/rcutorture.c:1590 kernel/rcu/rcutorture.c:1638)
>> [   10.821968] rcu_torture_reader (kernel/rcu/rcutorture.c:1730)
>> [   10.821976] kthread (kernel/kthread.c:321)
>> [   10.821986] ret_from_fork (arch/arm64/kernel/entry.S:1005)
>> [   10.821997] irq event stamp: 478635
>> [   10.822001] hardirqs last enabled at (478635): _raw_spin_unlock_irq (./arch/arm64/include/asm/irqflags.h:35 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:202)
>> [   10.822016] hardirqs last disabled at (478634): __schedule (kernel/sched/core.c:5154 (discriminator 1))
>> [   10.822029] softirqs last enabled at (478626): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:262)
>> [   10.822040] softirqs last disabled at (478622): rcutorture_one_extend (./include/linux/bottom_half.h:19 kernel/rcu/rcutorture.c:1441)
>>
>> Per this warning, softirqs cannot be disabled in a non-preemptible region
>> under CONFIG_PREEMPT_RT. Adjust RCU torture accordingly.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/rcu/rcutorture.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 6096a7d14342..680f66b65f14 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -1537,6 +1537,8 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
>>       * them on non-RT.
>>       */
>>      if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>
> This depends on some rcutorture patches in -rt that are not yet in
> -rcu.  Would -rt be a good place for this one, or are those patches
> now ready for -rcu?
>

Right, this goes along with

  72d6f4f680bf ("rcutorture: Avoid problematic critical section nesting on RT")

(from v5.13-rt1), which seems to apply cleanly on top of the current
mainline. So if we want this to go straight into -rcu, the above needs to
go along with it.

Thomas et al, any objections?

>                                                       Thanx, Paul
>
>> +		/* Can't disable bh in atomic context under PREEMPT_RT */
>> +		mask &= ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);
>>              /*
>>               * Can't release the outermost rcu lock in an irq disabled
>>               * section without preemption also being disabled, if irqs
>> --
>> 2.25.1
>>
