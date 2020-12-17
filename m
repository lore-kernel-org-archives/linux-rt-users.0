Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B46C2BB48
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Dec 2020 12:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE87221F8
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Dec 2020 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgLQMUr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Dec 2020 07:20:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45570 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgLQMUo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Dec 2020 07:20:44 -0500
Date:   Thu, 17 Dec 2020 13:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608207593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDAXXDJx8OB/NbrJyyUPHdizuDecpKtIJlKvegA1Lvw=;
        b=Pp3JXuP4E9VdPMe/9HZZf18c+v0TdpxpNyKQ6lHUxowrcC/JwYywDNDLteJSuaM6Aww75p
        DtlyIk5rShhu59hPUXKfFnn/P6uun+PA8AF2aia2+WM4VNOIWdOaKNBbd0tjNYwlYjhuoV
        onf7Ul3kDQWgpvEGcxusN8RtVjvjgrSODGbZwVgGtCTNg5iHi3OmSgVa8iSAG1bcoXQEjr
        xrmXRhYq1qxtHR32ygcmmMoAGagUUXMe+oGCBWLOB4eBt0zMuPlYIxGYExQmle7Oy15Eme
        qa+cXwMB5ZHDiyiv6Nisg56qO0giuUqssUHKugDoU4G/Od9w1tsn+lZwxbqwWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608207593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDAXXDJx8OB/NbrJyyUPHdizuDecpKtIJlKvegA1Lvw=;
        b=7qY81DUmsahcmpZyeNrNmv993/P0XNW4pbKhSOLoPAOPBR6H1viUI2ARKa94FEWcsvPBRr
        so6yC7WjruHIWJAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.1-rt19
Message-ID: <20201217121952.vbncck5p7ph5qyjj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.1-rt19 patch set.=20

Changes since v5.10.1-rt18:

  - The RCU related patches have been updated resulting in updated
    documentation.

  - The tracing infrastructure is able to recognize "serving softirq"
    context with PREEMPT_RT enabled and marks it accordingly while
    recording the trace.

Known issues
     - None.

The delta patch against v5.10.1-rt18 is appended below and can be found her=
e:
=20
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.=
10.1-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.=
10.1-rt19

The RT patch against v5.10.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.=
10.1-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-=
5.10.1-rt19.tar.xz

Sebastian

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Gra=
ce-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited=
-Grace-Periods.rst
index 72f0f6fbd53c0..6f89cf1e567d0 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Peri=
ods.rst
@@ -38,7 +38,7 @@ sections.
 RCU-preempt Expedited Grace Periods
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-``CONFIG_PREEMPT=3Dy`` kernels implement RCU-preempt.
+``CONFIG_PREEMPTION=3Dy`` kernels implement RCU-preempt.
 The overall flow of the handling of a given CPU by an RCU-preempt
 expedited grace period is shown in the following diagram:
=20
@@ -112,7 +112,7 @@ things.
 RCU-sched Expedited Grace Periods
 ---------------------------------
=20
-``CONFIG_PREEMPT=3Dn`` kernels implement RCU-sched. The overall flow of
+``CONFIG_PREEMPTION=3Dn`` kernels implement RCU-sched. The overall flow of
 the handling of a given CPU by an RCU-sched expedited grace period is
 shown in the following diagram:
=20
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Docum=
entation/RCU/Design/Requirements/Requirements.rst
index 1ae79a10a8de6..17d38480ef5c5 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -78,7 +78,7 @@ RCU treats a nested set as one big RCU read-side critical=
 section.
 Production-quality implementations of ``rcu_read_lock()`` and
 ``rcu_read_unlock()`` are extremely lightweight, and in fact have
 exactly zero overhead in Linux kernels built for production use with
-``CONFIG_PREEMPT=3Dn``.
+``CONFIG_PREEMPTION=3Dn``.
=20
 This guarantee allows ordering to be enforced with extremely low
 overhead to readers, for example:
@@ -1182,7 +1182,7 @@ and has become decreasingly so as memory sizes have e=
xpanded and memory
 costs have plummeted. However, as I learned from Matt Mackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
-non-preemptible (``CONFIG_PREEMPT=3Dn``) kernels, and thus `tiny
+non-preemptible (``CONFIG_PREEMPTION=3Dn``) kernels, and thus `tiny
 RCU <https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm.com>`=
__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
@@ -1498,7 +1498,7 @@ limitations.
=20
 Implementations of RCU for which ``rcu_read_lock()`` and
 ``rcu_read_unlock()`` generate no code, such as Linux-kernel RCU when
-``CONFIG_PREEMPT=3Dn``, can be nested arbitrarily deeply. After all, there
+``CONFIG_PREEMPTION=3Dn``, can be nested arbitrarily deeply. After all, th=
ere
 is no overhead. Except that if all these instances of
 ``rcu_read_lock()`` and ``rcu_read_unlock()`` are visible to the
 compiler, compilation will eventually fail due to exhausting memory,
@@ -1771,7 +1771,7 @@ implementation can be a no-op.
=20
 However, once the scheduler has spawned its first kthread, this early
 boot trick fails for ``synchronize_rcu()`` (as well as for
-``synchronize_rcu_expedited()``) in ``CONFIG_PREEMPT=3Dy`` kernels. The
+``synchronize_rcu_expedited()``) in ``CONFIG_PREEMPTION=3Dy`` kernels. The
 reason is that an RCU read-side critical section might be preempted,
 which means that a subsequent ``synchronize_rcu()`` really does have to
 wait for something, as opposed to simply returning immediately.
@@ -2010,7 +2010,7 @@ The compiler must not be permitted to transform this =
source code into
        5 rcu_read_unlock();
        6 do_something_with(v, user_v);
=20
-If the compiler did make this transformation in a ``CONFIG_PREEMPT=3Dn`` k=
ernel
+If the compiler did make this transformation in a ``CONFIG_PREEMPTION=3Dn`=
` kernel
 build, and if ``get_user()`` did page fault, the result would be a quiesce=
nt
 state in the middle of an RCU read-side critical section.  This misplaced
 quiescent state could result in line 4 being a use-after-free access,
@@ -2289,10 +2289,10 @@ decides to throw at it.
=20
 The Linux kernel is used for real-time workloads, especially in
 conjunction with the `-rt
