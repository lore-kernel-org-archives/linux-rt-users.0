From: Jan Blunck <jblunck@suse.de>
Subject: [PATCH] Allocate memory before disabling memory in irq_to_desc_alloc_node()
Date: Mon, 31 Aug 2009 21:30:02 +0200
Message-ID: <20090831193002.GI28804@bolzano.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35706 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbZHaTaC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2009 15:30:02 -0400
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 493B879727
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2009 21:30:03 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[ I already send a similar patch to the list on May 29th ([RFC] Convert
sparse_irq_lock to raw_spinlock_t). ]

When allocating struct irq_desc we can get the memory before disabling the
interrupts.

[   22.867664] BUG: sleeping function called from invalid context at
/usr/src/pa
ckages/BUILD/kernel-rt-2.6.31/linux-2.6.30/kernel/rtmutex.c:684
[   22.867682] in_atomic(): 1, irqs_disabled(): 1, pid: 4084, name: ip
[   22.867691] Pid: 4084, comm: ip Tainted: G          N  2.6.31-rc7-rt8-20-rt
#
1
[   22.867702] Call Trace:
[   22.867727]  [<ffffffff81011711>] try_stack_unwind+0x171/0x1c0
[   22.867742]  [<ffffffff8101002c>] dump_trace+0xac/0x2f0
[   22.867755]  [<ffffffff81011204>] show_trace_log_lvl+0x64/0x90
[   22.867768]  [<ffffffff81011253>] show_trace+0x23/0x40
[   22.867782]  [<ffffffff814de2be>] dump_stack+0x81/0xa3
[   22.867793]  [<ffffffff81057209>] __might_sleep+0x109/0x120
[   22.867806]  [<ffffffff814e18e1>] rt_spin_lock+0x41/0xb0
[   22.867822]  [<ffffffff811568fe>] _slab_irq_disable+0x5e/0x90
[   22.867837]  [<ffffffff811578c6>] kmem_cache_alloc_node+0x46/0x280
[   22.867850]  [<ffffffff81158efa>] __kmalloc_node+0x7a/0x160
[   22.867868]  [<ffffffff810df452>] kzalloc_node+0x22/0x40
[   22.867884]  [<ffffffff814c6c70>] irq_to_desc_alloc_node+0x100/0x1e0
[   22.867899]  [<ffffffff8102f9fc>] create_irq_nr+0x5c/0x150
[   22.867913]  [<ffffffff8102fbd2>] arch_setup_msi_irqs+0xe2/0x1d0
[   22.867931]  [<ffffffff8129ff20>] msi_capability_init+0x130/0x250
[   22.867945]  [<ffffffff812a0136>] pci_enable_msi_block+0xf6/0x150
[   22.867977]  [<ffffffffa026184a>] nv_request_irq+0x27a/0x430 [forcedeth]
[   22.868001]  [<ffffffffa0264f2d>] nv_open+0x3ad/0x610 [forcedeth]
[   22.868020]  [<ffffffff813ee052>] dev_open+0xf2/0x140
[   22.868034]  [<ffffffff813ed33c>] dev_change_flags+0xac/0x200
[   22.868048]  [<ffffffff813f9844>] do_setlink+0x2a4/0x460
[   22.868061]  [<ffffffff813fb3fb>] rtnl_newlink+0x49b/0x560
[   22.868071]  [<ffffffff813fad24>] rtnetlink_rcv_msg+0x1b4/0x270
[   22.868083]  [<ffffffff81412f59>] netlink_rcv_skb+0xa9/0xe0
[   22.868094]  [<ffffffff813fab46>] rtnetlink_rcv+0x36/0x60
[   22.868103]  [<ffffffff81412bbd>] netlink_unicast+0x2cd/0x2e0
[   22.868121]  [<ffffffff814139e4>] netlink_sendmsg+0x234/0x330
[   22.868131]  [<ffffffff813d7b06>] sock_sendmsg+0x116/0x160
[   22.868142]  [<ffffffff813d7d12>] sys_sendmsg+0x1c2/0x370
[   22.868153]  [<ffffffff8100c7c2>] system_call_fastpath+0x16/0x1b
[   22.868176]  [<00007fc1bf778220>] 0x7fc1bf778220

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 kernel/irq/handle.c       |   46 ++++++++++++++++++++++++++++-----------
 kernel/irq/internals.h    |    1 
 kernel/irq/numa_migrate.c |   53 ++++++++++++++++++----------------------------
 kernel/softirq.c          |    6 +++++
 4 files changed, 61 insertions(+), 45 deletions(-)

