Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D8215067;
	Thu,  9 Jan 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422890; cv=none; b=cU/nS+iArr6CTGxl//F5dCkue6LlqfRlqPxA/XPkAC6bRYbAJEcNWxB+LODk1slaAhA5eE7IkiEabQwC2nPhb8SVJhWopwfmctH+IQytE86wV3mL/9+RKocPckytyxqKIp6URQjms3OL9a7/ukL7R6Nm+lFtTCd816LpUXnmcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422890; c=relaxed/simple;
	bh=GtZ1by6dGwKjfosMP0xkz7dQqaPyZLXgN9FO0YpYDJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uuyaMw8equ9PCpPpiOlFDf1t1LaWEqeugm9kIQXYBHO83nOfe2v6s8OlNJJCyczVHzARaEe62XIf7887xpUnQBvxSq/G65lzXjhX6Q1a00ORae64sJZ27hvwZccVVL9jnwz3OMy5KFJ0wSKYuNWtSFJCPAO39L2sIM1UAqfWWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwIxjZMj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTKLuYNk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwIxjZMj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTKLuYNk"
Date: Thu, 9 Jan 2025 12:41:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736422885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z7verech13lfUP/LzTFIjZNJekPfjk1pXK3GbSwd6H8=;
	b=CwIxjZMjGxROVOueMKEBs/So1H+EElM8001ksJ0USZd43SK8TlBv3euGhdsQVle8Lr6Qqp
	Iy8gjZiAvkLV57+1WSnrR4hRn2KbcpESrCI0KVJfYct3DReTjRru//sWd5i12CF4k11Q3D
	Lk0m0HdMCqJWIry/Wnw84L9wYvBWH3GJbi0xcXgluTdmsqjERoSxGu0Moiq982d6HZdy/g
	TaMPsPnM5B+biRHdObZPv2FGrhmQJvyLxwes5C7Fj1PQaBYbVUmlAcz24BBei3WRyEjyxJ
	GTZR1cFQDEe7ZGjTxMLa1i/9//MBKyYyD4+SR7hBQc8rbYoAMD1fW+39xOF4gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736422885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z7verech13lfUP/LzTFIjZNJekPfjk1pXK3GbSwd6H8=;
	b=bTKLuYNk3R5Q31472hW8PbavSDUQ5W8JVufaE+ukfgJrszvrGoCjB16/DccgI2v2T8BkFA
	A48gV6QnV/rW+MAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.12.8-rt8
Message-ID: <20250109114123.uaMIMQx_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.12.8-rt8 patch set. 

Changes since v6.12.8-rt7:

  - Adding Lazy-Preempt for PowerPC. This also fixes a boot problem on
    certain PowerPC parts. The regression was introduced after dropping
    the old Lazy-Preempt patches for PowerPC back in v6.6-rc6-rt10.
    Reported by Robert Joslyn, patch by Shrikanth Hegde.

Known issues
    None.

The delta patch against v6.12.8-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/incr/patch-6.12.8-rt7-rt8.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.12.8-rt8

The RT patch against v6.12.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.8-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patches-6.12.8-rt8.tar.xz

Sebastian

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3e08ee0654de0..3d72545eac3ef 100644
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
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
