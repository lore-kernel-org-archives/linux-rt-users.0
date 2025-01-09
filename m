Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321E215778;
	Thu,  9 Jan 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417254; cv=none; b=nEMZP5uBxWTAicBkee3COeKgxSNeKy8DJY3Mzl8vu+RWlNaa+OflHn3IAo16diiJZAN+16kALbFmy3QgO5yFzh3AnayNQLw/kcR5Fmobk/0if4ayEJNSGeTVivyoK2RNoZXpg/atNUO6zOQRfdfq47n9bdcDRnKlxMxtoA/vaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417254; c=relaxed/simple;
	bh=JH6HUe2XuL+pHO6EbEOIDmBxoHH1CIc95xh3JKNRA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UuT7Qqh2i/qG6n+tPOt++u2HZNgCyNGEdiGJML/qPZuwdWR4PxxQLKXM+A+tVe4kEcFwfN6kClfmUa5P4g+c//V3USM1n9Kdcb2Ct+PZMKxQ8ijvJd0mv8F1eM8+X8kc1whhM+lVsgPD338FigtRUHMCQhd4Zn8m3vFNzDvMMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4a0ritm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2a/btbu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4a0ritm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2a/btbu"
Date: Thu, 9 Jan 2025 11:07:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736417249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CgQXKihXi0e7JfbyZx8Z1cfzhu0PbQDsqfmVR2gbIew=;
	b=T4a0ritm5q9+9Us1N7/ZbwIsZdCTcRUVJLeNn+roZT89XhH+C+RbDO/YLAAqmWR/OJG4YX
	yTTNlahH21JjD341S3WAXm2NL61xoEAtTFr6z6oIufBXgr204y6DHbf8+Ha1ZCI21I2PhO
	dmvTvrHm+dPPTTXrd0kesYohqgcDWezvPiXMnX48qiYfPIYDnXwCmZXtIrtDI7zInXu6PR
	1Y9eD5ysgaD3L2/OjH4wNHtvxZcSWSk2LgID9SNhiF0hbSX76NTspd1CQdPhxVPQ6JdGWQ
	kFyal4UAO9utTAFBGLUFG0SQqIX6UPk+Hxfv0Bxo3HQBHNSJgkP8JNDXcmiGyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736417249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CgQXKihXi0e7JfbyZx8Z1cfzhu0PbQDsqfmVR2gbIew=;
	b=v2a/btbum8hoXN+3K6ojHJcdbivzNLqJCsNpciNlSsW7LNI7pxf/XCQ7TgfxspR/ITj671
	vtAD6WwXDWNK1vBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.13-rc6-rt3
Message-ID: <20250109100727.WZAG8ggV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.13-rc6-rt3 patch set. 

Changes since v6.13-rc6-rt2:

  - Adding Lazy-Preempt for PowerPC. This also fixes a boot problem on
    certain PowerPC parts. The regression was introduced after dropping
    the old Lazy-Preempt patches for PowerPC back in v6.6-rc6-rt10.
    Reported by Robert Joslyn, patch by Shrikanth Hegde.

  - Update the modules core clean up patch series to v3.

Known issues
    None.

The delta patch against v6.13-rc6-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/incr/patch-6.13-rc6-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.13-rc6-rt3

The RT patch against v6.13-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patch-6.13-rc6-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patches-6.13-rc6-rt3.tar.xz

Sebastian

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index da2ee8d6ef1a7..354ce16d83cb5 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -285,11 +285,9 @@ bool in_module_plt(unsigned long loc)
 	struct module *mod;
 	bool ret;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_text_address(loc);
 	ret = mod && (loc - (u32)mod->arch.core.plt_ent < mod->arch.core.plt_count * PLT_ENT_SIZE ||
 		      loc - (u32)mod->arch.init.plt_ent < mod->arch.init.plt_count * PLT_ENT_SIZE);
-	preempt_enable();
-
 	return ret;
 }
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 245cb419ca24d..2b76939b6304f 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -257,14 +257,13 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	 * dealing with an out-of-range condition, we can assume it
 	 * is due to a module being loaded far away from the kernel.
 	 *
