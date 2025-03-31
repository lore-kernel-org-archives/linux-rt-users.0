Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE71D9A54;
	Mon, 31 Mar 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414976; cv=none; b=NIh8kFCtMDWHlEEpuqNrNMEjxsDKd7R5WOQbDwk1hIZF/tMaaTDuzUedrq50ExKEWRmDPuIQb0/SmUm67xTEUlz16zhjMIBcsRdo1nvYqNLAHIOaVy0edJKY99KKeb+tv6ST0NThBojuITsyTJB90zzfjcjwOHNKGM5/UZSJVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414976; c=relaxed/simple;
	bh=YwvNzFm/MMPxxMnEMkNryYcNyy00siBirol1dspx+DM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VbJSvpiESpjJr5FWFECjPEuBSOjXqrwnHwLLqnsfBmL9dwNI2w6Sh52kvN2h/nW0qJ4G4cRUQ+oSwx0Bm05yaQApoVWXehkjeyg+ePfbsx6/s6oXnd7KKN8qF7Qc+Oa+yFvQzAjL4/2VPlzUCVgJ1S3J/qDP7nWnnArc1niLESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFQkh/3i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOJePznb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFQkh/3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOJePznb"
Date: Mon, 31 Mar 2025 11:56:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743414971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FOAGnLu8LO209nJAyUa26Xe9MxlyUuWUSQvb932sz94=;
	b=ZFQkh/3ixpqFuQaIo+69FUnVM45ng/KiuV1CrdcsKw8vWDmsrDYK3vKHqPNUOY+AT2k9y4
	NNiQFFYidWqB1/9sLsBlY9ECvRhkw+4wwY4B4d+9A68KS3SBE1tRzICfh1K7glJr5RWma3
	FRJ3Ocv7NfoMPbMoZc9rO9PqJw4OmZ7AHTUa042OY0fPo3G/VjCZ9QAh9QKpPhE72kDcoV
	0NbPa16p5xkteZignD3KCObXOWYBjJrmIll0bB5rvniQl3E/MowshUQ+e4isoURtmdBDs8
	pBYrorKrgbBlnGsZri/tLNoaO+TTa1nb9wFYgm5H0fMnz4AfeE7xCwfT+lAn7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743414971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FOAGnLu8LO209nJAyUa26Xe9MxlyUuWUSQvb932sz94=;
	b=VOJePznbUzWUTz83HCVMblUA8gNZwkCrPPSC0PBHFr7+oNEm60QlCQW9nZtrpOjWUTDL6Y
	tXCbjudwLmaX6PDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.14-rt3
Message-ID: <20250331095610.ulLtPP2C@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.14-rt3 patch set. 

Changes since v6.14-rt2:

  - Update the "generic function for the preemption model" series has
    been updated to v4.

  - ARM64 gained preempt-lazy support. Patch by Mark Rutland.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
	https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.14-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.14/incr/patch-6.14-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.14-rt3

The RT patch against v6.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.14/older/patch-6.14-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.14/older/patches-6.14-rt3.tar.xz

