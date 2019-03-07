Return-Path: <SRS0=0bBW=RK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24F5C43381
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A7C20840
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGSOu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:14:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49796 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfCGSOu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Mar 2019 13:14:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52909EBD;
        Thu,  7 Mar 2019 10:14:49 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414CC3F71D;
        Thu,  7 Mar 2019 10:14:48 -0800 (PST)
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190304172053.17340-1-julien.grall@arm.com>
 <20190307123823.fnzb7njqdib4xghk@flow>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <c86522b3-cc38-1559-5011-22de1d08db99@arm.com>
Date:   Thu, 7 Mar 2019 18:14:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307123823.fnzb7njqdib4xghk@flow>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 07/03/2019 12:38, Sebastian Andrzej Siewior wrote:
> On 2019-03-04 17:20:53 [+0000], Julien Grall wrote:
>> At the moment show_lock is implemented using spin_lock_t and called from
>> an interrupt context on Arm64. The following backtrace was triggered by:
>>
>> 42sh# echo l > /proc/sysrq-trigger
>>
>> [ 4432.073756] sysrq: SysRq : Show backtrace of all active CPUs
>> [ 4432.403422] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
>> [ 4432.403424] sysrq: CPU6:
>> [ 4432.403426] in_atomic(): 1, irqs_disabled(): 128, pid: 2410, name: kworker/u16:2
>>
>> [...]
>>
>> [ 4432.403581] Call trace:
>> [ 4432.403584]  dump_backtrace+0x0/0x148
>> [ 4432.403586]  show_stack+0x14/0x20
>> [ 4432.403588]  dump_stack+0x9c/0xd4
>> [ 4432.403592]  ___might_sleep+0x1cc/0x298
>> [ 4432.403595]  rt_spin_lock+0x5c/0x70
>> [ 4432.403596]  showacpu+0x34/0x68
>> [ 4432.403599]  flush_smp_call_function_queue+0xd4/0x278
>> [ 4432.403602]  generic_smp_call_function_single_interrupt+0x10/0x18
>> [ 4432.403605]  handle_IPI+0x26c/0x668
>> [ 4432.403607]  gic_handle_irq+0x9c/0xa0
>> [ 4432.403609]  el1_irq+0xb4/0x13c
>>
>> With RT-patches, spin_lock can now sleep and therefore cannot be used from
>> interrupt context. Use a raw_spin_lock instead to prevent the lock to
>> sleep.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> Now that I had time to look at it, for the change itself:
> 	Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> For the description please take into consideration to add something like
> this:
> 
>   Systems which don't provide arch_trigger_cpumask_backtrace() will
>   invoke showacpu() from a smp_call_function() function which is invoked
>   with disabled interrupts even on -RT systems.
>   The function acquires the show_lock lock which only purpose is to
>   ensure that the CPUs don't print simultaneously. Otherwise the output
>   would clash and it would be hard to tell the output from CPUx apart
>   from CPUy.
>   On -RT the spin_lock() can not be acquired from this context. A
>   raw_spin_lock() is required. It will introduce the system's latency
>   by performing the sysrq request and other CPUs will block on the lock
>   until the request is done. This is okay because the user asked for a
>   backtrace of all active CPUs and under "normal circumstances in
>   production" this path should not be triggered.

This description looks better. I will update the commit message. Do you mind if 
I had your signed-off-by as you provided the commit message?

> 
> Which explains *why* you do the change and *why* it is okay to do the
> change. If we start changing each spin_lock() to a raw_spin_lock()
> because lockdep said so then soon the RT switch will make less change
> than it should.

I understand, I will take into account for the next RT patches I will post.

> 
>  From top of my head I think you won't see the output on -RT right away.
> The output won't be printed from the non-preemptible context and will be
> delayed until a printk occurs from a preemptible context.

FWIW, this is the behavior I saw when testing this patch.

