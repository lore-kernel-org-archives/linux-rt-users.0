Return-Path: <SRS0=38ny=S7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E88C43219
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA2D2063F
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfD2PTH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:19:07 -0400
Received: from foss.arm.com ([217.140.101.70]:60186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbfD2PTG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Apr 2019 11:19:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4327D80D;
        Mon, 29 Apr 2019 08:19:06 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD753F5C1;
        Mon, 29 Apr 2019 08:19:04 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-8-julien.grall@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <74a6c2e6-126c-57f0-af5c-ab1130130eba@arm.com>
Date:   Mon, 29 Apr 2019 16:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-8-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/04/2019 15:44, Julien Grall wrote:
> A recent change split iommu_dma_map_msi_msg() in two new functions. The
> function was still implemented to avoid modifying all the callers at
> once.
> 
> Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
> be removed.

Yay! The end of my horrible bodge :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>      Changes in v2:
>          - Rework the commit message
> ---
>   drivers/iommu/dma-iommu.c | 20 --------------------
>   include/linux/dma-iommu.h |  5 -----
>   2 files changed, 25 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2309f59cefa4..12f4464828a4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -936,23 +936,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
>   	msg->address_lo += lower_32_bits(msi_page->iova);
>   }
> -
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -	struct msi_desc *desc = irq_get_msi_desc(irq);
> -	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
> -
> -	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
> -		/*
> -		 * We're called from a void callback, so the best we can do is
> -		 * 'fail' by filling the message with obviously bogus values.
> -		 * Since we got this far due to an IOMMU being present, it's
> -		 * not like the existing address would have worked anyway...
> -		 */
> -		msg->address_hi = ~0U;
> -		msg->address_lo = ~0U;
> -		msg->data = ~0U;
> -	} else {
> -		iommu_dma_compose_msi_msg(desc, msg);
> -	}
> -}
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 3fc48fbd6f63..ddd217c197df 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -82,7 +82,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
>   void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   			       struct msi_msg *msg);
>   
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
>   #else
> @@ -122,10 +121,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   {
>   }
>   
> -static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -}
> -
>   static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   }
> 
