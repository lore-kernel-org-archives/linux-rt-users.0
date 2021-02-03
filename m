Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285BC433E6
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Feb 2021 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE6064F92
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Feb 2021 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBCSE7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Feb 2021 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhBCSED (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Feb 2021 13:04:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39504C061573;
        Wed,  3 Feb 2021 10:03:21 -0800 (PST)
Date:   Wed, 3 Feb 2021 19:03:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612375399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=17k3BbCI8Ytq0x5cq3SFC2x7Jpgk0ZEPyYDmtM3iTis=;
        b=yQNdtq3DwtfFyn0eNm8QuAtpMgzdgIbpLuMV6R7FkuDbLIkZXQwir27VmArCwd8S33EsDT
        RFYXGXg8TyIncSPT2n0A+o8oIwuWYoMA9g4WCQSFtvWlpokJDmBu7iuYXO8BYmK4yndjUy
        hlJMROlKnsqWslRVXIaboTx7mVEBtFPSA2NY7e2ERfbU8Z1q+EgbbbeOEBUBj5e9W4qxRY
        5kdaGcY4cLprC3zwzMhp+mSO9o8j0NSNsR023W6yydA/kDccjoGfZDUhgEBCah/djwBq+Q
        2oMQXsnU2GZrekEdJu4JlnB6TWg6CXDCyC3sAwsc6b6gLp7nvkBpJpBTECuM6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612375399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=17k3BbCI8Ytq0x5cq3SFC2x7Jpgk0ZEPyYDmtM3iTis=;
        b=eBKCJ0rawrozUHlZ6pHYvH/6GNC2eNd1KdrkrIiOvY5kl3QpcrXLR8wBZdznClkSOBrPYu
        mia9d8sZZUdSlJBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.12-rt26
Message-ID: <20210203180317.zl5guuldgtxhezdg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.12-rt26 patch set. 

Changes since v5.10.12-rt25:

  - Updated the "tracing: Merge irqflags + preempt counter." patch to
    the version Steven posted for upstream inclusion.

  - Update the work-in-progress softirq patch. One difference is that
    tasklet_disable() becomes now sleeping if the tasklet is running
    instead busy-spinning until it is done. Driver which invoke the
    function in atomic context on !RT have been converted.

Known issues
     - kdb/kgdb can easily deadlock.
     - kmsg dumpers expecting not to be called in parallel can clobber
       their temp buffer.
     - netconsole triggers WARN.

The delta patch against v5.10.12-rt25 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.12-rt25-rt26.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.12-rt26

The RT patch against v5.10.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.12-rt26.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.12-rt26.tar.xz

Sebastian

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 316a9947541fe..e96a4e8a4a10c 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -2054,7 +2054,7 @@ static int eni_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	}
 	submitted++;
 	ATM_SKB(skb)->vcc = vcc;
-	tasklet_disable(&ENI_DEV(vcc->dev)->task);
+	tasklet_disable_in_atomic(&ENI_DEV(vcc->dev)->task);
 	res = do_tx(skb);
 	tasklet_enable(&ENI_DEV(vcc->dev)->task);
 	if (res == enq_ok) return 0;
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9811c40956e54..17c9d825188bb 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2545,7 +2545,7 @@ static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 	struct driver_data *driver_data = packet->driver_data;
 	int ret = -ENOENT;
 
-	tasklet_disable(&ctx->tasklet);
+	tasklet_disable_in_atomic(&ctx->tasklet);
 
 	if (packet->ack != 0)
 		goto out;
@@ -3465,7 +3465,7 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 	struct iso_context *ctx = container_of(base, struct iso_context, base);
 	int ret = 0;
 
