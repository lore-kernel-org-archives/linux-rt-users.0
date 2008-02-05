From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: CPU hotplug and IRQ affinity with 2.6.24-rt1
Date: Tue, 05 Feb 2008 10:13:28 -0700
Message-ID: <47A852E8.BA47.005A.0@novell.com>
References: <47A7A131.8040800@qualcomm.com>
 <20080205025144.GA31774@dwalker1.mvista.com>
 <47A7A784.BA47.005A.0@novell.com>
 <20080205165936.GA18613@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Max Krasnyanskiy" <maxk@qualcomm.com>,
	"LKML" <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: "Daniel Walker" <dwalker@dwalker1.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:35299 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYBERTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2008 12:19:51 -0500
In-Reply-To: <20080205165936.GA18613@dwalker1.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Tue, Feb 5, 2008 at 11:59 AM, in message
<20080205165936.GA18613@dwalker1.mvista.com>, Daniel Walker
<dwalker@dwalker1.mvista.com> wrote: 
> On Mon, Feb 04, 2008 at 10:02:12PM -0700, Gregory Haskins wrote:
>> >>> On Mon, Feb 4, 2008 at  9:51 PM, in message
>> <20080205025144.GA31774@dwalker1.mvista.com>, Daniel Walker
>> <dwalker@dwalker1.mvista.com> wrote: 
>> > I get the following when I tried it,
>> > 
>> > BUG: sleeping function called from invalid context bash(5126) at
>> > kernel/rtmutex.c:638
>> > in_atomic():1 [00000001], irqs_disabled():1
>> 
>> Hi Daniel,
>>   Can you try this patch and let me know if it fixes your problem?
>> 
>> -----------------------
>> 
>> use rcu for root-domain kfree
>> 
>> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
>> 
>> diff --git a/kernel/sched.c b/kernel/sched.c
>> index e6ad493..77e86c1 100644
>> --- a/kernel/sched.c
>> +++ b/kernel/sched.c
>> @@ -339,6 +339,7 @@ struct root_domain {
>>         atomic_t refcount;
>>         cpumask_t span;
>>         cpumask_t online;
>> +       struct rcu_head rcu;
>> 
>>         /*
>>          * The "RT overload" flag: it gets set if a CPU has more than
>> @@ -6222,6 +6223,12 @@ sd_parent_degenerate(struct sched_domain *sd, struct 
> sched_domain *parent)
>>         return 1;
>>  }
>> 
>> +/* rcu callback to free a root-domain */
>> +static void rq_free_root(struct rcu_head *rcu)
>> +{
>> +       kfree(container_of(rcu, struct root_domain, rcu));
>> +}
>> +
> 
> I looked at the code a bit, and I'm not sure you need this complexity..
> Once you have replace the old_rq, there is no reason it needs to
> protection of the run queue spinlock .. So you could just move the kfree
> down below the spin_unlock_irqrestore() ..

Indeed.  When I looked last night at the stack, I thought the in_atomic was coming from further up in the trace.  I see the issue now, thanks Daniel.  (Anyone have a spare brown bag?)

-Greg

> 
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
