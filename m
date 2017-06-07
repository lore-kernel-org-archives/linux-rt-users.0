From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT V2] sched: Prevent task state corruption by spurious
 lock wakeup
Date: Wed, 7 Jun 2017 22:18:12 +0200
Message-ID: <20170607201812.426qdkyd75z3vpcy@linutronix.de>
References: <alpine.DEB.2.20.1706021834070.1899@nanos>
 <alpine.DEB.2.20.1706030940220.2228@nanos>
 <alpine.DEB.2.20.1706061412290.1885@nanos>
 <alpine.DEB.2.20.1706061419150.1885@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706061419150.1885@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-06 14:20:37 [+0200], Thomas Gleixner wrote:
> Mathias and others reported GDB failures on RT.
> 
> The following scenario leads to task state corruption:
> 
> CPU0						CPU1
> 
> T1->state = TASK_XXX;
> spin_lock(&lock)
>   rt_spin_lock_slowlock(&lock->rtmutex)
>     raw_spin_lock(&rtm->wait_lock);
>     T1->saved_state = current->state;
>     T1->state = TASK_UNINTERRUPTIBLE;
> 						spin_unlock(&lock)
>     task_blocks_on_rt_mutex(rtm)  		  rt_spin_lock_slowunlock(&lock->rtmutex)
>       queue_waiter(rtm)				    raw_spin_lock(&rtm->wait_lock);
>       pi_chain_walk(rtm)
>         raw_spin_unlock(&rtm->wait_lock);
> 						    wake_top_waiter(T1)
> 
>       raw_spin_lock(&rtm->wait_lock);
>     
> 
>     for (;;) {
>       if (__try_to_take_rt_mutex())  <- Succeeds
>         break;
>       ...
>     }
> 	
>     T1->state = T1->saved_state;
> 						     try_to_wake_up(T1)
> 						       ttwu_do_wakeup(T1)
> 						         T1->state = TASK_RUNNING;
> 
> In most cases this is harmless because waiting for some event, which is the
> usual reason for TASK_[UN]INTERRUPTIBLE has to be safe against other forms
> of spurious wakeups anyway.
> 
> But in case of TASK_TRACED this is actually fatal, because the task loses
> the TASK_TRACED state. In consequence it fails to consume SIGSTOP which was
> sent from the debugger and actually delivers SIGSTOP to the task which
> breaks the ptrace mechanics and brings the debugger into an unexpected
> state.
> 
> The TASK_TRACED state should prevent getting there due to the state
> matching logic in try_to_wake_up(). But that's not true because
> wake_up_lock_sleeper() uses TASK_ALL as state mask. That's bogus because
> lock sleepers always use TASK_UNINTERRUPTIBLE, so the wakeup should use
> that as well.
> 
> The cure is way simpler as figuring it out:
> 
> Change the mask used in wake_up_lock_sleeper() from TASK_ALL to
> TASK_UNINTERRUPTIBLE.
> 
> Reported-by: Mathias Koehrer <mathias.koehrer@etas.com>
> Reported-by: David Hauck <davidh@netacquire.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable-rt@vger.kernel.org

Applied

Sebastian