-	 * NOTE: __module_text_address() must be called with preemption
-	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
+	 * NOTE: __module_text_address() must be called within a RCU read
+	 * section, but we can rely on ftrace_lock to ensure that 'mod'
 	 * retains its validity throughout the remainder of this code.
 	 */
 	if (!mod) {
-		preempt_disable();
+		guard(rcu)();
 		mod = __module_text_address(pc);
-		preempt_enable();
 	}
 
 	if (WARN_ON(!mod))
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 18056229e22e4..5b7b8ac13e350 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -85,14 +85,13 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod
 	 * dealing with an out-of-range condition, we can assume it
 	 * is due to a module being loaded far away from the kernel.
 	 *
-	 * NOTE: __module_text_address() must be called with preemption
-	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
+	 * NOTE: __module_text_address() must be called within a RCU read
+	 * section, but we can rely on ftrace_lock to ensure that 'mod'
 	 * retains its validity throughout the remainder of this code.
 	 */
 	if (!mod) {
-		preempt_disable();
-		mod = __module_text_address(pc);
-		preempt_enable();
+		scoped_guard(rcu)
+			mod = __module_text_address(pc);
 	}
 
 	if (WARN_ON(!mod))
diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index b257228763317..d623935a75471 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -399,7 +399,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
 
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	guard(rcu)();
 
 	if (is_entry_func(state->pc))
 		goto end;
@@ -514,14 +514,12 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (!__kernel_text_address(state->pc))
 		goto err;
 
-	preempt_enable();
 	return true;
 
 err:
 	state->error = true;
 
 end:
-	preempt_enable();
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
 }
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7ece090edf4d3..56e6189d25b59 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,6 +145,7 @@ config PPC
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 6ebca2996f18f..2785c7462ebf7 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -103,6 +103,7 @@ void arch_setup_new_exec(void);
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
+#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		12	/* Force successful syscall return */
@@ -122,6 +123,7 @@ void arch_setup_new_exec(void);
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -142,9 +144,10 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_EMU)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
-				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
+				 _TIF_UPROBE | _TIF_RESTORE_TM | \
+				 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL)
+
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index af62ec974b970..8f4acc55407b0 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED) {
+		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
 			schedule();
 		} else {
 			/*
@@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 5ccd791761e8f..558d7f4e4bea6 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -115,10 +115,8 @@ static unsigned long ftrace_lookup_module_stub(unsigned long ip, unsigned long a
 {
 	struct module *mod = NULL;
 
-	preempt_disable();
-	mod = __module_text_address(ip);
-	preempt_enable();
-
+	scoped_guard(rcu)
+		mod = __module_text_address(ip);
 	if (!mod)
 		pr_err("No module loaded at addr=%lx\n", ip);
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 98787376eb87c..531d40f10c8a1 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -120,10 +120,8 @@ static struct module *ftrace_lookup_module(struct dyn_ftrace *rec)
 {
 	struct module *mod;
 
-	preempt_disable();
-	mod = __module_text_address(rec->ip);
-	preempt_enable();
-
+	scoped_guard(rcu)
+		mod = __module_text_address(rec->ip);
 	if (!mod)
 		pr_err("No module loaded at addr=%lx\n", rec->ip);
 
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index d491da8d18389..58ed6bd613a6f 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
 	 * set and we are preemptible. The hack here is to schedule a
 	 * decrementer to fire here and reschedule for us if necessary.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT) && need_resched())
+	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
 		set_dec(1);
 	return 0;
 }
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index f17d166078823..276b5368ff6b0 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -98,11 +98,10 @@ static inline bool within_module_coretext(void *addr)
 #ifdef CONFIG_MODULES
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address((unsigned long)addr);
 	if (mod && within_module_core((unsigned long)addr, mod))
 		ret = true;
-	preempt_enable();
 #endif
 	return ret;
 }
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index d4705a348a804..977ee75e047c8 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -476,7 +476,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
 
 	/* Don't let modules unload while we're reading their ORC data. */
-	preempt_disable();
+	guard(rcu)();
 
 	/* End-of-stack check for user tasks: */
 	if (state->regs && user_mode(state->regs))
@@ -669,14 +669,12 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto err;
 	}
 
