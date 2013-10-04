From: Yang Shi <yang.shi@windriver.com>
Subject: Re: [PATCH 1/2] rt: Don't call schedule_work_on in preemption disabled
 context
Date: Fri, 4 Oct 2013 09:36:41 -0700
Message-ID: <524EEE99.1060907@windriver.com>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com> <1379365759-5743-2-git-send-email-yang.shi@windriver.com> <20131004154616.GJ19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50525 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab3JDQgx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 12:36:53 -0400
In-Reply-To: <20131004154616.GJ19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/4/2013 8:46 AM, Sebastian Andrzej Siewior wrote:
> * Yang Shi | 2013-09-16 14:09:18 [-0700]:
>
>> ---
>> mm/memcontrol.c |    5 ++++-
>> 1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 82a187a..9f7cc0f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2453,8 +2453,11 @@ static void drain_all_stock(struct mem_cgroup *root_memcg, bool sync)
>> 		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
>> 			if (cpu == curcpu)
>> 				drain_local_stock(&stock->work);
>> -			else
>> +			else {
>> +				preempt_enable();
>> 				schedule_work_on(cpu, &stock->work);
>> +				preempt_disable();
>> +			}
>> 		}
> What ensures that you don't switch CPUs between preempt_enable() &
> preempt_disable() and is curcpu != smp_processor_id() ?

drain_all_stock is called by drain_all_stock_async or 
drain_all_stock_sync, and the call in both is protected by mutex:

if (!mutex_trylock(&percpu_charge_mutex))
                 return;
         drain_all_stock(root_memcg, false);
         mutex_unlock(&percpu_charge_mutex);


So, I suppose this should be able to protect from migration?

Thanks,
Yang

>
> What about removing the get_cpu() & put_cpu() calls (and the shortcut)?
>
>> 	}
>> 	put_cpu();
> Sebastian

