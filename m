From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.5-rt15
Date: Fri, 2 Nov 2012 23:11:03 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1211022303510.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39384 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab2KBWLE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Nov 2012 18:11:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.6.5-rt15 brown paper bag release.

Changes since 3.6.5-rt14:

   * Fix typos and other stupidities^Wcrimes committed by an
     overworked and tired RT maintainer (courtesy Paul Gortmaker)

The embarrasing delta patch against 3.6.5-rt14 is appended below and
can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.5-rt14-rt15.patch.xz

The RT patch against 3.6.5 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.5-rt15.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.5-rt15.tar.xz

Enjoy,

	tglx

------------->
Index: linux-stable/arch/x86/kernel/entry_32.S
===================================================================
--- linux-stable.orig/arch/x86/kernel/entry_32.S
+++ linux-stable/arch/x86/kernel/entry_32.S
@@ -597,7 +597,7 @@ ENDPROC(system_call)
 	ALIGN
 	RING0_PTREGS_FRAME		# can't unwind into user space anyway
 work_pending:
-	testl $_TIF_NEED_RESCHED_MASK, %cx
+	testl $_TIF_NEED_RESCHED_MASK, %ecx
 	jz work_notifysig
 work_resched:
 	call schedule
Index: linux-stable/kernel/Kconfig.preempt
===================================================================
--- linux-stable.orig/kernel/Kconfig.preempt
+++ linux-stable/kernel/Kconfig.preempt
@@ -10,7 +10,7 @@ config HAVE_PREEMPT_LAZY
 	bool
 
 config PREEMPT_LAZY
-	def_bool y if HAVE_PREEMPT_LAZE && PREEMPT_RT_FULL
+	def_bool y if HAVE_PREEMPT_LAZY && PREEMPT_RT_FULL
 
 choice
 	prompt "Preemption Model"
Index: linux-stable/kernel/sched/features.h
===================================================================
--- linux-stable.orig/kernel/sched/features.h
+++ linux-stable/kernel/sched/features.h
@@ -76,4 +76,3 @@ SCHED_FEAT(PREEMPT_LAZY, true)
 SCHED_FEAT(FORCE_SD_OVERLAP, false)
 SCHED_FEAT(RT_RUNTIME_SHARE, true)
 SCHED_FEAT(LB_MIN, false)
