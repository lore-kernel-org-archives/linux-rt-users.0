From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 07 Apr 2015 18:55:50 -0600
Message-ID: <55247C96.1080707@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>	<1428369962-74723-1-git-send-email-tmac@hp.com>	<1428369962-74723-2-git-send-email-tmac@hp.com> <20150406215959.4e8ad37b@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:41618 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbbDHA5h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 20:57:37 -0400
In-Reply-To: <20150406215959.4e8ad37b@grimm.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 04/06/2015 07:59 PM, Steven Rostedt wrote:
> 

Thanks for the comments.

> Hmm, why is it not allowed?
> 
> If we just let it boost it, it will cut down on the code changes and
> checks that add to the hot paths.
> 

There is a WARN_ON() at line 3150 in sched/core.c to warn against
boosting idle_task priority.

In this case we are not actually boosting the idle_task priority, which
should be OK.  But the warning could be very overwhelming on some
platforms. TO keep the warning, I decided not to boots priority.  Please
let me know if you have any suggestion.

>>  		rt_mutex_enqueue_pi(owner, waiter);
>> -
> 
> I don't think this whitespace change needs to be done. The space does
> split up the dequeue and enqueue from the rest.
> 

Will restore it.

>> +	/* Might sleep, should not be called in interrupt context. */
>> +	BUG_ON(in_interrupt());
> 
> You're right it shouldn't. But that's why might_sleep() will give us a
> nice big warning if it is. Don't add the BUG_ON().
> 

Will remove it.

>> -static void  noinline __sched rt_spin_lock_slowunlock_hirq(struct rt_mutex *lock)
>> +static inline void rt_spin_lock_fastunlock_in_irq(struct rt_mutex *lock,
> 
> Why the name change?
> 

Instead of adding a new task_struct *caller parameter to
rt_spin_lock_fastUnlock() and make all other invocations of it to supply
the additional parameter, a simpler change would be to add a new
function rt_spin_lock_fastunlock_in_irq(), similar to the original
rt_spin_lock_slowunlock_hirq(), but first do fast mutex acquire attempt
with idle_task as owner and attempt the slow path if required and leave
the rt_spin_lock_fast_unlock() as it is.

>> +	void (*slowfn)(struct rt_mutex *lock, struct task_struct *task))
>>  {
>>  	int ret;
>> +	struct task_struct *intr_owner = current;
>>  
>> +	if (unlikely(in_irq()))
> 
> Why unlikely? This should only be called in interrupt context.
> 
> In fact, perhaps we should have a:
> 
> 	WARN_ON(!in_irq());
> 
> Then we don't need this test at all, and just assign the owner the idle
> task.
> 

You are right.  Sorry I guess I did not pay enough attention here. Will
do that.

>> +		intr_owner = idle_task(smp_processor_id());
> 
> Also, never butt a single if statement up against another if statement.
> Add a space, otherwise it gives the impression of being an
>   if () else if ()
> 

OK thanks.

>> +	if (likely(rt_mutex_cmpxchg(lock, intr_owner, NULL))) {
>> +		rt_mutex_deadlock_account_unlock(intr_owner);
>> +		return;
>> +	}
> 
> And add a space here. Don't butt conditionals together unless they are
> related (if else if, etc)
> 

Will do.

>>  	do {
>>  		ret = raw_spin_trylock(&lock->wait_lock);
>>  	} while (!ret);
> 
> I know this isn't part of the patch, but that do loop needs a comment
> (this is more toward Sebastian, and not you). It looks buggy, and I
> think we do it this way just so that lockdep doesn't complain. We need
> a comment here that states something like:
> 
> 	/*
> 	 * To get this rt_mutex from interrupt context, we had to have
> 	 * taken the wait_lock once before. Thus, nothing can deadlock
> 	 * us now. The wait_lock is internal to the rt_mutex, and
> 	 * anything that may have it now, will soon release it, because
> 	 * we own the rt_mutex but do not hold anything that the owner
> 	 * of the wait_lock would need to grab.
> 	 *
> 	 * The do { } while() is to keep lockdep from complaining.
> 	 */
> 

Will do.

> I wonder if there's another way to just take the wait_lock and tell
> lockdep not to complain?
> 
> Peter?
> 
>>  
>> -	__rt_spin_lock_slowunlock(lock);
>> +	slowfn(lock, intr_owner);
>>  }
>>  
>>  void __lockfunc rt_spin_lock(spinlock_t *lock)
>> @@ -1118,7 +1136,7 @@ void __lockfunc rt_spin_unlock_after_trylock_in_irq(spinlock_t *lock)
>>  {
>>  	/* NOTE: we always pass in '1' for nested, for simplicity */
>>  	spin_release(&lock->dep_map, 1, _RET_IP_);
>> -	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_hirq);
>> +	rt_spin_lock_fastunlock_in_irq(&lock->lock, __rt_spin_lock_slowunlock);
>>  }
>>  
>>  void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
>> @@ -1146,8 +1164,12 @@ int __lockfunc __rt_spin_trylock(struct rt_mutex *lock)
>>  
>>  int __lockfunc rt_spin_trylock(spinlock_t *lock)
> 
> We really should have a rt_spin_trylock_in_irq() and not have the
> below if conditional.
> 
> The paths that will be executed in hard irq context are static. They
> should be labeled as such.
> 

Are you talking about having a new function spin_trylock_in_irq() that
is turned into rt_spin-trylock_in_irq() that is called only in the
interrupt context?

That was part of my originally changes.  But that also require change in
kernel/timer.c and include/linux/spinlock_rt.h.  Since it involves
changes in 2 additional files, I backed out.  BTW, with that we could
also add a WAR_ON(in_irq()) in rt_spin_trylock().

> -- Steve

Thanks,
Mak.

