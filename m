From: Daniel Wagner <wagi@monom.org>
Subject: Re: Null pointer 4.14.1-rt3
Date: Fri, 1 Dec 2017 08:12:19 +0100
Message-ID: <b97176af-5773-8331-db96-395d91bdffd7@monom.org>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
 <20171130154251.GD11362@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.monom.org ([188.138.9.77]:46774 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdLAHMX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 02:12:23 -0500
In-Reply-To: <20171130154251.GD11362@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 11/30/2017 04:42 PM, Sebastian Andrzej Siewior wrote:
>> root@beaglebone:~# cyclictest -p 80 -n -m 
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 0.62 0.19 0.07 1/65 361          
>>
>> [   46.747855] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [   46.747863] pgd = db048000
>> [   46.747869] [00000000] *pgd=9b0a0831, *pte=00000000, *ppte=00000000
>> [   46.747901] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
>> [   46.747911] Modules linked in:
>> [   46.747927] CPU: 0 PID: 361 Comm: cyclictest Not tainted 4.14.1-rt3 #9
>> [   46.747930] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [   46.747935] task: db225d00 task.stack: db164000
>> [   46.747944] PC is at 0x0
>> [   46.747960] LR is at smp_cross_call+0x40/0x160
> …
>> [   46.748234] [<c010f15c>] (smp_cross_call) from [<c010f990>] (arch_send_call_function_single_ipi+0x38/0x40)
>> [   46.748253] [<c010f990>] (arch_send_call_function_single_ipi) from [<c024c1b8>] (irq_work_queue_on+0xa4/0x114)
>> [   46.748277] [<c024c1b8>] (irq_work_queue_on) from [<c0183550>] (pull_rt_task+0x334/0x354)
>> [   46.748290] [<c0183550>] (pull_rt_task) from [<c01849dc>] (pick_next_task_rt+0x58/0x2bc)
>> [   46.748311] [<c01849dc>] (pick_next_task_rt) from [<c0880ff0>] (__schedule+0x5b0/0x91c)
>> [   46.748322] [<c0880ff0>] (__schedule) from [<c08813b8>] (schedule+0x5c/0xfc)
>> [   46.748334] [<c08813b8>] (schedule) from [<c0884864>] (do_nanosleep+0xf4/0x20c)
>> [   46.748350] [<c0884864>] (do_nanosleep) from [<c01cd350>] (__hrtimer_nanosleep+0x108/0x184)
>> [   46.748361] [<c01cd350>] (__hrtimer_nanosleep) from [<c01cd478>] (hrtimer_nanosleep+0x1c/0x20)
>> [   46.748372] [<c01cd478>] (hrtimer_nanosleep) from [<c01d6c6c>] (common_nsleep+0x2c/0x30)
>> [   46.748383] [<c01d6c6c>] (common_nsleep) from [<c01d87bc>] (SyS_clock_nanosleep+0xc4/0x110)
>> [   46.748400] [<c01d87bc>] (SyS_clock_nanosleep) from [<c01083a0>] (ret_fast_syscall+0x0/0x28)
>> [   46.748410] Code: bad PC value
> 
> ach. The other part of the email. Would you mind trying v4.15-rc1? This
> should blow up the same way.

Sorry about the missing part. I only copied the stack trace into the
other mail.

Anyway, I am running v4.15-rc1 with CONFIG_PREEMPT and it didn't crash
so far. On v4.14.1-rt3 the crash happens immediately after starting
cyclictest.

Thanks,
Daniel