Sebastian

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1254992184d2e..afbd2ebe5c39d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -275,8 +275,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d] %s" S_SMP S_ISA "\n",
-		 str, err, ++die_counter, preempt_model_str());
+	pr_emerg("Internal error: %s: %x [#%d]" S_SMP S_ISA "\n",
+		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4c..ace21a07a00c7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -41,6 +41,7 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a1..4443ef2789758 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -59,11 +59,12 @@ void arch_setup_new_exec(void);
 
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
-#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
-#define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
-#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
+#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
+#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
+#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
+#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -85,6 +86,7 @@ void arch_setup_new_exec(void);
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -100,10 +102,10 @@ void arch_setup_new_exec(void);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
 				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b260ddc4d3e9a..7993fab0cab4c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 	do {
 		local_irq_enable();
 
-		if (thread_flags & _TIF_NEED_RESCHED)
+		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (thread_flags & _TIF_UPROBE)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0b6f92fcdb304..529cff825531c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -179,8 +179,8 @@ static int __die(const char *str, long err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %016lx [#%d] %s" S_SMP "\n",
-		 str, err, ++die_counter, preempt_model_str());
+	pr_emerg("Internal error: %s: %016lx [#%d] " S_SMP "\n",
+		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, 0, SIGSEGV);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d6d77d92b3358..cb8e9357383e9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s %s %s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       preempt_model_str(),
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 7930fbab69dbb..911b95cd57e58 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -198,8 +198,8 @@ void __noreturn die(struct pt_regs *regs, const char *str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d] %s", str, regs->int_code & 0xffff,
-	       regs->int_code >> 17, ++die_counter, preempt_model_str());
+	printk("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
+	       regs->int_code >> 17, ++die_counter);
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 064b23a93c6fe..91639d1e4ec2c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -400,8 +400,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		exec_summary_regs = *regs;
 
 	printk(KERN_DEFAULT
-	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
-	       ++die_counter, preempt_model_str(),
+	       "Oops: %s: %04lx [#%d]%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 0edba7d8df8c7..44c07c4e0833a 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -633,7 +633,7 @@ void __noreturn die(const char * str, struct pt_regs * regs, long err)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, preempt_model_str());
+	pr_info("%s: sig: %ld [#%d]\n", str, err, ++die_counter);
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 694ece3870a54..f6557863e694e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7647,32 +7647,55 @@ PREEMPT_MODEL_ACCESSOR(lazy);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
+#define preempt_dynamic_mode -1
+
 static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+const char *preempt_modes[] = {
+	"none", "voluntary", "full", "lazy", NULL,
+};
+
 const char *preempt_model_str(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && preempt_model_lazy()) {
-		if (preempt_model_rt())
-			return "PREEMPT_RT+LAZY";
-		if (preempt_model_full())
-			return "PREEMPT+LAZY";
-		if (preempt_model_voluntary())
-			return "VOLUNTARY+LAZY";
-		if (preempt_model_none())
-			return "NONE+LAZY";
-	} else {
-		if (preempt_model_rt())
-			return "PREEMPT_RT";
-		if (preempt_model_full())
-			return "PREEMPT";
-		if (preempt_model_voluntary())
-			return "VOLUNTARY";
-		if (preempt_model_none())
-			return "NONE";
+	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		(IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
+		 IS_ENABLED(CONFIG_PREEMPT_LAZY));
+	static char buf[128];
+
+	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
+		struct seq_buf s;
+
+		seq_buf_init(&s, buf, sizeof(buf));
+		seq_buf_puts(&s, "PREEMPT");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			seq_buf_printf(&s, "%sRT%s",
+				       brace ? "_{" : "_",
+				       brace ? "," : "");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
+			seq_buf_printf(&s, "(%s)%s",
+				       preempt_dynamic_mode > 0 ?
+				       preempt_modes[preempt_dynamic_mode] : "undef",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			seq_buf_printf(&s, "LAZY%s",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		return seq_buf_str(&s);
 	}
-	return "UNKNOWN-PREEMPT";
+
+	if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BUILD))
+		return "VOLUNTARY";
+
+	return "NONE";
 }
 
 int io_schedule_prepare(void)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e6..39be73969d284 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -244,11 +244,13 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full", "lazy",
-	};
-	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int j;
+
+	/* Count entries in NULL terminated preempt_modes */
+	for (j = 0; preempt_modes[j]; j++)
+		;
+	j -= !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 
 	for (; i < j; i++) {
 		if (preempt_dynamic_mode == i)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 023b844159c94..1287c5789b7ec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3619,6 +3619,7 @@ extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
+extern const char *preempt_modes[];
 
 #ifdef CONFIG_SCHED_MM_CID
 
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index c3e59f8992279..b3a85fe8b673e 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,7 +54,7 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s" BUILD_ID_FMT "\n",
+	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s " BUILD_ID_FMT "\n",
 	       log_lvl, raw_smp_processor_id(),
 	       __kuid_val(current_real_cred()->euid),
 	       current->pid, current->comm,
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
