From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Null pointer 4.14.1-rt3
Date: Thu, 30 Nov 2017 11:22:32 -0500
Message-ID: <20171130112232.4c0cb600@gandalf.local.home>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
        <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbdK3QWf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 11:22:35 -0500
In-Reply-To: <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 Nov 2017 16:11:22 +0100
Daniel Wagner <wagi@monom.org> wrote:

> > Fresh after a boot I just got this:  
> 
> v4.14.1-rt2 doesn't crash. I suspect that Steven's recent 
> change 073371b12467 ("sched/rt: Simplify the IPI based RT balancing logic") 
> is the root of the problem.
> 
> [   46.748234] [<c010f15c>] (smp_cross_call) from [<c010f990>] (arch_send_call_function_single_ipi+0x38/0x40)
> [   46.748253] [<c010f990>] (arch_send_call_function_single_ipi) from [<c024c1b8>] (irq_work_queue_on+0xa4/0x114)
> [   46.748277] [<c024c1b8>] (irq_work_queue_on) from [<c0183550>] (pull_rt_task+0x334/0x354)
> [   46.748290] [<c0183550>] (pull_rt_task) from [<c01849dc>] (pick_next_task_rt+0x58/0x2bc)
> [   46.748311] [<c01849dc>] (pick_next_task_rt) from [<c0880ff0>] (__schedule+0x5b0/0x91c)
> [   46.748322] [<c0880ff0>] (__schedule) from [<c08813b8>] (schedule+0x5c/0xfc)
> [   46.748334] [<c08813b8>] (schedule) from [<c0884864>] (do_nanosleep+0xf4/0x20c)
> [   46.748350] [<c0884864>] (do_nanosleep) from [<c01cd350>] (__hrtimer_nanosleep+0x108/0x184)
> [   46.748361] [<c01cd350>] (__hrtimer_nanosleep) from [<c01cd478>] (hrtimer_nanosleep+0x1c/0x20)
> [   46.748372] [<c01cd478>] (hrtimer_nanosleep) from [<c01d6c6c>] (common_nsleep+0x2c/0x30)
> [   46.748383] [<c01d6c6c>] (common_nsleep) from [<c01d87bc>] (SyS_clock_nanosleep+0xc4/0x110)
> [   46.748400] [<c01d87bc>] (SyS_clock_nanosleep) from [<c01083a0>] (ret_fast_syscall+0x0/0x28)
> 
> Obviously, the beaglebone black has just one CPU, maybe this confused
> the rt balancing logic?
>

Is it compiled for non SMP? That push pull logic shouldn't be called.

-- Steve
