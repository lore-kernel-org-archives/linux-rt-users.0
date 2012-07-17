From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch RT 1/3] cpu/rt: Rework cpu down for PREEMPT_RT
Date: Mon, 16 Jul 2012 23:16:38 -0400
Message-ID: <1342494998.24525.6.camel@gandalf.stny.rr.com>
References: <20120715090141.942753287@linutronix.de>
	 <20120715091932.036115656@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120715091932.036115656@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-07-16 at 08:07 +0000, Thomas Gleixner wrote:

I know you are on vacation (hope you are enjoying yourself ;-)


> ---
>  include/linux/sched.h |    7 ++
>  kernel/cpu.c          |  236 +++++++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/core.c   |   82 +++++++++++++++++-
>  3 files changed, 285 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7fc8321..777f7bb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1973,6 +1973,10 @@ extern void do_set_cpus_allowed(struct task_struct *p,
>  
>  extern int set_cpus_allowed_ptr(struct task_struct *p,
>  				const struct cpumask *new_mask);
> +int migrate_me(void);
> +void tell_sched_cpu_down_begin(int cpu);
> +void tell_sched_cpu_down_done(int cpu);
> +
>  #else
>  static inline void do_set_cpus_allowed(struct task_struct *p,
>  				      const struct cpumask *new_mask)
> @@ -1985,6 +1989,9 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p,
>  		return -EINVAL;
>  	return 0;
>  }
> +static inline int migrate_me(void) { return 0; }
> +static inline void tell_sched_cpu_down_begin(int cpu) { }
> +static inline void tell_sched_cpu_down_done(int cpu) { }
>  #endif
>  
>  #ifndef CONFIG_CPUMASK_OFFSTACK
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index d79d33a..c5b3273 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -46,12 +46,7 @@ static int cpu_hotplug_disabled;
>  
>  static struct {
>  	struct task_struct *active_writer;
> -#ifdef CONFIG_PREEMPT_RT_FULL
> -	/* Makes the lock keep the task's state */
> -	spinlock_t lock;
> -#else
>  	struct mutex lock; /* Synchronizes accesses to refcount, */
> -#endif
>  	/*
>  	 * Also blocks the new readers during
>  	 * an ongoing cpu hotplug operation.
> @@ -67,20 +62,42 @@ static struct {

As I was backporting this to 3.0-rt, I noticed that the following is
needed too:

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c5b3273..3e722c0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,11 +54,7 @@ static struct {
 	int refcount;
 } cpu_hotplug = {
 	.active_writer = NULL,
-#ifdef CONFIG_PREEMPT_RT_FULL
-	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
-#else
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
-#endif
 	.refcount = 0,
 };

As this goes with part of the applied patch above.
 
I'll add this on top, if no one objects.

-- Steve
