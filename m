From: Yang Shi <yang.shi@windriver.com>
Subject: Re: [PATCH 1/2] rt: Don't call schedule_work_on in preemption disabled
 context
Date: Fri, 4 Oct 2013 10:49:04 -0700
Message-ID: <524EFF90.3090402@windriver.com>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com> <1379365759-5743-2-git-send-email-yang.shi@windriver.com> <20131004154616.GJ19953@linutronix.de> <524EEE99.1060907@windriver.com> <20131004171010.GK19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42147 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab3JDRtQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 13:49:16 -0400
In-Reply-To: <20131004171010.GK19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/4/2013 10:10 AM, Sebastian Andrzej Siewior wrote:
> * Yang Shi | 2013-10-04 09:36:41 [-0700]:
>
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2453,8 +2453,11 @@ static void drain_all_stock(struct mem_cgroup *root_memcg, bool sync)
>>>> 		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
>>>> 			if (cpu == curcpu)
>>>> 				drain_local_stock(&stock->work);
>>>> -			else
>>>> +			else {
>>>> +				preempt_enable();
>>>> 				schedule_work_on(cpu, &stock->work);
>>>> +				preempt_disable();
>>>> +			}
>>>> 		}
>>> What ensures that you don't switch CPUs between preempt_enable() &
>>> preempt_disable() and is curcpu != smp_processor_id() ?
>> drain_all_stock is called by drain_all_stock_async or
>> drain_all_stock_sync, and the call in both is protected by mutex:
>>
>> if (!mutex_trylock(&percpu_charge_mutex))
>>                 return;
>>         drain_all_stock(root_memcg, false);
>>         mutex_unlock(&percpu_charge_mutex);
>>
>>
>> So, I suppose this should be able to protect from migration?
> preempt_disable() ensures that the task executing drain_all_stock() is
> not moved from cpu1 to cpu5. Lets say we run cpu1, on first invocation
> we get we get moved from cpu1 to cpu5 after preempt_enable(). On the
> second run we have (1 == 1) and invoke drain_local_stock() the argument
> is ignored so we execute drain_local_stock() with data of cpu5. Later we
> schedule work for cpu5 again but we never did it for cpu1.
>
> The code here is robust enough that nothing bad happens if
> drain_local_stock() is invoked twice on one CPU and the system probably
> survives it if one CPU is skipped. However I would prefer not to have
> such an example in the queue where it seems that it is okay to just
> enable preemption and invoke schedule_work_on() because it breaks the
> assumptions which are made by get_cpu().

Ok, I see. Anyway, we can't call schedule_work_on with preempt disabled.

And, I checked the git commit history about the drain_local_stock call, 
it sounds it is just an optimization for preventing from deferring local 
stock drain to work queue.

So, It sounds safe to remove the get_cpu and the shortcut to make 
schedule_work_on called safely as you suggested.

If this sounds fine to you, I'm going to come up with V2.

Thanks,
Yang


>
>> Thanks,
>> Yang
> Sebastian

