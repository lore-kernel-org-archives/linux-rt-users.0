Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEC5CAF;
	Tue, 23 Jan 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034759; cv=none; b=tKbB5T/BLu1vFx7+djLGMCh/y5bK8J94Tmprg8iyAqU7/iH6CkBQ224sbvyHCPORL4XGp36ex44sxFLcbyOdbiMi7024oqF4kqvUsrUP6cdqsaxWn4gXVr9pp5ldFc/1yFUOQOKZCASq9e81PC3tmioO8YM4xN7AuH5ehQIsHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034759; c=relaxed/simple;
	bh=OcOD1hUdLe4yEkcJA9JGWS2pSOzPb0YFLJcDma7oSwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2zXM+kvp2RZqdgoUctSlEah0YTLb9WOj7huci3XD8ZiVKWfOukDhulp4WdNvuj4heYtW8BHZA8vJhh34j5fveqrRebEAT7ArZUH8nAb44guWZnYosM5EhNBXXta8peBaYqsnVV+1jeDxthIoK+eeWbMjNC0mdnhdzjrjmKI4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2tsUSLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2tsUSLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1354C433F1;
	Tue, 23 Jan 2024 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706034758;
	bh=OcOD1hUdLe4yEkcJA9JGWS2pSOzPb0YFLJcDma7oSwU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F2tsUSLUxMd9EyGGDlC9KMepkdtWAFP/hJJvfFoJE2KNsGF4Ma52tygc/sLVbbnzE
	 Y7GeVgIaYkiWiyJPpJ0nzC3WwszdaWWMM4QlKXRtI0+wtcH91KbDNR+FNljTLAAZMC
	 Nu2isbUp5k+vIW085Q1b5F1URsIhTnnohoZ41P9h7+t/OcuUMnUubohm+7grCjYO2x
	 H++m0J4kjmhwsM2WpJKrYR3PQhK+K36dqae+bR4Oe3BkKsP4mNIFzBxm14iBooYiA0
	 k9OiIWp30Z5LpCyL4svJ2JydZg40G2Oi1TTYd1Q9C872sY4QXNC8Tqgc55FSPWXwL7
	 riAAtRYRQvh+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D97ACE0964; Tue, 23 Jan 2024 10:32:38 -0800 (PST)
Date: Tue, 23 Jan 2024 10:32:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Leon Woestenberg <leon@sidebranch.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linux-rt-users@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: Unexpected rcuc osnoise on PREEMPT_RT with "rcu_nocbs=all
 rcu_nocb_poll"
Message-ID: <637bcd9c-e769-47d7-acee-6d25e4e3c7bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAMjhiJj0PnBrZdujKWnF43TmLB37L-bfs99nyDi+j2p+Nv1enQ@mail.gmail.com>
 <Zary17RaLN1hS63H@pavilion.home>
 <24c8a28f-b87d-4953-bf09-2158597fc0c5@paulmck-laptop>
 <CAMjhiJhbKF_Yt_0Js6AEbjCHTZAMNRejCw7eiCGZL8L_Y97-Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMjhiJhbKF_Yt_0Js6AEbjCHTZAMNRejCw7eiCGZL8L_Y97-Gw@mail.gmail.com>

