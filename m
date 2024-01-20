Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC819E;
	Sat, 20 Jan 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711066; cv=none; b=IkBJIy1H7caXNbOx3yecbZyj37vpDbZrpZVKgDhtTXWNqfOvUqYi58ahDn4jTrUt8vckAJv9TOENZMfEBRkgkI4kfaI38oKf0kDUxZINE8uBuw8DNb69AgzNCAJoTS3rHdKRqPHHE7CZpB2eT8BDNlcZFxK26ccRfY0CEj8wUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711066; c=relaxed/simple;
	bh=oETj7TBYW76shr/ODVtWAlUsvo7c40r2ZvJHufnjU/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX+SPCImOIoXllh3nfvno2C2eq1qE/Jk1z2JekoW0ZsIWXcarRFECMP5fzvaxec66/EeNmGLE7wm3Z7v5S6YP7GaZOxPUZBgV+VZLhTQr/TiBgDkn2FU1AALh0GlV933bMgPWxsZZzUMZVKiid9BJAib3c9qlY/xk6vTYlJiG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8TH4M8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8TH4M8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03AFC433F1;
	Sat, 20 Jan 2024 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705711065;
	bh=oETj7TBYW76shr/ODVtWAlUsvo7c40r2ZvJHufnjU/I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b8TH4M8ONznFDW6/Ft9JAqaUMhsKhz+vnWhPL1tKAUuVV3rHcNvPm1RnsfW1ezHa+
	 A+EAHoFqh9z6Zo2T4r61nx04Hn2BSGAJ2tU0Lk4oOWhP/fUA1HZXLR+ray7CZZXv+x
	 CSIxFsufL+5rLstJ416wH5Yeaf8vTSc/MTFJ1LFadgYsBAIGEu2dcOkrHgI6qn9cWN
	 ckCvdrLpuUzEN25vQfTeLcQfSA5gn3o+258oU8knHyy/9xiBN7l8QAblhNw+C+S9HO
	 Df5X3EYCL0m94FUzfQuelcoFRC+bAFw+/SFiQQwZfN5Bk8zg4kmXhPSMSkuYINdYJd
	 j4vaw/RNEt3ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 25ABECE0ACF; Fri, 19 Jan 2024 16:37:45 -0800 (PST)
Date: Fri, 19 Jan 2024 16:37:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Leon Woestenberg <leon@sidebranch.com>, linux-rt-users@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: Unexpected rcuc osnoise on PREEMPT_RT with "rcu_nocbs=all
 rcu_nocb_poll"
Message-ID: <24c8a28f-b87d-4953-bf09-2158597fc0c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAMjhiJj0PnBrZdujKWnF43TmLB37L-bfs99nyDi+j2p+Nv1enQ@mail.gmail.com>
 <Zary17RaLN1hS63H@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zary17RaLN1hS63H@pavilion.home>

On Fri, Jan 19, 2024 at 11:08:23PM +0100, Frederic Weisbecker wrote:
> Le Fri, Jan 19, 2024 at 04:38:23PM +0100, Leon Woestenberg a écrit :
> > Hello all,
> > 
> > On 6.1.71-rt21 (PREEMPT_RT against vanilla) I am trying to find the
> > root cause of an "rcuc" thread scheduled in on an isolated core (CPU
> > #4).
> > The isolated core should run a single non-kernel user-space-busy-loop
> > thread (SCHED_OTHER, not FIFO or RR).
> > 
> > tsc=reliable isolcpus=domain,managed_irq,4-7 nohz_full=4-7
> > rcu_nocbs=all rcu_nocb_poll
> > /proc/irq/*/smp_affinity and cpumasks in
> > /sys/devices/virtual/workqueue/ all show 000f or less (CPUs 0-3)
> > 
> > Using osnoise I see rcuc/4 popping up as a cause of noise, but my
> > kernel command line should prevent that, right?

Well, your choice is rcuc or ksoftirqd.  Either way, there is some per-CPU
work that must be done.  But to Frederic's later point, not very much
work.  In particular, RCU callbacks should be invoked on an rcuoc kthread.

Unless CPU 4 spends absolutely no time in the kernel, and never ever
has more than one runnable task at any given time.  And doesn't have
any other excuse to take a scheduling-clock interrupt.  Otherwise, CPU
4's rcuc kthread will burn at least a little bit of time.  The more time
CPU 4 spends in the kernel and the more time CPU 4 spends with more than
one runnable task, the more time CPU 4's rcuc kthread will burn.

> > I see this in the kernel boot log, and I wonder if this is related to my issue:
> > 
> > [    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.

This simply means that the processing that would have been done in
softirq (for example, by ksoftirqd) will now be done by rcuc.

> > tree.c:102:static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);
> > 
> > Could this cause the rcuc threads to become active, even with the
> > "rcu_nocbs=all rcu_nocb_poll" setting?

You can override this with rcutree.use_softirq=1 if you wish.  But that
will simply move the processing from the rcuc kthread to softirq context.

> That's unexpected. The RCU load should be moved from rcuc to rcuo* kthreads.
> 
> Do you have CONFIG_RCU_STRICT_GRACE_PERIOD=y perhaps?
> 
> Also do you really need rcu_nocb_poll? I would expect this option to be useful
> for debugging only, though I'm not aware of every usecases.

I have the same questions.  ;-)

							Thanx, Paul

> Thanks.
> 
> > 
> > 
> > Thanks, Leon.
> > 
> > 
> > [    0.063516] rcu: Preemptible hierarchical RCU implementation.
> > [    0.063517] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
> > [    0.063518] rcu:     RCU priority boosting: priority 1 delay 500 ms.
> > [    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.
> > [    0.063519]     No expedited grace period (rcu_normal_after_boot).
> > [    0.063519]     Trampoline variant of Tasks RCU enabled.
> > [    0.063519]     Rude variant of Tasks RCU enabled.
> > [    0.063520]     Tracing variant of Tasks RCU enabled.
> > [    0.063520] rcu: RCU calculated value of scheduler-enlistment delay
> > is 25 jiffies.
> > [    0.063521] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> > [    0.066896] NO_HZ: Full dynticks CPUs: 4-7.
> > [    0.066897] rcu:     Offload RCU callbacks from CPUs: 0-15.
> > [    0.066898] rcu:     Poll for callbacks from no-CBs CPUs.
> > [    0.066901] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> > [    1.145094] rcu: Hierarchical SRCU implementation.
> > [    1.145094] rcu:     Max phase no-delay instances is 1000.
> > 
> > 
> > --
> > Leon Woestenberg
> > leon@sidebranch.com
> > T: +31 40 711 42 76
> > M: +31 6 472 30 372
> > 
> > Sidebranch Embedded Systems
> > Eindhoven, The Netherlands
> > http://www.sidebranch.com
> > 
