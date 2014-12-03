From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Wed, 03 Dec 2014 15:39:57 -0700
Message-ID: <547F913D.20405@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
	"Haefliger, Juerg" <Juerg.Haefliger@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:40522 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaLCWj7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Dec 2014 17:39:59 -0500
Received: from g9t2301.houston.hp.com (g9t2301.houston.hp.com [16.216.185.78])
	by g4t3427.houston.hp.com (Postfix) with ESMTP id CE72C22B
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Dec 2014 22:39:58 +0000 (UTC)
In-Reply-To: CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On 12/03/2014 09:56 AM, Juerg Haefliger wrote:
> Added lots of tracing and here is the sequence of events that lead to
the deadlock:
>
> mutex A is free
> mutex B is free>
>
> eth1: acquires mutex B (rt_spin_lock_nested)
>
> iperf: wants to acquire mutex B (rt_spin_lock)
>   iperf: blocks on rtmutex (mutex B, owner eth1)
>     iperf: enqueue iperf on mutex B
>     iperf: top waiter of mutex B is iperf
>     iperf: enqueue_pi iperf on eth1
>     iperf: chain_walk = 0
>   iperf: for (;;)
>     iperf: __try_to_take_rt_mutex(mutex B, owner eth1)
>
> At this point iperf is in a tight loop trying to take mutex B
>
> iperf: receives an smp_apic_timer_interrupt (which yankes it out of
> the previous for (;;) loop)
>   iperf: acquires mutex A (rt_spin_trylock)
>
> eth1: wants to acquire mutex A (rt_spin_lock)
>   eth1: gets wait_lock of mutex A
>   eth1: blocks on rtmutex (mutex A, owner iperf)
>
> iperf: tries to release mutex A (rt_spin_unlock_after_trylock_in_irq)
>   iperf: spins on trying to get wait_lock of mutex A (in
> rt_spin_lock_slowunlock_hirq)
>
>     eth1: enqueue eth1 on mutex A
>     eth1: top waiter of mutex A is eth1
>     eth1: enqueue_pi eth1 on iperf
>     eth1: adjust prio of iperf from 120 to 49
>     eth1: iperf is blocked on mutex B
>     eth1: chain_walk = 1
>     eth1: releases wait_lock of mutex A
>
>   iperf: gets wait_lock of mutex A
>     iperf: __rt_spin_lock_slowunlock mutex A
>
>     eth1: rt_mutex_adjust_prio_chain(task=iperf, orig_lock=mutex A,
> next_lock=mutex B, orig_waiter=eth1,mutex A, top_task=eth1)
>       eth1: waiter is iperf,mutex B
>       eth1: lock is mutex B
>       eth1: raw_spin_trylock mutex B
>       eth1: rt_mutex_owner(mutex B) == eth1 ---> -EDEADLOCK
>
> Does that make sense? Please let me know if I need to provide more
> info. I have detailed ftrace and crash dumps that I could provided if
> need be.
> Is this a 'real' problem or is the above fix (ignore the deadlock)
> sufficient?
>
> Thanks
> ...Juerg

I believe this is a problem with spin_do_trylock()->rt_mutex_trylock()
called by update_process_times as a result of the
smp_apic_timer_interrupt in the interrupt context.  rt_mutex_trylock(),
both the fast and slow paths, uses current (current running task) as the
mutex's owner.

In the interrupt context, though current is readable it is invalid and
should not be used as the owner of the mutex.  The mutex's real owner is
the interrupt handler, not the interrupted executing task.  Using
current as the mutex's owner causes the false negative in
rt_mutex_adjust_prio_chain(), predicting a deadlock, when it is not
really a deadlock.

>From your scenario above, assuming that there is a way to indicate a
mutex is owned by interrupt handler rather than the interrupted iperf,
the portion of iperf interrupted by sm_apic_timer_interrupt would be
rephrased as  sm_apic_timer_interrupt_handler and the above scenario
would now be,

