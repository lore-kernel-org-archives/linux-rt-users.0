From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC 3/3] rt: Check if the task needs to migrate when
 re-enabling migration
Date: Fri, 16 Jun 2017 18:58:15 +0200
Message-ID: <20170616165815.mvu2jr323xy3dhf3@linutronix.de>
References: <cover.1497607974.git.bristot@redhat.com>
 <99de119c39e3af618efdb2f79bf30e60ca42a6ec.1497607974.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <99de119c39e3af618efdb2f79bf30e60ca42a6ec.1497607974.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-16 12:39:48 [+0200], Daniel Bristot de Oliveira wrote:
> In the case of an affinity change during a migrate_disable section,
> __set_cpus_allowed_ptr will not try to move the task from a CPU
> in which it cannot execute anymore.
> 
> So, after enabling migration, if the current task cannot execute in
> the current CPU anymore, migrate it away.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> ---
>  kernel/sched/core.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0396bf2..207bc85 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3462,6 +3462,34 @@ void migrate_enable(void)
>  			task_rq(p)->dl.dl_nr_migratory++;
>  	}
>  
> +	/*
> +	 * Check if the task can still run on this CPU. In the case of an
> +	 * affinity change during a migrate_disable section,
> +	 * __set_cpus_allowed_ptr will not try to move the task from a CPU
> +	 * that the task cannot execute anymore.
> +	 *
> +	 * So, if the current task cannot execute in the current CPU anymore,
> +	 * migrate it away.
> +	 */
> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), &p->cpus_allowed))) {
> +		const struct cpumask *cpu_mask = (p->flags & PF_KTHREAD) ?
> +			cpu_online_mask : cpu_active_mask;
> +
> +		int dest_cpu = cpumask_any_and(cpu_mask, &p->cpus_allowed);
> +		struct migration_arg arg = {p, dest_cpu};
> +
> +		/* Need help from migration thread: drop lock and wait. */
> +		task_rq_unlock(rq, p, &rf);
> +		unpin_current_cpu();
> +		preempt_enable();
> +		preempt_lazy_enable();
> +
> +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> +		tlb_migrate_finish(p->mm);
> +
> +		return;
> +	}

I noticed this problem (and the one you pointed out in 2/3) while
redoing this whole thing for v4.11. In v4.11 I added a field
current->migrate_disable_update [0]. Once it is set, I do what you do
here + __do_set_cpus_allowed_tail() which is the whole part that got
skipped in do_set_cpus_allowed(). 
Invoking set_cpus_allowed_common() as you do in 2/3 works in general but
sched_DL does a few extra things so I would suggest to backport that
part from v4.11. Also I have no idea if it is okay to run that hook for
DL if the task is still limited to only one CPU (instead in
migrate_enable()). So this is the backport for v4.9:

diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1535,6 +1535,7 @@ struct task_struct {
 	unsigned int policy;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int migrate_disable;
+	int migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
 	int migrate_disable_atomic;
 # endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1138,18 +1138,14 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void __do_set_cpus_allowed_tail(struct task_struct *p,
+				       const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
 	lockdep_assert_held(&p->pi_lock);
 
-	if (__migrate_disabled(p)) {
-		cpumask_copy(&p->cpus_allowed, new_mask);
-		return;
-	}
-
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 
@@ -1172,6 +1168,20 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_curr_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	if (__migrate_disabled(p)) {
+		lockdep_assert_held(&p->pi_lock);
+
+		cpumask_copy(&p->cpus_allowed, new_mask);
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+		p->migrate_disable_update = 1;
+#endif
+		return;
+	}
+	__do_set_cpus_allowed_tail(p, new_mask);
+}
+
 static DEFINE_PER_CPU(struct cpumask, sched_cpumasks);
 static DEFINE_MUTEX(sched_down_mutex);
 static cpumask_t sched_down_cpumask;
@@ -1307,9 +1317,16 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	}
 
 	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
+	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
 
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
+	if (__migrate_disabled(p)) {
+		p->migrate_disable_update = 1;
+		goto out;
+	}
+#endif
+
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
@@ -3435,6 +3452,43 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
+	if (p->migrate_disable_update) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		rq = task_rq_lock(p, &rf);
+		update_rq_clock(rq);
+
+		__do_set_cpus_allowed_tail(p, &p->cpus_allowed);
+		task_rq_unlock(rq, p, &rf);
+
+		p->migrate_disable_update = 0;
+
+		WARN_ON(smp_processor_id() != task_cpu(p));
+		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_allowed)) {
+			const struct cpumask *cpu_valid_mask = cpu_active_mask;
+			struct migration_arg arg;
+			unsigned int dest_cpu;
+
+			if (p->flags & PF_KTHREAD) {
+				/*
+				 * Kernel threads are allowed on online && !active CPUs
+				 */
+				cpu_valid_mask = cpu_online_mask;
+			}
+			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_allowed);
+			arg.task = p;
+			arg.dest_cpu = dest_cpu;
+
+			unpin_current_cpu();
+			preempt_lazy_enable();
+			preempt_enable();
+			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			tlb_migrate_finish(p->mm);
+			return;
+		}
+	}
+
 	unpin_current_cpu();
 	preempt_enable();
 	preempt_lazy_enable();

Any objections?

>  	task_rq_unlock(rq, p, &rf);
>  	unpin_current_cpu();
>  	preempt_enable();

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/sched/core.c?h=v4.11.5-rt1#n7635

Sebastian
