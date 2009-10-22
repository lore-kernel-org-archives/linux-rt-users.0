From: dino@in.ibm.com
Subject: [patch -rt 11/17] Provide an arch specific hook for cpufreq based scaling of cpu_power.
Date: Thu, 22 Oct 2009 18:07:54 +0530
Message-ID: <20091022124111.966875893@spinlock.in.ibm.com>
References: <20091022123743.506956796@spinlock.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	John Stultz <johnstul@us.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:50417 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323AbZJVMlL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 08:41:11 -0400
Content-Disposition: inline; filename=sched-lb-10.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
---
 kernel/sched.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: linux-2.6.31.4-rt14-lb1/kernel/sched.c
===================================================================
--- linux-2.6.31.4-rt14-lb1.orig/kernel/sched.c	2009-10-21 10:47:15.000000000 -0400
+++ linux-2.6.31.4-rt14-lb1/kernel/sched.c	2009-10-21 10:48:58.000000000 -0400
@@ -3793,7 +3793,18 @@
 }
 #endif /* CONFIG_SCHED_MC || CONFIG_SCHED_SMT */
 
-unsigned long __weak arch_scale_smt_power(struct sched_domain *sd, int cpu)
+
+unsigned long default_scale_freq_power(struct sched_domain *sd, int cpu)
+{
+	return SCHED_LOAD_SCALE;
+}
+
+unsigned long __weak arch_scale_freq_power(struct sched_domain *sd, int cpu)
+{
+	return default_scale_freq_power(sd, cpu);
+}
+
+unsigned long default_scale_smt_power(struct sched_domain *sd, int cpu)
 {
 	unsigned long weight = cpumask_weight(sched_domain_span(sd));
 	unsigned long smt_gain = sd->smt_gain;
@@ -3803,6 +3814,11 @@
 	return smt_gain;
 }
 
+unsigned long __weak arch_scale_smt_power(struct sched_domain *sd, int cpu)
+{
+	return default_scale_smt_power(sd, cpu);
+}
+
 unsigned long scale_rt_power(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -3827,7 +3843,8 @@
 	unsigned long power = SCHED_LOAD_SCALE;
 	struct sched_group *sdg = sd->groups;
 
-	/* here we could scale based on cpufreq */
+	power *= arch_scale_freq_power(sd, cpu);
+	power >> SCHED_LOAD_SHIFT;
 
 	if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1) {
 		power *= arch_scale_smt_power(sd, cpu);

--
