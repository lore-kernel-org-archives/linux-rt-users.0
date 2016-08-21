From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH] Make output of RT throttling more verbose
Date: Sun, 21 Aug 2016 23:39:21 +0200
Message-ID: <250cd9a5-7b1d-96b4-1317-c54bc632bb6a@osadl.org>
References: <99b19596-c11b-0b92-7376-b1a07f1aaa88@osadl.org>
 <20160817084613.npcfmylluwhi5suh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:51160 "EHLO toro.web-alm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbcHUVkM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Aug 2016 17:40:12 -0400
In-Reply-To: <20160817084613.npcfmylluwhi5suh@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

>> [..]
>> @@ -923,7 +924,11 @@ static int sched_rt_runtime_exceeded(str
>>  		 */
>>  		if (likely(rt_b->rt_runtime)) {
>>  			rt_rq->rt_throttled = 1;
>> -			printk_deferred_once("sched: RT throttling activated\n");
>> +			printk_deferred("sched: RT throttling activated cmd %s "
>> +			   "cpu %d pid %d prio %d us %llu flags 0x%08lx\n",
>> +			   curr->comm, task_cpu(curr), task_pid_nr(curr),
>> +			   MAX_RT_PRIO-1 - curr->prio, delta_exec >> 10,
>> +			   (unsigned long) task_thread_info(curr)->flags);
>
> I would keep the _once.
Ok.

> Other than that, I don't think that the output is correct.
If you had said "The output may not always point to the culprit", I 
immediately would agree. The probability of whether the real culprit is 
hit or an innocent other RT task depends on their uninterrupted runtime. 
Given that a legitimate RT task normally only runs for a couple of 
microseconds and a task that causes RT throttling may run a thousand 
times longer, the extended output still may provide a hint to solve the 
problem. At least this is what I found when I did a number of 
(admittedly artificial) experiments.

We could save a short history of RT tasks along with their uninterrupted 
runtime and, in case of throttling, print the one with the longest 
uninterrupted runtime.

Carsten.