-	tasklet_disable(&ctx->context.tasklet);
+	tasklet_disable_in_atomic(&ctx->context.tasklet);
 
 	if (!test_and_set_bit_lock(0, &ctx->flushing_completions)) {
 		context_tasklet((unsigned long)&ctx->context);
diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
index 98df38fe553ce..12d085405bd05 100644
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -332,7 +332,7 @@ static int __init arc_rimi_init(void)
 		dev->irq = 9;
 
 	if (arcrimi_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -349,7 +349,7 @@ static void __exit arc_rimi_exit(void)
 	iounmap(lp->mem_start);
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 	free_irq(dev->irq, dev);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 #ifndef MODULE
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index 22a49c6d7ae6e..5d4a4c7efbbff 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -298,6 +298,10 @@ struct arcnet_local {
 
 	int excnak_pending;    /* We just got an excesive nak interrupt */
 
+	/* RESET flag handling */
+	int reset_in_progress;
+	struct work_struct reset_work;
+
 	struct {
 		uint16_t sequence;	/* sequence number (incs with each packet) */
 		__be16 aborted_seq;
@@ -350,7 +354,9 @@ void arcnet_dump_skb(struct net_device *dev, struct sk_buff *skb, char *desc)
 
 void arcnet_unregister_proto(struct ArcProto *proto);
 irqreturn_t arcnet_interrupt(int irq, void *dev_id);
+
 struct net_device *alloc_arcdev(const char *name);
+void free_arcdev(struct net_device *dev);
 
 int arcnet_open(struct net_device *dev);
 int arcnet_close(struct net_device *dev);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index e04efc0a5c977..d76dd7d14299e 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -387,10 +387,44 @@ static void arcnet_timer(struct timer_list *t)
 	struct arcnet_local *lp = from_timer(lp, t, timer);
 	struct net_device *dev = lp->dev;
 
-	if (!netif_carrier_ok(dev)) {
+	spin_lock_irq(&lp->lock);
+
+	if (!lp->reset_in_progress && !netif_carrier_ok(dev)) {
 		netif_carrier_on(dev);
 		netdev_info(dev, "link up\n");
 	}
+
+	spin_unlock_irq(&lp->lock);
+}
+
+static void reset_device_work(struct work_struct *work)
+{
+	struct arcnet_local *lp;
+	struct net_device *dev;
+
+	lp = container_of(work, struct arcnet_local, reset_work);
+	dev = lp->dev;
+
+	/* Do not bring the network interface back up if an ifdown
+	 * was already done.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		return;
+
+	rtnl_lock();
+
+	/* Do another check, in case of an ifdown that was triggered in
+	 * the small race window between the exit condition above and
+	 * acquiring RTNL.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		goto out;
+
+	dev_close(dev);
+	dev_open(dev, NULL);
+
+out:
+	rtnl_unlock();
 }
 
 static void arcnet_reply_tasklet(unsigned long data)
@@ -452,12 +486,25 @@ struct net_device *alloc_arcdev(const char *name)
 		lp->dev = dev;
 		spin_lock_init(&lp->lock);
 		timer_setup(&lp->timer, arcnet_timer, 0);
+		INIT_WORK(&lp->reset_work, reset_device_work);
 	}
 
 	return dev;
 }
 EXPORT_SYMBOL(alloc_arcdev);
 
+void free_arcdev(struct net_device *dev)
+{
+	struct arcnet_local *lp = netdev_priv(dev);
+
+	/* Do not cancel this at ->ndo_close(), as the workqueue itself
+	 * indirectly calls the ifdown path through dev_close().
+	 */
+	cancel_work_sync(&lp->reset_work);
+	free_netdev(dev);
+}
+EXPORT_SYMBOL(free_arcdev);
+
 /* Open/initialize the board.  This is called sometime after booting when
  * the 'ifconfig' program is run.
  *
@@ -587,6 +634,10 @@ int arcnet_close(struct net_device *dev)
 
 	/* shut down the card */
 	lp->hw.close(dev);
+
+	/* reset counters */
+	lp->reset_in_progress = 0;
+
 	module_put(lp->hw.owner);
 	return 0;
 }
@@ -820,6 +871,9 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 
 	spin_lock_irqsave(&lp->lock, flags);
 
+	if (lp->reset_in_progress)
+		goto out;
+
 	/* RESET flag was enabled - if device is not running, we must
 	 * clear it right away (but nothing else).
 	 */
@@ -852,11 +906,14 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 		if (status & RESETflag) {
 			arc_printk(D_NORMAL, dev, "spurious reset (status=%Xh)\n",
 				   status);
-			arcnet_close(dev);
-			arcnet_open(dev);
+
+			lp->reset_in_progress = 1;
+			netif_stop_queue(dev);
+			netif_carrier_off(dev);
+			schedule_work(&lp->reset_work);
 
 			/* get out of the interrupt handler! */
-			break;
+			goto out;
 		}
 		/* RX is inhibited - we must have received something.
 		 * Prepare to receive into the next buffer.
@@ -1052,6 +1109,7 @@ irqreturn_t arcnet_interrupt(int irq, void *dev_id)
 	udelay(1);
 	lp->hw.intmask(dev, lp->intmask);
 
+out:
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return retval;
 }
diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index f983c4ce6b07f..be618e4b9ed5e 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -169,7 +169,7 @@ static int __init com20020_init(void)
 		dev->irq = 9;
 
 	if (com20020isa_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -182,7 +182,7 @@ static void __exit com20020_exit(void)
 	unregister_netdev(my_dev);
 	free_irq(my_dev->irq, my_dev);
 	release_region(my_dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(my_dev);
+	free_arcdev(my_dev);
 }
 
 #ifndef MODULE
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index eb7f76753c9c0..8bdc44b7e09a1 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -291,7 +291,7 @@ static void com20020pci_remove(struct pci_dev *pdev)
 
 		unregister_netdev(dev);
 		free_irq(dev->irq, dev);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index cf607ffcf358e..9cc5eb6a8e905 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -177,7 +177,7 @@ static void com20020_detach(struct pcmcia_device *link)
 		dev = info->dev;
 		if (dev) {
 			dev_dbg(&link->dev, "kfree...\n");
-			free_netdev(dev);
+			free_arcdev(dev);
 		}
 		dev_dbg(&link->dev, "kfree2...\n");
 		kfree(info);
diff --git a/drivers/net/arcnet/com90io.c b/drivers/net/arcnet/com90io.c
index cf214b7306715..3856b447d38ed 100644
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -396,7 +396,7 @@ static int __init com90io_init(void)
 	err = com90io_probe(dev);
 
 	if (err) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return err;
 	}
 
@@ -419,7 +419,7 @@ static void __exit com90io_exit(void)
 
 	free_irq(dev->irq, dev);
 	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 module_init(com90io_init)
diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
index 3dc3d533cb19a..d8dfb9ea0de89 100644
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -554,7 +554,7 @@ static int __init com90xx_found(int ioaddr, int airq, u_long shmem,
 err_release_mem:
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 err_free_dev:
-	free_netdev(dev);
+	free_arcdev(dev);
 	return -EIO;
 }
 
@@ -672,7 +672,7 @@ static void __exit com90xx_exit(void)
 		release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 		release_mem_region(dev->mem_start,
 				   dev->mem_end - dev->mem_start + 1);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 
diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index e3a8858915b37..df0eab479d512 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -963,7 +963,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 	unsigned long flag;
 
 	netif_stop_queue(dev);
-	tasklet_disable(&np->tx_tasklet);
+	tasklet_disable_in_atomic(&np->tx_tasklet);
 	iowrite16(0, ioaddr + IntrEnable);
 	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
 		   "TxFrameId %2.2x,"
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index e9efe074edc11..f1b9284e0bea8 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -1265,9 +1265,9 @@ jme_stop_shutdown_timer(struct jme_adapter *jme)
 	jwrite32f(jme, JME_APMC, apmc);
 }
 
-static void jme_link_change_tasklet(struct tasklet_struct *t)
+static void jme_link_change_work(struct work_struct *work)
 {
-	struct jme_adapter *jme = from_tasklet(jme, t, linkch_task);
+	struct jme_adapter *jme = container_of(work, struct jme_adapter, linkch_task);
 	struct net_device *netdev = jme->dev;
 	int rc;
 
@@ -1510,7 +1510,7 @@ jme_intr_msi(struct jme_adapter *jme, u32 intrstat)
 		 * all other events are ignored
 		 */
 		jwrite32(jme, JME_IEVE, intrstat);
-		tasklet_schedule(&jme->linkch_task);
+		schedule_work(&jme->linkch_task);
 		goto out_reenable;
 	}
 
@@ -1832,7 +1832,6 @@ jme_open(struct net_device *netdev)
 	jme_clear_pm_disable_wol(jme);
 	JME_NAPI_ENABLE(jme);
 
-	tasklet_setup(&jme->linkch_task, jme_link_change_tasklet);
 	tasklet_setup(&jme->txclean_task, jme_tx_clean_tasklet);
 	tasklet_setup(&jme->rxclean_task, jme_rx_clean_tasklet);
 	tasklet_setup(&jme->rxempty_task, jme_rx_empty_tasklet);
@@ -1920,7 +1919,7 @@ jme_close(struct net_device *netdev)
 
 	JME_NAPI_DISABLE(jme);
 
-	tasklet_kill(&jme->linkch_task);
+	cancel_work_sync(&jme->linkch_task);
 	tasklet_kill(&jme->txclean_task);
 	tasklet_kill(&jme->rxclean_task);
 	tasklet_kill(&jme->rxempty_task);
@@ -3035,6 +3034,7 @@ jme_init_one(struct pci_dev *pdev,
 	atomic_set(&jme->rx_empty, 1);
 
 	tasklet_setup(&jme->pcc_task, jme_pcc_tasklet);
+	INIT_WORK(&jme->linkch_task, jme_link_change_work);
 	jme->dpi.cur = PCC_P1;
 
 	jme->reg_ghc = 0;
diff --git a/drivers/net/ethernet/jme.h b/drivers/net/ethernet/jme.h
index a2c3b00d939d0..2af76329b4a27 100644
--- a/drivers/net/ethernet/jme.h
+++ b/drivers/net/ethernet/jme.h
@@ -411,7 +411,7 @@ struct jme_adapter {
 	struct tasklet_struct	rxempty_task;
 	struct tasklet_struct	rxclean_task;
 	struct tasklet_struct	txclean_task;
-	struct tasklet_struct	linkch_task;
+	struct work_struct	linkch_task;
 	struct tasklet_struct	pcc_task;
 	unsigned long		flags;
 	u32			reg_txcs;
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 71e2ada86793f..72e2e71aac0e6 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -251,7 +251,7 @@ void ath9k_beacon_ensure_primary_slot(struct ath_softc *sc)
 	int first_slot = ATH_BCBUF;
 	int slot;
 
-	tasklet_disable(&sc->bcon_tasklet);
+	tasklet_disable_in_atomic(&sc->bcon_tasklet);
 
 	/* Find first taken slot. */
 	for (slot = 0; slot < ATH_BCBUF; slot++) {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 03ed5cb1c4b25..7370cdc1abdb6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1458,7 +1458,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * Prevents hv_pci_onchannelcallback() from running concurrently
 	 * in the tasklet.
 	 */
-	tasklet_disable(&channel->callback_event);
+	tasklet_disable_in_atomic(&channel->callback_event);
 
 	/*
 	 * Since this function is called with IRQ locks held, can't
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e65df3c95bc55..2725c6ad10af6 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -660,17 +660,14 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-static inline void tasklet_unlock(struct tasklet_struct *t)
-{
-	smp_mb__before_atomic();
-	clear_bit(TASKLET_STATE_RUN, &(t)->state);
-}
-
+void tasklet_unlock(struct tasklet_struct *t);
 void tasklet_unlock_wait(struct tasklet_struct *t);
+void tasklet_unlock_spin_wait(struct tasklet_struct *t);
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
 static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_spin_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);
@@ -695,6 +692,17 @@ static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 	smp_mb__after_atomic();
 }
 
+/*
+ * Do not use in new code. There is no real reason to invoke this from
+ * atomic contexts.
+ */
+static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
+{
+	tasklet_disable_nosync(t);
+	tasklet_unlock_spin_wait(t);
+	smp_mb();
+}
+
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5d08fb467f69a..89c3f7162267b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -162,9 +162,58 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 	entry->flags			= trace_ctx >> 24;
 }
 
-unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
-unsigned int tracing_gen_ctx_flags(void);
-unsigned int tracing_gen_ctx_flags_dect(void);
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
+
+enum trace_flag_type {
+	TRACE_FLAG_IRQS_OFF		= 0x01,
+	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED		= 0x04,
+	TRACE_FLAG_HARDIRQ		= 0x08,
+	TRACE_FLAG_SOFTIRQ		= 0x10,
+	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
+	TRACE_FLAG_NMI			= 0x40,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x80,
+};
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
+		TRACE_FLAG_IRQS_OFF : 0;
+	return tracing_gen_ctx_irq_test(irq_status);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	unsigned long irqflags;
+
+	local_save_flags(irqflags);
+	return tracing_gen_ctx_flags(irqflags);
+}
+#else
+
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+#endif
+
+static inline unsigned int tracing_gen_ctx_dec(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx = tracing_gen_ctx();
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
+}
 
 struct trace_event_file;
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 08a30f7f04b55..3efa760417280 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -26,6 +26,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/wait_bit.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -150,7 +151,7 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
  */
 bool local_bh_blocked(void)
 {
-	return this_cpu_read(softirq_ctrl.cnt) != 0;
+	return __this_cpu_read(softirq_ctrl.cnt) != 0;
 }
 
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
@@ -224,7 +225,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	lockdep_assert_irqs_enabled();
 
 	local_irq_save(flags);
-	curcnt = this_cpu_read(softirq_ctrl.cnt);
+	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
@@ -743,6 +744,16 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
+static inline bool tasklet_clear_sched(struct tasklet_struct *t)
+{
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+		wake_up_var(&t->state);
+		return true;
+	}
+
+	return false;
+}
+
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
@@ -762,8 +773,7 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
+				if (!tasklet_clear_sched(t))
 					BUG();
 				if (t->use_callback)
 					t->callback(t);
@@ -819,8 +829,11 @@ void tasklet_init(struct tasklet_struct *t,
 EXPORT_SYMBOL(tasklet_init);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-
-void tasklet_unlock_wait(struct tasklet_struct *t)
+/*
+ * Do not use in new code. There is no real reason to invoke this from
+ * atomic contexts.
+ */
+void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 {
 	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
@@ -838,7 +851,7 @@ void tasklet_unlock_wait(struct tasklet_struct *t)
 		}
 	}
 }
-EXPORT_SYMBOL(tasklet_unlock_wait);
+EXPORT_SYMBOL(tasklet_unlock_spin_wait);
 #endif
 
 void tasklet_kill(struct tasklet_struct *t)
@@ -846,29 +859,31 @@ void tasklet_kill(struct tasklet_struct *t)
 	if (in_interrupt())
 		pr_notice("Attempt to kill tasklet from interrupt\n");
 
-	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		do {
-			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-				/*
-				 * Prevent a live lock when current
-				 * preempted soft interrupt processing or
-				 * prevents ksoftirqd from running. If the
-				 * tasklet runs on a different CPU then
-				 * this has no effect other than doing the
-				 * BH disable/enable dance for nothing.
-				 */
-				local_bh_disable();
-				local_bh_enable();
-			} else {
-				yield();
-			}
-		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
-	}
+	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
+		wait_var_event(&t->state, !test_bit(TASKLET_STATE_SCHED, &t->state));
+
 	tasklet_unlock_wait(t);
