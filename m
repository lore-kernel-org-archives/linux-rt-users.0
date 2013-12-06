From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?=
	<tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/1] rcutree/rcu_bh_qs: disable irq while calling rcu_preempt_qs()
Date: Fri, 6 Dec 2013 09:57:24 +0800
Message-ID: <52A12F04.8040402@windriver.com>
References: <1386237162-10141-1-git-send-email-tiejun.chen@windriver.com> <52A09B10.1010004@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<bigeasy@linutronix.de>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:64780 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3LFB5S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 20:57:18 -0500
In-Reply-To: <52A09B10.1010004@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/05/2013 11:26 PM, Paul Gortmaker wrote:
> On 13-12-05 04:52 AM, Tiejun Chen wrote:
>> Any callers should make sure irq is disabled before calling rcu_preempt_qs().
>
> Can we stick to the standard rule of three here for commit logs please?
>
> 1) Describe what the end user symptoms look like (crash, bug, splat)
>
> 2) Describe the underlying problem, i.e. why it happens.
>
> 3) Describe why the fix proposed is the _right_ fix, in cases
> where it isn't obvious what the impact of the change will be etc.
>
> Maybe it seems obvious to you what the 1,2,3 are -- but it won't
> be obvious to everyone, and I hate having to guess.

This is required according to that comments from rcu_preempt_qs():

rcutree_plugin.h:

/*
  * Record a preemptible-RCU quiescent state for the specified CPU.  Note
  * that this just means that the task currently running on the CPU is
  * not in a quiescent state.  There might be any number of tasks blocked
  * while in an RCU read-side critical section.
  *
  * Unlike the other rcu_*_qs() functions, callers to this function
  * must disable irqs in order to protect the assignment to
  * ->rcu_read_unlock_special.
  */
static void rcu_preempt_qs(int cpu)
...

But in RT case, rcu_bh_qs() as the wrapper of rcu_preempt_qs() is called in some 
scenarios where irq is enabled, like this path,

do_single_softirq()
	|
	+ local_irq_enable();
	+ handle_softirq()
	|	|
	|	+ rcu_bh_qs()
	|		|
	|		+ rcu_preempt_qs()
	|
	+ local_irq_disable()

So I think we'd better disable irq directly inside of rcu_bh_qs() to fix this 
problem, and especially this is also kind for the potential rcu_bh_qs() usage 
elsewhere in the future.

If you guy like this explanation, I'm happy for posting this as a long log in 
this patch head description.

Thanks,

Tiejun

>
> Thanks,
> Paul.
> --
>
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   kernel/rcutree.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
>> index 7ec834d..6f6d133 100644
>> --- a/kernel/rcutree.c
>> +++ b/kernel/rcutree.c
>> @@ -186,7 +186,12 @@ static void rcu_preempt_qs(int cpu);
>>
>>   void rcu_bh_qs(int cpu)
>>   {
>> +	unsigned long flags;
>> +
>> +	/* Callers to this function, rcu_preempt_qs(), must disable irqs. */
>> +	local_irq_save(flags);
>>   	rcu_preempt_qs(cpu);
>> +	local_irq_restore(flags);
>>   }
>>   #else
>>   void rcu_bh_qs(int cpu)
>>
>

