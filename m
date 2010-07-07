From: Mike Galbraith <efault@gmx.de>
Subject: [patch] drivers/dca: convert dca_lock to a raw spinlock
Date: Wed, 07 Jul 2010 10:29:01 +0200
Message-ID: <1278491341.7926.4.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751027Ab0GGI3E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 04:29:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


drivers/dca: convert dca_lock to a raw spinlock

[   25.607517] igb 0000:01:00.0: DCA enabled
[   25.607524] BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
[   25.607528] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1805, name: modprobe
[   25.607532] Pid: 1805, comm: modprobe Tainted: G   M    W N  2.6.33.5-rt23-rt_debug #2
[   25.607536] Call Trace:
[   25.607557]  [<ffffffff820078a1>] try_stack_unwind+0x151/0x1a0
[   25.607566]  [<ffffffff820062c2>] dump_trace+0x92/0x370
[   25.607573]  [<ffffffff8200731c>] show_trace_log_lvl+0x5c/0x80
[   25.607578]  [<ffffffff82007355>] show_trace+0x15/0x20
[   25.607587]  [<ffffffff823f4588>] dump_stack+0x77/0x8f
[   25.607595]  [<ffffffff82043f2a>] __might_sleep+0x11a/0x130
[   25.607602]  [<ffffffff823f7b93>] rt_spin_lock+0x83/0x90
[   25.607611]  [<ffffffffa0209138>] dca_common_get_tag+0x28/0x80 [dca]
[   25.607622]  [<ffffffffa02091c8>] dca3_get_tag+0x18/0x20 [dca]
[   25.607634]  [<ffffffffa0244e71>] igb_update_dca+0xb1/0x1d0 [igb]
[   25.607649]  [<ffffffffa0244ff5>] igb_setup_dca+0x65/0x80 [igb]
[   25.607663]  [<ffffffffa02535a6>] igb_probe+0x946/0xe4d [igb]
[   25.607678]  [<ffffffff82247517>] local_pci_probe+0x17/0x20
[   25.607686]  [<ffffffff82248661>] pci_device_probe+0x121/0x130
[   25.607699]  [<ffffffff822e4832>] driver_probe_device+0xd2/0x2e0
[   25.607707]  [<ffffffff822e4adb>] __driver_attach+0x9b/0xa0
[   25.607714]  [<ffffffff822e3d1b>] bus_for_each_dev+0x6b/0xa0
[   25.607720]  [<ffffffff822e4591>] driver_attach+0x21/0x30
[   25.607727]  [<ffffffff822e3425>] bus_add_driver+0x1e5/0x350
[   25.607734]  [<ffffffff822e4e41>] driver_register+0x81/0x160
[   25.607742]  [<ffffffff8224890f>] __pci_register_driver+0x6f/0xf0
[   25.607752]  [<ffffffffa011505b>] igb_init_module+0x5b/0x5d [igb]
[   25.607769]  [<ffffffff820001dd>] do_one_initcall+0x3d/0x1a0
[   25.607778]  [<ffffffff820961f6>] sys_init_module+0xe6/0x270
[   25.607786]  [<ffffffff82003232>] system_call_fastpath+0x16/0x1b
[   25.607794]  [<00007f84d6783f4a>] 0x7f84d6783f4a

Signed-off-by: Mike Galbraith <efault@gmx.de>
LKML-Reference: <new-submission>

---
 drivers/dca/dca-core.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6.33-rt/drivers/dca/dca-core.c
===================================================================
--- linux-2.6.33-rt.orig/drivers/dca/dca-core.c
+++ linux-2.6.33-rt/drivers/dca/dca-core.c
@@ -34,7 +34,7 @@ MODULE_VERSION(DCA_VERSION);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
 
-static DEFINE_SPINLOCK(dca_lock);
+static DEFINE_RAW_SPINLOCK(dca_lock);
 
 static LIST_HEAD(dca_domains);
 