-	clear_bit(TASKLET_STATE_SCHED, &t->state);
+	tasklet_clear_sched(t);
 }
 EXPORT_SYMBOL(tasklet_kill);
 
+#ifdef CONFIG_SMP
+void tasklet_unlock(struct tasklet_struct *t)
+{
+	smp_mb__before_atomic();
+	clear_bit(TASKLET_STATE_RUN, &t->state);
+	smp_mb__after_atomic();
+	wake_up_var(&t->state);
+}
+EXPORT_SYMBOL_GPL(tasklet_unlock);
+
+void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	wait_var_event(&t->state, !test_bit(TASKLET_STATE_RUN, &t->state));
+}
+EXPORT_SYMBOL_GPL(tasklet_unlock_wait);
+#endif
+
 void __init softirq_init(void)
 {
 	int cpu;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d6e75c7233b1f..c300ac3375737 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -79,7 +79,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
-		trace_ctx = _tracing_gen_ctx_flags(0);
+		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + len + cgid_len,
 						  trace_ctx);
@@ -253,7 +253,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		tracing_record_cmdline(current);
 
 		buffer = blk_tr->array_buffer.buffer;
-		trace_ctx = _tracing_gen_ctx_flags(0);
+		trace_ctx = tracing_gen_ctx_flags(0);
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + pdu_len + cgid_len,
 						  trace_ctx);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0f9162f0c02a3..d7ce9d0ad43d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1018,7 +1018,7 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 
 	alloc = sizeof(*entry) + size + 2; /* possible \n added */
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	buffer = global_trace.array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
@@ -1068,7 +1068,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	buffer = global_trace.array_buffer.buffer;
 
 	ring_buffer_nest_start(buffer);
