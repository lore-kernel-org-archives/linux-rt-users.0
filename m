From: John Kacur <jkacur@redhat.com>
Subject: Simplify the code in cpuid_open
Date: Thu, 8 Oct 2009 17:20:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910081706250.24270@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: hpa@zytor.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbZJHPVC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Oct 2009 11:21:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Peter picked up my patch for tip/x86/cpu that removes the bkl in 
cpuid_open. Ingo subsequently merged that into tip/master.

The following patch folds back-in tglx's patch that we should have known 
about if we had looked into tip/rt/bkl in the first place!

Please pick it up for tip/x86/cpu and tip/master.

>From b416b75555aca5e7f066f6edd824fce4b7d08d28 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 8 Oct 2009 16:31:57 +0200
Subject: [PATCH] Simplify the code in cpuid_open

This patch folds back in tglx's 55968ede164ae523692f00717f50cd926f1382a0
to my patch that removed the bkl.

This simplifies the code, and makes it consistent with the changes to
kill the bkl in msr.c as well.

This is applied against tip/master

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 arch/x86/kernel/cpuid.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 8bb8401..7ef24a7 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -116,18 +116,16 @@ static int cpuid_open(struct inode *inode, struct file *file)
 {
 	unsigned int cpu;
 	struct cpuinfo_x86 *c;
-	int ret = 0;
 
 	cpu = iminor(file->f_path.dentry->d_inode);
-	if (cpu >= nr_cpu_ids || !cpu_online(cpu)) {
-		ret = -ENXIO;	/* No such CPU */
-		goto out;
-	}
+	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
+		return -ENXIO;	/* No such CPU */
+
 	c = &cpu_data(cpu);
 	if (c->cpuid_level < 0)
-		ret = -EIO;	/* CPUID not supported */
-out:
-	return ret;
+		return -EIO;	/* CPUID not supported */
+
+	return 0;
 }
 
 /*
-- 
1.6.0.6

