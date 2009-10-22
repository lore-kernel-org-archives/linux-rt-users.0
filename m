From: dino@in.ibm.com
Subject: [patch -rt 04/17] sched: add smt_gain
Date: Thu, 22 Oct 2009 18:07:47 +0530
Message-ID: <20091022124110.406368730@spinlock.in.ibm.com>
References: <20091022123743.506956796@spinlock.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	John Stultz <johnstul@us.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755895AbZJVMm2@vger.kernel.org>
Content-Disposition: inline; filename=sched-lb-1b.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The idea is that multi-threading a core yields more work capacity than
a single thread, provide a way to express a static gain for threads.
 
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
---
 include/linux/sched.h    |    1 +
 include/linux/topology.h |    1 +
 kernel/sched.c           |    8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6.31.4-rt14/include/linux/sched.h
===================================================================
--- linux-2.6.31.4-rt14.orig/include/linux/sched.h	2009-10-16 09:15:30.000000000 -0400
+++ linux-2.6.31.4-rt14/include/linux/sched.h	2009-10-16 09:15:34.000000000 -0400
@@ -966,6 +966,7 @@
 	unsigned int newidle_idx;
 	unsigned int wake_idx;
 	unsigned int forkexec_idx;
+	unsigned int smt_gain;
 	int flags;			/* See SD_* */
 	enum sched_domain_level level;
 
Index: linux-2.6.31.4-rt14/include/linux/topology.h
===================================================================
--- linux-2.6.31.4-rt14.orig/include/linux/topology.h	2009-10-16 09:15:16.000000000 -0400
+++ linux-2.6.31.4-rt14/include/linux/topology.h	2009-10-16 09:15:34.000000000 -0400
@@ -99,6 +99,7 @@
 				| SD_SHARE_CPUPOWER,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
+	.smt_gain		= 1178,	/* 15% */	\
 }
 #endif
 #endif /* CONFIG_SCHED_SMT */
Index: linux-2.6.31.4-rt14/kernel/sched.c
===================================================================
--- linux-2.6.31.4-rt14.orig/kernel/sched.c	2009-10-16 09:15:32.000000000 -0400
+++ linux-2.6.31.4-rt14/kernel/sched.c	2009-10-16 09:15:34.000000000 -0400
@@ -8729,9 +8729,15 @@
 		weight = cpumask_weight(sched_domain_span(sd));
 		/*
 		 * SMT siblings share the power of a single core.
+		 * Usually multiple threads get a better yield out of
+		 * that one core than a single thread would have,
+		 * reflect that in sd->smt_gain.
 		 */
-		if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1)
+		if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1) {
+			power *= sd->smt_gain;
 			power /= weight;
+			power >>= SCHED_LOAD_SHIFT;
+		}
 		sg_inc_cpu_power(sd->groups, power);
 		return;
 	}

--
