From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Fri, 24 Apr 2015 08:54:49 +0200
Message-ID: <1429858489.3461.28.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com> <552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>
	 <55389632.50308@siemens.com> <1429772482.3419.40.camel@gmail.com>
	 <55389B67.3000703@siemens.com> <1429773566.3419.42.camel@gmail.com>
	 <20150423170026.0de65c90@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423170026.0de65c90@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2015-04-23 at 17:00 -0400, Steven Rostedt wrote:
> On Thu, 23 Apr 2015 09:19:26 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>=20
> > >   CC      kernel/irq_work.o
> > > In file included from ../include/asm-generic/percpu.h:6:0,
> > >                  from ../arch/x86/include/asm/percpu.h:522,
> > >                  from ../arch/x86/include/asm/current.h:5,
> > >                  from ../arch/x86/include/asm/processor.h:15,
> > >                  from ../arch/x86/include/asm/irq_work.h:4,
> > >                  from ../include/linux/irq_work.h:47,
> > >                  from ../kernel/irq_work.c:11:
> > > ../kernel/irq_work.c: In function =E2=80=98irq_work_queue_on=E2=80=
=99:
> > > ../kernel/irq_work.c:85:17: error: =E2=80=98hirq_work_list=E2=80=99=
 undeclared=20
> > > (first use in this function)
> > >         &per_cpu(hirq_work_list, cpu));
> >=20
> > Aw poo, so that's just what I _thought_ it was for.
>=20
> It helps optimization but does nothing for undefined symbols.
>=20
> That said, why don't we clean up that irq_work code and at least
> declare both lists, and get rid of all the #ifdefs. I wonder if gcc i=
s
> smart enough to not allocate a static variable if it happens to be
> optimized out?

Nope, it didn't notice a thing.

This is a stab at that cleanup.  Usable as is with Jan's ok, or as
fodder for your bitmaster-9000 patch shredder, or whatever.  Box works
and it makes line count shrink...

I downgraded evolution v3.16->v3.12 to restore its ability to read it's
own fscking "Preformatted" switch, so whitespace should be fine.=20

Oh, btw, if anyone (else) makes a 4.1-rt, your rt push work will want
one of those nifty hirq tags lest box make boom due to trying to do tha=
t
not only way late, but with irqs enabled which pisses sched all off.

Subject: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date:	Thu, 16 Apr 2015 18:28:16 +0200
=46rom:	Jan Kiszka <jan.kiszka@siemens.com>

Instead of turning all irq_work requests into lazy ones on -rt, just
move their execution from hard into soft-irq context.

This resolves deadlocks of ftrace which will queue work from arbitrary
contexts, including those that have locks held that are needed for
raising a soft-irq.

Mike: cleanup ifdef mess and kill hirq_work_list.  We need two lists,
and already have them, merely need to select according to work type.
In -rt all work not tagged for hirq execution is queued to the lazy
list and runs via irq_work_tick().  Raising SOFTIRQ_TIMER is always
done via IPI for deadlock safety, if the work item is not a lazy work
or the tick is stopped, fire IPI immediately, otherwise let it wait.
IOW, lazy work is lazy in -rt only until someone queues immediate work.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---

Second try, looks much better so far. And it also removes my concerns
regarding other potential cases besides ftrace.

 kernel/irq_work.c |   85 ++++++++++++++++++++-------------------------=
---------
 1 file changed, 33 insertions(+), 52 deletions(-)

--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -23,9 +23,7 @@
=20
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
-#ifdef CONFIG_PREEMPT_RT_FULL
-static DEFINE_PER_CPU(struct llist_head, hirq_work_list);
-#endif
+
 /*
  * Claim the entry so that no one else will poke at it.
  */
@@ -68,7 +66,7 @@ void __weak arch_irq_work_raise(void)
  */
 bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
-	bool raise_irqwork;
+	struct llist_head *list;
=20
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -80,19 +78,12 @@ bool irq_work_queue_on(struct irq_work *
 	if (!irq_work_claim(work))
 		return false;
=20
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ)
-		raise_irqwork =3D llist_add(&work->llnode,
-					  &per_cpu(hirq_work_list, cpu));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HA=
RD_IRQ))
+		list =3D &per_cpu(lazy_list, cpu);
 	else
-		raise_irqwork =3D llist_add(&work->llnode,
-					  &per_cpu(lazy_list, cpu));
-#else
-		raise_irqwork =3D llist_add(&work->llnode,
-					  &per_cpu(raised_list, cpu));
-#endif
+		list =3D &per_cpu(raised_list, cpu);
=20
-	if (raise_irqwork)
+	if (llist_add(&work->llnode, list))
 		arch_send_call_function_single_ipi(cpu);
=20
 	return true;
@@ -103,6 +94,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
+	struct llist_head *list;
+	bool lazy_work, realtime =3D IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
@@ -110,25 +104,17 @@ bool irq_work_queue(struct irq_work *wor
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
=20
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (work->flags & IRQ_WORK_HARD_IRQ) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			raise_softirq(TIMER_SOFTIRQ);
-	}
-#else
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+	lazy_work =3D work->flags & IRQ_WORK_LAZY;
+
+	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+		list =3D this_cpu_ptr(&lazy_list);
+	else
+		list =3D this_cpu_ptr(&raised_list);
+
+	if (llist_add(&work->llnode, list)) {
+		if (!lazy_work || tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	}
-#endif
=20
 	preempt_enable();
=20
@@ -143,12 +129,8 @@ bool irq_work_needs_cpu(void)
 	raised =3D this_cpu_ptr(&raised_list);
 	lazy =3D this_cpu_ptr(&lazy_list);
=20
-	if (llist_empty(raised))
-		if (llist_empty(lazy))
-#ifdef CONFIG_PREEMPT_RT_FULL
-			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
-#endif
-				return false;
+	if (llist_empty(raised) && llist_empty(lazy))
+		return false;
=20
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
@@ -162,9 +144,7 @@ static void irq_work_run_list(struct lli
 	struct irq_work *work;
 	struct llist_node *llnode;
=20
-#ifndef CONFIG_PREEMPT_RT_FULL
-	BUG_ON(!irqs_disabled());
-#endif
+	BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !irqs_disabled());
=20
 	if (llist_empty(list))
 		return;
@@ -200,26 +180,27 @@ static void irq_work_run_list(struct lli
  */
 void irq_work_run(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&hirq_work_list));
-#else
 	irq_work_run_list(this_cpu_ptr(&raised_list));
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-#endif
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+		/*
+		 * NOTE: we raise softirq via IPI for safety,
+		 * and execute in irq_work_tick() to move the
+		 * overhead from hard to soft irq context.
+		 */
+		if (!llist_empty(this_cpu_ptr(&lazy_list)))
+			raise_softirq(TIMER_SOFTIRQ);
+	} else
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
=20
 void irq_work_tick(void)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-#else
-	struct llist_head *raised =3D &__get_cpu_var(raised_list);
+	struct llist_head *raised =3D this_cpu_ptr(&raised_list);
=20
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
-	irq_work_run_list(&__get_cpu_var(lazy_list));
-#endif
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
=20
 /*