-	preempt_enable();
 	return true;
 
 err:
 	state->error = true;
 
 the_end:
-	preempt_enable();
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
 }
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index c3f075e8f60cb..d5dd54c53ace6 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -55,9 +55,8 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	if (is_ksym_addr((unsigned long)ptr))
 		return ptr;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address((unsigned long)ptr);
-	preempt_enable();
 
 	if (mod)
 		ptr = dereference_module_function_descriptor(mod, ptr);
diff --git a/include/linux/module.h b/include/linux/module.h
index 94acbacdcdf18..5c1f7ea76c8cb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -663,7 +663,7 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
 	return within_module_init(addr, mod) || within_module_core(addr, mod);
 }
 
-/* Search for module by name: must be in a RCU-sched critical section. */
+/* Search for module by name: must be in a RCU critical section. */
 struct module *find_module(const char *name);
 
 extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08caad7767176..abcd4d1f98eab 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -71,14 +71,11 @@ static bool is_module_cfi_trap(unsigned long addr)
 	struct module *mod;
 	bool found = false;
 
-	rcu_read_lock_sched_notrace();
-
+	guard(rcu)();
 	mod = __module_address(addr);
 	if (mod)
 		found = is_trap(addr, mod->kcfi_traps, mod->kcfi_traps_end);
 
-	rcu_read_unlock_sched_notrace();
-
 	return found;
 }
 #else /* CONFIG_MODULES */
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 93a822d3c468c..7cb19e6014266 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -653,13 +653,12 @@ static int __jump_label_mod_text_reserved(void *start, void *end)
 	struct module *mod;
 	int ret;
 
-	preempt_disable();
-	mod = __module_text_address((unsigned long)start);
-	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
-	if (!try_module_get(mod))
-		mod = NULL;
-	preempt_enable();
-
+	scoped_guard(rcu) {
+		mod = __module_text_address((unsigned long)start);
+		WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
+		if (!try_module_get(mod))
+			mod = NULL;
+	}
 	if (!mod)
 		return 0;
 
@@ -746,9 +745,9 @@ static int jump_label_add_module(struct module *mod)
 				kfree(jlm);
 				return -ENOMEM;
 			}
-			preempt_disable();
-			jlm2->mod = __module_address((unsigned long)key);
-			preempt_enable();
+			scoped_guard(rcu)
+				jlm2->mod = __module_address((unsigned long)key);
+
 			jlm2->entries = static_key_entries(key);
 			jlm2->next = NULL;
 			static_key_set_mod(key, jlm2);
@@ -906,13 +905,13 @@ static void jump_label_update(struct static_key *key)
 		return;
 	}
 
-	preempt_disable();
-	mod = __module_address((unsigned long)key);
-	if (mod) {
-		stop = mod->jump_entries + mod->num_jump_entries;
-		init = mod->state == MODULE_STATE_COMING;
+	scoped_guard(rcu) {
+		mod = __module_address((unsigned long)key);
+		if (mod) {
+			stop = mod->jump_entries + mod->num_jump_entries;
+			init = mod->state == MODULE_STATE_COMING;
+		}
 	}
-	preempt_enable();
 #endif
 	entry = static_key_entries(key);
 	/* if there are no users, entry can be NULL */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b027a4030976a..22e47a27df4aa 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1566,7 +1566,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (ret)
 		return ret;
 	jump_label_lock();
-	preempt_disable();
+	rcu_read_lock();
 
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
@@ -1612,7 +1612,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	}
 
 out:
-	preempt_enable();
+	rcu_read_unlock();
 	jump_label_unlock();
 
 	return ret;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3c21c31796db0..f8932c63b08e3 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -59,7 +59,7 @@ static void klp_find_object_module(struct klp_object *obj)
 	if (!klp_is_module(obj))
 		return;
 