On Mon, Jan 22, 2024 at 03:32:44PM +0100, Leon Woestenberg wrote:
> Hi Frederic, Paul, all,
> 
> On Sat, Jan 20, 2024 at 1:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Fri, Jan 19, 2024 at 11:08:23PM +0100, Frederic Weisbecker wrote:
> > > Le Fri, Jan 19, 2024 at 04:38:23PM +0100, Leon Woestenberg a écrit :
> > > > The isolated core should run a single non-kernel user-space-busy-loop
> > > > thread (SCHED_OTHER, not FIFO or RR).
> > > >
> > > > tsc=reliable isolcpus=domain,managed_irq,4-7 nohz_full=4-7
> > > > rcu_nocbs=all rcu_nocb_poll
> > > > /proc/irq/*/smp_affinity and cpumasks in
> > > > /sys/devices/virtual/workqueue/ all show 000f or less (CPUs 0-3)
> > > >
> > > > Using osnoise I see rcuc/4 popping up as a cause of noise, but my
> > > > kernel command line should prevent that, right?
> >
> > Well, your choice is rcuc or ksoftirqd.  Either way, there is some per-CPU
> > work that must be done.  But to Frederic's later point, not very much
> > work.  In particular, RCU callbacks should be invoked on an rcuoc kthread.
> >
> Yes, that's what I expected (and what I got to work on an earlier
> system with an older kernel).
> 
> I went back to running ftrace against the isolated CPU, and I see some
> kworker work.
> Sometimes  blk_mq_run_work_func().
> 
> (I think seeing rcuc in my osnoise trace was coincidental.)
> 
> What would be the method to find the root cause more clearly? Should I
> deepen my ftrace function call depth?

Is the application thread running on CPU 4 doing any kernel work?
Alternatively, is there more than one runnable task on CPU 4?

> I am getting one interruption per 8 minutes on the isolated CPU. Here
> is an example trace that ran 30 minutes:
> 
> cat trace.4
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>   4)               |  vtime_user_exit() {
>   4)   0.634 us    |    get_vtime_delta();
>   4)   1.799 us    |    account_user_time();
>   4)   5.808 us    |  }
>   4)               |  irq_enter_rcu() {
>   4)   0.640 us    |    tick_irq_enter();
>   4)   0.914 us    |  }
>   4)               |  __sysvec_call_function_single() {
>   4)               |  /* call_function_single_entry: vector=251 */
>   4)   0.513 us    |    generic_smp_call_function_single_interrupt();
>   4)               |  /* call_function_single_exit: vector=251 */
>   4)   2.136 us    |  }

CPU 4 was the target of an smp_call_function_single().  Which just
means that some other CPU needs CPU 4 to do something for it.  The
csd_function_entry trace event, if enabled, will give you the name of the
function called, which might help you work out what needed to be adjusted.

