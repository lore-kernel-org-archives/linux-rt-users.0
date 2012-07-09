From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Mon, 9 Jul 2012 15:40:23 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1207091539190.32033@ionos>
References: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com> <E7D6489E57008E4088E37F78D30C62E60BC983@LB-OPS-EXCH01.miranda.com> <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com> <20120704131520.GH9200@uudg.org>
 <E7D6489E57008E4088E37F78D30C62E60C4957@LB-OPS-EXCH01.miranda.com> <alpine.LFD.2.02.1207091211060.32033@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: PRINGLE Chris <chris.pringle@miranda.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50653 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2GINk1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 09:40:27 -0400
In-Reply-To: <alpine.LFD.2.02.1207091211060.32033@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Chris,

On Mon, 9 Jul 2012, Thomas Gleixner wrote:
> On Fri, 6 Jul 2012, PRINGLE Chris wrote:
> > It worries me a bit because this could potentially go wrong during
> > runtime if the kernel ever reaps the lookaside cache for memory;
> > this will then crash the entire system.
> 
> Found the root cause, working on a fix.

Does the patch below work for you?

Thanks,

	tglx

Index: linux-stable-rt/mm/slab.c
===================================================================
--- linux-stable-rt.orig/mm/slab.c
+++ linux-stable-rt/mm/slab.c
@@ -743,8 +743,26 @@ slab_on_each_cpu(void (*func)(void *arg,
 {
 	unsigned int i;
 
+	get_cpu_light();
 	for_each_online_cpu(i)
 		func(arg, i);
+	put_cpu_light();
+}
+
+static void lock_slab_on(unsigned int cpu)
+{
+	if (cpu == smp_processor_id())
+		local_lock_irq(slab_lock);
+	else
+		local_spin_lock_irq(slab_lock, &per_cpu(slab_lock, cpu).lock);
+}
+
+static void unlock_slab_on(unsigned int cpu)
+{
+	if (cpu == smp_processor_id())
+		local_unlock_irq(slab_lock);
+	else
+		local_spin_unlock_irq(slab_lock, &per_cpu(slab_lock, cpu).lock);
 }
 #endif
 
@@ -2692,10 +2710,10 @@ static void do_drain(void *arg, int cpu)
 {
 	LIST_HEAD(tmp);
 
-	spin_lock_irq(&per_cpu(slab_lock, cpu).lock);
+	lock_slab_on(cpu);
 	__do_drain(arg, cpu);
 	list_splice_init(&per_cpu(slab_free_list, cpu), &tmp);
-	spin_unlock_irq(&per_cpu(slab_lock, cpu).lock);
+	unlock_slab_on(cpu);
 	free_delayed(&tmp);
 }
 #endif
@@ -4163,9 +4181,9 @@ static void do_ccupdate_local(void *info
 #else
 static void do_ccupdate_local(void *info, int cpu)
 {
-	spin_lock_irq(&per_cpu(slab_lock, cpu).lock);
+	lock_slab_on(cpu);
 	__do_ccupdate_local(info, cpu);
-	spin_unlock_irq(&per_cpu(slab_lock, cpu).lock);
+	unlock_slab_on(cpu);
 }
 #endif
 