-	rcu_read_lock_sched();
+	guard(rcu)();
 	/*
 	 * We do not want to block removal of patched modules and therefore
 	 * we do not take a reference here. The patches are removed by
@@ -75,8 +75,6 @@ static void klp_find_object_module(struct klp_object *obj)
 	 */
 	if (mod && mod->klp_alive)
 		obj->mod = mod;
-
-	rcu_read_unlock_sched();
 }
 
 static bool klp_initialized(void)
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index d8e0a51ff9968..00a60796327c0 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -177,18 +177,15 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	unsigned long strtab_size;
 	void *data_base = mod->mem[MOD_DATA].base;
 	void *init_data_base = mod->mem[MOD_INIT_DATA].base;
+	struct mod_kallsyms *kallsyms;
 
-	/* Set up to point into init section. */
-	rcu_assign_pointer(mod->kallsyms, init_data_base + info->mod_kallsyms_init_off);
+	kallsyms = init_data_base + info->mod_kallsyms_init_off;
 
-	rcu_read_lock();
-	/* The following is safe since this pointer cannot change */
-	rcu_dereference(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
-	rcu_dereference(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	kallsyms->symtab = (void *)symsec->sh_addr;
+	kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	rcu_dereference(mod->kallsyms)->strtab =
-		(void *)info->sechdrs[info->index.str].sh_addr;
-	rcu_dereference(mod->kallsyms)->typetab = init_data_base + info->init_typeoffs;
+	kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
+	kallsyms->typetab = init_data_base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -198,20 +195,19 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.strtab = s = data_base + info->stroffs;
 	mod->core_kallsyms.typetab = data_base + info->core_typeoffs;
 	strtab_size = info->core_typeoffs - info->stroffs;
-	src = rcu_dereference(mod->kallsyms)->symtab;
-	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
-		rcu_dereference(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
+	src = kallsyms->symtab;
+	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
+		kallsyms->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			ssize_t ret;
 
 			mod->core_kallsyms.typetab[ndst] =
-			    rcu_dereference(mod->kallsyms)->typetab[i];
+				kallsyms->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			ret = strscpy(s,
-				      &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
+			ret = strscpy(s, &kallsyms->strtab[src[i].st_name],
 				      strtab_size);
 			if (ret < 0)
 				break;
@@ -219,7 +215,9 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 			strtab_size -= ret + 1;
 		}
 	}
-	rcu_read_unlock();
+
+	/* Set up to point into init section. */
+	rcu_assign_pointer(mod->kallsyms, kallsyms);
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
@@ -349,7 +347,6 @@ int module_address_lookup(unsigned long addr,
 		if (sym)
 			ret = strscpy(namebuf, sym, KSYM_NAME_LEN);
 	}
-
 	return ret;
 }
 
@@ -478,6 +475,7 @@ int module_kallsyms_on_each_symbol(const char *modname,
 
 		kallsyms = rcu_dereference_check(mod->kallsyms,
 						 lockdep_is_held(&module_mutex));
+
 		for (i = 0; i < kallsyms->num_symtab; i++) {
 			const Elf_Sym *sym = &kallsyms->symtab[i];
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 073a8d57884d8..6a99076146cbc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -331,7 +331,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 /*
  * Find an exported symbol and return it, along with, (optional) crc and
- * (optional) module which owns it.  Needs RCU or module_mutex.
+ * (optional) module which owns it. Needs RCU or module_mutex.
  */
 bool find_symbol(struct find_symbol_arg *fsa)
 {
@@ -821,6 +821,10 @@ void symbol_put_addr(void *addr)
 	if (core_kernel_text(a))
 		return;
 
+	/*
+	 * Even though we hold a reference on the module; we still need to
+	 * RCU read section in order to safely traverse the data structure.
+	 */
 	guard(rcu)();
 	modaddr = __module_text_address(a);
 	BUG_ON(!modaddr);
@@ -1357,16 +1361,17 @@ void *__symbol_get(const char *symbol)
 		.warn	= true,
 	};
 
-	guard(rcu)();
-	if (!find_symbol(&fsa))
-		return NULL;
-	if (fsa.license != GPL_ONLY) {
-		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
-			symbol);
-		return NULL;
+	scoped_guard(rcu) {
+		if (!find_symbol(&fsa))
+			return NULL;
+		if (fsa.license != GPL_ONLY) {
+			pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+				symbol);
+			return NULL;
+		}
+		if (strong_try_module_get(fsa.owner))
+			return NULL;
 	}
-	if (strong_try_module_get(fsa.owner))
-		return NULL;
 	return (void *)kernel_symbol_value(fsa.sym);
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
@@ -3615,26 +3620,23 @@ char *module_flags(struct module *mod, char *buf, bool show_state)
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
-	const struct exception_table_entry *e = NULL;
 	struct module *mod;
 
 	guard(rcu)();
 	mod = __module_address(addr);
 	if (!mod)
-		goto out;
+		return NULL;
 
 	if (!mod->num_exentries)
-		goto out;
-
-	e = search_extable(mod->extable,
-			   mod->num_exentries,
-			   addr);
-out:
+		return NULL;
 	/*
-	 * Now, if we found one, we are running inside it now, hence
-	 * we cannot unload the module, hence no refcnt needed.
+	 * The address passed here belongs to a module that is currently
+	 * invoked (we are running inside it). Therefore its module::refcnt
+	 * needs already be >0 to ensure that it is not removed at this stage.
+	 * All other user need to invoke this function within a RCU read
+	 * section.
 	 */
-	return e;
+	return search_extable(mod->extable, mod->num_exentries, addr);
 }
 
 /**
@@ -3646,12 +3648,8 @@ const struct exception_table_entry *search_module_extables(unsigned long addr)
  */
 bool is_module_address(unsigned long addr)
 {
-	bool ret;
-
 	guard(rcu)();
-	ret = __module_address(addr) != NULL;
-
-	return ret;
+	return __module_address(addr) != NULL;
 }
 
 /**
@@ -3695,12 +3693,8 @@ struct module *__module_address(unsigned long addr)
  */
 bool is_module_text_address(unsigned long addr)
 {
-	bool ret;
-
 	guard(rcu)();
-	ret = __module_text_address(addr) != NULL;
-
-	return ret;
+	return __module_text_address(addr) != NULL;
 }
 
 /**
@@ -3729,6 +3723,7 @@ void print_modules(void)
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
 	printk(KERN_DEFAULT "Modules linked in:");
+	/* Most callers should already have preempt disabled, but make sure */
 	guard(rcu)();
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
index 277197977d438..d3204c5c74eb7 100644
--- a/kernel/module/tree_lookup.c
+++ b/kernel/module/tree_lookup.c
@@ -12,11 +12,11 @@
 
 /*
  * Use a latched RB-tree for __module_address(); this allows us to use
- * RCU-sched lookups of the address from any context.
+ * RCU lookups of the address from any context.
  *
- * This is conditional on PERF_EVENTS || TRACING because those can really hit
- * __module_address() hard by doing a lot of stack unwinding; potentially from
- * NMI context.
+ * This is conditional on PERF_EVENTS || TRACING || CFI_CLANG because those can
+ * really hit __module_address() hard by doing a lot of stack unwinding;
+ * potentially from NMI context.
  */
 
 static __always_inline unsigned long __mod_tree_val(struct latch_tree_node *n)
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 0437eea1d209f..65ef8f2a821da 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -62,16 +62,17 @@ int check_modstruct_version(const struct load_info *info,
 		.name	= "module_layout",
 		.gplok	= true,
 	};
+	bool have_symbol;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
 	 * locking is necessary. Regardless use a RCU read section to keep
 	 * lockdep happy.
 	 */
-	scoped_guard(rcu) {
-		if (!find_symbol(&fsa))
-			BUG();
-	}
+	scoped_guard(rcu)
+		have_symbol = find_symbol(&fsa);
+	BUG_ON(!have_symbol);
+
 	return check_version(info, "module_layout", mod, fsa.crc);
 }
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index bb7d066a7c397..c2c59e6ef35d0 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -325,13 +325,12 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 	struct module *mod;
 	int ret;
 
