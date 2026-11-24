Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522113;
	b=f6GB62UiRTPPEU+jSpqTo9myjSYnaOHDvlIIHotnhRspSImZqhyvC+wS/nFndH+cuvUW
	 rTe6PKMonV8M+3Du1pwOGWQhB1RU5Fu66MVnIk4hrAh9NxNeNcaMR7Ku+YbXt5kLafG3T
	 S5okpi2fF0bAkE03W/EmhNq2NeXLf21nE7UDOTyTUbnexFILGvXUHHiL6SjC3c1VEUgue
	 Sd7AO7AfwWydPH7X2MouMbwbzuEi26PEH1wm8fwmZFFBFE/AYFqTNZzSXGW0D/FzSag4V
	 YmS44YZkrjSjAULZdWx9NY3Oow+BNtp6fzm9fvmnsswWqDVn+DYCYfmK5siyUr+DyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522113;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VqJ96x7irDA25tpkuaj/0vDZJhWuEo9c3bEZALNqSGo=;
	b=BDN4P+Isk3n5rMDQoAH8NtnBywLzDlTpgXH3623GeY9JfIybVY9XnOKzMB3YYuNQP3O0
	 HInNcz4SvdMb5PFekl941w05wdyAWMDmQZbik0IknyKnOj0CNfgHSQ6YMlqlk/y7/p6D+
	 X9VpAPK72ycJI9ROqhPiEjIdL5lGdTawyQdO3Vj0/nbNhYqFNS22wWlFuzy0kq1ZMseWa
	 254S8k4sWpfFj9KMwgfbV38gnAne0IGARhAhXCg0+5R2hJDL9NbHVOt6a4lNYJSccPyQo
	 RXv4x0e2nrzIqfmoxBLnMNuFt+cN4b3HkH1mt6cgbOS4en389z+WNIRbI5IpTuRukGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gn5MVccG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BnOOc09t;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD54606A326;
	Tue, 24 Nov 2026 12:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD54606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gn5MVccG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BnOOc09t
Date: Tue, 24 Nov 2026 13:08:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795522111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqJ96x7irDA25tpkuaj/0vDZJhWuEo9c3bEZALNqSGo=;
	b=gn5MVccGImMymK0cGWAo2vuYbwr5w2XyJbSq20Mv/pjr9t70Ey7iKWFukb/aaqa12yDTrf
	VxTHiFBFBz+LqOQqruBdbbbLlId0Izo4Ps9bx45WOmDZWkoRpgGLIqHlQQ4eT+SsxiDPsz
	MuoXxYgMIiefFRh1G/Y5mBxv6/iL+s46ogDCgrHNf50TuTZNc57/mEgcExK2HtSsWVq1pI
	KVYDM2jmbacQwGgTqrTe+WsdNii45TwlcmkkV7r4a+YXJ0RGPyWCazz/qpT04cdL8ctEBm
	FKgwokg7dfNMLkvQ45jeH/GXfDQOVCrtdEGRe9/85P6UMDj8pw0fUUlROA1L5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795522111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqJ96x7irDA25tpkuaj/0vDZJhWuEo9c3bEZALNqSGo=;
	b=BnOOc09tUwiZGYNo3KQCsEaSmxM9WTuSQkf5+SyCFWU0GdmrCWuW30ZGSVuHrUlZ9GgZou
	BsSLQorvdNLiJ+Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin King <martin3kx@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] sched/rt: push a queued task when its priority is boosted
Message-ID: <20261124120829.53F8ppqc@linutronix.de>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
 <20260814183652.611e7ecf@gandalf.local.home>
 <6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info>
 <20260903092037.5b739980@gandalf.local.home>
 <20261015061915.126442-1-chaosheng.qu.linux@gmail.com>
 <20261015084615.05957ae3@gandalf.local.home>
 <179526068763.97100.12205093734161349836@gmail.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179526068763.97100.12205093734161349836@gmail.com>

Martin, can you check if this solves your problem?

On 2026-11-21 19:31:27 [+0800], Chaosheng Qu wrote:
> A PI boost can raise a queued task above everything that is runnable on
> other CPUs while it still cannot run on its own rq, because the task
> currently running there has equal or higher priority.  prio_changed_rt()
> only calls resched_curr() in that case.  The task then waits for the
> current task to schedule out.

It only calls resched_curr() if the boosted task has a higher priority
and is not running. Then it will force a scheduling event by calling
resched_curr().

If it has a lower priority than the currently running task will remain
on CPU and the boosted will remain waiting.

> The pull side does not necessarily rescue it: pull_rt_task() only picks a
> task whose affinity includes the pulling CPU, so a task whose mask
> excludes the CPUs that just became idle is unreachable until the running
> task leaves on its own.  With RT_PUSH_IPI off this is the difference
> between a millisecond migration and a wait for the hog to finish.

While browsing through the code, the task should be added to the
pushable_tasks list once blocked. A PI-boost seems not to do anything if
it did not become highest priority on the local CPU.
A push as suggested below will try to move it to another CPU if
possible. What I don't get why does it work with RT_PUSH_IPI enabled?

This means there is a scheduling event (or something else) doing
pull_rt_task() and the IPI feature causes to iterate over all CPUs und
find the boosted task on a matching CPU.
Without RT_PUSH_IPI, it is limited to a CPU which might not to be suited
for the task (due to different affinity). Did I get it right?

> Queue a push when the priority of a queued, non-current RT task goes up.
> push_rt_task() already declines to move a task that is not pushable and
> skips the reschedule path when the task is higher priority than the
> current one, so the extra callback only acts when a migration target
> exists.
> 
> Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
> ---
> Steve,
> 
> This is the fix we discussed in October.  The case that matters is the
> queued task that the pull side cannot reach because its mask excludes the
> CPUs that just became idle.
> 
> Numbers from a 4-vCPU QEMU guest (TCG; KVM is not available here), non-RT
> kernel, RT_PUSH_IPI off.  L is FIFO 10 with mask {cpu1,cpu3}, X is FIFO 99
> hogging cpu1, W is FIFO 90 on cpu2 and blocks on L's PI mutex, R is FIFO 60
> on cpu3:
> 
>    baseline: 1/5 rescued, 802.8 / 1161.0 / 1311.8 / 30.2 / 1280.0 ms
>    patched:  5/5 rescued,  13.8 / 1.1 / 0.2 / 0.2 / 0.8 ms
> 
> The reproducer is a small static C program; I can post it if useful.
> 
>  kernel/sched/rt.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 85303add7..db93bfff7 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2499,6 +2499,19 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
>  		 */
>  		if (p->prio < rq->donor->prio)
>  			resched_curr(rq);
> +
> +		/*
> +		 * A (PI) boost can make @p the highest priority
> +		 * pushable task on this rq while it still cannot run
> +		 * here, because the running task is of equal or higher
> +		 * priority. If @p's affinity excludes the CPUs that
> +		 * become idle, the pull side cannot pick it and it may
> +		 * stay queued until the current task schedules out.
> +		 * Trigger a push for the new priority.
> +		 */
> +		if (oldprio > p->prio && p->nr_cpus_allowed > 1 &&
> +		    p->prio >= rq->donor->prio)
> +			rt_queue_push_tasks(rq);
>  	}
>  }
>  

Sebastian