>   4)               |  irq_exit_rcu() {
>   4)   0.203 us    |    idle_cpu();
>   4)               |    tick_nohz_irq_exit() {
>   4)               |      /* tick_stop: success=0 dependency=SCHED */
>   4)   7.564 us    |    }
>   4)   8.285 us    |  }
>   4)               |  exit_to_user_mode_prepare() {
>   4)   0.217 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.187 us    |    __rcu_irq_enter_check_tick();
>   4)               |  /* reschedule_entry: vector=253 */
>   4)               |  /* reschedule_exit: vector=253 */
>   4)               |    raw_irqentry_exit_cond_resched() {
>   4)               |      /* local_timer_entry: vector=236 */
>   4)               |      /* local_timer_exit: vector=236 */
>   4)               |      /* tick_stop: success=0 dependency=SCHED */
>   4)               |      /* sched_switch: prev_comm=hiccups_x86-64
> prev_pid=1335 prev_prio=120 prev_state=R+ ==> next_comm=kworker/4:0H
> next_pid=1160 next_prio=100 */
>  ------------------------------------------
>   4)  hiccups-1335  =>  kworker-1160
>  ------------------------------------------
> 
>   4)               |  finish_task_switch.isra.0() {
>   4)   0.475 us    |    vtime_task_switch_generic();
>   4)   0.126 us    |    __tick_nohz_task_switch();
>   4)   1.069 us    |  }
>   4)               |  wq_worker_running() {
>   4)   0.223 us    |    kthread_data();
>   4)   0.547 us    |  }
>   4)   0.180 us    |  _raw_spin_lock_irq();
>   4)   0.115 us    |  _raw_spin_unlock_irq();
>   4)               |  mod_timer() {
>   4)   0.241 us    |    lock_timer_base();
>   4)   0.104 us    |    detach_if_pending();
>   4)   0.123 us    |    _raw_spin_lock();
>   4)   0.120 us    |    calc_wheel_index();
>   4)   0.115 us    |    enqueue_timer();
>   4)   0.134 us    |    _raw_spin_unlock_irqrestore();
>   4)   1.815 us    |  }
>   4)               |  create_worker() {
>   4)   0.238 us    |    rt_spin_lock();
>   4)   0.288 us    |    rt_spin_unlock();
>   4)   0.144 us    |    kfree();
>   4)   1.216 us    |    alloc_worker();
>   4)               |    kthread_create_on_node() {
>   4)               |      /* sched_switch: prev_comm=kworker/4:0H

The workqueue_execute_start trace event will tell you which function
is the workqueue handler, though that would not have helped here.

> prev_pid=1160 prev_prio=100 prev_state=D ==> next_comm=hiccups_x86-64
> next_pid=1335 next_prio=120 */
>  ------------------------------------------
>   4)  kworker-1160  =>  hiccups-1335
>  ------------------------------------------
> 
>   4) + 33.354 us   |    } /* raw_irqentry_exit_cond_resched */
>   4)   1.334 us    |    schedule();
>   4)   0.151 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.133 us    |    mem_cgroup_handle_over_high();
>   4)   0.203 us    |    blkcg_maybe_throttle_current();
>   4)   0.300 us    |    __rseq_handle_notify_resume();
>   4)   0.113 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.114 us    |    fpregs_assert_state_consistent();
>   4)   0.142 us    |    switch_fpu_return();
>   4) + 39.502 us   |  } /* exit_to_user_mode_prepare */
>   4)               |  vtime_user_enter() {
>   4)   0.177 us    |    get_vtime_delta();
>   4)   0.390 us    |  }
>   4)               |  vtime_user_exit() {
>   4)   0.171 us    |    get_vtime_delta();
>   4)   0.437 us    |  }
>   4)               |  irq_enter_rcu() {
>   4)   0.167 us    |    tick_irq_enter();
>   4)   0.393 us    |  }
>   4)               |  __sysvec_call_function_single() {
>   4)               |  /* call_function_single_entry: vector=251 */
>   4)   0.348 us    |    generic_smp_call_function_single_interrupt();
>   4)               |  /* call_function_single_exit: vector=251 */

Another smp_call_function_single(), same tracepoint.

>   4)   0.908 us    |  }
>   4)               |  irq_exit_rcu() {
>   4)   0.304 us    |    idle_cpu();
>   4)               |    tick_nohz_irq_exit() {
>   4)               |      /* tick_stop: success=0 dependency=SCHED */
>   4)   0.646 us    |    }
>   4)   2.154 us    |  }
>   4)               |  exit_to_user_mode_prepare() {
>   4)   0.129 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.219 us    |    __rcu_irq_enter_check_tick();
>   4)               |  /* reschedule_entry: vector=253 */
>   4)               |  /* reschedule_exit: vector=253 */
>   4)               |    raw_irqentry_exit_cond_resched() {
>   4)               |      /* sched_switch: prev_comm=hiccups_x86-64
> prev_pid=1335 prev_prio=120 prev_state=R+ ==> next_comm=kworker/4:0H
> next_pid=1160 next_prio=100 */
>  ------------------------------------------
>   4)  hiccups-1335  =>  kworker-1160
>  ------------------------------------------
> 
>   4) + 96.177 us   |    } /* kthread_create_on_node */
>   4)   1.071 us    |    set_user_nice();
>   4)   0.999 us    |    kthread_bind_mask();
>   4)   0.436 us    |    worker_attach_to_pool();
>   4)   0.112 us    |    _raw_spin_lock_irq();
>   4)   0.146 us    |    worker_enter_idle();
>   4)   2.932 us    |    wake_up_process();
>   4)   0.114 us    |    _raw_spin_unlock_irq();
>   4) ! 107.063 us  |  } /* create_worker */
>   4)               |  del_timer_sync() {
>   4)   0.154 us    |    lock_timer_base();
>   4)   0.132 us    |    detach_if_pending();
>   4)   0.099 us    |    _raw_spin_unlock_irqrestore();
>   4)   0.854 us    |  }
>   4)   0.103 us    |  _raw_spin_lock_irq();
>   4)               |  rcuwait_wake_up() {
>   4)   0.097 us    |    __rcu_read_lock();
>   4)   0.099 us    |    __rcu_read_unlock();
>   4)   0.511 us    |  }
>   4)               |  process_one_work() {
>   4)   0.100 us    |    _raw_spin_unlock_irq();
>   4)   8.334 us    |    blk_mq_run_work_fn();

