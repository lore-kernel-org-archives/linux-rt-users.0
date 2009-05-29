From: Jan Blunck <jblunck@suse.de>
Subject: [RFC] Convert sparse_irq_lock to raw_spinlock_t
Date: Fri, 29 May 2009 14:26:15 +0200
Message-ID: <20090529122615.GJ23793@bolzano.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758208AbZE2M0O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 May 2009 08:26:14 -0400
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DA59779727
	for <linux-rt-users@vger.kernel.org>; Fri, 29 May 2009 14:26:15 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Moving of IRQs is done in hardirq context so the sparse_irq_lock needs to be
raw_spinlock_t. For this to work we need to move the memory allocation before
actually taking the lock itself.

This patch doesn't seem to do 100% the right thing since I still get the
following from lockdep:

[ INFO: inconsistent lock state ]
2.6.29.4-rt16-rt #2
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (per_cpu__lock_slab_locked#5){?.+...}, at: [<ffffffff802f85d5>]
 _slab_irq_disab
le+0x40/0x63
{HARDIRQ-ON-W} state was registered at:
  [<ffffffff80287b64>] mark_lock+0x296/0x3ed
  [<ffffffff80287d79>] mark_irqflags+0xbe/0x125
  [<ffffffff8028a2a8>] __lock_acquire+0x692/0x855
  [<ffffffff8028a56f>] lock_acquire+0x104/0x130
  [<ffffffff804e9e50>] rt_spin_lock+0x7d/0x81
  [<ffffffff804e70ee>] cpuup_callback+0x48/0x229
  [<ffffffff804ee098>] notifier_call_chain+0x33/0x5b
  [<ffffffff8027d463>] __raw_notifier_call_chain+0x9/0xb
  [<ffffffff804e57ee>] _cpu_up+0x75/0x12e
  [<ffffffff804e5908>] cpu_up+0x61/0x76
  [<ffffffff8079466b>] smp_init+0x52/0xa0
  [<ffffffff80794787>] kernel_init+0x80/0x19b
  [<ffffffff8022609a>] child_rip+0xa/0x20
  [<ffffffffffffffff>] 0xffffffffffffffff
irq event stamp: 119862
hardirqs last  enabled at (119861): [<ffffffff802b6622>]
__rcu_read_lock+0xa9/0x
bc
hardirqs last disabled at (119862): [<ffffffff80224d3a>] save_args+0x6a/0x70
softirqs last  enabled at (0): [<ffffffff80262759>] copy_process+0x573/0x111f
softirqs last disabled at (0): [<(null)>] (null)

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (&irq_desc_lock_class){-.....}, at: [<ffffffff802b430d>]
 handle_fasteoi_ir
q+0x20/0xff

stack backtrace:
Pid: 0, comm: swapper Tainted: G          N  2.6.29.4-rt16-rt #2
Call Trace:
 [<ffffffff80227cba>] dump_trace+0xda/0x3d0
 [<ffffffff80228a6f>] show_trace_log_lvl+0x4c/0x58
 [<ffffffff80228a8b>] show_trace+0x10/0x12
 [<ffffffff804e7691>] dump_stack+0x72/0x7b
 [<ffffffff802876a0>] print_usage_bug+0x1ce/0x1df
 [<ffffffff80287766>] mark_lock_irq+0xb5/0x21d
 [<ffffffff80287b88>] mark_lock+0x2ba/0x3ed
 [<ffffffff80287d0f>] mark_irqflags+0x54/0x125
 [<ffffffff8028a2a8>] __lock_acquire+0x692/0x855
 [<ffffffff8028a56f>] lock_acquire+0x104/0x130
 [<ffffffff804e9e50>] rt_spin_lock+0x7d/0x81
 [<ffffffff802f85d5>] _slab_irq_disable+0x40/0x63
 [<ffffffff802fa520>] kmem_cache_alloc_node+0x41/0x225
 [<ffffffff802b5349>] __real_move_irq_desc+0x44/0x1bd
 [<ffffffff802b5504>] move_irq_desc+0x42/0x56
 [<ffffffff8023c0be>] irq_complete_move+0x80/0x95
 [<ffffffff8023d91b>] ack_apic_level+0x20/0x101
 [<ffffffff802b43cf>] handle_fasteoi_irq+0xe2/0xff
 [<ffffffff8022764f>] handle_irq+0x1f/0x27
 [<ffffffff80226db6>] do_IRQ+0x5e/0xc6
 [<ffffffff80225953>] ret_from_intr+0x0/0x16
DWARF2 unwinder stuck at ret_from_intr+0x0/0x16

Leftover inexact backtrace:

 <IRQ>  <EOI>  [<ffffffff802b6627>] ? __rcu_read_lock+0xae/0xbc
 [<ffffffff804ee0ec>] ? __atomic_notifier_call_chain+0x2c/0x56
 [<ffffffff804ee125>] ? atomic_notifier_call_chain+0xf/0x11
 [<ffffffff80224121>] ? cpu_idle+0x7d/0xca
 [<ffffffff804e427f>] ? start_secondary+0xc5/0xca

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 kernel/irq/handle.c       |   38 ++++++++++++++++++++++++++------------
 kernel/irq/internals.h    |    2 +-
 kernel/irq/numa_migrate.c |   38 +++++++++++++++++++++-----------------
 kernel/softirq.c          |    6 ++++++
 4 files changed, 54 insertions(+), 30 deletions(-)

Index: b/kernel/irq/handle.c
===================================================================
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -124,10 +124,17 @@ static void init_one_irq_desc(int irq, s
 	arch_init_chip_data(desc, cpu);
 }
 
+static void free_one_irq_desc(struct irq_desc *desc)
+{
+	kfree(desc->kstat_irqs);
+	desc->kstat_irqs = NULL;
+	arch_free_chip_data(desc, &irq_desc_init);
+}
+
 /*
  * Protect the sparse_irqs:
  */
-DEFINE_SPINLOCK(sparse_irq_lock);
+DEFINE_RAW_SPINLOCK(sparse_irq_lock);
 
 struct irq_desc **irq_desc_ptrs __read_mostly;
 
@@ -191,7 +198,7 @@ struct irq_desc *irq_to_desc(unsigned in
 
 struct irq_desc *irq_to_desc_alloc_cpu(unsigned int irq, int cpu)
 {
-	struct irq_desc *desc;
+	struct irq_desc *desc, *tmp;
 	unsigned long flags;
 	int node;
 
@@ -205,6 +212,17 @@ struct irq_desc *irq_to_desc_alloc_cpu(u
 	if (desc)
 		return desc;
 
+	/* Allocate memory before disabling interrupts */
+	node = cpu_to_node(cpu);
+	tmp = kzalloc_node(sizeof(*tmp), GFP_ATOMIC, node);
+	printk(KERN_DEBUG "  alloc irq_desc for %d on cpu %d node %d\n",
+		 irq, cpu, node);
+	if (!tmp) {
+		printk(KERN_ERR "can not alloc irq_desc\n");
+		BUG_ON(1);
+	}
+	init_one_irq_desc(irq, tmp, cpu);
+
 	spin_lock_irqsave(&sparse_irq_lock, flags);
 
 	/* We have to check it to avoid races with another CPU */
@@ -212,20 +230,16 @@ struct irq_desc *irq_to_desc_alloc_cpu(u
 	if (desc)
 		goto out_unlock;
 
-	node = cpu_to_node(cpu);
-	desc = kzalloc_node(sizeof(*desc), GFP_ATOMIC, node);
-	printk(KERN_DEBUG "  alloc irq_desc for %d on cpu %d node %d\n",
-		 irq, cpu, node);
-	if (!desc) {
-		printk(KERN_ERR "can not alloc irq_desc\n");
-		BUG_ON(1);
-	}
-	init_one_irq_desc(irq, desc, cpu);
+	irq_desc_ptrs[irq] = tmp;
+	desc = tmp;
+	spin_unlock_irqrestore(&sparse_irq_lock, flags);
 
-	irq_desc_ptrs[irq] = desc;
+	return desc;
 
 out_unlock:
 	spin_unlock_irqrestore(&sparse_irq_lock, flags);
+	free_one_irq_desc(tmp);
+	kfree(tmp);
 
 	return desc;
 }
Index: b/kernel/irq/internals.h
===================================================================
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -16,7 +16,7 @@ extern int __irq_set_trigger(struct irq_
 extern struct lock_class_key irq_desc_lock_class;
 extern void init_kstat_irqs(struct irq_desc *desc, int cpu, int nr);
 extern void clear_kstat_irqs(struct irq_desc *desc);
-extern spinlock_t sparse_irq_lock;
+extern raw_spinlock_t sparse_irq_lock;
 
 #ifdef CONFIG_SPARSE_IRQ
 /* irq_desc_ptrs allocated at boot time */
Index: b/kernel/irq/numa_migrate.c
===================================================================
--- a/kernel/irq/numa_migrate.c
+++ b/kernel/irq/numa_migrate.c
@@ -61,38 +61,40 @@ static void free_one_irq_desc(struct irq
 static struct irq_desc *__real_move_irq_desc(struct irq_desc *old_desc,
 						int cpu)
 {
-	struct irq_desc *desc;
+	struct irq_desc *desc, *tmp;
 	unsigned int irq;
 	unsigned long flags;
 	int node;
 
 	irq = old_desc->irq;
 
-	spin_lock_irqsave(&sparse_irq_lock, flags);
-
-	/* We have to check it to avoid races with another CPU */
-	desc = irq_desc_ptrs[irq];
-
-	if (desc && old_desc != desc)
-		goto out_unlock;
-
+	/* Allocate memory before disabling IRQs */
 	node = cpu_to_node(cpu);
-	desc = kzalloc_node(sizeof(*desc), GFP_ATOMIC, node);
-	if (!desc) {
+	tmp = kzalloc_node(sizeof(*tmp), GFP_ATOMIC, node);
+	if (!tmp) {
 		printk(KERN_ERR "irq %d: can not get new irq_desc "
 				"for migration.\n", irq);
 		/* still use old one */
 		desc = old_desc;
-		goto out_unlock;
+		goto out;
 	}
-	if (!init_copy_one_irq_desc(irq, old_desc, desc, cpu)) {
+	if (!init_copy_one_irq_desc(irq, old_desc, tmp, cpu)) {
 		/* still use old one */
-		kfree(desc);
+		kfree(tmp);
 		desc = old_desc;
-		goto out_unlock;
+		goto out;
 	}
 
-	irq_desc_ptrs[irq] = desc;
+	spin_lock_irqsave(&sparse_irq_lock, flags);
+
+	/* We have to check it to avoid races with another CPU */
+	desc = irq_desc_ptrs[irq];
+
+	if (desc && old_desc != desc)
+		goto out_unlock;
+
+	irq_desc_ptrs[irq] = tmp;
+	desc = tmp;
 	spin_unlock_irqrestore(&sparse_irq_lock, flags);
 
 	/* free the old one */
@@ -105,7 +107,9 @@ static struct irq_desc *__real_move_irq_
 
 out_unlock:
 	spin_unlock_irqrestore(&sparse_irq_lock, flags);
