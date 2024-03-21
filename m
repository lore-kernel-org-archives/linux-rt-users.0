Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280FEC3
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Mar 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981985; cv=none; b=Kq41E2Cwi5+6DmmJ4iolajsG7GRbKaC/E3XYR9JDK3J4NhKh6EBLwcApVdlju0yKleu+xSHBRfy/zm7vtvYtTAaAIR2CG9E8xvv7hsqtwv7hNAR+hrjCedmebJV7Rj74evreFRRtX6JYtOB02LZ0ZQstR+Ztqxk+Nr8pYUoDS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981985; c=relaxed/simple;
	bh=QxtggDmvUvX9369ayJxHxkYEvN5TCK3yhzhVOkuko7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeAFEUdjukukGn56H0+AsXlfohUqRnIz3DBOQg7KQrJsYpW7TbGeEZaHHWDYC6571349K7MJbVg9PeZJQg7HMifO1ARkqqUgwbAdRhWPUfAkzMV8IXiX9UXnb0BMhrC9B4aAPCXVd5+ufcJwzUyqyul7NgfFqu7+wxhRvkJLUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIP5u8Ym; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIP5u8Ym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710981983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19Unt3HQ6SAxrfLPHkQKWbDT06kZNE7blMquRNeahv8=;
	b=dIP5u8YmxrzqGsBxwIEQz63vyckHhXqp7FnF+Rzt4rBEUhoFwXA/0eGxzqUiUzSHeKnGRX
	Uk0z6d6DwSJfHG0iWLlpjXItz4kXG0PU3JG1WVJuw0CqPIzaP2X7mGCLxAIHnufxiiafbg
	YxfnlbYWtEBCWCn1NhLgu0MnechgzCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-UG8ih7rGPg-j5s91EyrnQA-1; Wed, 20 Mar 2024 20:46:19 -0400
X-MC-Unique: UG8ih7rGPg-j5s91EyrnQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCBF485A58C;
	Thu, 21 Mar 2024 00:46:18 +0000 (UTC)
Received: from [10.22.33.155] (unknown [10.22.33.155])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52E902166B34;
	Thu, 21 Mar 2024 00:46:17 +0000 (UTC)
Message-ID: <39bb4123-cf1d-4846-b82e-95195ccec5d8@redhat.com>
Date: Wed, 20 Mar 2024 20:46:11 -0400
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20240320122012.2c1f461f@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240320122012.2c1f461f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 3/20/24 12:20, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> I'm debugging some latency issues on a Chromebook and the preemptirqsoff
> tracer hit this:
>
> # tracer: preemptirqsoff
> #
> # preemptirqsoff latency trace v1.1.5 on 5.15.148-21853-g165fd2387469-dirty
> # --------------------------------------------------------------------
> # latency: 7813 us, #60/60, CPU#1 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
> #    -----------------
> #    | task: init-1 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: rwsem_optimistic_spin
> #  => ended at:   rwsem_optimistic_spin
> #
> #
> #                    _------=> CPU#
> #                   / _-----=> irqs-off
> #                  | / _----=> need-resched
> #                  || / _---=> hardirq/softirq
> #                  ||| / _--=> preempt-depth
> #                  |||| / _-=> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>     <...>-1         1...1.    0us!: rwsem_optimistic_spin+0x20/0x194 <-rwsem_optimistic_spin+0x20/0x194
>     <...>-1         1.N.1. 7813us : rwsem_optimistic_spin+0x140/0x194 <-rwsem_optimistic_spin+0x140/0x194
>     <...>-1         1.N.1. 7814us+: tracer_preempt_on+0x4c/0x6a <-rwsem_optimistic_spin+0x140/0x194
>     <...>-1         1.N.1. 7824us : <stack trace>
>   => rwsem_optimistic_spin+0x140/0x194
>   => rwsem_down_write_slowpath+0xc9/0x3fe
>   => copy_process+0xd08/0x1b8a
>   => kernel_clone+0x94/0x256
>   => __x64_sys_clone+0x7a/0x9a
>   => do_syscall_64+0x51/0xa1
>   => entry_SYSCALL_64_after_hwframe+0x5c/0xc6
>
> Which isn't a real issue, as it's in the rwsem_optimistic_spin() code that
> spins with interrupts enabled, preempt disabled, and checks for
> need_resched(). If it is true, it breaks out and schedules.
>
> Hence, it's hiding real issues, because it can spin for a very long time
> and this is not the source of the latency I'm tracking down.
>
> I would like to introduce restart_critical_timings() and place it in
> locations that have this behavior.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I have no objection to that. However, there are now 2 function call 
overhead in each iteration if either CONFIG_IRQSOFF_TRACER or 
CONFIG_PREEMPT_TRACER is on. Is it possible to do it with just one 
function call? IOW, make restart_critical_timings() a real function.

Cheers,
Longman

>
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 147feebd508c..e9f97f60bfc0 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -145,6 +145,13 @@ do {						\
>   # define start_critical_timings() do { } while (0)
>   #endif
>   
> +/* Used in spins that check need_resched() with preemption disabled */
> +static inline void restart_critical_timings(void)
> +{
> +	stop_critical_timings();
> +	start_critical_timings();
> +}
> +
>   #ifdef CONFIG_DEBUG_IRQFLAGS
>   extern void warn_bogus_irq_restore(void);
>   #define raw_check_bogus_irq_restore()			\
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..fa7b43e53d20 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -27,6 +27,7 @@
>   #include <linux/export.h>
>   #include <linux/rwsem.h>
>   #include <linux/atomic.h>
> +#include <linux/irqflags.h>
>   #include <trace/events/lock.h>
>   
>   #ifndef CONFIG_PREEMPT_RT
> @@ -780,6 +781,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>   		 */
>   		barrier();
>   
> +		restart_critical_timings();
>   		if (need_resched() || !owner_on_cpu(owner)) {
>   			state = OWNER_NONSPINNABLE;
>   			break;
> @@ -912,6 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>   		 * a writer, need_resched() check needs to be done here.
>   		 */
>   		if (owner_state != OWNER_WRITER) {
> +			restart_critical_timings();
>   			if (need_resched())
>   				break;
>   			if (rt_task(current) &&
>