And in this case the workqueue handler is blk_mq_run_work_fn(), as
you noted.  Is I/O being initiated on CPU 4?  If so, it might help
to move that I/O to one of CPUs 0-3.

>   4)   0.133 us    |    _raw_spin_lock_irq();
>   4)   0.118 us    |    pwq_dec_nr_in_flight();
>   4)   9.496 us    |  }
>   4)   0.114 us    |  worker_enter_idle();
>   4)   0.108 us    |  _raw_spin_unlock_irq();
>   4)               |  schedule() {
>   4)   0.148 us    |    wq_worker_sleeping();
>   4)   0.114 us    |    rcu_note_context_switch();
>   4)   0.100 us    |    _raw_spin_lock();
>   4)   0.125 us    |    update_rq_clock();
>   4)   0.817 us    |    dequeue_task_fair();
>   4)   0.550 us    |    pick_next_task_fair();
>   4)   0.435 us    |    psi_task_switch();
>   4)               |    __traceiter_sched_switch() {
>   4)               |      /* sched_switch: prev_comm=kworker/4:0H
> prev_pid=1160 prev_prio=100 prev_state=I ==> next_comm=kworker/4:1H
> next_pid=1348 next_prio=100 */
>   4)   0.315 us    |    }
>   4)   0.114 us    |    enter_lazy_tlb();
>  ------------------------------------------
>   4)  kworker-1160  =>  kworker-1348
>  ------------------------------------------
> 
>   4)               |  finish_task_switch.isra.0() {
>   4)   0.289 us    |    vtime_task_switch_generic();
>   4)   0.111 us    |    __tick_nohz_task_switch();
>   4)   0.791 us    |  }
>   4)               |  __kthread_parkme() {
>   4)   0.106 us    |    _raw_spin_lock_irqsave();
>   4)   0.098 us    |    _raw_spin_unlock_irqrestore();
>   4)   0.611 us    |  }
>   4)               |  worker_thread() {
>   4)   0.107 us    |    mutex_lock();
>   4)   0.107 us    |    mutex_unlock();
>   4)   0.101 us    |    _raw_spin_lock_irq();
>   4)   0.128 us    |    worker_enter_idle();
>   4)   0.104 us    |    _raw_spin_unlock_irq();
>   4)               |    schedule() {
>   4)               |      /* sched_switch: prev_comm=kworker/4:1H
> prev_pid=1348 prev_prio=100 prev_state=I ==> next_comm=hiccups_x86-64
> next_pid=1335 next_prio=120 */
>  ------------------------------------------
>   4)  kworker-1348  =>  hiccups-1335
>  ------------------------------------------
> 
>   4) + 36.544 us   |    } /* raw_irqentry_exit_cond_resched */
>   4)   1.160 us    |    schedule();
>   4)   0.138 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.125 us    |    mem_cgroup_handle_over_high();
>   4)   0.113 us    |    blkcg_maybe_throttle_current();
>   4)   0.262 us    |    __rseq_handle_notify_resume();
>   4)   0.112 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.111 us    |    fpregs_assert_state_consistent();
>   4)   0.124 us    |    switch_fpu_return();
>   4) + 41.539 us   |  } /* exit_to_user_mode_prepare */
>   4)               |  vtime_user_enter() {
>   4)   0.189 us    |    get_vtime_delta();
>   4)   0.390 us    |  }
>   4)               |  vtime_user_exit() {
>   4)   0.178 us    |    get_vtime_delta();
>   4)   0.413 us    |  }
>   4)               |  irq_enter_rcu() {
>   4)   0.155 us    |    tick_irq_enter();
>   4)   0.428 us    |  }
>   4)               |  __sysvec_call_function_single() {
>   4)               |  /* call_function_single_entry: vector=251 */
>   4)   0.329 us    |    generic_smp_call_function_single_interrupt();
>   4)               |  /* call_function_single_exit: vector=251 */
>   4)   1.158 us    |  }
>   4)               |  irq_exit_rcu() {
>   4)   0.190 us    |    idle_cpu();
>   4)               |    tick_nohz_irq_exit() {
>   4)               |      /* tick_stop: success=0 dependency=SCHED */
>   4)   0.518 us    |    }
>   4)   1.128 us    |  }
>   4)               |  exit_to_user_mode_prepare() {
>   4)   0.128 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.109 us    |    __rcu_irq_enter_check_tick();
>   4)               |  /* reschedule_entry: vector=253 */
>   4)               |  /* reschedule_exit: vector=253 */
>   4)               |    raw_irqentry_exit_cond_resched() {
>   4)               |      /* sched_switch: prev_comm=hiccups_x86-64
> prev_pid=1335 prev_prio=120 prev_state=R+ ==> next_comm=kworker/4:1H
> next_pid=1348 next_prio=100 */
>  ------------------------------------------
>   4)  hiccups-1335  =>  kworker-1348
>  ------------------------------------------
> 
>   4) ! 277.107 us  |    } /* schedule */
>   4)   0.190 us    |    _raw_spin_lock_irq();
>   4)   6.380 us    |    process_one_work();
>   4)   0.128 us    |    worker_enter_idle();
>   4)   0.115 us    |    _raw_spin_unlock_irq();
>   4)               |    schedule() {
>   4)               |      /* sched_switch: prev_comm=kworker/4:1H
> prev_pid=1348 prev_prio=100 prev_state=I ==> next_comm=hiccups_x86-64
> next_pid=1335 next_prio=120 */
>  ------------------------------------------
>   4)  kworker-1348  =>  hiccups-1335
>  ------------------------------------------
> 
>   4) + 15.222 us   |    } /* raw_irqentry_exit_cond_resched */
>   4)   1.086 us    |    schedule();
>   4)   0.115 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.100 us    |    mem_cgroup_handle_over_high();
>   4)   0.106 us    |    blkcg_maybe_throttle_current();
>   4)   0.148 us    |    __rseq_handle_notify_resume();
>   4)   0.116 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.119 us    |    fpregs_assert_state_consistent();
>   4)   0.123 us    |    switch_fpu_return();
>   4) + 19.265 us   |  }
>   4)               |  vtime_user_enter() {
>   4)   0.160 us    |    get_vtime_delta();
>   4)   0.366 us    |  }
>   4)               |  vtime_user_exit() {
>   4)   0.173 us    |    get_vtime_delta();
>   4)   0.399 us    |  }
>   4)               |  irq_enter_rcu() {
>   4)   0.152 us    |    tick_irq_enter();
>   4)   0.380 us    |  }
>   4)               |  __sysvec_apic_timer_interrupt() {
>   4)               |  /* local_timer_entry: vector=236 */
>   4)   8.901 us    |    hrtimer_interrupt();
>   4)               |  /* local_timer_exit: vector=236 */
>   4)   9.422 us    |  }
>   4)               |  irq_exit_rcu() {
>   4)   0.394 us    |    wake_up_process();
>   4)   0.137 us    |    idle_cpu();
>   4)   0.677 us    |    tick_nohz_irq_exit();
>   4)   1.797 us    |  }
>   4)               |  exit_to_user_mode_prepare() {
>   4)   0.112 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)               |    schedule() {
>   4)               |      /* sched_switch: prev_comm=hiccups_x86-64
> prev_pid=1335 prev_prio=120 prev_state=R+ ==> next_comm=ktimers/4
> next_pid=1157 next_prio=98 */
>  ------------------------------------------
>   4)  hiccups-1335  =>  ktimers-1157
>  ------------------------------------------
> 
>   4)               |  finish_task_switch.isra.0() {
>   4)   0.564 us    |    vtime_task_switch_generic();
>   4)   0.210 us    |    __tick_nohz_task_switch();
>   4)   1.321 us    |  }
>   4)   0.213 us    |  kthread_should_stop();
>   4)   0.135 us    |  kthread_should_park();
>   4)   0.118 us    |  timersd_should_run();
>   4)               |  run_timersd() {
>   4)   0.409 us    |    __local_bh_disable_ip();
>   4)               |    __do_softirq() {
>   4)               |      /* timer_expire_entry:
> timer=00000000b281d363 function=delayed_work_timer_fn now=4295134337
> baseclk=4295016960 */
>   4)   4.507 us    |    }
>   4)   0.355 us    |    __local_bh_enable();
>   4)   5.864 us    |  }
>   4)   0.129 us    |  kthread_should_stop();
>   4)   0.102 us    |  kthread_should_park();
>   4)   0.099 us    |  timersd_should_run();
>   4)               |  schedule() {
>   4)   0.132 us    |    rcu_note_context_switch();
>   4)   0.114 us    |    _raw_spin_lock();
>   4)   0.122 us    |    update_rq_clock();
>   4)   1.191 us    |    dequeue_task_rt();
>   4)   0.184 us    |    balance_rt();
>   4)   0.120 us    |    balance_fair();
>   4)   0.233 us    |    put_prev_task_rt();
>   4)   0.121 us    |    pick_next_task_stop();
>   4)   0.121 us    |    pick_next_task_dl();
>   4)   0.175 us    |    pick_next_task_rt();
>   4)   0.442 us    |    __pick_next_task_fair();
>   4)   0.396 us    |    psi_task_switch();
>   4)               |    __traceiter_sched_switch() {
>   4)               |      /* sched_switch: prev_comm=ktimers/4
> prev_pid=1157 prev_prio=98 prev_state=S ==> next_comm=kworker/4:1
> next_pid=1163 next_prio=120 */
>   4)   0.269 us    |    }
>   4)   0.114 us    |    enter_lazy_tlb();
>  ------------------------------------------
>   4)  ktimers-1157  =>  kworker-1163
>  ------------------------------------------
> 
>   4)               |  finish_task_switch.isra.0() {
>   4)   0.288 us    |    vtime_task_switch_generic();
>   4)   0.116 us    |    __tick_nohz_task_switch();
>   4)   0.111 us    |    __rcu_irq_enter_check_tick();
>   4)   0.176 us    |    irq_enter_rcu();
>   4)               |    __sysvec_irq_work() {
>   4)               |      /* irq_work_entry: vector=246 */
>   4)               |      /* irq_work_exit: vector=246 */
>   4)   0.907 us    |    }
>   4)               |    irq_exit_rcu() {
>   4)               |      /* tick_stop: success=0 dependency=SCHED */
>   4)   0.554 us    |    }
>   4)   0.123 us    |    raw_irqentry_exit_cond_resched();
>   4)   3.596 us    |  }
>   4)               |  wq_worker_running() {
>   4)   0.101 us    |    kthread_data();
>   4)   0.344 us    |  }
>   4)   0.121 us    |  _raw_spin_lock_irq();
>   4)               |  process_one_work() {
>   4)   0.112 us    |    _raw_spin_unlock_irq();
>   4)   1.246 us    |    vmstat_update();
>   4)   0.107 us    |    _raw_spin_lock_irq();
>   4)   0.108 us    |    pwq_dec_nr_in_flight();
>   4)   2.356 us    |  }

