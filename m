Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A64C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A2364E07
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Feb 2021 17:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBPRNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:13:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPRM6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 12:12:58 -0500
Date:   Tue, 16 Feb 2021 18:12:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613495534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xgUFOP38zzoo7uQGFvxcG06DJ4CUwIGShBVYNqohZFI=;
        b=2caLcZveimD80dIUvu0jyroU1mIK8CrSnMa1QT5z6mkwmDZt+LZ63L3Yrqwgfg/mNrFF0k
        58jtQtbBRm3wxBlbTZTnnjuiGnCPhEdMYpxPWRozuc+rG9OkksFCNVDT+Z68cRp43gzm1A
        N2m6ktfJc+t43lgUuO4qzy8qbKCSJ+qTNZADGvKxCGvBZNCtgZTGFzFUzroavMCJLJ+IF0
        CALaPyF6xWmTL8orEM6Ilvr7JHYFEXHKEMMH8JvsT8F+amEZj1LLQ7a+NYl8V9XiJFgdb/
        tQ0+20WjdNQE0/mkjuwS3AsDar8yq4BapYvxl94j4iIb0TD2F7BhsJqixiKe7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613495534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xgUFOP38zzoo7uQGFvxcG06DJ4CUwIGShBVYNqohZFI=;
        b=al5hreXtv2IkCuy7pGBJeJNl/vcAjJumBL6P0G84GnttTVqozEgRrSP6FC1vnUr03JLYSi
        sth1eMToYJqoX1Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.11-rt5
Message-ID: <20210216171213.r32ugl2a5ffjw3fz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.11-rt5 patch set. 

Changes since v5.11-rt4:

  - Lazy preemption fix for 64bit PowerPC. It was broken since
    v5.9-rc2-rt1. Reported by John Ogness.

  - Two patches for chelsio/cxgb network driver to avoid
    tasklet_disable() usage in atomic context on !RT.

  - Due to recent softirq rework it was not possible to compile a kernel
    with RT && !SMP. Reported by Jonathan Schwender, patch by Christian
    Eggers.

  - Update the block-mq patches to the version, that has been staged for
    upstream.

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.11-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/incr/patch-5.11-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.11-rt5

The RT patch against v5.11 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patch-5.11-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.11/older/patches-5.11-rt5.tar.xz

Sebastian

diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index b304c68dbcf50..092c014b0653e 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -401,7 +401,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 				if (preempt_count() == 0)
 					preempt_schedule_irq();
 			} else if (unlikely(*ti_flagsp & _TIF_NEED_RESCHED_LAZY)) {
-				if (current_thread_info()->preempt_lazy_count == 0)
+				if ((preempt_count() == 0) &&
+				    (current_thread_info()->preempt_lazy_count == 0))
 					preempt_schedule_irq();
 			}
 		}
