From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] sched: Prevent task state corruption by spurious lock wakeup
Date: Thu, 23 Nov 2017 00:33:45 -0500
Message-ID: <20171123053433.742369630@goodmis.org>
References: <20171123053341.174002403@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-sched-Prevent-task-state-corruption-by-spurious-lock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.97-rt111-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Mathias and others reported GDB failures on RT.

The following scenario leads to task state corruption:

CPU0						CPU1

T1->state = TASK_XXX;
spin_lock(&lock)
  rt_spin_lock_slowlock(&lock->rtmutex)
    raw_spin_lock(&rtm->wait_lock);
    T1->saved_state = current->state;
    T1->state = TASK_UNINTERRUPTIBLE;
						spin_unlock(&lock)
    task_blocks_on_rt_mutex(rtm)  		  rt_spin_lock_slowunlock(&lock->rtmutex)
      queue_waiter(rtm)				    raw_spin_lock(&rtm->wait_lock);
      pi_chain_walk(rtm)
        raw_spin_unlock(&rtm->wait_lock);
						    wake_top_waiter(T1)

      raw_spin_lock(&rtm->wait_lock);

    for (;;) {
      if (__try_to_take_rt_mutex())  <- Succeeds
        break;
      ...
    }

    T1->state = T1->saved_state;
						     try_to_wake_up(T1)
						       ttwu_do_wakeup(T1)
						         T1->state = TASK_RUNNING;

In most cases this is harmless because waiting for some event, which is the
usual reason for TASK_[UN]INTERRUPTIBLE has to be safe against other forms
of spurious wakeups anyway.

But in case of TASK_TRACED this is actually fatal, because the task loses
the TASK_TRACED state. In consequence it fails to consume SIGSTOP which was
sent from the debugger and actually delivers SIGSTOP to the task which
breaks the ptrace mechanics and brings the debugger into an unexpected
state.

The TASK_TRACED state should prevent getting there due to the state
matching logic in try_to_wake_up(). But that's not true because
wake_up_lock_sleeper() uses TASK_ALL as state mask. That's bogus because
lock sleepers always use TASK_UNINTERRUPTIBLE, so the wakeup should use
that as well.

The cure is way simpler as figuring it out:

Change the mask used in wake_up_lock_sleeper() from TASK_ALL to
TASK_UNINTERRUPTIBLE.

Cc: stable-rt@vger.kernel.org
Reported-by: Mathias Koehrer <mathias.koehrer@etas.com>
Reported-by: David Hauck <davidh@netacquire.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ed9550c87f66..970b893a1d15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2212,7 +2212,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
-- 
2.13.2