This is your kworker doing work, if I am not too confused.
Preceded by a context switch.

>   4)   0.099 us    |  worker_enter_idle();
>   4)   0.097 us    |  _raw_spin_unlock_irq();
>   4)               |  schedule() {
>   4)   0.153 us    |    wq_worker_sleeping();
>   4)   0.194 us    |    rcu_note_context_switch();
>   4)   0.413 us    |    _raw_spin_lock();
>   4)   0.134 us    |    update_rq_clock();
>   4)   0.702 us    |    dequeue_task_fair();
>   4)   1.123 us    |    pick_next_task_fair();
>   4)   0.687 us    |    psi_task_switch();
>   4)               |    __traceiter_sched_switch() {
>   4)               |      /* sched_switch: prev_comm=kworker/4:1
> prev_pid=1163 prev_prio=120 prev_state=I ==> next_comm=hiccups_x86-64
> next_pid=1335 next_prio=120 */
>   4)   0.246 us    |    }
>   4)   0.139 us    |    switch_mm_irqs_off();
>  ------------------------------------------
>   4)  kworker-1163  =>  hiccups-1335
>  ------------------------------------------
> 
>   4) + 32.824 us   |    } /* schedule */
>   4)   0.113 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.110 us    |    mem_cgroup_handle_over_high();
>   4)   0.104 us    |    blkcg_maybe_throttle_current();
>   4)   0.151 us    |    __rseq_handle_notify_resume();
>   4)   0.116 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.097 us    |    fpregs_assert_state_consistent();
>   4)   0.102 us    |    switch_fpu_return();
>   4) + 34.991 us   |  } /* exit_to_user_mode_prepare */
>   4)               |  vtime_user_enter() {
>   4)   0.174 us    |    get_vtime_delta();
>   4)   0.388 us    |  }
>   4)               |  vtime_user_exit() {
>   4)   0.188 us    |    get_vtime_delta();
>   4)   0.456 us    |    account_user_time();
>   4)   1.118 us    |  }
>   4)               |  irq_enter_rcu() {
>   4)   0.158 us    |    tick_irq_enter();
>   4)   0.391 us    |  }
>   4)               |  __sysvec_apic_timer_interrupt() {
>   4)               |  /* local_timer_entry: vector=236 */
>   4)   5.066 us    |    hrtimer_interrupt();
>   4)               |  /* local_timer_exit: vector=236 */
>   4)   5.596 us    |  }
>   4)               |  irq_exit_rcu() {
>   4)   0.111 us    |    idle_cpu();
>   4)               |    tick_nohz_irq_exit() {
>   4)               |      /* tick_stop: success=1 dependency=NONE */
>   4)   5.546 us    |    }
>   4)   6.018 us    |  }
>   4)               |  exit_to_user_mode_prepare() {
>   4)   0.118 us    |    rcu_nocb_flush_deferred_wakeup();
>   4)   0.128 us    |    fpregs_assert_state_consistent();
>   4)   0.623 us    |  }
>   4)               |  vtime_user_enter() {
>   4)   0.158 us    |    get_vtime_delta();
>   4)   0.364 us    |  }

