Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894948AE1B;
	Thu, 15 Oct 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068382; cv=none; b=YGRqDnifdP3Qd+kVYLEY9Nu0wmDn73agQ7SBqCQw69tdG4COpX6A4CMfKq0kJJJlwFXcOaNQiLcpKDoXTiXOuyrAj8qR73hTQORFlhmAGu3g//MNxdRTq2UUxsnhn3fs7XqbfAlNNP2+Fx1hXq60QzFbcMTWhhWQL9V6DbBAObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068382; c=relaxed/simple;
	bh=LmZj+cC1ScqNFr3kUxGb4ZPdNER21XB4Pj5cAJCc3Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEfZ6xmS7vuabzgRaK9bG7AxU8ib/O4Ndw3ayOjBRK7dh8h0shvOcUBDjw/weIwsVLaHkYQbAmcTcBwVgjk8iXSZRC0n+ba1ZuSDoJy5eNQnphJJX1npVSClcETes1fWxC/tXletSQrvK3KhOORLHEx3Tb89H3cTUpdKhamE2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=4LSFMqvt; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="4LSFMqvt"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C27AE409AF;
	Thu, 15 Oct 2026 12:46:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C31A18000F;
	Thu, 15 Oct 2026 12:46:16 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:46:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: Martin King <martin3kx@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION] sched/rt: NO_RT_PUSH_IPI causes multi-second
 PI-boost starvation in pro-audio workloads (dd29c017aed6)
Message-ID: <20261015084615.05957ae3@gandalf.local.home>
In-Reply-To: <20261015061915.126442-1-chaosheng.qu.linux@gmail.com>
References: <CAEB5A_91hob8ddOhW=PrO1=O7GrFmSxY3r1-_Ard6x8KHHuJGA@mail.gmail.com>
	<20260814183652.611e7ecf@gandalf.local.home>
	<6db9c47f-a1f8-49dd-9e80-f9014d75f9e8@leemhuis.info>
	<20260903092037.5b739980@gandalf.local.home>
	<20261015061915.126442-1-chaosheng.qu.linux@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C31A18000F
X-Stat-Signature: oa1eb3ixkx811cekhhrakryosqs6faim
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QpSyMVVid/7jm5CTQOwrRyyZ5zpMDu40=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=E3yo00mr6Y/CnWl22ClP/IkxRb9GBZjVoCUGXo+yW28=; b=4LSFMqvtor4CuNBokRZvnav3xAQAny4llQbsFsqoII8p5kLbVyawznp/JfP9hAxG/2yn5S4x8baR8wnK6xg1ItizuVfvviGOOJ4lWs1ibXQ8Ia1PoGvRApp9Xii23l/DA1G6UInU11wfXkPRzuvSsox1jwh12SEuWnJ2IBwmctk=
X-HE-Tag: 1792068376-139539
X-HE-Meta: U2FsdGVkX1/bHq/2gMheibYvBJ/Wg7TfO3l4HEJsSmlorHoQ1nhYMvw/6QgiC8T3CJN5/f5pOUXF2xVXvyaevnpGZUPagwzkeYHEavNzlFzuxLZE/bnB8eN9b0X/BvpVtGEQRgBZCEEsZIR03zFk9upNqmi+IX1aWZ+Iu3m2xoFsNhf+Ru72joTfW8syk0/eyKsN0A7P/E7uEbL0JqJeQhpzYVIzxYn4JfSt5QfHZxzFt94juPcGaADzs2vWqXDBvePlqn8eg8f40Os9dLdj1G0gLdRSOhLBtHj7LCBZ5tSriadGboXl9gGsNQtM9IkItXSNADdK9m0KC1+fYwkr8NQ//cUPy8gU

On Thu, 15 Oct 2026 14:19:15 +0800
Chaosheng Qu <chaosheng.qu.linux@gmail.com> wrote:

> Hi Steve, Martin,

Hi Chaosheng,

Thanks for the in-depth analysis!

> 
> I do not have Martin's workload, so this is not a reproduction of the reported
> audio dropouts. What I have is a narrower synthetic experiment that may help
> locate the non-PUSH failure Steve suspected. Sending data, not conclusions, and
> no patch yet.
> 
> The short version: with RT_PUSH_IPI off, a PI-boosted task that cannot run on
> its own CPU can be stuck in a state where the pull side cannot reach it and the
> push side was never queued, until the task holding the CPU schedules out on its
> own. Two things have to line up for that, and one of them (affinity) is in my
> first attempt to get this wrong, so I have included the counter-example below.
> 
> Setup
> -----
> 
> QEMU/KVM, 4 vCPU, non-PREEMPT_RT, 7.3-rc7 (24a19b953e2a). The feature is
> toggled at runtime via /sys/kernel/debug/sched/features. Four SCHED_FIFO
> threads:
> 
>   cpu1: L  FIFO 10  owner of PI mutex M, affinity {cpu1,cpu3}
>   cpu1: X  FIFO 99  hog, busy for the whole dwell
>   cpu2: W  FIFO 90  waiter, blocks on M     <- deliberately outside L's mask
>   cpu3: R  FIFO 60  spare, spinning
> 
> W blocking on M boosts L from 10 to 90; the trace confirms it:
> 
>   waiter-114 [002] d..3. 52.286120: sched_pi_setprio: comm=owner pid=115 oldprio=89 newprio=9

