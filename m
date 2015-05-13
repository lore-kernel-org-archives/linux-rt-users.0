From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Wed, 13 May 2015 12:34:27 -0400
Message-ID: <20150513123427.2ff23a9a@gandalf.local.home>
References: <55245FC8.9090509@osadl.org>
	<5526AE86.7030708@linutronix.de>
	<20150410123634.GA3057@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:36565 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752555AbbEMQea (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 May 2015 12:34:30 -0400
In-Reply-To: <20150410123634.GA3057@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 10 Apr 2015 14:36:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1450,9 +1450,9 @@ void update_process_times(int user_tick)
>  	scheduler_tick();
>  	run_local_timers();
>  	rcu_check_callbacks(cpu, user_tick);
> -#ifdef CONFIG_IRQ_WORK
> -	if (in_irq())
> -		irq_work_tick();
> +
> +#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
> +	irq_work_tick();
>  #endif

Found the bug. The above actually changes the code
for !CONFIG_PREEMPT_RT_FULL. You still need to keep that

	if (in_irq())

check, otherwise you can call irq_work_tick() from softirq in non RT
configs, which talking to Peter Zijlstra, is a no no.

Note, my tests were failing on CONFIG_PREEMPT_LL (low latency).

-- Steve


>  	run_posix_cpu_timers(p);
>  }

