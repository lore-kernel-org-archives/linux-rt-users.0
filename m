From: dino@in.ibm.com
Subject: [patch -rt 15/17] sched: Add a missing =
Date: Thu, 22 Oct 2009 18:07:58 +0530
Message-ID: <20091022124112.768152567@spinlock.in.ibm.com>
References: <20091022123743.506956796@spinlock.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	John Stultz <johnstul@us.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36462 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710AbZJVMlT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 08:41:19 -0400
Content-Disposition: inline; filename=sched_fixes.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>

Index: linux-2.6.31.4-rt14-lb1/kernel/sched.c
===================================================================
--- linux-2.6.31.4-rt14-lb1.orig/kernel/sched.c	2009-10-21 10:48:58.000000000 -0400
+++ linux-2.6.31.4-rt14-lb1/kernel/sched.c	2009-10-21 10:49:03.000000000 -0400
@@ -3844,7 +3844,7 @@
 	struct sched_group *sdg = sd->groups;
 
 	power *= arch_scale_freq_power(sd, cpu);
-	power >> SCHED_LOAD_SHIFT;
+	power >>= SCHED_LOAD_SHIFT;
 
 	if ((sd->flags & SD_SHARE_CPUPOWER) && weight > 1) {
 		power *= arch_scale_smt_power(sd, cpu);

--