This looks like the kernel exiting to userspace?

> > Unless CPU 4 spends absolutely no time in the kernel, and never ever
> > has more than one runnable task at any given time.  And doesn't have
> > any other excuse to take a scheduling-clock interrupt.  Otherwise, CPU
> > 4's rcuc kthread will burn at least a little bit of time.  The more time
> > CPU 4 spends in the kernel and the more time CPU 4 spends with more than
> > one runnable task, the more time CPU 4's rcuc kthread will burn.
> >
> I am exactly trying to achieve this (again, but now on 6.1.*-rt* latest).
> 
> > > > I see this in the kernel boot log, and I wonder if this is related to my issue:
> > > >
> > > > [    0.063518] rcu:     RCU_SOFTIRQ processing moved to rcuc kthreads.
> >
> > This simply means that the processing that would have been done in
> > softirq (for example, by ksoftirqd) will now be done by rcuc.
> >
> Note that my kernel has the PREEMPT_RT patch, so I would expect any
> softirq to be a kthread anyway.
> 
> > > > tree.c:102:static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);
> > > >
> > > > Could this cause the rcuc threads to become active, even with the
> > > > "rcu_nocbs=all rcu_nocb_poll" setting?
> >
> > You can override this with rcutree.use_softirq=1 if you wish.  But that
> > will simply move the processing from the rcuc kthread to softirq context.
> >
> ...which is a kthread after all in PREEMPT_RT,  right?
> 
> > > That's unexpected. The RCU load should be moved from rcuc to rcuo* kthreads.
> > >
> > > Do you have CONFIG_RCU_STRICT_GRACE_PERIOD=y perhaps?
> > >
> No. I do have some _TIMEOUT related settings, that I am not sure of if
> they are rcuc side or rcuo* side:
> 
> 162:CONFIG_RCU_EXPERT=y
> 172:CONFIG_RCU_STALL_COMMON=y
> 173:CONFIG_RCU_NEED_SEGCBLIST=y
> 174:CONFIG_RCU_FANOUT=64
> 175:CONFIG_RCU_FANOUT_LEAF=16
> 176:CONFIG_RCU_BOOST=y
> 177:CONFIG_RCU_BOOST_DELAY=500
> 178:# CONFIG_RCU_EXP_KTHREAD is not set
> 179:CONFIG_RCU_NOCB_CPU=y