iperf receives an smp_apic_timer_interrupt (which yankes it out of the
previous loop)
   sm_apic_timer_interrupt_handler acquires mutex A (rt_spin_trylock)

eth1 wants to acqsire mutex A (rt_spin_lock)
  eth1 gets wait_lock of mutex A
  eth1 blocks on rtmutex (mutex A, owner sm_apic_timer_interrupt_handler)

sm_apic_timer_interrupt_handler  tries to release mutex A
(rt_spin_unlock_after_trylock_in_irq)
  sm_apic_timer_interrupt_handler spins on trying to get wait_lock of
mutex A (owner eth1)

    eth1: enqueue eth1 on mutex A
    eth1: top waiter of mutex A is eth1
    eth1: enqueue_pi eth1 on sm_apic_timer_interrupt_handler
    eth1: adjust prio of sm_apic_timer_interrupt_handler from 120 to 49
    eth1: sm_apic_timer_interrupt_handler is not blocked on mutex B
    eth1: chain_walk = 0
    eth1: releases wait_lock of mutex A

  sm_apic_timer_interrupt_handler gets wait_lock of mutex A
    __rt_spin_lock_slowunlock mutex A

Instead of,

    eth1:
rt_mutex_adjust_prio_chain(task=sm_apic_timer_interrupt_handler,
orig_lock=mutex A, next_lock=mutex B, orig_waiter=eth1,mutex A,
top_task=eth1)
      eth1: waiter is iperf,mutex B
      eth1: lock is mutex B
      eth1: raw_spin_trylock mutex B
      eth1: rt_mutex_owner(mutex B) == eth1 ---> -EDEADLOCK

we'll have,
    eth1: both chain_walk == 0 and next_lock == NULL(instead of
chain_walk == 1 and next_lock == mutex B, since
sm_apic_timer_interrupt_handler is not actually waiting for mutex B)
    eth1: return 0 ---> No deadlock.

As mentioned, the fact that rt_mutex_trylock() inaccurately attributed
the owner of mutex B to iperf causes rt_mutex_adjust_prio_chain() to
inacurrately announce a deadlock.  In this situation there will be no
deadlock as sm_apic_timer_interrupt_handler will eventually complete the
interrupt handling and release mutex A and return to the interrupted
iperf which is to continue waiting on mutex B.  eth1 will eventually get
mutex A and releases both mutex B and A, and eventually iperf will get
mutex B without any deadlock.


At the moment, I can think of two ways to fix the problem.

One, to change the mutual exclusion mechanism of timer->base to use real
spin_lock, raw_spin-lock_t in RT patch, instead of rt_mutex.  But looks
like a lot of thought and work has already been done to make sure that
sm_apic_timer_interrupt handler works with rt_mutex (particularly with a
special non-blocking rt_mutex locking path(), spin_do_trylock(), that
can be safely used in interrupt context, get_next_timer_interrupt() and
update_process_times()).  This approach however would require changing
complex logic in kernel/timer.c module and would be a high risk change.

Another approach is the come up with a mechanism to accurately attribute
mutex's owner to an interrupt handler when acquired in an interrupt
context, instead of the interrupted current task.

This approach would involve only changes in the rt_mutex.c module and is
the one I'm looking at.  What I'm trying to do is in
rt_mutex_fasttrylock() and rt_mutex_fastunlock(), the two functions
callable in the interrupt context, when called in the interrupt context
instead of using current as the owner, uses a dummy (struct task_struct
*)~(0xf) as the owner.  Unfortunately this would involve additional
changes not to do additional work such as rt_mutex_enqueue_pi(),
rt_mutex_enqueue_pi() and __rt_mutex_adjust_prio(), etc., when the owner
is a dummy interrupt handler task.  With all the required changes, this
seems to be a lower risk and preferable change to the first approach.

At the moment I'm still debugging the above changes.  Will send it out
for comments once I get it to work.

Please let me know if you or anyone else has any question, comment
and/or suggestion.

Thanks in advance.

Thanks,
Mak.