Index: b/kernel/irq/handle.c
===================================================================
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -126,6 +126,22 @@ static void init_one_irq_desc(int irq, s
 	arch_init_chip_data(desc, node);
 }
 
+static void free_kstat_irqs(struct irq_desc *old_desc, struct irq_desc *desc)
+{
+	if (old_desc->kstat_irqs == desc->kstat_irqs)
+		return;
+
+	kfree(old_desc->kstat_irqs);
+	old_desc->kstat_irqs = NULL;
+}
+
+void free_one_irq_desc(struct irq_desc *old_desc, struct irq_desc *desc)
+{
+	free_kstat_irqs(old_desc, desc);
+	free_desc_masks(old_desc, desc);
+	arch_free_chip_data(old_desc, desc);
+}
+
 /*
  * Protect the sparse_irqs:
  */
@@ -195,7 +211,7 @@ struct irq_desc *irq_to_desc(unsigned in
 
 struct irq_desc * __ref irq_to_desc_alloc_node(unsigned int irq, int node)
 {
-	struct irq_desc *desc;
+	struct irq_desc *desc, *tmp;
 	unsigned long flags;
 
 	if (irq >= nr_irqs) {
@@ -208,26 +224,30 @@ struct irq_desc * __ref irq_to_desc_allo
 	if (desc)
 		return desc;
 
-	atomic_spin_lock_irqsave(&sparse_irq_lock, flags);
-
-	/* We have to check it to avoid races with another CPU */
-	desc = irq_desc_ptrs[irq];
-	if (desc)
-		goto out_unlock;
-
 	if (slab_is_available())
-		desc = kzalloc_node(sizeof(*desc), GFP_ATOMIC, node);
+		tmp = kzalloc_node(sizeof(*tmp), GFP_ATOMIC, node);
 	else
-		desc = alloc_bootmem_node(NODE_DATA(node), sizeof(*desc));
+		tmp = alloc_bootmem_node(NODE_DATA(node), sizeof(*tmp));
 
 	printk(KERN_DEBUG "  alloc irq_desc for %d on node %d\n", irq, node);
-	if (!desc) {
+	if (!tmp) {
 		printk(KERN_ERR "can not alloc irq_desc\n");
 		BUG_ON(1);
 	}
-	init_one_irq_desc(irq, desc, node);
+	init_one_irq_desc(irq, tmp, node);
+
+	atomic_spin_lock_irqsave(&sparse_irq_lock, flags);
+
+	/* We have to check it to avoid races with another CPU */
+	desc = irq_desc_ptrs[irq];
+	if (desc) {
+		free_one_irq_desc(tmp, desc);
+		kfree(tmp);
+		goto out_unlock;
+	}
 
-	irq_desc_ptrs[irq] = desc;
+	irq_desc_ptrs[irq] = tmp;
+	desc = tmp;
 
 out_unlock:
 	atomic_spin_unlock_irqrestore(&sparse_irq_lock, flags);
Index: b/kernel/irq/internals.h
===================================================================
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -16,6 +16,7 @@ extern void __disable_irq(struct irq_des
 extern void __enable_irq(struct irq_desc *desc, unsigned int irq, bool resume);
 
 extern struct lock_class_key irq_desc_lock_class;
+extern void free_one_irq_desc(struct irq_desc *old_desc, struct irq_desc *desc);
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 extern void clear_kstat_irqs(struct irq_desc *desc);
 extern atomic_spinlock_t sparse_irq_lock;
Index: b/kernel/irq/numa_migrate.c
===================================================================
--- a/kernel/irq/numa_migrate.c
+++ b/kernel/irq/numa_migrate.c
@@ -24,15 +24,6 @@ static void init_copy_kstat_irqs(struct
 			 nr * sizeof(*desc->kstat_irqs));
 }
 
-static void free_kstat_irqs(struct irq_desc *old_desc, struct irq_desc *desc)
-{
-	if (old_desc->kstat_irqs == desc->kstat_irqs)
-		return;
-
-	kfree(old_desc->kstat_irqs);
-	old_desc->kstat_irqs = NULL;
-}
-
 static bool init_copy_one_irq_desc(int irq, struct irq_desc *old_desc,
 		 struct irq_desc *desc, int node)
 {
@@ -51,46 +42,41 @@ static bool init_copy_one_irq_desc(int i
 	return true;
 }
 
-static void free_one_irq_desc(struct irq_desc *old_desc, struct irq_desc *desc)
-{
-	free_kstat_irqs(old_desc, desc);
-	free_desc_masks(old_desc, desc);
-	arch_free_chip_data(old_desc, desc);
-}
-
 static struct irq_desc *__real_move_irq_desc(struct irq_desc *old_desc,
 						int node)
 {
-	struct irq_desc *desc;
+	struct irq_desc *desc, *tmp;
 	unsigned int irq;
 	unsigned long flags;
 
 	irq = old_desc->irq;
 
-	atomic_spin_lock_irqsave(&sparse_irq_lock, flags);
-
-	/* We have to check it to avoid races with another CPU */
-	desc = irq_desc_ptrs[irq];
-
-	if (desc && old_desc != desc)
-		goto out_unlock;
-
-	desc = kzalloc_node(sizeof(*desc), GFP_ATOMIC, node);
-	if (!desc) {
+	/* Allocate memory before disabling IRQs */
+	tmp = kzalloc_node(sizeof(*tmp), GFP_ATOMIC, node);
+	if (!tmp) {
 		printk(KERN_ERR "irq %d: can not get new irq_desc "
 				"for migration.\n", irq);
 		/* still use old one */
 		desc = old_desc;
-		goto out_unlock;
+		goto out;
 	}
-	if (!init_copy_one_irq_desc(irq, old_desc, desc, node)) {
+	if (!init_copy_one_irq_desc(irq, old_desc, tmp, node)) {
 		/* still use old one */
-		kfree(desc);
+		kfree(tmp);
 		desc = old_desc;
-		goto out_unlock;
+		goto out;
 	}
 
-	irq_desc_ptrs[irq] = desc;
+	atomic_spin_lock_irqsave(&sparse_irq_lock, flags);
+
+	/* We have to check it to avoid races with another CPU */
+	desc = irq_desc_ptrs[irq];
+
+	if (desc && old_desc != desc)
+		goto out_unlock;
+
+	irq_desc_ptrs[irq] = tmp;
+	desc = tmp;
 	atomic_spin_unlock_irqrestore(&sparse_irq_lock, flags);
 
 	/* free the old one */
@@ -102,6 +88,9 @@ static struct irq_desc *__real_move_irq_
 out_unlock:
 	atomic_spin_unlock_irqrestore(&sparse_irq_lock, flags);
 
+	free_one_irq_desc(tmp, old_desc);
+	kfree(tmp);
+out:
 	return desc;
 }
 
Index: b/kernel/softirq.c
===================================================================
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1291,3 +1291,9 @@ int __weak arch_init_chip_data(struct ir
 {
 	return 0;
 }
+
+void __weak arch_free_chip_data(struct irq_desc *old_desc,
+				struct irq_desc *desc)
+{
+	return;
+}


Regards,
	Jan

-- 
Jan Blunck <jblunck@suse.de>
