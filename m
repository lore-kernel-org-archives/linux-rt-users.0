From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] sched: Prevent task state corruption by spurious lock
 wakeup
Date: Sat, 3 Jun 2017 09:47:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706030940220.2228@nanos>
References: <alpine.DEB.2.20.1706021834070.1899@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706021834070.1899@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2 Jun 2017, Thomas Gleixner wrote:

> Mathias and some others reported GDB failures on RT.
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
> 						    mark_top_waiter_for_wakeup(T1)
> 						    raw_spin_unlock(&rtm->wait_lock);
>       raw_spin_lock(&rtm->wait_lock);
> 						    wake_up_top_waiter()    
> 
>     for (;;) {
>       if (__try_to_take_rt_mutex())  <- Succeeds
>         break;
>       ...
>     }
> 						     try_to_wake_up(T1)
>     T1->state = T1->saved_state;
>     ==> T1->state == TASK_XXX
> 						       ttwu_do_wakeup(T1)
> 				FAIL ---->               T1->state = TASK_RUNNING;
> 
> 
> In most cases this is harmless because waiting for some event, which is the
> usual reason for TASK_[UN]INTERRUPTIBLE, has to be safe against other forms
> of spurious wakeups anyway.
> 
> But in case of TASK_TRACED this is actually fatal, because the task loses
> the TASK_TRACED state. In consequence it fails to consume SIGSTOP which was
> sent from the debugger and actually delivers SIGSTOP to the task which
> breaks the ptrace mechanics and brings the debugger into an unexpected
> state.
> 
> The cure is way simpler as figuring it out:
> 
> In a lock wakeup, check whether the task is actually blocked on a lock. If
> yes, deliver it. If not, consider the wakeup spurious and exit the wake up
> code without touching tasks state.

After recovering from heat and ptrace induced brain melt, I have to say
that the fix is actually working, but it's not fixing the root cause of the
problem.

If the to be woken task has state TASK_TRACED then the wakeup state check
should not match. But for some stupid reason wake_up_lock_sleeper() should
not use TASK_ALL. The lock sleepers are in state UNINTERRUPTIBLE, so the
wake state should be UNINTERRUPTIBLE as well.

The extra check in try_to_wake_up() should stay though as it prevents
spurious wake ups in general.

Delta patch below.

Thanks,

	tglx

8<------------------
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2220,7 +2220,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
