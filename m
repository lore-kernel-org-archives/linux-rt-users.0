From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.4.7-rt16
Date: Fri, 15 Apr 2016 19:49:08 +0200
Message-ID: <20160415174908.GA32486@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.4.7-rt16 patch set.
Changes since v4.4.7-rt15:

- picked a few panic() re-entrance from NMI fixes from upstream. On -RT
  we have the same problem without NMI but with the soft/hard watchdog
  triggering panic().

- Don't take the port->lock on oops_in_progress. We had a trylock but
  that trylock does not work if invoked with IRQs off (like from the
  panic() caller). I am not very happy about this but if we keep it
  that way it would make sense to make a similar change for the other
  UART drivers=E2=80=A6

- Rik van Riel and Clark Williams pointed out that a change made by
  Frederic Weisbecker in v4.5 could be backported and then we could
  remove some locking around vtime handling.=20

Known issues:
  - CPU hotplug got a little better but can deadlock.

The delta patch against 4.4.7-rt15 is appended below and can be found h=
ere:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-=
4.4.7-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git=
 v4.4.7-rt16

The RT patch against 4.4.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.7=
-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4=
=2E7-rt16.tar.xz

Sebastian

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 697f90db0e37..424aec4a4c71 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -231,7 +231,7 @@ pci_serr_error(unsigned char reason, struct pt_regs=
 *regs)
 #endif
=20
 	if (panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
=20
 	pr_emerg("Dazed and confused, but trying to continue\n");
=20
@@ -255,8 +255,16 @@ io_check_error(unsigned char reason, struct pt_reg=
s *regs)
 		 reason, smp_processor_id());
 	show_regs(regs);
=20
-	if (panic_on_io_nmi)
-		panic("NMI IOCK error: Not continuing");
+	if (panic_on_io_nmi) {
+		nmi_panic(regs, "NMI IOCK error: Not continuing");
+
+		/*
+		 * If we end up here, it means we have received an NMI while
+		 * processing panic(). Simply return without delaying and
+		 * re-enabling NMIs.
+		 */
+		return;
+	}
=20
 	/* Re-enable the IOCK line, wait for a few seconds */
 	reason =3D (reason & NMI_REASON_CLEAR_MASK) | NMI_REASON_CLEAR_IOCHK;
@@ -297,7 +305,7 @@ unknown_nmi_error(unsigned char reason, struct pt_r=
egs *regs)
=20
 	pr_emerg("Do you have a strange power saving mode enabled?\n");
 	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
-		panic("NMI: Not continuing");
+		nmi_panic(regs, "NMI: Not continuing");
=20
 	pr_emerg("Dazed and confused, but trying to continue\n");
 }
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f660d63f40fe..8384207adde2 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -726,6 +726,7 @@ static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
=20
 static atomic_t waiting_for_crash_ipi;
+static int crash_ipi_issued;
=20
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
@@ -788,6 +789,9 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
=20
 	smp_send_nmi_allbutself();
=20
+	/* Kick CPUs looping in NMI context. */
+	WRITE_ONCE(crash_ipi_issued, 1);
+
 	msecs =3D 1000; /* Wait at most a second for the other cpus to stop *=
/
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
@@ -796,6 +800,22 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
=20
 	/* Leave the nmi callback set */
 }
+
+/* Override the weak function in kernel/panic.c */
+void nmi_panic_self_stop(struct pt_regs *regs)
+{
+	while (1) {
+		/*
+		 * Wait for the crash dumping IPI to be issued, and then
+		 * call its callback directly.
+		 */
+		if (READ_ONCE(crash_ipi_issued))
+			crash_nmi_callback(0, regs); /* Don't return */
+
+		cpu_relax();
+	}
+}
+
 #else /* !CONFIG_SMP */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 91b831a1cc1c..a0b9e854672c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2844,9 +2844,9 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
=20
 	serial8250_rpm_get(up);
=20
-	if (port->sysrq)
+	if (port->sysrq || oops_in_progress)
 		locked =3D 0;