After reading the above, I can see the issue immediately.

> 
> L then cannot run on cpu1 because X holds it, and its only way out is to be
> moved to cpu3. cpu3's spare runs at FIFO 60, which matters: before the boost L
> has prio 89, and find_lock_lowest_rq() requires the target's
> highest_prio.curr to be strictly higher priority than the task being moved, so
> cpu3 is not a legal target until the boost happens. That way the opportunity is
> created by the boost itself and not by some unrelated migration.
> 
> Measurements, dwell 1500 ms
> ---------------------------
> 
>   RT_PUSH_IPI   n   resumed <100 ms   owner resume median   min / max
>   off (default) 8   0/8               1499.6 ms             1146.1 / 1502.6 ms
>   on            6   6/6                 0.8 ms                0.6 / 5.4 ms
>   off, no boost 2   0/2               1499.2 ms            1499.1 / 1499.2 ms
> 
> In the 8 "off" runs, 7 never migrated at all: L stayed on cpu1 and started only
> once X finished its dwell. The 8th moved to cpu3 5 ms before X exited, which is
> a by-product of the hog leaving rather than a rescue, so I used a fixed 100 ms
> threshold for "timely" rather than "eventually moved". With the dwell raised to
> 4000 ms the waiter was blocked for 2.26 s before L finally moved.
> 
> The third row is a control with PTHREAD_PRIO_NONE instead of PRIO_INHERIT, to
> check that the opportunity really comes from the boost. Without the boost L
> stays at prio 89, cpu3's curr is 39, 39 > 89 is false, and so there is no legal
> migration target at all. Both feature settings look the same there, which is
> the expected result.
> 
> The affinity counter-example
> ----------------------------
> 
> My first version gave L affinity {cpu1,cpu2}, that is, including the CPU whose
> priority drops when W blocks. In that shape both settings rescued L in 0.5-6.2
> ms and the two paths do not diverge at all. The reason is that cpu2 can pull L
> inline, and task_is_pushable() only requires
> cpumask_test_cpu(cpu, &p->cpus_mask) for the pulling CPU. The split only shows
> up once that CPU is removed from L's mask.
> 
> So this is a fairly narrow condition: PI boost, RT overload on the owner's CPU,
> and affinity that excludes the CPU that just went idle. I do not know whether
> Martin's livefx workers hit all three. The trace in his report has the worker
> boosted and enqueued but never scheduled while other CPUs idle, and nothing in
> his description rules it out, but I cannot confirm it from the data in the
> report.
> 
> Where the non-PUSH path appears to lose it
> ------------------------------------------
> 
> Both sides have to miss the boosted task.
> 
> 1. The pull side cannot reach it. In the non-PUSH branch, pull_rt_task() walks
>    the overloaded CPUs and calls pick_highest_pushable_task(src_rq, this_cpu),
>    which requires cpumask_test_cpu(cpu, &p->cpus_mask). L's mask excludes cpu2,
>    so cpu2's loop finds nothing and returns empty-handed.
> 
> 2. The push side was never queued. rt_queue_push_tasks() is only called from
>    set_next_task_rt() and switched_to_rt(). prio_changed_rt() queues a pull when
>    the running task's priority drops, but it does not queue a push. The boost
>    arrives through rt_mutex_setprio() -> sched_change_end() ->
>    prio_changed_rt(). L is not the current task on cpu1 (X is), so it takes the
>    non-current branch, which only ends up doing resched_curr().
> 
> The result is that after the boost, cpu1 will not queue a push until X itself
> schedules out, and cpu2 cannot pull L because of the affinity check.
> 
> The two paths are separable in the trace by the hardirq marker:
> 
>   # RT_PUSH_IPI on - the ipi runs the push in hardirq context on cpu1
>   hog-122 [001] d.h2. 53.803264: sched_migrate_task: comm=owner prio=9 orig_cpu=1 dest_cpu=3
> 
>   # off - no ipi; the push happens on cpu1's ordinary scheduling path,
>   # and in this run only 5 ms before X left on its own
>   hog-113 [001] d..3. 50.615178: sched_migrate_task: comm=owner prio=9 orig_cpu=1 dest_cpu=3
>   hog-131 [001] d..2. 70.614471: sched_switch: prev_comm=hog prev_state=X
> 
> One more observation, in case it is useful: prio_changed_rt() does not appear to
> have ever queued a push. I walked that function's history and did not find a
> revision that did. That would be consistent with Steve's guess that this is a
> long-standing bug that the PUSH path happened to cover, rather than something
> dd29c017aed6 introduced.

Exactly. The issue that you show here appears to be that the boosting of
the RT task should trigger another analysis of RT migration. Which we do
not do.

> 
> What I am not proposing
> -----------------------
> 
> I am not suggesting flipping the RT_PUSH_IPI default. The thundering-herd
> reason for keeping it off outside PREEMPT_RT is clear, and trading a regression
> for that is not a fix.
> 
> If this is too far from the real workload to be worth chasing, or if there is a
> specific trace you would rather have, tell me and I will either drop it or
> collect that instead. The probe and the full logs are small; happy to send them
> to anyone who wants to rerun it.

I think this is a legitimate bug and should be fix. We need to make the
prio_changed_rt() aware of the rto mask and trigger a push if needed.

-- Steve

