From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Fri, 20 Feb 2015 11:54:45 -0700
Message-ID: <54E782F5.8060405@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>	<1424395866-81589-2-git-send-email-tmac@hp.com> <20150219235321.0acf3c75@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150219235321.0acf3c75@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On 02/19/2015 09:53 PM, Steven Rostedt wrote:
> On Thu, 19 Feb 2015 18:31:05 -0700
> Thavatchai Makphaibulchoke <tmac@hp.com> wrote:
> 
>> This patch fixes the problem that the ownership of a mutex acquired by an
>> interrupt handler(IH) gets incorrectly attributed to the interrupted thread.
> 
> *blink*
> 
>>
>> This could result in an incorrect deadlock detection in function
>> rt_mutex_adjust_prio_chain(), causing thread to be killed and possibly leading
>> up to a system hang.
> 
> I highly doubt this is an incorrect deadlock that was detected. My
> money is on a real deadlock that happened.
> 
>>
>> Here is the approach taken: when calling from an interrupt handler, instead of
>> attributing ownership to the interrupted task, use a reserved task_struct value
>> to indicate that the owner is a interrupt handler.  This approach avoids the
>> incorrect deadlock detection.
> 
> How is this an incorrect deadlock? Please explain.
> 

Thanks for the comments.

Sorry for not explaining the problem in more details.

IH here means the bottom half of interrupt handler, executing in the
interrupt context (IC), not the preemptible interrupt kernel thread.
interrupt.

Here is the problem we encountered.

An smp_apic_timer_interrupt comes in while task X is in the process of
waiting for mutex A .  The IH successfully locks mutex B (in this case
run_local_timers() gets the timer base's lock, base->lock, via
spin_trylock()).

At the same time, task Y holding mutex A requests mutex B.

With current rtmutex code, mutex B ownership is incorrectly attributed
to task X (using current, which is inaccurate in the IC). To task Y the
situation effectively looks like it is holding mutex A and reuqesting B,
which is held by task X holding mutex B and is now waiting for mutex A.
 The deadlock detection is correct, a classic potential circular mutex
deadlock.

In reality, it is not.  The IH the actual owner of mutex B will
eventually completes and releases mutex B and task Y will eventually get
mutex B and proceed and so will task X.  Actually either deleting or
changing BUG_ON(ret) to WARN_ON(ret) in line 997 in fucntion
rt_spin_lock_slowlock(), the test ran fine without any problem.

A more detailed description of the problem could also be found at,

http://markmail.org/message/np33it233hoot4b2#query:+page:1+mid:np33it233hoot4b2+state:results


Please let me know what you think or need any additional info.

Thanks,
Mak.

>>
>> This also includes changes in several function in rtmutex.c now that the lock's
>> requester may be a interrupt handler, not a real task struct.  This impacts
>> the way how the lock is acquired and prioritized and decision whether to do
>> the house keeping functions required for a real task struct.
>>
>> The reserved task_struct values for interrupt handler are
>>
>> 	current | 0x2
>>
>> where current is the task_struct value of the interrupted task.
>>
>> Since IH will both acquire and release the lock only during an interrupt
>> handling, during which current is not changed, the reserved task_struct value
>> for an IH should be distinct from another instances of IH on a different cpu.
>>
> 
> The interrupt handler is a thread just like any other task. It's not
> special. If there was a deadlock detected, it most likely means that a
> deadlock exists.
> 
> -- Steve
