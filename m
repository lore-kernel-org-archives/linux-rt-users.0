From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 2/2] sched: readjust the load whenever
	task_setprio()is invoked
Date: Fri, 18 Jul 2008 07:01:58 -0600
Message-ID: <48805C06.BA47.005A.0@novell.com>
References: <20080703212939.1275.27072.stgit@lsg.lsg.lab.novell.com>
 <20080703213716.1275.33324.stgit@lsg.lsg.lab.novell.com>
 <1216384984.28405.36.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <mingo@elte.hu>, <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<stable@vger.kernel.org>
To: "Peter Zijlstra" <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:13608 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYGRM5k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 08:57:40 -0400
In-Reply-To: <1216384984.28405.36.camel@twins>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Fri, Jul 18, 2008 at  8:43 AM, in message <1216384984.28405.36.camel@twins>,
Peter Zijlstra <peterz@infradead.org> wrote: 
> On Thu, 2008-07-03 at 15:37 -0600, Gregory Haskins wrote:
>> The load may change with the priority, so be sure to recompute its value.
>> 
>> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Ingo Molnar <mingo@elte.hu>
> 
> Right, but in this case we'd need to do the dec/inc load game again
> because otherwise we'll skew stuff - see the previuos mail on how
> dequeue_task() doesn't actually do that.
> 
> Also, it looks like current mainline still has this issue.
> 
> OTOH - since prio boosting is a temporal feature, not changing the load
> isn't too bad, we ought to get back to where we came from pretty
> quickly.

Yeah, I agree.  This issue probably didn't actually matter much in practice.

It just "looked" wrong, so I figured I'd fix it ;)

-Greg

> 
> 
> 
>> ---
>> 
>>  kernel/sched.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/kernel/sched.c b/kernel/sched.c
>> index b046754..c3f41b9 100644
>> --- a/kernel/sched.c
>> +++ b/kernel/sched.c
>> @@ -4637,6 +4637,7 @@ void task_setprio(struct task_struct *p, int prio)
>>  		p->sched_class = &fair_sched_class;
>>  
>>  	p->prio = prio;
>> +	set_load_weight(p);
>>  
>>  //	trace_special_pid(p->pid, __PRIO(oldprio), PRIO(p));
>>  	prev_resched = _need_resched();
>> 



