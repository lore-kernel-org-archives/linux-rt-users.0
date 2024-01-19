Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3054BDA;
	Fri, 19 Jan 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705702107; cv=none; b=lNMUUj8aFPvjOa29MwF06zXGry8khOGK/E2Ea5V+CVIDaGbwvFHGLcCkocVJ9RyroRy7To8HUVvnws9oUXJcinGYXVOMjozcF6d8m5gZQ2Ei4CsuFQDNRHiSmGIVR0TwwzNnrP2CwZ+1JvyoGhVBu4KtpzNpekW4AqmtWn5MNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705702107; c=relaxed/simple;
	bh=fKfO9qo8wSkTzAGTv3G0A2yVzOzKvZSXfBvuQwGhhYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaygpkSkarV8GYfCiqG7x/arGdNQWOaOtYDeteCHflunH69HJXf4MR9SaqhrwAuqbXjFCrTZCmz78Q/Qu+NESZBs69sgn2tmxuTTBtQaYIbZgC8qYPMBsezjQbUm+MPkbXrBgUP5YIhs+V9Jh0DScUUTKmXFKhKza1QknHJjdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=funbvqly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="funbvqly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F985C433C7;
	Fri, 19 Jan 2024 22:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705702107;
	bh=fKfO9qo8wSkTzAGTv3G0A2yVzOzKvZSXfBvuQwGhhYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=funbvqlyOs5x/vAaRpLmLYDRFPU3g+mqYJGhmfGe/Kr+r76EjklkuixdMRYPEOxP2
	 m+CkkRp4pvD1kjsI5MyGO6GpI8TjWB0npqhsvqDoaoxJC5puietVHnBKFKhuT7nJkb
	 yyKbfst2F+gD4bQclO/B6U4nv1O1s4CcnPdM8z7VE0u1BO410qESOh2T0wKos38Nre
	 RaCvwmn6ZJJiPE6rZF+Msa09pvUHqAArtVR1MSNqW09IAEl5USCbl1GUjbqSlaub+x
	 YJpne5DUIW8XZuoYJB4Fu6yhHaqDS4ay8ufq1OSDSzxu2uOGigqkDh9LT7eS+fgOPL
	 ilyZDfBvdPk4Q==
Date: Fri, 19 Jan 2024 23:08:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Subject: Re: Unexpected rcuc osnoise on PREEMPT_RT with "rcu_nocbs=all
 rcu_nocb_poll"
Message-ID: <Zary17RaLN1hS63H@pavilion.home>
References: <CAMjhiJj0PnBrZdujKWnF43TmLB37L-bfs99nyDi+j2p+Nv1enQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMjhiJj0PnBrZdujKWnF43TmLB37L-bfs99nyDi+j2p+Nv1enQ@mail.gmail.com>

Le Fri, Jan 19, 2024 at 04:38:23PM +0100, Leon Woestenberg a écrit :
> Hello all,
> 
> On 6.1.71-rt21 (PREEMPT_RT against vanilla) I am trying to find the
> root cause of an "rcuc" thread scheduled in on an isolated core (CPU
> #4).
> The isolated core should run a single non-kernel user-space-busy-loop
> thread (SCHED_OTHER, not FIFO or RR).
> 
> tsc=reliable isolcpus=domain,managed_irq,4-7 nohz_full=4-7
> rcu_nocbs=all rcu_nocb_poll
> /proc/irq/*/smp_affinity and cpumasks in
> /sys/devices/virtual/workqueue/ all show 000f or less (CPUs 0-3)
> 
> Using osnoise I see rcuc/4 popping up as a cause of noise, but my
> kernel command line should prevent that, right?
> 
> I see this in the kernel boot log, and I wonder if this is related to my issue:
> 
> [    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.
> 
> tree.c:102:static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);
> 
> Could this cause the rcuc threads to become active, even with the
> "rcu_nocbs=all rcu_nocb_poll" setting?

That's unexpected. The RCU load should be moved from rcuc to rcuo* kthreads.

Do you have CONFIG_RCU_STRICT_GRACE_PERIOD=y perhaps?

Also do you really need rcu_nocb_poll? I would expect this option to be useful
for debugging only, though I'm not aware of every usecases.

Thanks.

> 
> 
> Thanks, Leon.
> 
> 
> [    0.063516] rcu: Preemptible hierarchical RCU implementation.
> [    0.063517] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
> [    0.063518] rcu:     RCU priority boosting: priority 1 delay 500 ms.
> [    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.
> [    0.063519]     No expedited grace period (rcu_normal_after_boot).
> [    0.063519]     Trampoline variant of Tasks RCU enabled.
> [    0.063519]     Rude variant of Tasks RCU enabled.
> [    0.063520]     Tracing variant of Tasks RCU enabled.
> [    0.063520] rcu: RCU calculated value of scheduler-enlistment delay
> is 25 jiffies.
> [    0.063521] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.066896] NO_HZ: Full dynticks CPUs: 4-7.
> [    0.066897] rcu:     Offload RCU callbacks from CPUs: 0-15.
> [    0.066898] rcu:     Poll for callbacks from no-CBs CPUs.
> [    0.066901] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    1.145094] rcu: Hierarchical SRCU implementation.
> [    1.145094] rcu:     Max phase no-delay instances is 1000.
> 
> 
> --
> Leon Woestenberg
> leon@sidebranch.com
> T: +31 40 711 42 76
> M: +31 6 472 30 372
> 
> Sidebranch Embedded Systems
> Eindhoven, The Netherlands
> http://www.sidebranch.com
> 