@@ -2587,20 +2587,13 @@ static unsigned short migration_disable_value(void)
 #endif
 }
 
-unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
-	unsigned int trace_flags = 0;
+	unsigned int trace_flags = irqs_status;
 	unsigned int pc;
 
 	pc = preempt_count();
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	if (irqs_disabled_flags(irqflags))
-		trace_flags |= TRACE_FLAG_IRQS_OFF;
-#else
-	trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
-#endif
-
 	if (pc & NMI_MASK)
 		trace_flags |= TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
@@ -2619,33 +2612,6 @@ unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
 		(trace_flags << 24);
 }
 
-unsigned int tracing_gen_ctx_flags(void)
-{
-	unsigned long irqflags;
-
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	local_save_flags(irqflags);
-#else
-	irqflags = 0;
-#endif
-	return _tracing_gen_ctx_flags(irqflags);
-}
-
-unsigned int tracing_gen_ctx_flags_dect(void)
-{
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx_flags();
-
-	/*
-	 * Subtract one from the preeption counter if preemption is enabled,
-	 * see trace_event_buffer_reserve()for details.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		trace_ctx--;
-	return trace_ctx;
-}
-
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
@@ -3090,7 +3056,7 @@ void trace_dump_stack(int skip)
 	skip++;
 #endif
 	__ftrace_trace_stack(global_trace.array_buffer.buffer,
-			     tracing_gen_ctx_flags(), skip, NULL);
+			     tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
@@ -3286,7 +3252,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	tbuffer = get_trace_buf();
@@ -3348,7 +3314,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 
@@ -6718,7 +6684,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    tracing_gen_ctx_flags());
+					    tracing_gen_ctx());
 	if (unlikely(!event))
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
@@ -6797,7 +6763,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    tracing_gen_ctx_flags());
+					    tracing_gen_ctx());
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8eca0d66d7560..2ad9faef718a2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,27 +136,6 @@ struct kretprobe_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
-/*
- * trace_flag_type is an enumeration that holds different
- * states when a trace occurs. These are:
- *  IRQS_OFF		- interrupts were disabled
- *  IRQS_NOSUPPORT	- arch does not support irqs_disabled_flags
- *  NEED_RESCHED	- reschedule is requested
- *  HARDIRQ		- inside an interrupt handler
- *  SOFTIRQ		- inside a softirq handler
- *  NEED_RESCHED_LAZY	- lazy reschedule is requested
- */
-enum trace_flag_type {
-	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
-	TRACE_FLAG_NEED_RESCHED		= 0x04,
-	TRACE_FLAG_HARDIRQ		= 0x08,
-	TRACE_FLAG_SOFTIRQ		= 0x10,
-	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
-	TRACE_FLAG_NMI			= 0x40,
-	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x80,
-};
-
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index a95b7f1fa351c..e47fdb4c92fbc 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -59,7 +59,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	if (atomic_read(&data->disabled))
 		goto out;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_BRANCH,
 					  sizeof(*entry), trace_ctx);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 9409b7c6ebea1..0443dd61667b9 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -422,7 +422,7 @@ void perf_trace_buf_update(void *record, u16 type)
 {
 	struct trace_entry *entry = record;
 
-	tracing_generic_entry_update(entry, type, tracing_gen_ctx_flags());
+	tracing_generic_entry_update(entry, type, tracing_gen_ctx());
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a38d7edb2fe03..1b67c78ed04da 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -266,7 +266,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	 * interested in the preempt_count at the time the tracepoint was
 	 * hit, we need to subtract one to offset the increment.
 	 */
-	fbuffer->trace_ctx = tracing_gen_ctx_flags_dect();
+	fbuffer->trace_ctx = tracing_gen_ctx_dec();
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
@@ -3681,7 +3681,7 @@ function_test_events_call(unsigned long ip, unsigned long parent_ip,
 	long disabled;
 	int cpu;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 	cpu = raw_smp_processor_id();
 	disabled = atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu));
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 65150c0a5e7af..c188045c5f976 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -203,7 +203,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 		return -ENOMEM;
 
 	tracing_generic_entry_update(entry, call->event.type,
-				     tracing_gen_ctx_flags());
+				     tracing_gen_ctx());
 
 	while ((len = parse_field(str, call, &field, &val)) > 0) {
 		if (is_function_field(field))
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 52ab6cf49d767..9a4362c1e5f0c 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -140,7 +140,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (unlikely(!tr->function_enabled))
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	bit = trace_test_and_set_recursion(TRACE_FTRACE_START, TRACE_FTRACE_MAX);
@@ -200,7 +200,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	disabled = atomic_inc_return(&data->disabled);
 
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		trace_function(tr, ip, parent_ip, trace_ctx);
 		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
@@ -407,7 +407,7 @@ static __always_inline void trace_stack(struct trace_array *tr)
 {
 	unsigned int trace_ctx;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index aaa37a6a479cd..b086ba8bb3d65 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -173,7 +173,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		ret = __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret = 0;
@@ -253,7 +253,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled = atomic_inc_return(&data->disabled);
 	if (likely(disabled == 1)) {
-		trace_ctx = _tracing_gen_ctx_flags(flags);
+		trace_ctx = tracing_gen_ctx_flags(flags);
 		__trace_graph_return(tr, trace, trace_ctx);
 	}
 	atomic_dec(&data->disabled);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 51bd4d74f56ce..4c01c5d8b9a7a 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -110,7 +110,7 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 	struct hwlat_entry *entry;
 
 	event = trace_buffer_lock_reserve(buffer, TRACE_HWLAT, sizeof(*entry),
-					  tracing_gen_ctx_flags());
+					  tracing_gen_ctx());
 	if (!event)
 		return;
 	entry	= ring_buffer_event_data(event);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 94219730dda2b..c463e69fb5c71 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -148,7 +148,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
 
@@ -198,7 +198,7 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return 0;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	ret = __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 
@@ -217,7 +217,7 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 }
@@ -331,7 +331,7 @@ check_critical_timing(struct trace_array *tr,
 	T1 = ftrace_now(cpu);
 	delta = T1-T0;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	if (!report_latency(tr, delta))
 		goto out;
@@ -393,7 +393,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 	data->preempt_timestamp = ftrace_now(cpu);
 	data->critical_start = parent_ip ? : ip;
 
-	__trace_function(tr, ip, parent_ip, tracing_gen_ctx_flags());
+	__trace_function(tr, ip, parent_ip, tracing_gen_ctx());
 
 	per_cpu(tracing_cpu, cpu) = 1;
 
@@ -426,7 +426,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 
 	atomic_inc(&data->disabled);
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 	__trace_function(tr, ip, parent_ip, trace_ctx);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start = 0;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a9417890e7335..2bd52edc15793 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1384,7 +1384,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx_flags();
+	fbuffer.trace_ctx = tracing_gen_ctx();
 	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
@@ -1431,7 +1431,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	fbuffer.trace_ctx = tracing_gen_ctx_flags();
+	fbuffer.trace_ctx = tracing_gen_ctx();
 	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 5a7d37bf6888c..7221ae0b4c477 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -302,7 +302,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 	struct trace_mmiotrace_rw *entry;
 	unsigned int trace_ctx;
 
-	trace_ctx = _tracing_gen_ctx_flags(0);
+	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
 					  sizeof(*entry), trace_ctx);
 	if (!event) {
@@ -333,7 +333,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 	struct trace_mmiotrace_map *entry;
 	unsigned int trace_ctx;
 
-	trace_ctx = _tracing_gen_ctx_flags(0);
+	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
 					  sizeof(*entry), trace_ctx);
 	if (!event) {
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index e8bb2d8149e63..f1c603358ff33 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -75,7 +75,7 @@ func_prolog_preempt_disable(struct trace_array *tr,
 	if (likely(!wakeup_task))
 		return 0;
 
-	*trace_ctx = tracing_gen_ctx_flags();
+	*trace_ctx = tracing_gen_ctx();
 	preempt_disable_notrace();
 
 	cpu = raw_smp_processor_id();
@@ -459,7 +459,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 		goto out;
 
 	local_irq_save(flags);
-	trace_ctx = _tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
 
 	arch_spin_lock(&wakeup_lock);
 
@@ -550,7 +550,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	if (unlikely(disabled != 1))
 		goto out;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	/* interrupts should be off from try_to_wake_up */
 	arch_spin_lock(&wakeup_lock);
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 71a2e705970f0..8bfcd3b094226 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -321,7 +321,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer,
@@ -365,7 +365,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	trace_ctx = tracing_gen_ctx_flags();
+	trace_ctx = tracing_gen_ctx();
 
 	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer,
diff --git a/localversion-rt b/localversion-rt
index c5b71f9a229d5..2e9afd4a0afd3 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt25
+-rt26
