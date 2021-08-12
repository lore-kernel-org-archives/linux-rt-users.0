Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75543C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF2460FBF
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhHLQr4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhHLQr4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 12:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD47B601FC;
        Thu, 12 Aug 2021 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628786850;
        bh=2N1nI+s5Reqp2IK7LI9Kb/ESk8nA0JDpiWnGhXfewBI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EFN/PywHNDOyOchEdkLc1zkXpBLySyDGMH7rU21WUMG1WTahK9RqI6MtYJVpD3g1e
         RQRQbozWRCirmFkzJfk+ZLOgXXVilwa5YQURYUpuAy+/ANwCK3f5h+j2xqKID7ssby
         YjQiFHN32RSXQJYo+97c1ajrcplEoQUP1zf76POeCGJot6ldKQNWZ4/ndGaodxbSLq
         QkdbK7kBQeOBKsWqyUQovjHMf4UN4/nZId/5DqaItcP+0v7RvTpM1liNHnA0c6rBVW
         GZnLLkYPclneWfIhpCUXQmd4lvfPGsQQ3GsMMksSk06Q7aX8cY+N5B77Y56i36iNcw
         0SPD87yJInLNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C8C55C0355; Thu, 12 Aug 2021 09:47:30 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:47:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 1/4] rcutorture: Don't disable softirqs with
 preemption disabled when PREEMPT_RT
Message-ID: <20210812164730.GX4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811201354.1976839-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 11, 2021 at 09:13:51PM +0100, Valentin Schneider wrote:
> Running RCU torture with CONFIG_PREEMPT_RT under v5.14-rc4-rt6 triggers:
> 
> [    8.755472] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> [    8.755482] WARNING: CPU: 1 PID: 137 at kernel/softirq.c:172 __local_bh_disable_ip (kernel/softirq.c:172 (discriminator 31))
> [    8.755500] Modules linked in:
> [    8.755506] CPU: 1 PID: 137 Comm: rcu_torture_rea Not tainted 5.14.0-rc4-rt6 #171
> [    8.755514] Hardware name: ARM Juno development board (r0) (DT)
> [    8.755518] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [    8.755622] Call trace:
> [    8.755624] __local_bh_disable_ip (kernel/softirq.c:172 (discriminator 31))
> [    8.755633] rcutorture_one_extend (kernel/rcu/rcutorture.c:1453)
> [    8.755640] rcu_torture_one_read (kernel/rcu/rcutorture.c:1601 kernel/rcu/rcutorture.c:1645)
> [    8.755645] rcu_torture_reader (kernel/rcu/rcutorture.c:1737)
> [    8.755650] kthread (kernel/kthread.c:327)
> [    8.755656] ret_from_fork (arch/arm64/kernel/entry.S:783)
> [    8.755663] irq event stamp: 11959
> [    8.755666] hardirqs last enabled at (11959): __rcu_read_unlock (kernel/rcu/tree_plugin.h:695 kernel/rcu/tree_plugin.h:451)
> [    8.755675] hardirqs last disabled at (11958): __rcu_read_unlock (kernel/rcu/tree_plugin.h:661 kernel/rcu/tree_plugin.h:451)
> [    8.755683] softirqs last enabled at (11950): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:261)
> [    8.755692] softirqs last disabled at (11942): rcutorture_one_extend (./include/linux/bottom_half.h:19 kernel/rcu/rcutorture.c:1441)
> 
> Per this warning, softirqs cannot be disabled in a non-preemptible region
> under CONFIG_PREEMPT_RT. Adjust RCU torture accordingly.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Looks sensible for -rt, but of course does not apply on mainline or -rcu.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index eecd1caef71d..4f3db1d3170d 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1548,6 +1548,8 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
>  	 * them on non-RT.
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/* Can't disable bh in atomic context under PREEMPT_RT */
> +		mask &= ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);
>  		/*
>  		 * Can't release the outermost rcu lock in an irq disabled
>  		 * section without preemption also being disabled, if irqs
> -- 
> 2.25.1
> 
