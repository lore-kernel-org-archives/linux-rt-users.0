Return-Path: <SRS0=J4zX=TK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8AC04A6B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB616217D6
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfEJRGA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 May 2019 13:06:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfEJRGA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 May 2019 13:06:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hP8y1-00039j-IL; Fri, 10 May 2019 19:05:53 +0200
Date:   Fri, 10 May 2019 19:05:53 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.14-rt9
Message-ID: <20190510170553.nuriamrjbp3su3nr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.14-rt9 patch set. 

Changes since v5.0.14-rt8:

  - Replace one x86 related FPU patch with what landed upstream.

  - IOMMU series by Julien Grall to avoiding sleeping locks in
    non-preemptible context.

  - Fix a race in wait_for_completion(). Patched by Corey Minyard.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.0.14-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.14-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.14-rt9

The RT patch against v5.0.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.14-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.14-rt9.tar.xz

Sebastian
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5d37ea10eaa26..a4715458e972f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -195,8 +195,8 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
 		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
 
-		ret = get_user_pages((unsigned long)buf_fx, nr_pages,
-				     FOLL_WRITE, NULL, NULL);
+		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
+					      NULL, FOLL_WRITE);
 		if (ret == nr_pages)
 			goto retry;
 		return -EFAULT;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a25715650e4..a6c0f8944963e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -93,6 +93,7 @@ config IOMMU_DMA
 	bool
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
 config FSL_PAMU
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c16..f1133d5f391df 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -889,17 +889,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
-	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
+	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
 	unsigned long flags;
 
-	if (!domain || !domain->iova_cookie)
-		return;
+	if (!domain || !domain->iova_cookie) {
+		desc->iommu_cookie = NULL;
+		return 0;
+	}
 
 	cookie = domain->iova_cookie;
 
@@ -912,19 +913,26 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	spin_unlock_irqrestore(&cookie->msi_lock, flags);
 
-	if (WARN_ON(!msi_page)) {
-		/*
-		 * We're called from a void callback, so the best we can do is
-		 * 'fail' by filling the message with obviously bogus values.
-		 * Since we got this far due to an IOMMU being present, it's
-		 * not like the existing address would have worked anyway...
-		 */
-		msg->address_hi = ~0U;
-		msg->address_lo = ~0U;
-		msg->data = ~0U;
-	} else {
-		msg->address_hi = upper_32_bits(msi_page->iova);
-		msg->address_lo &= cookie_msi_granule(cookie) - 1;
-		msg->address_lo += lower_32_bits(msi_page->iova);
-	}
+	msi_desc_set_iommu_cookie(desc, msi_page);
+
+	if (!msi_page)
+		return -ENOMEM;
+	return 0;
+}
+
+void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+			       struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_dma_msi_page *msi_page;
+
+	msi_page = msi_desc_get_iommu_cookie(desc);
+
+	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_page->iova);
+	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo += lower_32_bits(msi_page->iova);
 }
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f5fe0100f9ffd..4359f05833776 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -110,7 +110,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -167,6 +167,7 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
 static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct v2m_data *v2m = NULL, *tmp;
 	int hwirq, offset, i, err = 0;
 
@@ -186,6 +187,11 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = v2m->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    v2m->res.start + V2M_MSI_SETSPI_NS);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 93e32a59640ca..3fe56df326023 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->address_hi		= upper_32_bits(addr);
 	msg->data		= its_get_event_id(d);
 
-	iommu_dma_map_msi_msg(d->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,
@@ -2562,6 +2562,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	msi_alloc_info_t *info = args;
 	struct its_device *its_dev = info->scratchpad[0].ptr;
+	struct its_node *its = its_dev->its;
 	irq_hw_number_t hwirq;
 	int err;
 	int i;
@@ -2570,6 +2571,10 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index fbfa7ff6deb16..563a9b3662941 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -84,6 +84,7 @@ static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
 static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct mbi_range *mbi = NULL;
 	int hwirq, offset, i, err = 0;
 
@@ -104,6 +105,11 @@ static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = mbi->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    mbi_phys_base + GICD_SETSPI_NSR);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = mbi_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
@@ -142,7 +148,7 @@ static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
 	msg[0].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -202,7 +208,7 @@ static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
 	msg[1].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, &msg[1]);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
 
 /* Platform-MSI specific irqchip */
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c671b3212010e..669d291057725 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -100,7 +100,7 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data |= cpumask_first(mask);
 	}
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
@@ -141,6 +141,7 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 					unsigned int nr_irqs,
 					void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct ls_scfg_msi *msi_data = domain->host_data;
 	int pos, err = 0;
 
@@ -154,6 +155,10 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 		err = -ENOSPC;
 	spin_unlock(&msi_data->lock);
 
+	if (err)
+		return err;
+
+	err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr);
 	if (err)
 		return err;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa80..476e0c54de2db 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -71,12 +71,25 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 /* The DMA API isn't _quite_ the whole story, though... */
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
+/*
+ * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU device
+ *
+ * The MSI page will be stored in @desc.
+ *
+ * Return: 0 on success otherwise an error describing the failure.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+
+/* Update the MSI message if required. */
+void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+			       struct msi_msg *msg);
+
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
 
 struct iommu_domain;
+struct msi_desc;
 struct msi_msg;
 struct device;
 
@@ -99,7 +112,14 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
-static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+
+static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
+					     struct msi_msg *msg)
 {
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 784fb52b99002..aa6a4e1cef781 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
@@ -119,6 +122,29 @@ struct msi_desc {
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return desc->iommu_cookie;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+	desc->iommu_cookie = iommu_cookie;
+}
+#else
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return NULL;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+}
+#endif
+
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2baefca92..8fee06625c37c 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config IRQ_MSI_IOMMU
+	bool
+
 config HANDLE_DOMAIN_IRQ
 	bool
 
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a580849781..49c14137988ea 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
