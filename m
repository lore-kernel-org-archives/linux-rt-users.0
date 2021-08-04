Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B496C432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B06056B
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhHDWh0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhHDWh0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 18:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A4C60F41;
        Wed,  4 Aug 2021 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628116632;
        bh=CZDc3cuXIwg9cgSdNmFX+JqgPpKv7JvIYL0xpPA/LpY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZKUVPraVYkfCzKNwBVmOMqZ5pvwwG1NhufBNSrcln+cpyDr3l2dafv/3GPXEfTXSH
         IrPFtutGDy3ybFQPQGqtKSQeVFLFaUQzRjwGt5Dp/cMUU+aAe0zQFj9/sRyHrBwP/Y
         eqGNkQYKfL/aT5TnPlWcRwfU9/lwcB1CGREu+t92WOLMxXQwoJZuWalbsquaI8tUKf
         29ktO/4KqXZGTEpsoyaJOSt0WGMWl5qP4k+ENCNSVWdLX36GEAGZgGyt6YYiWkylTH
         GWdv3J1o6f9F7eRBjUs0eqHfokzwd3KbGgwihKExwZpAsU0UtUWFojRj9GYjH48uSB
         J38/ArSapK0oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 950F85C22D9; Wed,  4 Aug 2021 15:37:12 -0700 (PDT)
Date:   Wed, 4 Aug 2021 15:37:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
Subject: Re: [PATCH 1/2] rcutorture: Don't disable softirqs with preemption
 disabled when PREEMPT_RT
Message-ID: <20210804223712.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803225437.3612591-1-valentin.schneider@arm.com>
 <20210803225437.3612591-2-valentin.schneider@arm.com>
 <20210803234352.GX4397@paulmck-ThinkPad-P17-Gen-1>
 <87v94la4zm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v94la4zm.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 04, 2021 at 11:17:33AM +0100, Valentin Schneider wrote:
> 
> +Cc Scott, Sebastian
> 
> On 03/08/21 16:43, Paul E. McKenney wrote:
> > On Tue, Aug 03, 2021 at 11:54:36PM +0100, Valentin Schneider wrote:
> >> Running RCU torture with CONFIG_PREEMPT_RT under v5.13-rt1 triggers:
> >>
> >> [   10.821700] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> >> [   10.821716] WARNING: CPU: 5 PID: 137 at kernel/softirq.c:173 __local_bh_disable_ip (kernel/softirq.c:173 (discriminator 31))
> >> [   10.821739] Modules linked in:
> >> [   10.821749] CPU: 5 PID: 137 Comm: rcu_torture_rea Not tainted 5.13.0-rt1-00005-g08bbda29766a #129
> >> [   10.821759] Hardware name: ARM Juno development board (r0) (DT)
> >> [   10.821765] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> >> [   10.821938] Call trace:
> >> [   10.821941] __local_bh_disable_ip (kernel/softirq.c:173 (discriminator 31))
> >> [   10.821950] rcutorture_one_extend (./include/linux/rcupdate.h:274 ./include/linux/rcupdate.h:737 kernel/rcu/rcutorture.c:1443)
> >> [   10.821960] rcu_torture_one_read (kernel/rcu/rcutorture.c:1590 kernel/rcu/rcutorture.c:1638)
> >> [   10.821968] rcu_torture_reader (kernel/rcu/rcutorture.c:1730)
> >> [   10.821976] kthread (kernel/kthread.c:321)
> >> [   10.821986] ret_from_fork (arch/arm64/kernel/entry.S:1005)
> >> [   10.821997] irq event stamp: 478635
> >> [   10.822001] hardirqs last enabled at (478635): _raw_spin_unlock_irq (./arch/arm64/include/asm/irqflags.h:35 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:202)
> >> [   10.822016] hardirqs last disabled at (478634): __schedule (kernel/sched/core.c:5154 (discriminator 1))
> >> [   10.822029] softirqs last enabled at (478626): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:262)
> >> [   10.822040] softirqs last disabled at (478622): rcutorture_one_extend (./include/linux/bottom_half.h:19 kernel/rcu/rcutorture.c:1441)
> >>
> >> Per this warning, softirqs cannot be disabled in a non-preemptible region
> >> under CONFIG_PREEMPT_RT. Adjust RCU torture accordingly.
> >>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >> ---
> >>  kernel/rcu/rcutorture.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 6096a7d14342..680f66b65f14 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -1537,6 +1537,8 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
> >>       * them on non-RT.
> >>       */
> >>      if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >
> > This depends on some rcutorture patches in -rt that are not yet in
> > -rcu.  Would -rt be a good place for this one, or are those patches
> > now ready for -rcu?
> >
> 
> Right, this goes along with
> 
>   72d6f4f680bf ("rcutorture: Avoid problematic critical section nesting on RT")
> 
> (from v5.13-rt1), which seems to apply cleanly on top of the current
> mainline. So if we want this to go straight into -rcu, the above needs to
> go along with it.

Ah, this one needs to have its changes conditioned on PREEMPT_RT.
The situations that this patch excludes really can happen in mainline,
so they still need to be tested in mainline.

It all comes back now.  ;-)

							Thanx, Paul

> Thomas et al, any objections?
> 
> >                                                       Thanx, Paul
> >
> >> +		/* Can't disable bh in atomic context under PREEMPT_RT */
> >> +		mask &= ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);
> >>              /*
> >>               * Can't release the outermost rcu lock in an irq disabled
> >>               * section without preemption also being disabled, if irqs
> >> --
> >> 2.25.1
> >>
