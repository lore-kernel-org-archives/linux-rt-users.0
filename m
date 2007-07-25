From: John Sigler <linux.kernel@free.fr>
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Wed, 25 Jul 2007 14:53:25 +0200
Message-ID: <46A747C5.8050900@free.fr>
References: <20070723125925.GE8055@in.ibm.com> <46A5D626.6070009@free.fr> <20070725060843.GB7745@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:42305 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbXGYMxa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 08:53:30 -0400
In-Reply-To: <20070725060843.GB7745@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ankita Garg wrote:
> On Tue, Jul 24, 2007 at 12:36:22PM +0200, John Sigler wrote:
>> Ankita Garg wrote:
>>
>>> This patch adds support to display captured -rt stats under 
>>> /proc/schedstat.
>>>
>>> Signed-off-by: Ankita Garg <ankita@in.ibm.com>
>>> --
>>> sched_stats.h |    5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-2.6.22.1/kernel/sched_stats.h
>>> ===================================================================
>>> --- linux-2.6.22.1.orig/kernel/sched_stats.h	2007-07-23 
>>> 18:15:57.000000000 +0530
>>> +++ linux-2.6.22.1/kernel/sched_stats.h	2007-07-23 
>>> 18:24:03.000000000 +0530
>>> @@ -21,12 +21,15 @@
>>>
>>> 		/* runqueue-specific stats */
>>> 		seq_printf(seq,
>>> -		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %llu 
>>> %lu",
>>> +		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %llu %lu %lu 
>>> %lu %llu %lu",
>>> 		    cpu, rq->yld_both_empty,
>>> 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
>>> 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
>>> 		    rq->ttwu_cnt, rq->ttwu_local,
>>> 		    rq->rq_sched_info.cpu_time,
>>> +#ifdef CONFIG_PREEMPT_RT
>>> +		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled,
>>> +#endif
>>> 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
>>>
>>> 		seq_printf(seq, "\n");
>>
>> I know you've written a new patch that makes this one obsolete, but I 
>> wanted to discuss this specific patch.
>>
>> Originally, there were 13 conversion specifications, and your patch
>> adds 3, for a total of 16 conversion specifications.
>>
>> However, if CONFIG_PREEMPT_RT is not defined, then seq_printf is
>> called with only 13 arguments.
>>
>> Is it safe to call seq_printf with too few arguments?
> 
> So I tried to run the code disabling CONFIG_PREEMPT_RT, to see the
> behavior vsnprintf() on supplying fewer arguments. Arbit/garbage value is
> printed for conversion specifications that do not have a matching argument.
> It did not cause any issue at all beyond that point. But considering the
> correctness and quality of code, was going to post the updated patch (if
> the re-work had not happened)!

I double-checked. Calling v*printf with too few parameters also leads to 
undefined behavior.

You didn't notice any ill effects on your particular compiler / platform 
combination, but the code above remains a time bomb :-)

Once in UB land, all bets are off.

Regards.
