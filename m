Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601025D1E9;
	Mon,  3 Nov 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181784; cv=none; b=MN2W9LmyQ7fTdYbRp85jqkb7G/MZhY5n9iIrkd4D0lCabYF6Gke6Rm07V/+f8kTQXAAXMkbAYbbsqai2FOYq0as+qCFLmYc8YAimInkq5fJSE5X2EV6Un5iGithmhiRupY3BmGPlcJYGo8Lz3BTqSFqzRYP0Vnoz1x+dVitWCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181784; c=relaxed/simple;
	bh=GKiEHQYbZ9O5zRueidCrnI4Nof1vAVhqWFWETa9Q4zo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J10JPbTIiN4uUZJwX70ipfFC9GX74XeatUIY/8lrD6UAE+5Pu7sIn/dTwgnxJcq9dtru1meYK9pZDGak6xK/BR2IS4jEMuyfCWGibT1LH8vuF90VE7716vyzo5TK52vE3CyPwragaW3cON39S6NYQG6PwkNvQ5oGCPyRPuwh+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XiUcUBih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/QgBKkz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XiUcUBih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/QgBKkz"
Date: Mon, 3 Nov 2025 15:56:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8KmgFJFmTnTiwLLTqDjpcpiVmKo1ylq3G0CC12iUpoY=;
	b=XiUcUBihyp2w0Hj1A+qX62EhBt9ql+MEQdBEAbMTGs8yZvCzdk3YCvphsh3B7FJcgr5VpP
	h5zvSgAQkF6b5Bz2C2Piz2SoknBhI5MoG1BaRElC0OTrrVPC83AOTTx3Gk1QAUb/ECLrQH
	b1myItGYDWYb5bx7aEBTVFyfHU4nzIPcCo1PyHNZkHg7avF3USHObJXCNBeRSTnvbh1nLm
	ToQJhqJV4hFKQxP/k7zevDmTNNRZASCfhQwd/Mrzhk7tOPaAsfCreVMmAehQJFKk+eHyxr
	J9JfFm5Y9ls6MJydBCqqn1H4TWWrSrGSBVweJD4iXmVNfYFUsAnXyiE4Jvawfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8KmgFJFmTnTiwLLTqDjpcpiVmKo1ylq3G0CC12iUpoY=;
	b=0/QgBKkzEfE2DTyCGGTLXUqJyB251lidPPfp2TNNngiKVckX6VheJgzR+Z1t/box3+nnjl
	NYJ8t2zSf6WeNKBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.18-rc4-rt3
Message-ID: <20251103145619.amGKEIT5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.18-rc4-rt3 patch set. 

Changes since v6.18-rc4-rt2:

  - Replace the ARM patches based on latest version posted to upstream:
    - HIGHPTE is now disabled instead of HAVE_GUP_FAST. 
    - HAVE_ARCH_JUMP_LABEL is now allowed on UP and only disabled on
      SMP builds.
    - Redid the page fault to avoid a warning and harden the branch
      predictor on the correct CPU if needed.
    - Removed the KVM dependency as there is no more KVM.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.18-rc4-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/incr/patch-6.18-rc4-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.18-rc4-rt3

The RT patch against v6.18-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patch-6.18-rc4-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patches-6.18-rc4-rt3.tar.xz

Sebastian

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 002db8da69ee5..84ad4fe11589b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -41,7 +41,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
-	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
@@ -81,7 +81,7 @@ config ARM
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && !PREEMPT_RT
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
@@ -106,7 +106,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
-	select HAVE_GUP_FAST if ARM_LPAE && !(PREEMPT_RT && HIGHPTE)
+	select HAVE_GUP_FAST if ARM_LPAE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_FREGS
@@ -130,7 +130,6 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
@@ -1215,7 +1214,7 @@ config HIGHMEM
 
 config HIGHPTE
 	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM
+	depends on HIGHMEM && !PREEMPT_RT
 	default y
 	help
 	  The VM uses one page of physical memory for each page table.
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 00713f22ef066..ad58c1e22a5f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -183,9 +183,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 {
 	struct task_struct *tsk = current;
 
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -218,10 +215,14 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
 	 */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		if (addr >= TASK_SIZE)
+			harden_branch_predictor();
+		local_irq_enable();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-	else
+	} else {
 		__do_kernel_fault(mm, addr, fsr, regs);
+	}
 }
 
 #ifdef CONFIG_MMU
@@ -274,8 +275,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
+	if (interrupts_enabled(regs)) {
+		if (user_mode(regs) && addr >= TASK_SIZE)
+			harden_branch_predictor();
 		local_irq_enable();
+	}
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -473,9 +477,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
 
-	if (interrupts_enabled(regs))
-		local_irq_enable();
-
 	if (user_mode(regs))
 		goto bad_area;
 
@@ -546,9 +547,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	if (interrupts_enabled(regs))
-		local_irq_enable();
-
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