This combined with your nohz_full=4-7 will offload handling of RCU
callbacks to kthreads, but you should also check to make sure that
the resulting rcuo* kthreads are never running on CPUs 4-7.

> 180:# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> 181:CONFIG_RCU_NOCB_CPU_CB_BOOST=y
> 10445:# CONFIG_RCU_SCALE_TEST is not set
> 10446:# CONFIG_RCU_TORTURE_TEST is not set
> 10447:# CONFIG_RCU_REF_SCALE_TEST is not set
> 10448:CONFIG_RCU_CPU_STALL_TIMEOUT=21
> 10449:CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> 10450:# CONFIG_RCU_TRACE is not set
> 10451:# CONFIG_RCU_EQS_DEBUG is not set
> 
> > > Also do you really need rcu_nocb_poll? I would expect this option to be useful
> > > for debugging only, though I'm not aware of every usecases.
> >
> "Setting rcu_nocb_poll to relieve each CPU from the responsibility
> awakening their RCU offload threads".
> 
> I hoped this would decrease the CPU specific RCU (rcuc) side to become
> more silent on the timer. Or is it purely synchronous on the event
> anyway?

Without rcu_nocb_poll, when your kernel code does call_rcu(), for example,
when userspace closes a file, that call_rcu() will do a wakeup with
attendant overhead.  With rcu_nocb_poll, call_rcu() won't do wakeups
(unless your application (say) closes tens of thousands of files all at
once on a single CPU), but the rcuog* kthreads will wake up periodically
to poll.  Depending on what is pinned where, you might want either
setting of rcu_nocb_poll.

> > I have the same questions.  ;-)
> >
> Good, that means -EUSER is even more likely.  (five nines? :-) )

This file gives some information on per-CPU kthreads, a bit dated, but
still likely helpful:

Documentation/admin-guide/kernel-per-CPU-kthreads.rst

							Thanx, Paul
