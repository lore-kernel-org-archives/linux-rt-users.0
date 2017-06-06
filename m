From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT V2] sched: Prevent task state corruption by spurious
 lock wakeup
Date: Tue, 6 Jun 2017 18:28:15 +0200
Message-ID: <20170606162815.jdurd7xa75fw57g7@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.20.1706021834070.1899@nanos>
 <alpine.DEB.2.20.1706030940220.2228@nanos>
 <alpine.DEB.2.20.1706061412290.1885@nanos>
 <alpine.DEB.2.20.1706061419150.1885@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1706061419150.1885@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jun 06, 2017 at 02:20:37PM +0200, Thomas Gleixner wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2210,7 +2210,7 @@ EXPORT_SYMBOL(wake_up_process);
>   */
>  int wake_up_lock_sleeper(struct task_struct *p)
>  {
> -	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
> +	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
>  }
>  
>  int wake_up_state(struct task_struct *p, unsigned int state)

Do we want this?

---
Subject: sched: Remove TASK_ALL

It's unused:

$ git grep "\<TASK_ALL\>" | wc -l
1

And dangerous, kill the bugger.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3dfa5f99d6ee..e88aadbe2071 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -94,7 +94,6 @@ struct task_group;
 
 /* Convenience macros for the sake of wake_up(): */
 #define TASK_NORMAL			(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL			(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state(): */
 #define TASK_REPORT			(TASK_RUNNING | TASK_INTERRUPTIBLE | \
