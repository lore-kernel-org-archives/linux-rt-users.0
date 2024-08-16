Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD41BC9F4;
	Fri, 16 Aug 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817204; cv=none; b=NEk0YhiLYWG0SQzaSIDOakyWvY2G9tXgH3B4C55LJcXb4MLMMMTZcSfGfOtSjs5cgZzCbdr9y7HyPse6+eH0g0PVcLdIMY+UG8qe10xjhIYoxJhzrc5bqEzDV3JjAeHpg5F9EhJwNb/H0c+j45/tNDJd59I2f/pzXqPQli1Gakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817204; c=relaxed/simple;
	bh=7shEPdJf0CafYrHC9Ib1ES84Fg0sKjcDSfEimrrQ11M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY0FksgT4l2cwAutVisUa7CX/7P2DgOz8CboOvyt62LC6Eok3MXd5E/A+cap5IPd3XsMyD71KNzduC7df6j8pZm12oY6XttNNCS16ALS6NDR+xiQCrlgiaZoaKs3o+RCOijr0adCbNAvowLKiNNZxEPWlVnSKEPb2nNcaq1gaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBBFku4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBBFku4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11393C32782;
	Fri, 16 Aug 2024 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723817204;
	bh=7shEPdJf0CafYrHC9Ib1ES84Fg0sKjcDSfEimrrQ11M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBBFku4oIg4qGYo9iR8BFgBtfnQLRrbrDhEIcTA4Y/2e40S7pyuQZGoQhspNTJPrB
	 H9ZVzJPI7um2trmBLeYiykugPqxZBAxfz6cAddT/XW9xMM8j+3dvjwaP2etHJpk2gN
	 HHDOi8aFmdnM5DsgiB8i4w2kFkZkQTYkzaTuIobkMwhvUp6bloWPeCXiQSLOPb4YeU
	 25e5l8Wm8KDHP2Ll7OO6UwZasVYTsuvBkJEQUQUFYpOgpjoUvTA2VYvKIw/eGwa5qb
	 y3hWS4ynf8CxYbGQ90Y0AnGLPGZdCcNrH1xBLLkaIylDzSbS5NihUcew0/JF5C1kRC
	 8NoS71JtC8C5A==
Date: Fri, 16 Aug 2024 16:06:41 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Leon Woestenberg <leon@sidebranch.com>
Cc: paulmck@kernel.org, linux-rt-users@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: Unexpected rcuc osnoise on PREEMPT_RT with "rcu_nocbs=all
 rcu_nocb_poll"
Message-ID: <Zr9c8cawtQ0eMt-Z@pavilion.home>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMjhiJhbKF_Yt_0Js6AEbjCHTZAMNRejCw7eiCGZL8L_Y97-Gw@mail.gmail.com>

Le Mon, Jan 22, 2024 at 03:32:44PM +0100, Leon Woestenberg a écrit :
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

I'm not seeing rcuc here in this trace. Do you have another one?

OTOH I see quite some workqueue activity and some timer callbacks.
For example blk_mq_run_work_fn() (doing IO from isolated CPU ?)
And also vmstat which should be handled since v6.4 with:

be5e015d107d (vmstat: skip periodic vmstat update for isolated CPUs)

Thanks.
