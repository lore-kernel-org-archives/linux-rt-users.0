Return-Path: <SRS0=Yxvf=YL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A7CA9EA0
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D1D20854
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 22:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbfJRWLm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390321AbfJRWLl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Oct 2019 18:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BEE87BDA6;
        Fri, 18 Oct 2019 22:11:40 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3631F60A97;
        Fri, 18 Oct 2019 22:11:34 +0000 (UTC)
Message-ID: <017d54ccd076199f3c5270bd98aa62f6e995c7af.camel@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: Lazy migrate_disable processing
From:   Scott Wood <swood@redhat.com>
To:     Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Oct 2019 17:11:34 -0500
In-Reply-To: <67dca2a2-5322-ca9d-d093-4bbdfc4aec29@redhat.com>
References: <20191012065214.28109-1-swood@redhat.com>
         <20191012065214.28109-3-swood@redhat.com>
         <67dca2a2-5322-ca9d-d093-4bbdfc4aec29@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 18 Oct 2019 22:11:40 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-10-18 at 14:12 -0400, Waiman Long wrote:
> On 10/12/19 2:52 AM, Scott Wood wrote:
> > Avoid overhead on the majority of migrate disable/enable sequences by
> > only manipulating scheduler data (and grabbing the relevant locks) when
> > the task actually schedules while migrate-disabled.  A kernel build
> > showed around a 10% reduction in system time (with CONFIG_NR_CPUS=512).
> > 
> > Instead of cpuhp_pin_lock, CPU hotplug is handled by keeping a per-CPU
> > count of the number of pinned tasks (including tasks which have not
> > scheduled in the migrate-disabled section); takedown_cpu() will
> > wait until that reaches zero (confirmed by take_cpu_down() in stop
> > machine context to deal with races) before migrating tasks off of the
> > cpu.
> > 
> > To simplify synchronization, updating cpus_mask is no longer deferred
> > until migrate_enable().  This lets us not have to worry about
> > migrate_enable() missing the update if it's on the fast path (didn't
> > schedule during the migrate disabled section).  It also makes the code
> > a bit simpler and reduces deviation from mainline.
> > 
> > While the main motivation for this is the performance benefit, lazy
> > migrate disable also eliminates the restriction on calling
> > migrate_disable() while atomic but leaving the atomic region prior to
> > calling migrate_enable() -- though this won't help with
> > local_bh_disable()
> > (and thus rcutorture) unless something similar is done with the recently
> > added local_lock.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > The speedup is smaller than before, due to commit 659252061477862f
> > ("lib/smp_processor_id: Don't use cpumask_equal()") achieving
> > an overlapping speedup.
> > ---
> >  include/linux/cpu.h    |   4 --
> >  include/linux/sched.h  |  11 +--
> >  init/init_task.c       |   4 ++
> >  kernel/cpu.c           | 103 +++++++++++-----------------
> >  kernel/sched/core.c    | 180 ++++++++++++++++++++--------------------
> > ---------
> >  kernel/sched/sched.h   |   4 ++
> >  lib/smp_processor_id.c |   3 +
> >  7 files changed, 128 insertions(+), 181 deletions(-)
> > 
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index f4a772c12d14..2df500fdcbc4 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -113,8 +113,6 @@ static inline void cpu_maps_update_done(void)
> >  extern void cpu_hotplug_enable(void);
> >  void clear_tasks_mm_cpumask(int cpu);
> >  int cpu_down(unsigned int cpu);
> > -extern void pin_current_cpu(void);
> > -extern void unpin_current_cpu(void);
> >  
> >  #else /* CONFIG_HOTPLUG_CPU */
> >  
> > @@ -126,8 +124,6 @@ static inline void cpus_read_unlock(void) { }
> >  static inline void lockdep_assert_cpus_held(void) { }
> >  static inline void cpu_hotplug_disable(void) { }
> >  static inline void cpu_hotplug_enable(void) { }
> > -static inline void pin_current_cpu(void) { }
> > -static inline void unpin_current_cpu(void) { }
> >  
> >  #endif	/* !CONFIG_HOTPLUG_CPU */
> >  
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 7e892e727f12..c6872b38bf77 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -229,6 +229,8 @@
> >  extern long io_schedule_timeout(long timeout);
> >  extern void io_schedule(void);
> >  
> > +int cpu_nr_pinned(int cpu);
> > +
> >  /**
> >   * struct prev_cputime - snapshot of system and user cputime
> >   * @utime: time spent in user mode
> > @@ -661,16 +663,13 @@ struct task_struct {
> >  	cpumask_t			cpus_mask;
> >  #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
> >  	int				migrate_disable;
> > -	int				migrate_disable_update;
> > -	int				pinned_on_cpu;
> > +	bool				migrate_disable_scheduled;
> >  # ifdef CONFIG_SCHED_DEBUG
> > -	int				migrate_disable_atomic;
> > +	int				pinned_on_cpu;
> >  # endif
> > -
> >  #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
> >  # ifdef CONFIG_SCHED_DEBUG
> >  	int				migrate_disable;
> > -	int				migrate_disable_atomic;
> >  # endif
> >  #endif
> >  #ifdef CONFIG_PREEMPT_RT_FULL
> > @@ -2074,4 +2073,6 @@ static inline void rseq_syscall(struct pt_regs
> > *regs)
> >  
> >  #endif
> >  
> > +extern struct task_struct *takedown_cpu_task;
> > +
> >  #endif
> > diff --git a/init/init_task.c b/init/init_task.c
> > index e402413dc47d..c0c7618fd2fb 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -81,6 +81,10 @@ struct task_struct init_task
> >  	.cpus_ptr	= &init_task.cpus_mask,
> >  	.cpus_mask	= CPU_MASK_ALL,
> >  	.nr_cpus_allowed= NR_CPUS,
> > +#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE) && \
> > +    defined(CONFIG_SCHED_DEBUG)
> > +	.pinned_on_cpu	= -1,
> > +#endif
> >  	.mm		= NULL,
> >  	.active_mm	= &init_mm,
> >  	.restart_block	= {
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 25afa2bb1a2c..e1bf3c698a32 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -76,11 +76,6 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state,
> > cpuhp_state) = {
> >  	.fail = CPUHP_INVALID,
> >  };
> >  
> > -#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PREEMPT_RT_FULL)
> > -static DEFINE_PER_CPU(struct rt_rw_lock, cpuhp_pin_lock) = \
> > -	__RWLOCK_RT_INITIALIZER(cpuhp_pin_lock);
> > -#endif
> > -
> >  #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
> >  static struct lockdep_map cpuhp_state_up_map =
> >  	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
> > @@ -287,57 +282,6 @@ void cpu_maps_update_done(void)
> >  
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  
> > -/**
> > - * pin_current_cpu - Prevent the current cpu from being unplugged
> > - */
> > -void pin_current_cpu(void)
> > -{
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -	struct rt_rw_lock *cpuhp_pin;
> > -	unsigned int cpu;
> > -	int ret;
> > -
> > -again:
> > -	cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
> > -	ret = __read_rt_trylock(cpuhp_pin);
> > -	if (ret) {
> > -		current->pinned_on_cpu = smp_processor_id();
> > -		return;
> > -	}
> > -	cpu = smp_processor_id();
> > -	preempt_lazy_enable();
> > -	preempt_enable();
> > -
> > -	sleeping_lock_inc();
> > -	__read_rt_lock(cpuhp_pin);
> > -	sleeping_lock_dec();
> > -
> > -	preempt_disable();
> > -	preempt_lazy_disable();
> > -	if (cpu != smp_processor_id()) {
> > -		__read_rt_unlock(cpuhp_pin);
> > -		goto again;
> > -	}
> > -	current->pinned_on_cpu = cpu;
> > -#endif
> > -}
> > -
> > -/**
> > - * unpin_current_cpu - Allow unplug of current cpu
> > - */
> > -void unpin_current_cpu(void)
> > -{
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -	struct rt_rw_lock *cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
> > -
> > -	if (WARN_ON(current->pinned_on_cpu != smp_processor_id()))
> > -		cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, current-
> > >pinned_on_cpu);
> > -
> > -	current->pinned_on_cpu = -1;
> > -	__read_rt_unlock(cpuhp_pin);
> > -#endif
> > -}
> > -
> >  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
> >  
> >  void cpus_read_lock(void)
> > @@ -895,6 +839,15 @@ static int take_cpu_down(void *_param)
> >  	int err, cpu = smp_processor_id();
> >  	int ret;
> >  
> > +#ifdef CONFIG_PREEMPT_RT_BASE
> > +	/*
> > +	 * If any tasks disabled migration before we got here,
> > +	 * go back and sleep again.
> > +	 */
> > +	if (cpu_nr_pinned(cpu))
> > +		return -EAGAIN;
> > +#endif
> > +
> >  	/* Ensure this CPU doesn't handle any more interrupts. */
> >  	err = __cpu_disable();
> >  	if (err < 0)
> > @@ -924,11 +877,10 @@ static int take_cpu_down(void *_param)
> >  	return 0;
> >  }
> >  
> > +struct task_struct *takedown_cpu_task;
> > +
> >  static int takedown_cpu(unsigned int cpu)
> >  {
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -	struct rt_rw_lock *cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, cpu);
> > -#endif
> >  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
> >  	int err;
> >  
> > @@ -941,17 +893,38 @@ static int takedown_cpu(unsigned int cpu)
> >  	 */
> >  	irq_lock_sparse();
> >  
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -	__write_rt_lock(cpuhp_pin);
> > +#ifdef CONFIG_PREEMPT_RT_BASE
> > +	WARN_ON_ONCE(takedown_cpu_task);
> > +	takedown_cpu_task = current;
> 
> I don't know how likely it is for more than one task calling
> takedown_cpu() concurrently. But if that can happen, there is a
> possibility of missed wakeup.

cpus_write_lock() in _cpu_down() prevents this, as does cpu_add_remove_lock.

> The current code is fragile. How about something like
> 
> while (cmpxchg(&takedown_cpu_task, NULL, current) {
>     WARN_ON_ONCE(1);
>     schedule();
> }

It's a debug check to try to let us know if the code ever changes such that
multiple cpus can be taken down in parallel, not an attempt to actually make
that work.

That said, looking at this again, it seems there is a possibility for a
different race -- if __cpu_disable() returns an error, takedown_cpu_task
will be NULLed out without flushing tasks from the cpu.  This could happen
between reads of takedown_cpu_task in migrate_enable(), leading to
wake_up_process(NULL).  Even if we use READ_ONCE(), if we get delayed by an
interrupt long enough, the task pointed to might go away (or, less
seriously, receive a spurious wakeup).  A fix could be to stick a raw lock
around the if+wakeup and around takedown_cpu_task = NULL in the error path.

-Scott


