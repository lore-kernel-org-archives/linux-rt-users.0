From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH RT 0/6] lockstat measurement extensions
Date: Thu, 13 Mar 2008 17:40:08 -0700
Message-ID: <9810cff90803131740w6a71b61dy1183956132fa89a3@mail.gmail.com>
References: <9810cff90803131703t3626d83fq727b04242f407c13@mail.gmail.com>
	 <9810cff90803131726m55e11b62o5cdebd078626283f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, pavel@ucw.cz, acme@redhat.com, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com
To: "Gregory Haskins" <ghaskins@novell.com>, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.235]:57607 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYCNAkL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Mar 2008 20:40:11 -0400
Received: by qb-out-0506.google.com with SMTP id e11so3663156qbe.15
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2008 17:40:09 -0700 (PDT)
In-Reply-To: <9810cff90803131726m55e11b62o5cdebd078626283f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry missing the patch. At Thomas's urging, this is inlined:

--- linux-2.6.24/kernel/sched.c	2008-02-25 15:32:05.000000000 -0800
+++ linux-2.6.24.working/kernel/sched.c	2008-03-13 13:53:24.000000000 -0700
@@ -1175,6 +1175,20 @@
 	return cpu_curr(task_cpu(p)) == p;
 }

+int task_spinnable(struct task_struct *p)
+{
+/*
+ * The use of task_curr can crash the system since the struct
thread_info seems
+ * to disappear when dereferenced arbitrarily, so becareful.
+ */
+#ifdef CONFIG_SMP
+	if (p && p->se.on_rq && task_curr(p))
+		return 1;
+#else
+	return 0;
+#endif
+}
+
 /* Used instead of source_load when we know the type == 0 */
 unsigned long weighted_cpuload(const int cpu)
 {
@@ -1239,6 +1253,11 @@
 		      *new_cfsrq = cpu_cfs_rq(old_cfsrq, new_cpu);
 	u64 clock_offset;

+//--billh
+//	if (old_cpu >= NR_CPUS)
+//		panic("bogus cpu id %u\n", old_cpu);
+//
+//
 	clock_offset = old_rq->clock - new_rq->clock;

 #ifdef CONFIG_SCHEDSTATS