-patchset <https://rt.wiki.kernel.org/index.php/Main_Page>`__. The
+patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
-is inappropriate. Kernels built with ``CONFIG_PREEMPT=3Dy`` therefore use
+is inappropriate. Kernels built with ``CONFIG_PREEMPTION=3Dy`` therefore u=
se
 an RCU implementation that allows RCU read-side critical sections to be
 preempted. This requirement made its presence known after users made it
 clear that an earlier `real-time
@@ -2414,7 +2414,7 @@ includes ``rcu_read_lock_bh()``, ``rcu_read_unlock_bh=
()``,
 ``call_rcu_bh()``, ``rcu_barrier_bh()``, and
 ``rcu_read_lock_bh_held()``. However, the update-side APIs are now
 simple wrappers for other RCU flavors, namely RCU-sched in
-CONFIG_PREEMPT=3Dn kernels and RCU-preempt otherwise.
+CONFIG_PREEMPTION=3Dn kernels and RCU-preempt otherwise.
=20
 Sched Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2432,11 +2432,11 @@ not have this property, given that any point in the=
 code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows =E2=80=9Cclassic=E2=80=9D RCU in th=
at an
 RCU-sched grace period waits for pre-existing interrupt and NMI
-handlers. In kernels built with ``CONFIG_PREEMPT=3Dn``, the RCU and
+handlers. In kernels built with ``CONFIG_PREEMPTION=3Dn``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
-``CONFIG_PREEMPT=3Dy`` provide a separate implementation for each.
+``CONFIG_PREEMPTION=3Dy`` provide a separate implementation for each.
=20
-Note well that in ``CONFIG_PREEMPT=3Dy`` kernels,
+Note well that in ``CONFIG_PREEMPTION=3Dy`` kernels,
 ``rcu_read_lock_sched()`` and ``rcu_read_unlock_sched()`` disable and
 re-enable preemption, respectively. This means that if there was a
 preemption attempt during the RCU-sched read-side critical section,
@@ -2599,10 +2599,10 @@ userspace execution also delimit tasks-RCU read-sid=
e critical sections.
=20
 The tasks-RCU API is quite compact, consisting only of
 ``call_rcu_tasks()``, ``synchronize_rcu_tasks()``, and
-``rcu_barrier_tasks()``. In ``CONFIG_PREEMPT=3Dn`` kernels, trampolines
+``rcu_barrier_tasks()``. In ``CONFIG_PREEMPTION=3Dn`` kernels, trampolines
 cannot be preempted, so these APIs map to ``call_rcu()``,
 ``synchronize_rcu()``, and ``rcu_barrier()``, respectively. In
-``CONFIG_PREEMPT=3Dy`` kernels, trampolines can be preempted, and these
+``CONFIG_PREEMPTION=3Dy`` kernels, trampolines can be preempted, and these
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
=20
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.=
rst
index 54a79d03438a0..7ed4956043bd9 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -214,8 +214,8 @@ over a rather long period of time, but improvements are=
 always welcome!
 	the rest of the system.
=20
 7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPTION=3Dn and RCU-preempt for
-	PREEMPTION=3Dy. If the updater uses call_rcu() or synchronize_rcu(),
+	which is RCU-sched for PREEMPTION=3Dn and RCU-preempt for PREEMPTION=3Dy.
+	If the updater uses call_rcu() or synchronize_rcu(),
 	then the corresponding readers my use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
 	or any pair of primitives that disables and re-enables preemption,
diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrie=
r.rst
index f64f4413a47c4..3b4a248774961 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -9,7 +9,7 @@ RCU (read-copy update) is a synchronization mechanism that =
can be thought
 of as a replacement for read-writer locking (among other things), but with
 very low-overhead readers that are immune to deadlock, priority inversion,
 and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPT
+by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPTION
 kernels, generate no code whatsoever.
=20
 This means that RCU writers are unaware of the presence of concurrent
@@ -329,10 +329,10 @@ Answer: This cannot happen. The reason is that on_eac=
h_cpu() has its last
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
 	rcu_barrier_func() has completed. This by itself would prevent
-	a grace period from completing on non-CONFIG_PREEMPT kernels,
+	a grace period from completing on non-CONFIG_PREEMPTION kernels,
 	since each CPU must undergo a context switch (or other quiescent
 	state) before the grace period can complete. However, this is
-	of no use in CONFIG_PREEMPT kernels.
+	of no use in CONFIG_PREEMPTION kernels.
=20
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.=
rst
index fb3ff76c3e737..3b2b1479fd0f7 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -684,7 +684,7 @@ so there can be no deadlock cycle.
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
-on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
+on features such as hotplug CPU and the ability to run in CONFIG_PREEMPTION
 kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
 are the same as those shown in the preceding section, so they are omitted.
 ::
@@ -740,7 +740,7 @@ to that data item, so we can safely reclaim it.
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
=20
@@ -1094,7 +1094,7 @@ the right tool for your job.
 		overhead is **negative**.
=20
 Answer:
-		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+		Imagine a single-CPU system with a non-CONFIG_PREEMPTION
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1121,10 +1121,10 @@ the right tool for your job.
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 Answer:
-		Just as PREEMPT_RT permits preemption of spinlock
+		Just as CONFIG_PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 44fde25bb221e..37cb588e6ed29 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4085,6 +4085,10 @@
 			value, meaning that RCU_SOFTIRQ is used by default.
 			Specify rcutree.use_softirq=3D0 to use rcuc kthreads.
=20
+			But note that CONFIG_PREEMPT_RT=3Dy kernels disable
+			this kernel boot parameter, forcibly setting it
+			to zero.
+
 	rcutree.rcu_fanout_exact=3D [KNL]
 			Disable autobalancing of the rcu_node combining
 			tree.  This is used by rcutorture, and might
@@ -4463,6 +4467,13 @@
 			only normal grace-period primitives.  No effect
 			on CONFIG_TINY_RCU kernels.
=20
+			But note that CONFIG_PREEMPT_RT=3Dy kernels enables
+			this kernel boot parameter, forcibly setting
+			it to the value one, that is, converting any
+			post-boot attempt at an expedited RCU grace
+			period to instead use normal non-expedited
+			grace-period processing.
+
 	rcupdate.rcu_task_ipi_delay=3D [KNL]
 			Set time in jiffies during which RCU tasks will
 			avoid sending IPIs, starting with the beginning
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 79b122d6a2289..79b680067e646 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -150,17 +150,31 @@ enum print_line_t {
=20
 enum print_line_t trace_handle_return(struct trace_seq *s);
=20
-void tracing_generic_entry_update(struct trace_entry *entry,
-				  unsigned short type,
-				  unsigned long flags,
-				  int pc);
+static inline void tracing_generic_entry_update(struct trace_entry *entry,
+						unsigned short type,
+						unsigned int trace_ctx)
+{
+	struct task_struct *tsk =3D current;
+
+	entry->preempt_count		=3D trace_ctx & 0xff;
+	entry->migrate_disable		=3D (trace_ctx >> 8) & 0xff;
+	entry->preempt_lazy_count	=3D (trace_ctx >> 16) & 0xff;
+	entry->pid			=3D (tsk) ? tsk->pid : 0;
+	entry->type			=3D type;
+	entry->flags =3D			trace_ctx >> 24;
+}
+
+unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
+unsigned int tracing_gen_ctx_flags(void);
+unsigned int tracing_gen_ctx_flags_dect(void);
+
 struct trace_event_file;
=20
 struct ring_buffer_event *
 trace_event_buffer_lock_reserve(struct trace_buffer **current_buffer,
 				struct trace_event_file *trace_file,
 				int type, unsigned long len,
-				unsigned long flags, int pc);
+				unsigned int trace_ctx);
=20
 #define TRACE_RECORD_CMDLINE	BIT(0)
 #define TRACE_RECORD_TGID	BIT(1)
@@ -234,8 +248,7 @@ struct trace_event_buffer {
 	struct ring_buffer_event	*event;
 	struct trace_event_file		*trace_file;
 	void				*entry;
-	unsigned long			flags;
-	int				pc;
+	unsigned int			trace_ctx;
 	struct pt_regs			*regs;
 };
=20
@@ -243,7 +256,7 @@ void *trace_event_buffer_reserve(struct trace_event_buf=
fer *fbuffer,
 				  struct trace_event_file *trace_file,
 				  unsigned long len);
=20
-void trace_event_buffer_commit(struct trace_event_buffer *fbuffer);
+void trace_event_buffer_commit__(struct trace_event_buffer *fbuffer);
=20
 enum {
 	TRACE_EVENT_FL_FILTERED_BIT,
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7785961d82bae..ec5a7ff786717 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -694,7 +694,7 @@ trace_event_raw_event_##call(void *__data, proto)			\
 									\
 	{ assign; }							\
 									\
-	trace_event_buffer_commit(&fbuffer);				\
+	trace_event_buffer_commit__(&fbuffer);				\
 }
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time =
check
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1022945e3460..d6e75c7233b1f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -72,17 +72,17 @@ static void trace_note(struct blk_trace *bt, pid_t pid,=
 int action,
 	struct blk_io_trace *t;
 	struct ring_buffer_event *event =3D NULL;
 	struct trace_buffer *buffer =3D NULL;
-	int pc =3D 0;
+	unsigned int trace_ctx =3D 0;
 	int cpu =3D smp_processor_id();
 	bool blk_tracer =3D blk_tracer_enabled;
 	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;
=20
 	if (blk_tracer) {
 		buffer =3D blk_tr->array_buffer.buffer;
-		pc =3D preempt_count();
+		trace_ctx =3D _tracing_gen_ctx_flags(0);
 		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + len + cgid_len,
-						  0, pc);
+						  trace_ctx);
 		if (!event)
 			return;
 		t =3D ring_buffer_event_data(event);
@@ -107,7 +107,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid,=
 int action,
 		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
=20
 		if (blk_tracer)
-			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 	}
 }
=20
@@ -222,8 +222,9 @@ static void __blk_add_trace(struct blk_trace *bt, secto=
r_t sector, int bytes,
 	struct blk_io_trace *t;
 	unsigned long flags =3D 0;
 	unsigned long *sequence;
+	unsigned int trace_ctx =3D 0;
 	pid_t pid;
-	int cpu, pc =3D 0;
+	int cpu;
 	bool blk_tracer =3D blk_tracer_enabled;
 	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;
=20
@@ -252,10 +253,10 @@ static void __blk_add_trace(struct blk_trace *bt, sec=
tor_t sector, int bytes,
 		tracing_record_cmdline(current);
=20
 		buffer =3D blk_tr->array_buffer.buffer;
-		pc =3D preempt_count();
+		trace_ctx =3D _tracing_gen_ctx_flags(0);
 		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + pdu_len + cgid_len,
-						  0, pc);
+						  trace_ctx);
 		if (!event)
 			return;
 		t =3D ring_buffer_event_data(event);
@@ -301,7 +302,7 @@ static void __blk_add_trace(struct blk_trace *bt, secto=
r_t sector, int bytes,
 			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
=20
 		if (blk_tracer) {
-			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 			return;
 		}
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f125cb0fe0c30..99ae623058d4d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -165,7 +165,7 @@ static union trace_eval_map_item *trace_eval_maps;
 int tracing_set_tracer(struct trace_array *tr, const char *buf);
 static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
-				   unsigned long flags, int pc);
+				   unsigned int trace_ctx);
=20
 #define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
@@ -894,23 +894,23 @@ static inline void trace_access_lock_init(void)
=20
 #ifdef CONFIG_STACKTRACE
 static void __ftrace_trace_stack(struct trace_buffer *buffer,
-				 unsigned long flags,
-				 int skip, int pc, struct pt_regs *regs);
+				 unsigned int trace_ctx,
+				 int skip, struct pt_regs *regs);
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs);
+				      unsigned int trace_ctx,
+				      int skip, struct pt_regs *regs);
=20
 #else
 static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
-					unsigned long flags,
-					int skip, int pc, struct pt_regs *regs)
+					unsigned int trace_ctx,
+					int skip, struct pt_regs *regs)
 {
 }
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs)
+				      unsigned long trace_ctx,
+				      int skip, struct pt_regs *regs)
 {
 }
=20
@@ -918,24 +918,24 @@ static inline void ftrace_trace_stack(struct trace_ar=
ray *tr,
=20
 static __always_inline void
 trace_event_setup(struct ring_buffer_event *event,
-		  int type, unsigned long flags, int pc)
+		  int type, unsigned int trace_ctx)
 {
 	struct trace_entry *ent =3D ring_buffer_event_data(event);
=20
-	tracing_generic_entry_update(ent, type, flags, pc);
+	tracing_generic_entry_update(ent, type, trace_ctx);
 }
=20
 static __always_inline struct ring_buffer_event *
 __trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *event;
=20
 	event =3D ring_buffer_lock_reserve(buffer, len);
 	if (event !=3D NULL)
-		trace_event_setup(event, type, flags, pc);
+		trace_event_setup(event, type, trace_ctx);
=20
 	return event;
 }
@@ -996,25 +996,22 @@ int __trace_puts(unsigned long ip, const char *str, i=
nt size)
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	int alloc;
-	int pc;
=20
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
=20
-	pc =3D preempt_count();
-
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
=20
 	alloc =3D sizeof(*entry) + size + 2; /* possible \n added */
=20
-	local_save_flags(irq_flags);
+	trace_ctx =3D tracing_gen_ctx_flags();
 	buffer =3D global_trace.array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
-	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,=20
-					    irq_flags, pc);
+	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
+					    trace_ctx);
 	if (!event) {
 		size =3D 0;
 		goto out;
@@ -1033,7 +1030,7 @@ int __trace_puts(unsigned long ip, const char *str, i=
nt size)
 		entry->buf[size] =3D '\0';
=20
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
+	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
  out:
 	ring_buffer_nest_end(buffer);
 	return size;
@@ -1050,25 +1047,22 @@ int __trace_bputs(unsigned long ip, const char *str)
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct bputs_entry *entry;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	int size =3D sizeof(struct bputs_entry);
 	int ret =3D 0;
-	int pc;
=20
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
=20
-	pc =3D preempt_count();
-
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
=20
-	local_save_flags(irq_flags);
+	trace_ctx =3D tracing_gen_ctx_flags();
 	buffer =3D global_trace.array_buffer.buffer;
=20
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
-					    irq_flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
=20
@@ -1077,7 +1071,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	entry->str			=3D str;
=20
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
+	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
=20
 	ret =3D 1;
  out:
@@ -2577,49 +2571,91 @@ enum print_line_t trace_handle_return(struct trace_=
seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
=20
-static unsigned short migration_disable_value(struct task_struct *tsk)
+static unsigned short migration_disable_value(void)
 {
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
-	return tsk ? tsk->migration_disabled : 0;
+	return current->migration_disabled;
 #else
 	return 0;
 #endif
 }
=20
-void
-tracing_generic_entry_update(struct trace_entry *entry, unsigned short typ=
e,
-			     unsigned long flags, int pc)
+static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	struct task_struct *tsk =3D current;
+	unsigned int trace_flags =3D 0;
+	unsigned int pc;
+
+	pc =3D preempt_count();
=20
-	entry->preempt_count		=3D pc & 0xff;
-	entry->preempt_lazy_count	=3D preempt_lazy_count();
-	entry->pid			=3D (tsk) ? tsk->pid : 0;
-	entry->type			=3D type;
-	entry->flags =3D
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
+	if (irqs_disabled_flags(irqflags))
+		trace_flags |=3D TRACE_FLAG_IRQS_OFF;
 #else
-		TRACE_FLAG_IRQS_NOSUPPORT |
+		trace_flags |=3D TRACE_FLAG_IRQS_NOSUPPORT;
 #endif
-		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
-		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
-		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
-		(tif_need_resched_now() ? TRACE_FLAG_NEED_RESCHED : 0) |
-		(need_resched_lazy() ? TRACE_FLAG_NEED_RESCHED_LAZY : 0) |
-		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
=20
-	entry->migrate_disable =3D migration_disable_value(tsk);
+	if (pc & NMI_MASK)
+		trace_flags |=3D TRACE_FLAG_NMI;
+	if (pc & HARDIRQ_MASK)
+		trace_flags |=3D TRACE_FLAG_HARDIRQ;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (in_serving_softirq())
+			trace_flags |=3D TRACE_FLAG_SOFTIRQ;
+	} else {
+		if (pc & SOFTIRQ_OFFSET)
+			trace_flags |=3D TRACE_FLAG_SOFTIRQ;
+	}
+	if (tif_need_resched())
+		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
+	if (test_preempt_need_resched())
+		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
+
+	return (pc & 0xff) |
+		(migration_disable_value() & 0xff) << 8 |
+		(preempt_lazy_count() & 0xff) << 16 |
+		(trace_flags << 24);
+}
+
+unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	return __tracing_gen_ctx_flags(irqflags);
+}
+
+unsigned int tracing_gen_ctx_flags(void)
+{
+	unsigned long irqflags;
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+	local_save_flags(irqflags);
+#else
+	irqflags =3D 0;
+#endif
+	return _tracing_gen_ctx_flags(irqflags);
+}
+
+unsigned int tracing_gen_ctx_flags_dect(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx =3D tracing_gen_ctx_flags();
+
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
 }
-EXPORT_SYMBOL_GPL(tracing_generic_entry_update);
=20
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
-	return __trace_buffer_lock_reserve(buffer, type, len, flags, pc);
+	return __trace_buffer_lock_reserve(buffer, type, len, trace_ctx);
 }
=20
 DEFINE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
@@ -2739,7 +2775,7 @@ struct ring_buffer_event *
 trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 			  struct trace_event_file *trace_file,
 			  int type, unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *entry;
 	int val;
@@ -2752,15 +2788,15 @@ trace_event_buffer_lock_reserve(struct trace_buffer=
 **current_rb,
 		/* Try to use the per cpu buffer first */
 		val =3D this_cpu_inc_return(trace_buffered_event_cnt);
 		if (val =3D=3D 1) {
-			trace_event_setup(entry, type, flags, pc);
+			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] =3D len;
 			return entry;
 		}
 		this_cpu_dec(trace_buffered_event_cnt);
 	}
=20
-	entry =3D __trace_buffer_lock_reserve(*current_rb,
-					    type, len, flags, pc);
+	entry =3D __trace_buffer_lock_reserve(*current_rb, type, len,
+					    trace_ctx);
 	/*
 	 * If tracing is off, but we have triggers enabled
 	 * we still need to look at the event data. Use the temp_buffer
@@ -2769,8 +2805,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer *=
*current_rb,
 	 */
 	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
 		*current_rb =3D temp_buffer;
-		entry =3D __trace_buffer_lock_reserve(*current_rb,
-						    type, len, flags, pc);
+		entry =3D __trace_buffer_lock_reserve(*current_rb, type, len,
+						    trace_ctx);
 	}
 	return entry;
 }
@@ -2847,7 +2883,7 @@ int tracepoint_printk_sysctl(struct ctl_table *table,=
 int write,
 	return ret;
 }
=20
-void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
+void trace_event_buffer_commit__(struct trace_event_buffer *fbuffer)
 {
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
@@ -2856,9 +2892,9 @@ void trace_event_buffer_commit(struct trace_event_buf=
fer *fbuffer)
 		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
 	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
-				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
+				    fbuffer->trace_ctx, fbuffer->regs);
 }
-EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
+EXPORT_SYMBOL_GPL(trace_event_buffer_commit__);
=20
 /*
  * Skip 3:
@@ -2872,7 +2908,7 @@ EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 				     struct trace_buffer *buffer,
 				     struct ring_buffer_event *event,
-				     unsigned long flags, int pc,
+				     unsigned int trace_ctx,
 				     struct pt_regs *regs)
 {
 	__buffer_unlock_commit(buffer, event);
@@ -2883,8 +2919,8 @@ void trace_buffer_unlock_commit_regs(struct trace_arr=
ay *tr,
 	 * and mmiotrace, but that's ok if they lose a function or
 	 * two. They are not that meaningful.
 	 */
-	ftrace_trace_stack(tr, buffer, flags, regs ? 0 : STACK_SKIP, pc, regs);
-	ftrace_trace_userstack(tr, buffer, flags, pc);
+	ftrace_trace_stack(tr, buffer, trace_ctx, regs ? 0 : STACK_SKIP, regs);
+	ftrace_trace_userstack(tr, buffer, trace_ctx);
 }
=20
 /*
@@ -2898,9 +2934,8 @@ trace_buffer_unlock_commit_nostack(struct trace_buffe=
r *buffer,
 }
=20
 void
-trace_function(struct trace_array *tr,
-	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
-	       int pc)
+trace_function(struct trace_array *tr, unsigned long ip, unsigned long
+	       parent_ip, unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_function;
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
@@ -2908,7 +2943,7 @@ trace_function(struct trace_array *tr,
 	struct ftrace_entry *entry;
=20
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -2942,8 +2977,8 @@ static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_st=
acks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
=20
 static void __ftrace_trace_stack(struct trace_buffer *buffer,
-				 unsigned long flags,
-				 int skip, int pc, struct pt_regs *regs)
+				 unsigned int trace_ctx,
+				 int skip, struct pt_regs *regs)
 {
 	struct trace_event_call *call =3D &event_kernel_stack;
 	struct ring_buffer_event *event;
@@ -2990,7 +3025,7 @@ static void __ftrace_trace_stack(struct trace_buffer =
*buffer,
=20
 	size =3D nr_entries * sizeof(unsigned long);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-					    sizeof(*entry) + size, flags, pc);
+					    sizeof(*entry) + size, trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3011,22 +3046,22 @@ static void __ftrace_trace_stack(struct trace_buffe=
r *buffer,
=20
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs)
+				      unsigned int trace_ctx,
+				      int skip, struct pt_regs *regs)
 {
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
=20
-	__ftrace_trace_stack(buffer, flags, skip, pc, regs);
+	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
 }
=20
-void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
-		   int pc)
+void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
+		   int skip)
 {
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
=20
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
+		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
 		return;
 	}
=20
@@ -3040,7 +3075,7 @@ void __trace_stack(struct trace_array *tr, unsigned l=
ong flags, int skip,
 		return;
=20
 	rcu_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
+	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
 	rcu_irq_exit_irqson();
 }
=20
@@ -3062,7 +3097,7 @@ void trace_dump_stack(int skip)
 	skip++;
 #endif
 	__ftrace_trace_stack(global_trace.array_buffer.buffer,
-			     flags, skip, preempt_count(), NULL);
+			     tracing_gen_ctx_flags(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
=20
@@ -3071,7 +3106,7 @@ static DEFINE_PER_CPU(int, user_stack_count);
=20
 static void
 ftrace_trace_userstack(struct trace_array *tr,
-		       struct trace_buffer *buffer, unsigned long flags, int pc)
+		       struct trace_buffer *buffer, unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_user_stack;
 	struct ring_buffer_event *event;
@@ -3098,7 +3133,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 	__this_cpu_inc(user_stack_count);
=20
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_USER_STACK,
-					    sizeof(*entry), flags, pc);
+					    sizeof(*entry), trace_ctx);
 	if (!event)
 		goto out_drop_count;
 	entry	=3D ring_buffer_event_data(event);
@@ -3118,7 +3153,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 #else /* CONFIG_USER_STACKTRACE_SUPPORT */
 static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
-				   unsigned long flags, int pc)
+				   unsigned int trace_ctx)
 {
 }
 #endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
@@ -3248,9 +3283,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	struct trace_buffer *buffer;
 	struct trace_array *tr =3D &global_trace;
 	struct bprint_entry *entry;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	char *tbuffer;
-	int len =3D 0, size, pc;
+	int len =3D 0, size;
=20
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
@@ -3258,7 +3293,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
 	preempt_disable_notrace();
=20
 	tbuffer =3D get_trace_buf();
@@ -3272,12 +3307,11 @@ int trace_vbprintk(unsigned long ip, const char *fm=
t, va_list args)
 	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
 		goto out_put;
=20
-	local_save_flags(flags);
 	size =3D sizeof(*entry) + sizeof(u32) * len;
 	buffer =3D tr->array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3287,7 +3321,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	memcpy(entry->buf, tbuffer, sizeof(u32) * len);
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(tr, buffer, flags, 6, pc, NULL);
+		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
 	}
=20
 out:
@@ -3310,9 +3344,9 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 {
 	struct trace_event_call *call =3D &event_print;
 	struct ring_buffer_event *event;
-	int len =3D 0, size, pc;
+	int len =3D 0, size;
 	struct print_entry *entry;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	char *tbuffer;
=20
 	if (tracing_disabled || tracing_selftest_running)
@@ -3321,7 +3355,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
 	preempt_disable_notrace();
=20
=20
@@ -3333,11 +3367,10 @@ __trace_array_vprintk(struct trace_buffer *buffer,
=20
 	len =3D vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
=20
-	local_save_flags(flags);
 	size =3D sizeof(*entry) + len + 1;
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3346,7 +3379,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	memcpy(&entry->buf, tbuffer, len + 1);
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(&global_trace, buffer, flags, 6, pc, NULL);
+		ftrace_trace_stack(&global_trace, buffer, trace_ctx, 6, NULL);
 	}
=20
 out:
@@ -6665,7 +6698,6 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
 	enum event_trigger_type tt =3D ETT_NONE;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
-	unsigned long irq_flags;
 	ssize_t written;
 	int size;
 	int len;
@@ -6685,7 +6717,6 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
=20
 	BUILD_BUG_ON(TRACE_BUF_SIZE >=3D PAGE_SIZE);
=20
-	local_save_flags(irq_flags);
 	size =3D sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
=20
 	/* If less than "<faulted>", then make sure we can still add that */
@@ -6694,7 +6725,7 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    irq_flags, preempt_count());
+					    tracing_gen_ctx_flags());
 	if (unlikely(!event))
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
@@ -6746,7 +6777,6 @@ tracing_mark_raw_write(struct file *filp, const char =
__user *ubuf,
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
-	unsigned long irq_flags;
 	ssize_t written;
 	int size;
 	int len;
@@ -6768,14 +6798,13 @@ tracing_mark_raw_write(struct file *filp, const cha=
r __user *ubuf,
=20
 	BUILD_BUG_ON(TRACE_BUF_SIZE >=3D PAGE_SIZE);
=20
-	local_save_flags(irq_flags);
 	size =3D sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size +=3D FAULT_SIZE_ID - cnt;
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    irq_flags, preempt_count());
+					    tracing_gen_ctx_flags());
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4dac962694b85..a8c8cb04f942f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -768,8 +768,7 @@ struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags,
-			  int pc);
+			  unsigned int trace_ctx);
=20
 struct trace_entry *tracing_get_trace_entry(struct trace_array *tr,
 						struct trace_array_cpu *data);
@@ -794,11 +793,11 @@ unsigned long trace_total_entries(struct trace_array =
*tr);
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned long flags, int pc);
+		    unsigned int trace_ctx);
 void trace_graph_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned long flags, int pc);
+		    unsigned int trace_ctx);
 void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
@@ -866,11 +865,10 @@ static inline void latency_fsnotify(struct trace_arra=
y *tr) { }
 #endif
=20
 #ifdef CONFIG_STACKTRACE
-void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
-		   int pc);
+void __trace_stack(struct trace_array *tr, unsigned int trace_ctx, int ski=
p);
 #else
-static inline void __trace_stack(struct trace_array *tr, unsigned long fla=
gs,
-				 int skip, int pc)
+static inline void __trace_stack(struct trace_array *tr, unsigned int trac=
e_ctx,
+				 int skip)
 {
 }
 #endif /* CONFIG_STACKTRACE */
@@ -1005,10 +1003,10 @@ extern void graph_trace_open(struct trace_iterator =
*iter);
 extern void graph_trace_close(struct trace_iterator *iter);
 extern int __trace_graph_entry(struct trace_array *tr,
 			       struct ftrace_graph_ent *trace,
-			       unsigned long flags, int pc);
+			       unsigned int trace_ctx);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
-				 unsigned long flags, int pc);
+				 unsigned int trace_ctx);
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
@@ -1471,15 +1469,15 @@ extern int call_filter_check_discard(struct trace_e=
vent_call *call, void *rec,
 void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 				     struct trace_buffer *buffer,
 				     struct ring_buffer_event *event,
-				     unsigned long flags, int pc,
+				     unsigned int trcace_ctx,
 				     struct pt_regs *regs);
=20
 static inline void trace_buffer_unlock_commit(struct trace_array *tr,
 					      struct trace_buffer *buffer,
 					      struct ring_buffer_event *event,
-					      unsigned long flags, int pc)
+					      unsigned int trace_ctx)
 {
-	trace_buffer_unlock_commit_regs(tr, buffer, event, flags, pc, NULL);
+	trace_buffer_unlock_commit_regs(tr, buffer, event, trace_ctx, NULL);
 }
=20
 DECLARE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
@@ -1540,8 +1538,7 @@ __event_trigger_test_discard(struct trace_event_file =
*file,
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
- * @irq_flags: The state of the interrupts at the start of the event
- * @pc: The state of the preempt count at the start of the event.
+ * @trace_ctx: The tracing context flags.
  *
  * This is a helper function to handle triggers that require data
  * from the event itself. It also tests the event against filters and
@@ -1551,12 +1548,12 @@ static inline void
 event_trigger_unlock_commit(struct trace_event_file *file,
 			    struct trace_buffer *buffer,
 			    struct ring_buffer_event *event,
-			    void *entry, unsigned long irq_flags, int pc)
+			    void *entry, unsigned int trace_ctx)
 {
 	enum event_trigger_type tt =3D ETT_NONE;
=20
 	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
-		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
+		trace_buffer_unlock_commit(file->tr, buffer, event, trace_ctx);
=20
 	if (tt)
 		event_triggers_post_call(file, tt);
@@ -1568,8 +1565,7 @@ event_trigger_unlock_commit(struct trace_event_file *=
file,
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
- * @irq_flags: The state of the interrupts at the start of the event
- * @pc: The state of the preempt count at the start of the event.
+ * @trace_ctx: The tracing context flags.
  *
  * This is a helper function to handle triggers that require data
  * from the event itself. It also tests the event against filters and
@@ -1582,14 +1578,14 @@ static inline void
 event_trigger_unlock_commit_regs(struct trace_event_file *file,
 				 struct trace_buffer *buffer,
 				 struct ring_buffer_event *event,
-				 void *entry, unsigned long irq_flags, int pc,
+				 void *entry, unsigned int trace_ctx,
 				 struct pt_regs *regs)
 {
 	enum event_trigger_type tt =3D ETT_NONE;
=20
 	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
 		trace_buffer_unlock_commit_regs(file->tr, buffer, event,
-						irq_flags, pc, regs);
+						trace_ctx, regs);
=20
 	if (tt)
 		event_triggers_post_call(file, tt);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_per=
f.c
index 643e0b19920d2..9409b7c6ebea1 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -421,11 +421,8 @@ NOKPROBE_SYMBOL(perf_trace_buf_alloc);
 void perf_trace_buf_update(void *record, u16 type)
 {
 	struct trace_entry *entry =3D record;
-	int pc =3D preempt_count();
-	unsigned long flags;
=20
-	local_save_flags(flags);
-	tracing_generic_entry_update(entry, type, flags, pc);
+	tracing_generic_entry_update(entry, type, tracing_gen_ctx_flags());
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
=20
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8049624945776..029c5032fa28d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -260,22 +260,19 @@ void *trace_event_buffer_reserve(struct trace_event_b=
uffer *fbuffer,
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
=20
-	local_save_flags(fbuffer->flags);
-	fbuffer->pc =3D preempt_count();
 	/*
 	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
 	 * preemption (adding one to the preempt_count). Since we are
 	 * interested in the preempt_count at the time the tracepoint was
 	 * hit, we need to subtract one to offset the increment.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		fbuffer->pc--;
+	fbuffer->trace_ctx =3D tracing_gen_ctx_flags_dect();
 	fbuffer->trace_file =3D trace_file;
=20
 	fbuffer->event =3D
 		trace_event_buffer_lock_reserve(&fbuffer->buffer, trace_file,
 						event_call->event.type, len,
-						fbuffer->flags, fbuffer->pc);
+						fbuffer->trace_ctx);
 	if (!fbuffer->event)
 		return NULL;
=20
@@ -3681,11 +3678,11 @@ function_test_events_call(unsigned long ip, unsigne=
d long parent_ip,
 	struct ring_buffer_event *event;
 	struct ftrace_entry *entry;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int cpu;
-	int pc;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
 	preempt_disable_notrace();
 	cpu =3D raw_smp_processor_id();
 	disabled =3D atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu));
@@ -3697,7 +3694,7 @@ function_test_events_call(unsigned long ip, unsigned =
long parent_ip,
=20
 	event =3D trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
 						TRACE_FN, sizeof(*entry),
-						flags, pc);
+						trace_ctx);
 	if (!event)
 		goto out;
 	entry	=3D ring_buffer_event_data(event);
@@ -3705,7 +3702,7 @@ function_test_events_call(unsigned long ip, unsigned =
long parent_ip,
 	entry->parent_ip		=3D parent_ip;
=20
 	event_trigger_unlock_commit(&event_trace_file, buffer, event,
-				    entry, flags, pc);
+				    entry, trace_ctx);
  out:
 	atomic_dec(&per_cpu(ftrace_test_event_disable, cpu));
 	preempt_enable_notrace();
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events=
_inject.c
index 22bcf7c51d1ee..a5465a93fc149 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -25,7 +25,7 @@ trace_inject_entry(struct trace_event_file *file, void *r=
ec, int len)
 	if (entry) {
 		memcpy(entry, rec, len);
 		written =3D len;
-		trace_event_buffer_commit(&fbuffer);
+		trace_event_buffer_commit__(&fbuffer);
 	}
 	rcu_read_unlock_sched();
=20
@@ -192,7 +192,6 @@ static void *trace_alloc_entry(struct trace_event_call =
*call, int *size)
 static int parse_entry(char *str, struct trace_event_call *call, void **pe=
ntry)
 {
 	struct ftrace_event_field *field;
-	unsigned long irq_flags;
 	void *entry =3D NULL;
 	int entry_size;
 	u64 val =3D 0;
@@ -203,9 +202,8 @@ static int parse_entry(char *str, struct trace_event_ca=
ll *call, void **pentry)
 	if (!entry)
 		return -ENOMEM;
=20
-	local_save_flags(irq_flags);
-	tracing_generic_entry_update(entry, call->event.type, irq_flags,
-				     preempt_count());
+	tracing_generic_entry_update(entry, call->event.type,
+				     tracing_gen_ctx_flags());
=20
 	while ((len =3D parse_field(str, call, &field, &val)) > 0) {
 		if (is_function_field(field))
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_=
synth.c
index 881df991742ab..2fc59be73a288 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -504,7 +504,7 @@ static notrace void trace_event_raw_event_synth(void *_=
_data,
 		}
 	}
=20
-	trace_event_buffer_commit(&fbuffer);
+	trace_event_buffer_commit__(&fbuffer);
 out:
 	ring_buffer_nest_end(buffer);
 }
@@ -1494,7 +1494,7 @@ __synth_event_trace_start(struct trace_event_file *fi=
le,
 static inline void
 __synth_event_trace_end(struct synth_event_trace_state *trace_state)
 {
-	trace_event_buffer_commit(&trace_state->fbuffer);
+	trace_event_buffer_commit__(&trace_state->fbuffer);
=20
 	ring_buffer_nest_end(trace_state->buffer);
 }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 2c2126e1871d4..7066faab29e7a 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -133,15 +133,14 @@ function_trace_call(unsigned long ip, unsigned long p=
arent_ip,
 {
 	struct trace_array *tr =3D op->private;
 	struct trace_array_cpu *data;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	int bit;
 	int cpu;
-	int pc;
=20
 	if (unlikely(!tr->function_enabled))
 		return;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
 	preempt_disable_notrace();
=20
 	bit =3D trace_test_and_set_recursion(TRACE_FTRACE_START, TRACE_FTRACE_MAX=
);
@@ -150,10 +149,9 @@ function_trace_call(unsigned long ip, unsigned long pa=
rent_ip,
=20
 	cpu =3D smp_processor_id();
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
-	if (!atomic_read(&data->disabled)) {
-		local_save_flags(flags);
-		trace_function(tr, ip, parent_ip, flags, pc);
-	}
+	if (!atomic_read(&data->disabled))
+		trace_function(tr, ip, parent_ip, trace_ctx);
+
 	trace_clear_recursion(bit);
=20
  out:
@@ -187,7 +185,7 @@ function_stack_trace_call(unsigned long ip, unsigned lo=
ng parent_ip,
 	unsigned long flags;
 	long disabled;
 	int cpu;
-	int pc;
+	int trace_ctx;
=20
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -202,9 +200,9 @@ function_stack_trace_call(unsigned long ip, unsigned lo=
ng parent_ip,
 	disabled =3D atomic_inc_return(&data->disabled);
=20
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		trace_function(tr, ip, parent_ip, flags, pc);
-		__trace_stack(tr, flags, STACK_SKIP, pc);
+		trace_ctx =3D tracing_gen_ctx_flags();
+		trace_function(tr, ip, parent_ip, trace_ctx);
+		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
=20
 	atomic_dec(&data->disabled);
@@ -408,12 +406,12 @@ ftrace_traceoff(unsigned long ip, unsigned long paren=
t_ip,
 static __always_inline void trace_stack(struct trace_array *tr)
 {
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	local_save_flags(flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
=20
-	__trace_stack(tr, flags, FTRACE_STACK_SKIP, pc);
+	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
 }
=20
 static void
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_func=
tions_graph.c
index 60d66278aa0d8..aaa37a6a479cd 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -96,8 +96,7 @@ print_graph_duration(struct trace_array *tr, unsigned lon=
g long duration,
=20
 int __trace_graph_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
-				unsigned long flags,
-				int pc)
+				unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_funcgraph_entry;
 	struct ring_buffer_event *event;
@@ -105,7 +104,7 @@ int __trace_graph_entry(struct trace_array *tr,
 	struct ftrace_graph_ent_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return 0;
 	entry	=3D ring_buffer_event_data(event);
@@ -129,10 +128,10 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	struct trace_array *tr =3D graph_array;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int ret;
 	int cpu;
-	int pc;
=20
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
 		return 0;
@@ -174,8 +173,8 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled =3D atomic_inc_return(&data->disabled);
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		ret =3D __trace_graph_entry(tr, trace, flags, pc);
+		trace_ctx =3D _tracing_gen_ctx_flags(flags);
+		ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret =3D 0;
 	}
@@ -188,7 +187,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
=20
 static void
 __trace_graph_function(struct trace_array *tr,
-		unsigned long ip, unsigned long flags, int pc)
+		unsigned long ip, unsigned int trace_ctx)
 {
 	u64 time =3D trace_clock_local();
 	struct ftrace_graph_ent ent =3D {
@@ -202,22 +201,21 @@ __trace_graph_function(struct trace_array *tr,
 		.rettime  =3D time,
 	};
=20
-	__trace_graph_entry(tr, &ent, flags, pc);
-	__trace_graph_return(tr, &ret, flags, pc);
+	__trace_graph_entry(tr, &ent, trace_ctx);
+	__trace_graph_return(tr, &ret, trace_ctx);
 }
=20
 void
 trace_graph_function(struct trace_array *tr,
 		unsigned long ip, unsigned long parent_ip,
-		unsigned long flags, int pc)
+		unsigned int trace_ctx)
 {
-	__trace_graph_function(tr, ip, flags, pc);
+	__trace_graph_function(tr, ip, trace_ctx);
 }
=20
 void __trace_graph_return(struct trace_array *tr,
 				struct ftrace_graph_ret *trace,
-				unsigned long flags,
-				int pc)
+				unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_funcgraph_exit;
 	struct ring_buffer_event *event;
@@ -225,7 +223,7 @@ void __trace_graph_return(struct trace_array *tr,
 	struct ftrace_graph_ret_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RET,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -239,9 +237,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	struct trace_array *tr =3D graph_array;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int cpu;
-	int pc;
=20
 	ftrace_graph_addr_finish(trace);
=20
@@ -255,8 +253,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled =3D atomic_inc_return(&data->disabled);
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		__trace_graph_return(tr, trace, flags, pc);
+		trace_ctx =3D _tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx);
 	}
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d071fc271eef7..51bd4d74f56ce 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -108,14 +108,9 @@ static void trace_hwlat_sample(struct hwlat_sample *sa=
mple)
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct hwlat_entry *entry;
-	unsigned long flags;
-	int pc;
-
-	pc =3D preempt_count();
-	local_save_flags(flags);
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_HWLAT, sizeof(*entry),
-					  flags, pc);
+					  tracing_gen_ctx_flags());
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 10bbb0f381d56..95736a3bf2860 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -143,11 +143,14 @@ irqsoff_tracer_call(unsigned long ip, unsigned long p=
arent_ip,
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
=20
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
=20
-	trace_function(tr, ip, parent_ip, flags, preempt_count());
+	trace_ctx =3D _tracing_gen_ctx_flags(flags);
+
+	trace_function(tr, ip, parent_ip, trace_ctx);
=20
 	atomic_dec(&data->disabled);
 }
@@ -177,8 +180,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent =
*trace)
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	int ret;
-	int pc;
=20
 	if (ftrace_graph_ignore_func(trace))
 		return 0;
@@ -195,8 +198,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent =
*trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return 0;
=20
-	pc =3D preempt_count();
-	ret =3D __trace_graph_entry(tr, trace, flags, pc);
+	trace_ctx =3D _tracing_gen_ctx_flags(flags);
+	ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
=20
 	return ret;
@@ -207,15 +210,15 @@ static void irqsoff_graph_return(struct ftrace_graph_=
ret *trace)
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	ftrace_graph_addr_finish(trace);
=20
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
=20
-	pc =3D preempt_count();
-	__trace_graph_return(tr, trace, flags, pc);
+	trace_ctx =3D _tracing_gen_ctx_flags(flags);
+	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 }
=20
@@ -267,12 +270,12 @@ static void irqsoff_print_header(struct seq_file *s)
 static void
 __trace_function(struct trace_array *tr,
 		 unsigned long ip, unsigned long parent_ip,
-		 unsigned long flags, int pc)
+		 unsigned int trace_ctx)
 {
 	if (is_graph(tr))
-		trace_graph_function(tr, ip, parent_ip, flags, pc);
+		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, flags, pc);
+		trace_function(tr, ip, parent_ip, trace_ctx);
 }
=20
 #else
@@ -322,15 +325,13 @@ check_critical_timing(struct trace_array *tr,
 {
 	u64 T0, T1, delta;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	T0 =3D data->preempt_timestamp;
 	T1 =3D ftrace_now(cpu);
 	delta =3D T1-T0;
=20
-	local_save_flags(flags);
-
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
=20
 	if (!report_latency(tr, delta))
 		goto out;
@@ -341,9 +342,9 @@ check_critical_timing(struct trace_array *tr,
 	if (!report_latency(tr, delta))
 		goto out_unlock;
=20
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+	__trace_function(tr, CALLER_ADDR0, parent_ip, trace_ctx);
 	/* Skip 5 functions to get to the irq/preempt enable function */
-	__trace_stack(tr, flags, 5, pc);
+	__trace_stack(tr, trace_ctx, 5);
=20
 	if (data->critical_sequence !=3D max_sequence)
 		goto out_unlock;
@@ -363,16 +364,15 @@ check_critical_timing(struct trace_array *tr,
 out:
 	data->critical_sequence =3D max_sequence;
 	data->preempt_timestamp =3D ftrace_now(cpu);
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+	__trace_function(tr, CALLER_ADDR0, parent_ip, trace_ctx);
 }
=20
 static nokprobe_inline void
-start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
+start_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
 	int cpu;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
=20
 	if (!tracer_enabled || !tracing_is_enabled())
 		return;
@@ -393,9 +393,7 @@ start_critical_timing(unsigned long ip, unsigned long p=
arent_ip, int pc)
 	data->preempt_timestamp =3D ftrace_now(cpu);
 	data->critical_start =3D parent_ip ? : ip;
=20
-	local_save_flags(flags);
-
-	__trace_function(tr, ip, parent_ip, flags, pc);
+	__trace_function(tr, ip, parent_ip, tracing_gen_ctx_flags());
=20
 	per_cpu(tracing_cpu, cpu) =3D 1;
=20
@@ -403,12 +401,12 @@ start_critical_timing(unsigned long ip, unsigned long=
 parent_ip, int pc)
 }
=20
 static nokprobe_inline void
-stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
+stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
 	int cpu;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
+	unsigned int trace_ctx;
=20
 	cpu =3D raw_smp_processor_id();
 	/* Always clear the tracing cpu on stopping the trace */
@@ -428,8 +426,8 @@ stop_critical_timing(unsigned long ip, unsigned long pa=
rent_ip, int pc)
=20
 	atomic_inc(&data->disabled);
=20
-	local_save_flags(flags);
-	__trace_function(tr, ip, parent_ip, flags, pc);
+	trace_ctx =3D tracing_gen_ctx_flags();
+	__trace_function(tr, ip, parent_ip, trace_ctx);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start =3D 0;
 	atomic_dec(&data->disabled);
@@ -441,7 +439,7 @@ void start_critical_timings(void)
 	int pc =3D preempt_count();
=20
 	if (preempt_trace(pc) || irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
+		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 NOKPROBE_SYMBOL(start_critical_timings);
@@ -451,7 +449,7 @@ void stop_critical_timings(void)
 	int pc =3D preempt_count();
=20
 	if (preempt_trace(pc) || irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 NOKPROBE_SYMBOL(stop_critical_timings);
@@ -612,7 +610,7 @@ void tracer_hardirqs_on(unsigned long a0, unsigned long=
 a1)
 	unsigned int pc =3D preempt_count();
=20
 	if (!preempt_trace(pc) && irq_trace())
-		stop_critical_timing(a0, a1, pc);
+		stop_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_on);
=20
@@ -621,7 +619,7 @@ void tracer_hardirqs_off(unsigned long a0, unsigned lon=
g a1)
 	unsigned int pc =3D preempt_count();
=20
 	if (!preempt_trace(pc) && irq_trace())
-		start_critical_timing(a0, a1, pc);
+		start_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_off);
=20
@@ -664,7 +662,7 @@ void tracer_preempt_on(unsigned long a0, unsigned long =
a1)
 	int pc =3D preempt_count();
=20
 	if (preempt_trace(pc) && !irq_trace())
-		stop_critical_timing(a0, a1, pc);
+		stop_critical_timing(a0, a1);
 }
=20
 void tracer_preempt_off(unsigned long a0, unsigned long a1)
@@ -672,7 +670,7 @@ void tracer_preempt_off(unsigned long a0, unsigned long=
 a1)
 	int pc =3D preempt_count();
=20
 	if (preempt_trace(pc) && !irq_trace())
-		start_critical_timing(a0, a1, pc);
+		start_critical_timing(a0, a1);
 }
=20
 static int preemptoff_tracer_init(struct trace_array *tr)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b911e9f6d9f5c..de5938e5c348b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1383,8 +1383,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct p=
t_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
=20
-	local_save_flags(fbuffer.flags);
-	fbuffer.pc =3D preempt_count();
+	fbuffer.trace_ctx =3D tracing_gen_ctx_flags();
 	fbuffer.trace_file =3D trace_file;
=20
 	dsize =3D __get_data_size(&tk->tp, regs);
@@ -1393,7 +1392,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct p=
t_regs *regs,
 		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
 					call->event.type,
 					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.flags, fbuffer.pc);
+					fbuffer.trace_ctx);
 	if (!fbuffer.event)
 		return;
=20
@@ -1402,7 +1401,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct p=
t_regs *regs,
 	entry->ip =3D (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
=20
-	trace_event_buffer_commit(&fbuffer);
+	trace_event_buffer_commit__(&fbuffer);
 }
=20
 static void
@@ -1431,8 +1430,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struc=
t kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
=20
-	local_save_flags(fbuffer.flags);
-	fbuffer.pc =3D preempt_count();
+	fbuffer.trace_ctx =3D tracing_gen_ctx_flags();
 	fbuffer.trace_file =3D trace_file;
=20
 	dsize =3D __get_data_size(&tk->tp, regs);
@@ -1440,7 +1438,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struc=
t kretprobe_instance *ri,
 		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
 					call->event.type,
 					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.flags, fbuffer.pc);
+					fbuffer.trace_ctx);
 	if (!fbuffer.event)
 		return;
=20
@@ -1450,7 +1448,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struc=
t kretprobe_instance *ri,
 	entry->ret_ip =3D (unsigned long)ri->ret_addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
=20
-	trace_event_buffer_commit(&fbuffer);
+	trace_event_buffer_commit__(&fbuffer);
 }
=20
 static void
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 84582bf1ed5fb..5a7d37bf6888c 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -300,10 +300,11 @@ static void __trace_mmiotrace_rw(struct trace_array *=
tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
-	int pc =3D preempt_count();
+	unsigned int trace_ctx;
=20
+	trace_ctx =3D _tracing_gen_ctx_flags(0);
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
-					  sizeof(*entry), 0, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event) {
 		atomic_inc(&dropped_count);
 		return;
@@ -312,7 +313,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 	entry->rw			=3D *rw;
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, 0, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 void mmio_trace_rw(struct mmiotrace_rw *rw)
@@ -330,10 +331,11 @@ static void __trace_mmiotrace_map(struct trace_array =
*tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
-	int pc =3D preempt_count();
+	unsigned int trace_ctx;
=20
+	trace_ctx =3D _tracing_gen_ctx_flags(0);
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
-					  sizeof(*entry), 0, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event) {
 		atomic_inc(&dropped_count);
 		return;
@@ -342,7 +344,7 @@ static void __trace_mmiotrace_map(struct trace_array *t=
r,
 	entry->map			=3D *map;
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, 0, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 void mmio_trace_mapping(struct mmiotrace_map *map)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_w=
akeup.c
index 97b10bb31a1f0..795935a669f97 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -67,7 +67,7 @@ static bool function_enabled;
 static int
 func_prolog_preempt_disable(struct trace_array *tr,
 			    struct trace_array_cpu **data,
-			    int *pc)
+			    unsigned int *trace_ctx)
 {
 	long disabled;
 	int cpu;
@@ -75,7 +75,7 @@ func_prolog_preempt_disable(struct trace_array *tr,
 	if (likely(!wakeup_task))
 		return 0;
=20
-	*pc =3D preempt_count();
+	*trace_ctx =3D tracing_gen_ctx_flags();
 	preempt_disable_notrace();
=20
 	cpu =3D raw_smp_processor_id();
@@ -117,7 +117,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *=
trace)
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc, ret =3D 0;
+	unsigned int trace_ctx;
+	int ret =3D 0;
=20
 	if (ftrace_graph_ignore_func(trace))
 		return 0;
@@ -131,11 +132,11 @@ static int wakeup_graph_entry(struct ftrace_graph_ent=
 *trace)
 	if (ftrace_graph_notrace_addr(trace->func))
 		return 1;
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return 0;
=20
 	local_save_flags(flags);
-	ret =3D __trace_graph_entry(tr, trace, flags, pc);
+	ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 	preempt_enable_notrace();
=20
@@ -147,15 +148,15 @@ static void wakeup_graph_return(struct ftrace_graph_r=
et *trace)
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	ftrace_graph_addr_finish(trace);
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
=20
 	local_save_flags(flags);
-	__trace_graph_return(tr, trace, flags, pc);
+	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
=20
 	preempt_enable_notrace();
@@ -217,13 +218,13 @@ wakeup_tracer_call(unsigned long ip, unsigned long pa=
rent_ip,
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
=20
 	local_irq_save(flags);
-	trace_function(tr, ip, parent_ip, flags, pc);
+	trace_function(tr, ip, parent_ip, trace_ctx);
 	local_irq_restore(flags);
=20
 	atomic_dec(&data->disabled);
@@ -303,12 +304,12 @@ static void wakeup_print_header(struct seq_file *s)
 static void
 __trace_function(struct trace_array *tr,
 		 unsigned long ip, unsigned long parent_ip,
-		 unsigned long flags, int pc)
+		 unsigned int trace_ctx)
 {
 	if (is_graph(tr))
-		trace_graph_function(tr, ip, parent_ip, flags, pc);
+		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, flags, pc);
+		trace_function(tr, ip, parent_ip, trace_ctx);
 }
=20
 static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
@@ -375,7 +376,7 @@ static void
 tracing_sched_switch_trace(struct trace_array *tr,
 			   struct task_struct *prev,
 			   struct task_struct *next,
-			   unsigned long flags, int pc)
+			   unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_context_switch;
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
@@ -383,7 +384,7 @@ tracing_sched_switch_trace(struct trace_array *tr,
 	struct ctx_switch_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_CTX,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -396,14 +397,14 @@ tracing_sched_switch_trace(struct trace_array *tr,
 	entry->next_cpu	=3D task_cpu(next);
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, flags, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 static void
 tracing_sched_wakeup_trace(struct trace_array *tr,
 			   struct task_struct *wakee,
 			   struct task_struct *curr,
-			   unsigned long flags, int pc)
+			   unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_wakeup;
 	struct ring_buffer_event *event;
@@ -411,7 +412,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_WAKE,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -424,7 +425,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 	entry->next_cpu			=3D task_cpu(wakee);
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, flags, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 static void notrace
@@ -436,7 +437,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	unsigned long flags;
 	long disabled;
 	int cpu;
-	int pc;
+	unsigned int trace_ctx;
=20
 	tracing_record_cmdline(prev);
=20
@@ -455,7 +456,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	if (next !=3D wakeup_task)
 		return;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
=20
 	/* disable local data, not wakeup_cpu data */
 	cpu =3D raw_smp_processor_id();
@@ -473,9 +474,9 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	/* The task we are waiting for is waking up */
 	data =3D per_cpu_ptr(wakeup_trace->array_buffer.data, wakeup_cpu);
=20
-	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
-	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
-	__trace_stack(wakeup_trace, flags, 0, pc);
+	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, trace_ctx);
+	tracing_sched_switch_trace(wakeup_trace, prev, next, trace_ctx);
+	__trace_stack(wakeup_trace, trace_ctx, 0);
=20
 	T0 =3D data->preempt_timestamp;
 	T1 =3D ftrace_now(cpu);
@@ -529,7 +530,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	int cpu =3D smp_processor_id();
 	unsigned long flags;
 	long disabled;
-	int pc;
+	unsigned int trace_ctx;
=20
 	if (likely(!tracer_enabled))
 		return;
@@ -550,7 +551,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	    (!dl_task(p) && (p->prio >=3D wakeup_prio || p->prio >=3D current->pr=
io)))
 		return;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
 	disabled =3D atomic_inc_return(&per_cpu_ptr(wakeup_trace->array_buffer.da=
ta, cpu)->disabled);
 	if (unlikely(disabled !=3D 1))
 		goto out;
@@ -585,15 +586,15 @@ probe_wakeup(void *ignore, struct task_struct *p)
=20
 	data =3D per_cpu_ptr(wakeup_trace->array_buffer.data, wakeup_cpu);
 	data->preempt_timestamp =3D ftrace_now(cpu);
-	tracing_sched_wakeup_trace(wakeup_trace, p, current, flags, pc);
-	__trace_stack(wakeup_trace, flags, 0, pc);
+	tracing_sched_wakeup_trace(wakeup_trace, p, current, trace_ctx);
+	__trace_stack(wakeup_trace, trace_ctx, 0);
=20
 	/*
 	 * We must be careful in using CALLER_ADDR2. But since wake_up
 	 * is not called by an assembly function  (where as schedule is)
 	 * it should be safe to use it here.
 	 */
-	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, flags, pc);
+	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, trace_ctx);
=20
 out_locked:
 	arch_spin_unlock(&wakeup_lock);
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index d85a2f0f316b3..71a2e705970f0 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -298,9 +298,8 @@ static void ftrace_syscall_enter(void *data, struct pt_=
regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	unsigned long args[6];
-	int pc;
 	int syscall_nr;
 	int size;
=20
@@ -322,12 +321,11 @@ static void ftrace_syscall_enter(void *data, struct p=
t_regs *regs, long id)
=20
 	size =3D sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
=20
-	local_save_flags(irq_flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D trace_buffer_lock_reserve(buffer,
-			sys_data->enter_event->event.type, size, irq_flags, pc);
+			sys_data->enter_event->event.type, size, trace_ctx);
 	if (!event)
 		return;
=20
@@ -337,7 +335,7 @@ static void ftrace_syscall_enter(void *data, struct pt_=
regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    irq_flags, pc);
+				    trace_ctx);
 }
=20
 static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
@@ -348,8 +346,7 @@ static void ftrace_syscall_exit(void *data, struct pt_r=
egs *regs, long ret)
 	struct syscall_metadata *sys_data;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	unsigned long irq_flags;
-	int pc;
+	unsigned int trace_ctx;
 	int syscall_nr;
=20
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
@@ -368,13 +365,12 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
 	if (!sys_data)
 		return;
=20
-	local_save_flags(irq_flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags();
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D trace_buffer_lock_reserve(buffer,
 			sys_data->exit_event->event.type, sizeof(*entry),
-			irq_flags, pc);
+			trace_ctx);
 	if (!event)
 		return;
=20
@@ -383,7 +379,7 @@ static void ftrace_syscall_exit(void *data, struct pt_r=
egs *regs, long ret)
 	entry->ret =3D syscall_get_return_value(current, regs);
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    irq_flags, pc);
+				    trace_ctx);
 }
=20
 static int reg_event_syscall_enter(struct trace_event_file *file,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad30..a1ed96a7a4624 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -961,7 +961,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 	esize =3D SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 	size =3D esize + tu->tp.size + dsize;
 	event =3D trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type, size, 0, 0);
+						call->event.type, size, 0);
 	if (!event)
 		return;
=20
@@ -977,7 +977,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
=20
 	memcpy(data, ucb->buf, tu->tp.size + dsize);
=20
-	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0, 0);
+	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0);
 }
=20
 /* uprobe handler */
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