> There are
> printk related patches which fix that and allow a printk from a
> non-preemptible context for a configured log level.
> 
> Looking at the showacpu() construct: Do you get a proper stacktrace for a
> busy CPU or does it always start at el1_irq()? Because if the interrupt
> always starts with its own interrupt stack then the backtrace is
> useless. All you would need is the information that the CPU is alive and
> a oneline printk() saying so would be enough. Or, if it starts on its
> own stack but is able to unwind to the previous context *then* you gain
> additional information you are looking for.

 From my understanding, the stack frames across exceptions are chained. So the 
stacktrace will be able to unwind to the previous context.

Actually, in my previous e-mail, I have cut down the stacktrace to el1_irq() as 
it was quite long. An example of the full stack trace:

[  516.820845] sysrq: SysRq : Show backtrace of all active CPUs
[  516.941513] sysrq: CPU0:
[  516.941515] Call trace:
[  516.941519]  dump_backtrace+0x0/0x148
[  516.941521]  show_stack+0x14/0x20
[  516.941524]  showacpu+0x58/0x70
[  516.941527]  flush_smp_call_function_queue+0xd4/0x278
[  516.941530]  generic_smp_call_function_single_interrupt+0x10/0x18
[  516.941533]  handle_IPI+0x26c/0x668
[  516.941535]  gic_handle_irq+0x9c/0xa0
[  516.941537]  el1_irq+0xb4/0x13c
[  516.941539]  generic_exec_single+0x174/0x218
[  516.941541]  smp_call_function_single+0xc4/0x280
[  516.941544]  task_function_call+0x54/0x90
[  516.941547]  event_function_call+0xa0/0x158
[  516.941549]  _perf_event_enable+0x54/0x80
[  516.941552]  perf_event_enable+0x24/0x40
[  516.941555]  kvm_pmu_enable_counter.part.0+0x64/0x90
[  516.941557]  kvm_pmu_handle_pmcr+0xc0/0xd8
[  516.941559]  access_pmcr+0x104/0x138
[  516.941561]  perform_access+0x1c/0x78
[  516.941564]  kvm_handle_sys_reg+0x144/0x4e0
[  516.941566]  handle_exit+0x13c/0x1f8
[  516.941568]  kvm_arch_vcpu_ioctl_run+0x68c/0xbe8
[  516.941571]  kvm_vcpu_ioctl+0x398/0xad8
[  516.941574]  do_vfs_ioctl+0xbc/0x910
[  516.941576]  ksys_ioctl+0x78/0xa8
[  516.941579]  __arm64_sys_ioctl+0x1c/0x28
[  516.941582]  el0_svc_common+0x90/0x118
[  516.941584]  el0_svc_handler+0x2c/0x80
[  516.941586]  el0_svc+0x8/0xc

Thank you for your acked-by and the explanation. I will resend the patch with 
the updated comment.

Best regards,

> 
>> ---
>>   drivers/tty/sysrq.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index 1f03078ec352..8473557c7ab2 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
>>   #endif
>>   
>>   #ifdef CONFIG_SMP
>> -static DEFINE_SPINLOCK(show_lock);
>> +static DEFINE_RAW_SPINLOCK(show_lock);
>>   
>>   static void showacpu(void *dummy)
>>   {
>> @@ -218,10 +218,10 @@ static void showacpu(void *dummy)
>>   	if (idle_cpu(smp_processor_id()))
>>   		return;
>>   
>> -	spin_lock_irqsave(&show_lock, flags);
>> +	raw_spin_lock_irqsave(&show_lock, flags);
>>   	pr_info("CPU%d:\n", smp_processor_id());
>>   	show_stack(NULL, NULL);
>> -	spin_unlock_irqrestore(&show_lock, flags);
>> +	raw_spin_unlock_irqrestore(&show_lock, flags);
>>   }
>>   
>>   static void sysrq_showregs_othercpus(struct work_struct *dummy)
>> -- 
>> 2.11.0
>>
> 
> Sebastian
> 

-- 
Julien Grall
