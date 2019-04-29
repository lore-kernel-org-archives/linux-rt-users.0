Return-Path: <SRS0=38ny=S7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711AC43219
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8034C20673
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfD2P2P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:28:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfD2P2O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Apr 2019 11:28:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0842E80D;
        Mon, 29 Apr 2019 08:28:14 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 021E73F5C1;
        Mon, 29 Apr 2019 08:28:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg() in
 two parts
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, jason@lakedaemon.net,
        tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-3-julien.grall@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <254b2633-53e9-3fa3-a7e7-f713efdb0017@arm.com>
Date:   Mon, 29 Apr 2019 16:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-3-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/04/2019 15:44, Julien Grall wrote:
> On RT, iommu_dma_map_msi_msg() may be called from non-preemptible
> context. This will lead to a splat with CONFIG_DEBUG_ATOMIC_SLEEP as
> the function is using spin_lock (they can sleep on RT).
> 
> iommu_dma_map_msi_msg() is used to map the MSI page in the IOMMU PT
> and update the MSI message with the IOVA.
> 
> Only the part to lookup for the MSI page requires to be called in
> preemptible context. As the MSI page cannot change over the lifecycle
> of the MSI interrupt, the lookup can be cached and re-used later on.
> 
> iomma_dma_map_msi_msg() is now split in two functions:
>     - iommu_dma_prepare_msi(): This function will prepare the mapping
>     in the IOMMU and store the cookie in the structure msi_desc. This
>     function should be called in preemptible context.
>     - iommu_dma_compose_msi_msg(): This function will update the MSI
>     message with the IOVA when the device is behind an IOMMU.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     Changes in v2:
>         - Rework the commit message to use imperative mood
>         - Use the MSI accessor to get/set the iommu cookie
>         - Don't use ternary on return
>         - Select CONFIG_IRQ_MSI_IOMMU
>         - Pass an msi_desc rather than the irq number
> ---
>  drivers/iommu/Kconfig     |  1 +
>  drivers/iommu/dma-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++---------
>  include/linux/dma-iommu.h | 23 +++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6f07f3b21816..eb1c8cd243f9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -94,6 +94,7 @@ config IOMMU_DMA
>  	bool
>  	select IOMMU_API
>  	select IOMMU_IOVA
> +	select IRQ_MSI_IOMMU
>  	select NEED_SG_DMA_LENGTH
>  
>  config FSL_PAMU
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77aabe637a60..2309f59cefa4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -888,17 +888,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return NULL;
>  }
>  
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
> -	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
> +	struct device *dev = msi_desc_to_dev(desc);
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  	struct iommu_dma_cookie *cookie;
>  	struct iommu_dma_msi_page *msi_page;
> -	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
>  	unsigned long flags;
>  
> -	if (!domain || !domain->iova_cookie)
> -		return;
> +	if (!domain || !domain->iova_cookie) {
> +		desc->iommu_cookie = NULL;

nit: This could be

		msi_desc_set_iommu_cookie(desc, NULL);

now that you have introduced the relevant accessors.

> +		return 0;
> +	}
>  
>  	cookie = domain->iova_cookie;
>  
> @@ -911,7 +912,37 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>  
> -	if (WARN_ON(!msi_page)) {
> +	msi_desc_set_iommu_cookie(desc, msi_page);
> +
> +	if (!msi_page)
> +		return -ENOMEM;
> +	else
> +		return 0;
> +}
> +
> +void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +			       struct msi_msg *msg)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	const struct iommu_dma_msi_page *msi_page;
> +
> +	msi_page = msi_desc_get_iommu_cookie(desc);
> +
> +	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
> +		return;
> +
> +	msg->address_hi = upper_32_bits(msi_page->iova);
> +	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
> +	msg->address_lo += lower_32_bits(msi_page->iova);
> +}
> +
> +void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> +{
> +	struct msi_desc *desc = irq_get_msi_desc(irq);
> +	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
> +
> +	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
>  		/*
>  		 * We're called from a void callback, so the best we can do is
>  		 * 'fail' by filling the message with obviously bogus values.
> @@ -922,8 +953,6 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  		msg->address_lo = ~0U;
>  		msg->data = ~0U;
>  	} else {
> -		msg->address_hi = upper_32_bits(msi_page->iova);
> -		msg->address_lo &= cookie_msi_granule(cookie) - 1;
> -		msg->address_lo += lower_32_bits(msi_page->iova);
> +		iommu_dma_compose_msi_msg(desc, msg);
>  	}
>  }
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index e760dc5d1fa8..3fc48fbd6f63 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -71,12 +71,24 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs);
>  
>  /* The DMA API isn't _quite_ the whole story, though... */
> +/*
> + * Map the MSI page in the IOMMU device and store it in @desc
> + *
> + * Return 0 if succeeded other an error if the preparation has failed.

s/other/or/

This could be a proper kerneldoc thing, while you're at it.

> + */
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> +
> +/* Update the MSI message if required. */
> +void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +			       struct msi_msg *msg);
> +
>  void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>  
>  #else
>  
>  struct iommu_domain;
> +struct msi_desc;
>  struct msi_msg;
>  struct device;
>  
> @@ -99,6 +111,17 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>  {
>  }
>  
> +static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
> +					phys_addr_t msi_addr)
> +{
> +	return 0;
> +}
> +
> +static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +					     struct msi_msg *msg)
> +{
> +}
> +
>  static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  {
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
