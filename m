Return-Path: <SRS0=38ny=S7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC7C43219
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50CC20673
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfD2PML (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:12:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2PMI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Apr 2019 11:12:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951F680D;
        Mon, 29 Apr 2019 08:12:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89B103F5C1;
        Mon, 29 Apr 2019 08:12:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] genirq/msi: Add a new field in msi_desc to store
 an IOMMU cookie
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-2-julien.grall@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <df16760f-b5fe-5af4-18a1-fbb450d772a4@arm.com>
Date:   Mon, 29 Apr 2019 16:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-2-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/04/2019 15:44, Julien Grall wrote:
> When an MSI doorbell is located downstream of an IOMMU, it is required
> to swizzle the physical address with an appropriately-mapped IOVA for any
> device attached to one of our DMA ops domain.
> 
> At the moment, the allocation of the mapping may be done when composing
> the message. However, the composing may be done in non-preemtible
> context while the allocation requires to be called from preemptible
> context.
> 
> A follow-up change will split the current logic in two functions
> requiring to keep an IOMMU cookie per MSI.
> 
> A new field is introduced in msi_desc to store an IOMMU cookie. As the
> cookie may not be required in some configuration, the field is protected
> under a new config CONFIG_IRQ_MSI_IOMMU.
> 
> A pair of helpers has also been introduced to access the field.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>      Changes in v2:
>          - Update the commit message to use imperative mood
>          - Protect the field with a new config that will be selected by
>          IOMMU_DMA later on
>          - Add a set of helpers to access the new field
> ---
>   include/linux/msi.h | 26 ++++++++++++++++++++++++++
>   kernel/irq/Kconfig  |  3 +++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 7e9b81c3b50d..82a308c19222 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -77,6 +77,9 @@ struct msi_desc {
>   	struct device			*dev;
>   	struct msi_msg			msg;
>   	struct irq_affinity_desc	*affinity;
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	const void			*iommu_cookie;
> +#endif
>   
>   	union {
>   		/* PCI MSI/X specific data */
> @@ -119,6 +122,29 @@ struct msi_desc {
>   #define for_each_msi_entry_safe(desc, tmp, dev)	\
>   	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
>   
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> +{
> +	return desc->iommu_cookie;
> +}
> +
> +static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> +					     const void *iommu_cookie)
> +{
> +	desc->iommu_cookie = iommu_cookie;
> +}
> +#else
> +static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> +{
> +	return NULL;
> +}
> +
> +static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> +					     const void *iommu_cookie)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_PCI_MSI
>   #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
>   #define for_each_pci_msi_entry(desc, pdev)	\
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 5f3e2baefca9..8fee06625c37 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
>   	select IRQ_DOMAIN_HIERARCHY
>   	select GENERIC_MSI_IRQ
>   
> +config IRQ_MSI_IOMMU
> +	bool
> +
>   config HANDLE_DOMAIN_IRQ
>   	bool
>   
> 