diff --git a/drivers/net/ethernet/chelsio/cxgb/common.h b/drivers/net/ethernet/chelsio/cxgb/common.h
index 6475060649e90..0321be77366c4 100644
--- a/drivers/net/ethernet/chelsio/cxgb/common.h
+++ b/drivers/net/ethernet/chelsio/cxgb/common.h
@@ -238,7 +238,6 @@ struct adapter {
 	int msg_enable;
 	u32 mmio_len;
 
-	struct work_struct ext_intr_handler_task;
 	struct adapter_params params;
 
 	/* Terminator modules. */
@@ -257,6 +256,7 @@ struct adapter {
 
 	/* guards async operations */
 	spinlock_t async_lock ____cacheline_aligned;
+	u32 pending_thread_intr;
 	u32 slow_intr_mask;
 	int t1powersave;
 };
@@ -334,8 +334,7 @@ void t1_interrupts_enable(adapter_t *adapter);
 void t1_interrupts_disable(adapter_t *adapter);
 void t1_interrupts_clear(adapter_t *adapter);
 int t1_elmer0_ext_intr_handler(adapter_t *adapter);
-void t1_elmer0_ext_intr(adapter_t *adapter);
-int t1_slow_intr_handler(adapter_t *adapter);
+irqreturn_t t1_slow_intr_handler(adapter_t *adapter);
 
 int t1_link_start(struct cphy *phy, struct cmac *mac, struct link_config *lc);
 const struct board_info *t1_get_board_info(unsigned int board_id);
@@ -347,7 +346,6 @@ int t1_get_board_rev(adapter_t *adapter, const struct board_info *bi,
 int t1_init_hw_modules(adapter_t *adapter);
 int t1_init_sw_modules(adapter_t *adapter, const struct board_info *bi);
 void t1_free_sw_modules(adapter_t *adapter);
-void t1_fatal_err(adapter_t *adapter);
 void t1_link_changed(adapter_t *adapter, int port_id);
 void t1_link_negotiated(adapter_t *adapter, int port_id, int link_stat,
 			    int speed, int duplex, int pause);
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index 0e4a0f413960a..512da98019c66 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -211,9 +211,10 @@ static int cxgb_up(struct adapter *adapter)
 	t1_interrupts_clear(adapter);
 
 	adapter->params.has_msi = !disable_msi && !pci_enable_msi(adapter->pdev);
-	err = request_irq(adapter->pdev->irq, t1_interrupt,
-			  adapter->params.has_msi ? 0 : IRQF_SHARED,
-			  adapter->name, adapter);
+	err = request_threaded_irq(adapter->pdev->irq, t1_interrupt,
+				   t1_interrupt_thread,
+				   adapter->params.has_msi ? 0 : IRQF_SHARED,
+				   adapter->name, adapter);
 	if (err) {
 		if (adapter->params.has_msi)
 			pci_disable_msi(adapter->pdev);
@@ -916,51 +917,6 @@ static void mac_stats_task(struct work_struct *work)
 	spin_unlock(&adapter->work_lock);
 }
 
-/*
- * Processes elmer0 external interrupts in process context.
- */
-static void ext_intr_task(struct work_struct *work)
-{
-	struct adapter *adapter =
-		container_of(work, struct adapter, ext_intr_handler_task);
-
-	t1_elmer0_ext_intr_handler(adapter);
-
-	/* Now reenable external interrupts */
-	spin_lock_irq(&adapter->async_lock);
-	adapter->slow_intr_mask |= F_PL_INTR_EXT;
-	writel(F_PL_INTR_EXT, adapter->regs + A_PL_CAUSE);
-	writel(adapter->slow_intr_mask | F_PL_INTR_SGE_DATA,
-		   adapter->regs + A_PL_ENABLE);
-	spin_unlock_irq(&adapter->async_lock);
-}
-
-/*
- * Interrupt-context handler for elmer0 external interrupts.
- */
-void t1_elmer0_ext_intr(struct adapter *adapter)
-{
-	/*
-	 * Schedule a task to handle external interrupts as we require
-	 * a process context.  We disable EXT interrupts in the interim
-	 * and let the task reenable them when it's done.
-	 */
-	adapter->slow_intr_mask &= ~F_PL_INTR_EXT;
-	writel(adapter->slow_intr_mask | F_PL_INTR_SGE_DATA,
-		   adapter->regs + A_PL_ENABLE);
-	schedule_work(&adapter->ext_intr_handler_task);
-}
-
-void t1_fatal_err(struct adapter *adapter)
-{
-	if (adapter->flags & FULL_INIT_DONE) {
-		t1_sge_stop(adapter->sge);
-		t1_interrupts_disable(adapter);
-	}
-	pr_alert("%s: encountered fatal error, operation suspended\n",
-		 adapter->name);
-}
-
 static const struct net_device_ops cxgb_netdev_ops = {
 	.ndo_open		= cxgb_open,
 	.ndo_stop		= cxgb_close,
@@ -1062,8 +1018,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			spin_lock_init(&adapter->async_lock);
 			spin_lock_init(&adapter->mac_lock);
 
-			INIT_WORK(&adapter->ext_intr_handler_task,
-				  ext_intr_task);
 			INIT_DELAYED_WORK(&adapter->stats_update_task,
 					  mac_stats_task);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index 2d9c2b5a690a3..cda01f22c71c8 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -940,10 +940,11 @@ void t1_sge_intr_clear(struct sge *sge)
 /*
  * SGE 'Error' interrupt handler
  */
-int t1_sge_intr_error_handler(struct sge *sge)
+bool t1_sge_intr_error_handler(struct sge *sge)
 {
 	struct adapter *adapter = sge->adapter;
 	u32 cause = readl(adapter->regs + A_SG_INT_CAUSE);
+	bool wake = false;
 
 	if (adapter->port[0].dev->hw_features & NETIF_F_TSO)
 		cause &= ~F_PACKET_TOO_BIG;
@@ -967,11 +968,14 @@ int t1_sge_intr_error_handler(struct sge *sge)
 		sge->stats.pkt_mismatch++;
 		pr_alert("%s: SGE packet mismatch\n", adapter->name);
 	}
-	if (cause & SGE_INT_FATAL)
-		t1_fatal_err(adapter);
+	if (cause & SGE_INT_FATAL) {
+		t1_interrupts_disable(adapter);
+		adapter->pending_thread_intr |= F_PL_INTR_SGE_ERR;
+		wake = true;
+	}
 
 	writel(cause, adapter->regs + A_SG_INT_CAUSE);
-	return 0;
+	return wake;
 }
 
 const struct sge_intr_counts *t1_sge_get_intr_counts(const struct sge *sge)
@@ -1619,11 +1623,46 @@ int t1_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+irqreturn_t t1_interrupt_thread(int irq, void *data)
+{
+	struct adapter *adapter = data;
+	u32 pending_thread_intr;
+
+	spin_lock_irq(&adapter->async_lock);
+	pending_thread_intr = adapter->pending_thread_intr;
+	adapter->pending_thread_intr = 0;
+	spin_unlock_irq(&adapter->async_lock);
+
+	if (!pending_thread_intr)
+		return IRQ_NONE;
+
+	if (pending_thread_intr & F_PL_INTR_EXT)
+		t1_elmer0_ext_intr_handler(adapter);
+
+	/* This error is fatal, interrupts remain off */
+	if (pending_thread_intr & F_PL_INTR_SGE_ERR) {
+		pr_alert("%s: encountered fatal error, operation suspended\n",
+			 adapter->name);
+		t1_sge_stop(adapter->sge);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock_irq(&adapter->async_lock);
+	adapter->slow_intr_mask |= F_PL_INTR_EXT;
+
+	writel(F_PL_INTR_EXT, adapter->regs + A_PL_CAUSE);
+	writel(adapter->slow_intr_mask | F_PL_INTR_SGE_DATA,
+	       adapter->regs + A_PL_ENABLE);
+	spin_unlock_irq(&adapter->async_lock);
+
+	return IRQ_HANDLED;
+}
+
 irqreturn_t t1_interrupt(int irq, void *data)
 {
 	struct adapter *adapter = data;
 	struct sge *sge = adapter->sge;
-	int handled;
+	irqreturn_t handled;
 
 	if (likely(responses_pending(adapter))) {
 		writel(F_PL_INTR_SGE_DATA, adapter->regs + A_PL_CAUSE);
@@ -1645,10 +1684,10 @@ irqreturn_t t1_interrupt(int irq, void *data)
 	handled = t1_slow_intr_handler(adapter);
 	spin_unlock(&adapter->async_lock);
 
-	if (!handled)
+	if (handled == IRQ_NONE)
 		sge->stats.unhandled_irqs++;
 
-	return IRQ_RETVAL(handled != 0);
+	return handled;
 }
 
 /*
diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.h b/drivers/net/ethernet/chelsio/cxgb/sge.h
index a1ba591b34312..716705b96f265 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.h
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.h
@@ -74,6 +74,7 @@ struct sge *t1_sge_create(struct adapter *, struct sge_params *);
 int t1_sge_configure(struct sge *, struct sge_params *);
 int t1_sge_set_coalesce_params(struct sge *, struct sge_params *);
 void t1_sge_destroy(struct sge *);
+irqreturn_t t1_interrupt_thread(int irq, void *data);
 irqreturn_t t1_interrupt(int irq, void *cookie);
 int t1_poll(struct napi_struct *, int);
 
@@ -81,7 +82,7 @@ netdev_tx_t t1_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void t1_vlan_mode(struct adapter *adapter, netdev_features_t features);
 void t1_sge_start(struct sge *);
 void t1_sge_stop(struct sge *);
-int t1_sge_intr_error_handler(struct sge *);
+bool t1_sge_intr_error_handler(struct sge *sge);
 void t1_sge_intr_enable(struct sge *);
 void t1_sge_intr_disable(struct sge *);
 void t1_sge_intr_clear(struct sge *);
diff --git a/drivers/net/ethernet/chelsio/cxgb/subr.c b/drivers/net/ethernet/chelsio/cxgb/subr.c
index ea0f8741d7cfd..310add28fcf59 100644
--- a/drivers/net/ethernet/chelsio/cxgb/subr.c
+++ b/drivers/net/ethernet/chelsio/cxgb/subr.c
@@ -170,7 +170,7 @@ void t1_link_changed(adapter_t *adapter, int port_id)
 	t1_link_negotiated(adapter, port_id, link_ok, speed, duplex, fc);
 }
 
-static int t1_pci_intr_handler(adapter_t *adapter)
+static bool t1_pci_intr_handler(adapter_t *adapter)
 {
 	u32 pcix_cause;
 
@@ -179,9 +179,13 @@ static int t1_pci_intr_handler(adapter_t *adapter)
 	if (pcix_cause) {
 		pci_write_config_dword(adapter->pdev, A_PCICFG_INTR_CAUSE,
 				       pcix_cause);
-		t1_fatal_err(adapter);    /* PCI errors are fatal */
+		/* PCI errors are fatal */
+		t1_interrupts_disable(adapter);
+		adapter->pending_thread_intr |= F_PL_INTR_SGE_ERR;
+		pr_alert("%s: PCI error encountered.\n", adapter->name);
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 #ifdef CONFIG_CHELSIO_T1_1G
@@ -210,13 +214,16 @@ static int fpga_phy_intr_handler(adapter_t *adapter)
 /*
  * Slow path interrupt handler for FPGAs.
  */
-static int fpga_slow_intr(adapter_t *adapter)
+static irqreturn_t fpga_slow_intr(adapter_t *adapter)
 {
 	u32 cause = readl(adapter->regs + A_PL_CAUSE);
+	irqreturn_t ret = IRQ_NONE;
 
 	cause &= ~F_PL_INTR_SGE_DATA;
-	if (cause & F_PL_INTR_SGE_ERR)
-		t1_sge_intr_error_handler(adapter->sge);
+	if (cause & F_PL_INTR_SGE_ERR) {
+		if (t1_sge_intr_error_handler(adapter->sge))
+			ret = IRQ_WAKE_THREAD;
+	}
 
 	if (cause & FPGA_PCIX_INTERRUPT_GMAC)
 		fpga_phy_intr_handler(adapter);
@@ -231,14 +238,19 @@ static int fpga_slow_intr(adapter_t *adapter)
 		/* Clear TP interrupt */
 		writel(tp_cause, adapter->regs + FPGA_TP_ADDR_INTERRUPT_CAUSE);
 	}
-	if (cause & FPGA_PCIX_INTERRUPT_PCIX)
-		t1_pci_intr_handler(adapter);
+	if (cause & FPGA_PCIX_INTERRUPT_PCIX) {
+		if (t1_pci_intr_handler(adapter))
+			ret = IRQ_WAKE_THREAD;
+	}
 
 	/* Clear the interrupts just processed. */
 	if (cause)
 		writel(cause, adapter->regs + A_PL_CAUSE);
 
-	return cause != 0;
+	if (ret != IRQ_NONE)
+		return ret;
+
+	return cause == 0 ? IRQ_NONE : IRQ_HANDLED;
 }
 #endif
 
@@ -842,31 +854,45 @@ void t1_interrupts_clear(adapter_t* adapter)
 /*
  * Slow path interrupt handler for ASICs.
  */
-static int asic_slow_intr(adapter_t *adapter)
+static irqreturn_t asic_slow_intr(adapter_t *adapter)
 {
 	u32 cause = readl(adapter->regs + A_PL_CAUSE);
+	irqreturn_t ret = IRQ_HANDLED;
 
 	cause &= adapter->slow_intr_mask;
 	if (!cause)
-		return 0;
-	if (cause & F_PL_INTR_SGE_ERR)
-		t1_sge_intr_error_handler(adapter->sge);
+		return IRQ_NONE;
+	if (cause & F_PL_INTR_SGE_ERR) {
+		if (t1_sge_intr_error_handler(adapter->sge))
+			ret = IRQ_WAKE_THREAD;
+	}
 	if (cause & F_PL_INTR_TP)
 		t1_tp_intr_handler(adapter->tp);
 	if (cause & F_PL_INTR_ESPI)
 		t1_espi_intr_handler(adapter->espi);
-	if (cause & F_PL_INTR_PCIX)
-		t1_pci_intr_handler(adapter);
-	if (cause & F_PL_INTR_EXT)
-		t1_elmer0_ext_intr(adapter);
+	if (cause & F_PL_INTR_PCIX) {
+		if (t1_pci_intr_handler(adapter))
+			ret = IRQ_WAKE_THREAD;
+	}
+	if (cause & F_PL_INTR_EXT) {
+		/* Wake the threaded interrupt to handle external interrupts as
+		 * we require a process context. We disable EXT interrupts in
+		 * the interim and let the thread reenable them when it's done.
+		 */
+		adapter->pending_thread_intr |= F_PL_INTR_EXT;
+		adapter->slow_intr_mask &= ~F_PL_INTR_EXT;
+		writel(adapter->slow_intr_mask | F_PL_INTR_SGE_DATA,
+		       adapter->regs + A_PL_ENABLE);
+		ret = IRQ_WAKE_THREAD;
+	}
 
 	/* Clear the interrupts just processed. */
 	writel(cause, adapter->regs + A_PL_CAUSE);
 	readl(adapter->regs + A_PL_CAUSE); /* flush writes */
-	return 1;
+	return ret;
 }
 
-int t1_slow_intr_handler(adapter_t *adapter)
+irqreturn_t t1_slow_intr_handler(adapter_t *adapter)
 {
 #ifdef CONFIG_CHELSIO_T1_1G
 	if (!t1_is_asic(adapter))
diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb0..01e9d01d1866e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
@@ -449,6 +450,19 @@ void flush_smp_call_function_from_idle(void)
 
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
+
+	if (local_softirq_pending()) {
+
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			do_softirq();
+		} else {
+			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
+
+			if (ksoftirqd && ksoftirqd->state != TASK_RUNNING)
+				wake_up_process(ksoftirqd);
+		}
+	}
+
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8f4c141b20c05..a9b66aa086366 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -867,7 +867,7 @@ void tasklet_kill(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(tasklet_kill);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