-	preempt_disable();
-	mod = __module_text_address((unsigned long)start);
-	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
-	if (!try_module_get(mod))
-		mod = NULL;
-	preempt_enable();
-
+	scoped_guard(rcu) {
+		mod = __module_text_address((unsigned long)start);
+		WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
+		if (!try_module_get(mod))
+			mod = NULL;
+	}
 	if (!mod)
 		return 0;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b8db5aee9d38..020df7b6ff90c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2336,10 +2336,9 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 {
 	struct module *mod;
 
-	preempt_disable();
+	guard(rcu)();
 	mod = __module_address((unsigned long)btp);
 	module_put(mod);
-	preempt_enable();
 }
 
 static __always_inline
@@ -2907,16 +2906,14 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 	for (i = 0; i < addrs_cnt; i++) {
 		struct module *mod;
 
-		preempt_disable();
-		mod = __module_address(addrs[i]);
-		/* Either no module or we it's already stored  */
-		if (!mod || has_module(&arr, mod)) {
-			preempt_enable();
-			continue;
+		scoped_guard(rcu) {
+			mod = __module_address(addrs[i]);
+			/* Either no module or we it's already stored  */
+			if (!mod || has_module(&arr, mod))
+				continue;
+			if (!try_module_get(mod))
+				err = -EINVAL;
 		}
-		if (!try_module_get(mod))
-			err = -EINVAL;
-		preempt_enable();
 		if (err)
 			break;
 		err = add_module(&arr, mod);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 935a886af40c9..37ff78ee17fe0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -123,9 +123,8 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 	if (!p)
 		return true;
 	*p = '\0';
-	rcu_read_lock_sched();
-	ret = !!find_module(tk->symbol);
-	rcu_read_unlock_sched();
+	scoped_guard(rcu)
+		ret = !!find_module(tk->symbol);
 	*p = ':';
 
 	return ret;
@@ -800,12 +799,10 @@ static struct module *try_module_get_by_name(const char *name)
 {
 	struct module *mod;
 
-	rcu_read_lock_sched();
+	guard(rcu)();
 	mod = find_module(name);
 	if (mod && !try_module_get(mod))
 		mod = NULL;
-	rcu_read_unlock_sched();
-
 	return mod;
 }
 #else
diff --git a/lib/bug.c b/lib/bug.c
index e0ff219899902..b1f07459c2ee3 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -66,23 +66,19 @@ static LIST_HEAD(module_bug_list);
 
 static struct bug_entry *module_find_bug(unsigned long bugaddr)
 {
+	struct bug_entry *bug;
 	struct module *mod;
-	struct bug_entry *bug = NULL;
 
-	rcu_read_lock_sched();
+	guard(rcu)();
 	list_for_each_entry_rcu(mod, &module_bug_list, bug_list) {
 		unsigned i;
 
 		bug = mod->bug_table;
 		for (i = 0; i < mod->num_bugs; ++i, ++bug)
 			if (bugaddr == bug_addr(bug))
-				goto out;
+				return bug;
 	}
-	bug = NULL;
-out:
-	rcu_read_unlock_sched();
-
-	return bug;
+	return NULL;
 }
 
 void module_bug_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
@@ -235,11 +231,11 @@ void generic_bug_clear_once(void)
 #ifdef CONFIG_MODULES
 	struct module *mod;
 
-	rcu_read_lock_sched();
-	list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
-		clear_once_table(mod->bug_table,
-				 mod->bug_table + mod->num_bugs);
-	rcu_read_unlock_sched();
+	scoped_guard(rcu) {
+		list_for_each_entry_rcu(mod, &module_bug_list, bug_list)
+			clear_once_table(mod->bug_table,
+					 mod->bug_table + mod->num_bugs);
+	}
 #endif
 
 	clear_once_table(__start___bug_table, __stop___bug_table);
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