-	else if (oops_in_progress || in_kdb_printk())
+	else if (in_kdb_printk())
 		locked =3D spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index d8ec0f202eee..60fadde71a44 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -156,8 +156,7 @@ extern struct task_group root_task_group;
=20
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 # define INIT_VTIME(tsk)						\
-	.vtime_lock =3D __RAW_SPIN_LOCK_UNLOCKED(tsk.vtime_lock),	\
-	.vtime_seq =3D SEQCNT_ZERO(tsk.vtime_seq),			\
+	.vtime_seqcount =3D SEQCNT_ZERO(tsk.vtime_seqcount),	\
 	.vtime_snap =3D 0,				\
 	.vtime_snap_whence =3D VTIME_SYS,
 #else
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c44e33a49a08..c84b10d6527d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -259,6 +259,7 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
+void nmi_panic(struct pt_regs *regs, const char *msg);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
@@ -450,6 +451,14 @@ extern int sysctl_panic_on_stackoverflow;
 extern bool crash_kexec_post_notifiers;
=20
 /*
+ * panic_cpu is used for synchronizing panic() and crash_kexec() execu=
tion. It
+ * holds a CPU number which is executing panic() currently. A value of
+ * PANIC_CPU_INVALID means no CPU has entered panic() or crash_kexec()=
=2E
+ */
+extern atomic_t panic_cpu;
+#define PANIC_CPU_INVALID	-1
+
+/*
  * Only to be used by arch init code. If the user over-wrote the defau=
lt
  * CONFIG_PANIC_TIMEOUT, honor it.
  */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 58c5ec8c3742..f9a0f2b540f1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1539,12 +1539,14 @@ struct task_struct {
 	cputime_t gtime;
 	struct prev_cputime prev_cputime;
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-	raw_spinlock_t vtime_lock;
-	seqcount_t vtime_seq;
+	seqcount_t vtime_seqcount;
 	unsigned long long vtime_snap;
 	enum {
-		VTIME_SLEEPING =3D 0,
+		/* Task is sleeping or running in a CPU with VTIME inactive */
+		VTIME_INACTIVE =3D 0,
+		/* Task runs in userspace in a CPU with VTIME active */
 		VTIME_USER,
+		/* Task runs in kernelspace in a CPU with VTIME active */
 		VTIME_SYS,
 	} vtime_snap_whence;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 46c1e8342ad8..4e93b4ea33f7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1379,10 +1379,9 @@ static struct task_struct *copy_process(unsigned=
 long clone_flags,
 	prev_cputime_init(&p->prev_cputime);
=20
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-	raw_spin_lock_init(&p->vtime_lock);
-	seqcount_init(&p->vtime_seq);
+	seqcount_init(&p->vtime_seqcount);
 	p->vtime_snap =3D 0;
-	p->vtime_snap_whence =3D VTIME_SLEEPING;
+	p->vtime_snap_whence =3D VTIME_INACTIVE;
 #endif
=20
 #if defined(SPLIT_RSS_COUNTING)
diff --git a/kernel/panic.c b/kernel/panic.c
index 50d4ae2e7d1b..3535f802953a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -61,6 +61,37 @@ void __weak panic_smp_self_stop(void)
 		cpu_relax();
 }
=20
+/*
+ * Stop ourselves in NMI context if another CPU has already panicked. =
Arch code
+ * may override this to prepare for crash dumping, e.g. save regs info=
=2E
+ */
+void __weak nmi_panic_self_stop(struct pt_regs *regs)
+{
+	panic_smp_self_stop();
+}
+
+atomic_t panic_cpu =3D ATOMIC_INIT(PANIC_CPU_INVALID);
+
+/*
+ * A variant of panic() called from NMI context. We return if we've al=
ready
+ * panicked on this CPU. If another CPU already panicked, loop in
+ * nmi_panic_self_stop() which can provide architecture dependent code=
 such
+ * as saving register state for crash dump.
+ */
+void nmi_panic(struct pt_regs *regs, const char *msg)
+{
+	int old_cpu, cpu;
+
+	cpu =3D raw_smp_processor_id();
+	old_cpu =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
+
+	if (old_cpu =3D=3D PANIC_CPU_INVALID)
+		panic("%s", msg);
+	else if (old_cpu !=3D cpu)
+		nmi_panic_self_stop(regs);
+}
+EXPORT_SYMBOL(nmi_panic);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -71,17 +102,17 @@ void __weak panic_smp_self_stop(void)
  */
 void panic(const char *fmt, ...)
 {
-	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next =3D 0;
 	int state =3D 0;
+	int old_cpu, this_cpu;
=20
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
 	 * from deadlocking the first cpu that invokes the panic, since
 	 * there is nothing to prevent an interrupt handler (that runs
-	 * after the panic_lock is acquired) from invoking panic again.
+	 * after setting panic_cpu) from invoking panic() again.
 	 */
 	local_irq_disable();
=20
@@ -94,8 +125,16 @@ void panic(const char *fmt, ...)
 	 * multiple parallel invocations of panic, all other CPUs either
 	 * stop themself or will wait until they are stopped by the 1st CPU
 	 * with smp_send_stop().
+	 *
+	 * `old_cpu =3D=3D PANIC_CPU_INVALID' means this is the 1st CPU which
+	 * comes here, so go ahead.
+	 * `old_cpu =3D=3D this_cpu' means we came from nmi_panic() which set=
s
+	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
 	 */
-	if (!spin_trylock(&panic_lock))
+	this_cpu =3D raw_smp_processor_id();
+	old_cpu  =3D atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
+
+	if (old_cpu !=3D PANIC_CPU_INVALID && old_cpu !=3D this_cpu)
 		panic_smp_self_stop();
=20
 	console_verbose();
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index c45f4b026230..4611b1c1cb12 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -680,7 +680,7 @@ static cputime_t get_vtime_delta(struct task_struct=
 *tsk)
 {
 	unsigned long long delta =3D vtime_delta(tsk);
=20
-	WARN_ON_ONCE(tsk->vtime_snap_whence =3D=3D VTIME_SLEEPING);
+	WARN_ON_ONCE(tsk->vtime_snap_whence =3D=3D VTIME_INACTIVE);
 	tsk->vtime_snap +=3D delta;
=20
 	/* CHECKME: always safe to convert nsecs to cputime? */
@@ -696,45 +696,37 @@ static void __vtime_account_system(struct task_st=
ruct *tsk)
=20
 void vtime_account_system(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	__vtime_account_system(tsk);
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
=20
 void vtime_gen_account_irq_exit(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	__vtime_account_system(tsk);
 	if (context_tracking_in_user())
 		tsk->vtime_snap_whence =3D VTIME_USER;
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
=20
 void vtime_account_user(struct task_struct *tsk)
 {
 	cputime_t delta_cpu;
=20
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	delta_cpu =3D get_vtime_delta(tsk);
 	tsk->vtime_snap_whence =3D VTIME_SYS;
 	account_user_time(tsk, delta_cpu, cputime_to_scaled(delta_cpu));
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
=20
 void vtime_user_enter(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	__vtime_account_system(tsk);
 	tsk->vtime_snap_whence =3D VTIME_USER;
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
=20
 void vtime_guest_enter(struct task_struct *tsk)
@@ -746,23 +738,19 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 * synchronization against the reader (task_gtime())
 	 * that can thus safely catch up with a tickless delta.
 	 */
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	__vtime_account_system(tsk);
 	current->flags |=3D PF_VCPU;
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
=20
 void vtime_guest_exit(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
-	write_seqcount_begin(&tsk->vtime_seq);
+	write_seqcount_begin(&tsk->vtime_seqcount);
 	__vtime_account_system(tsk);
 	current->flags &=3D ~PF_VCPU;
-	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
+	write_seqcount_end(&tsk->vtime_seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
=20
@@ -775,30 +763,26 @@ void vtime_account_idle(struct task_struct *tsk)
=20
 void arch_vtime_task_switch(struct task_struct *prev)
 {
-	raw_spin_lock(&prev->vtime_lock);
-	write_seqcount_begin(&prev->vtime_seq);
-	prev->vtime_snap_whence =3D VTIME_SLEEPING;
-	write_seqcount_end(&prev->vtime_seq);
-	raw_spin_unlock(&prev->vtime_lock);
+	write_seqcount_begin(&prev->vtime_seqcount);
+	prev->vtime_snap_whence =3D VTIME_INACTIVE;
+	write_seqcount_end(&prev->vtime_seqcount);
=20
-	raw_spin_lock(&current->vtime_lock);
-	write_seqcount_begin(&current->vtime_seq);
+	write_seqcount_begin(&current->vtime_seqcount);
 	current->vtime_snap_whence =3D VTIME_SYS;
 	current->vtime_snap =3D sched_clock_cpu(smp_processor_id());
-	write_seqcount_end(&current->vtime_seq);
-	raw_spin_unlock(&current->vtime_lock);
+	write_seqcount_end(&current->vtime_seqcount);
 }
=20
 void vtime_init_idle(struct task_struct *t, int cpu)
 {
 	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&t->vtime_lock, flags);
-	write_seqcount_begin(&t->vtime_seq);
+	local_irq_save(flags);
+	write_seqcount_begin(&t->vtime_seqcount);
 	t->vtime_snap_whence =3D VTIME_SYS;
 	t->vtime_snap =3D sched_clock_cpu(cpu);
-	write_seqcount_end(&t->vtime_seq);
-	raw_spin_unlock_irqrestore(&t->vtime_lock, flags);
+	write_seqcount_end(&t->vtime_seqcount);
+	local_irq_restore(flags);
 }
=20
 cputime_t task_gtime(struct task_struct *t)
@@ -810,13 +794,13 @@ cputime_t task_gtime(struct task_struct *t)
 		return t->gtime;
=20
 	do {
-		seq =3D read_seqcount_begin(&t->vtime_seq);
+		seq =3D read_seqcount_begin(&t->vtime_seqcount);
=20
 		gtime =3D t->gtime;
 		if (t->flags & PF_VCPU)
 			gtime +=3D vtime_delta(t);
=20
-	} while (read_seqcount_retry(&t->vtime_seq, seq));
+	} while (read_seqcount_retry(&t->vtime_seqcount, seq));
=20
 	return gtime;
 }
@@ -839,7 +823,7 @@ fetch_task_cputime(struct task_struct *t,
 		*udelta =3D 0;
 		*sdelta =3D 0;
=20
-		seq =3D read_seqcount_begin(&t->vtime_seq);
+		seq =3D read_seqcount_begin(&t->vtime_seqcount);
=20
 		if (u_dst)
 			*u_dst =3D *u_src;
@@ -847,7 +831,7 @@ fetch_task_cputime(struct task_struct *t,
 			*s_dst =3D *s_src;
=20
 		/* Task is sleeping, nothing to add */
-		if (t->vtime_snap_whence =3D=3D VTIME_SLEEPING ||
+		if (t->vtime_snap_whence =3D=3D VTIME_INACTIVE ||
 		    is_idle_task(t))
 			continue;
=20
@@ -863,7 +847,7 @@ fetch_task_cputime(struct task_struct *t,
 			if (t->vtime_snap_whence =3D=3D VTIME_SYS)
 				*sdelta =3D delta;
 		}
-	} while (read_seqcount_retry(&t->vtime_seq, seq));
+	} while (read_seqcount_retry(&t->vtime_seqcount, seq));
 }
=20
=20
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d974121159ca..47d143740774 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -361,7 +361,7 @@ static void watchdog_overflow_callback(struct perf_=
event *event,
=20
 		raw_spin_unlock(&watchdog_output_lock);
 		if (hardlockup_panic)
-			panic("Hard LOCKUP");
+			nmi_panic(regs, "Hard LOCKUP");
=20
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d..1199ebade17b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