@@ -139,19 +139,19 @@ int dca_add_requester(struct device *dev
 	if (!dev)
 		return -EFAULT;
 
-	spin_lock_irqsave(&dca_lock, flags);
+	raw_spin_lock_irqsave(&dca_lock, flags);
 
 	/* check if the requester has not been added already */
 	dca = dca_find_provider_by_dev(dev);
 	if (dca) {
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return -EEXIST;
 	}
 
 	pci_rc = dca_pci_rc_from_dev(dev);
 	domain = dca_find_domain(pci_rc);
 	if (!domain) {
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return -ENODEV;
 	}
 
@@ -161,17 +161,17 @@ int dca_add_requester(struct device *dev
 			break;
 	}
 
-	spin_unlock_irqrestore(&dca_lock, flags);
+	raw_spin_unlock_irqrestore(&dca_lock, flags);
 
 	if (slot < 0)
 		return slot;
 
 	err = dca_sysfs_add_req(dca, dev, slot);
 	if (err) {
-		spin_lock_irqsave(&dca_lock, flags);
+		raw_spin_lock_irqsave(&dca_lock, flags);
 		if (dca == dca_find_provider_by_dev(dev))
 			dca->ops->remove_requester(dca, dev);
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return err;
 	}
 
@@ -192,14 +192,14 @@ int dca_remove_requester(struct device *
 	if (!dev)
 		return -EFAULT;
 
-	spin_lock_irqsave(&dca_lock, flags);
+	raw_spin_lock_irqsave(&dca_lock, flags);
 	dca = dca_find_provider_by_dev(dev);
 	if (!dca) {
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return -ENODEV;
 	}
 	slot = dca->ops->remove_requester(dca, dev);
-	spin_unlock_irqrestore(&dca_lock, flags);
+	raw_spin_unlock_irqrestore(&dca_lock, flags);
 
 	if (slot < 0)
 		return slot;
@@ -221,16 +221,16 @@ u8 dca_common_get_tag(struct device *dev
 	u8 tag;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dca_lock, flags);
+	raw_spin_lock_irqsave(&dca_lock, flags);
 
 	dca = dca_find_provider_by_dev(dev);
 	if (!dca) {
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return -ENODEV;
 	}
 	tag = dca->ops->get_tag(dca, dev, cpu);
 
-	spin_unlock_irqrestore(&dca_lock, flags);
+	raw_spin_unlock_irqrestore(&dca_lock, flags);
 	return tag;
 }
 
@@ -309,14 +309,14 @@ int register_dca_provider(struct dca_pro
 	if (err)
 		return err;
 
-	spin_lock_irqsave(&dca_lock, flags);
+	raw_spin_lock_irqsave(&dca_lock, flags);
 	domain = dca_get_domain(dev);
 	if (!domain) {
-		spin_unlock_irqrestore(&dca_lock, flags);
+		raw_spin_unlock_irqrestore(&dca_lock, flags);
 		return -ENODEV;
 	}
 	list_add(&dca->node, &domain->dca_providers);
-	spin_unlock_irqrestore(&dca_lock, flags);
+	raw_spin_unlock_irqrestore(&dca_lock, flags);
 
 	blocking_notifier_call_chain(&dca_provider_chain,
 				     DCA_PROVIDER_ADD, NULL);
@@ -337,7 +337,7 @@ void unregister_dca_provider(struct dca_
 	blocking_notifier_call_chain(&dca_provider_chain,
 				     DCA_PROVIDER_REMOVE, NULL);
 
-	spin_lock_irqsave(&dca_lock, flags);
+	raw_spin_lock_irqsave(&dca_lock, flags);
 
 	list_del(&dca->node);
 
@@ -346,7 +346,7 @@ void unregister_dca_provider(struct dca_
 	if (list_empty(&domain->dca_providers))
 		dca_free_domain(domain);
 
-	spin_unlock_irqrestore(&dca_lock, flags);
+	raw_spin_unlock_irqrestore(&dca_lock, flags);
 
 	dca_sysfs_remove_provider(dca);
 }


