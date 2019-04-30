Return-Path: <SRS0=4n46=TA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC04C04AA6
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4669F20652
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfD3Mxf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfD3Mxf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Apr 2019 08:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CAB4307C947;
        Tue, 30 Apr 2019 12:53:35 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81256183E2;
        Tue, 30 Apr 2019 12:53:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] genirq/msi: Add a new field in msi_desc to store
 an IOMMU cookie
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, miquel.raynal@bootlin.com,
        tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-2-julien.grall@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a7edba11-e34c-047c-7852-28bbf87157e6@redhat.com>
Date:   Tue, 30 Apr 2019 14:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-2-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 30 Apr 2019 12:53:35 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

On 4/29/19 4:44 PM, Julien Grall wrote:
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
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
Besides other's comments
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
>     Changes in v2:
>         - Update the commit message to use imperative mood
>         - Protect the field with a new config that will be selected by
>         IOMMU_DMA later on
>         - Add a set of helpers to access the new field
> ---
>  include/linux/msi.h | 26 ++++++++++++++++++++++++++
>  kernel/irq/Kconfig  |  3 +++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 7e9b81c3b50d..82a308c19222 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -77,6 +77,9 @@ struct msi_desc {
>  	struct device			*dev;
>  	struct msi_msg			msg;
>  	struct irq_affinity_desc	*affinity;
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	const void			*iommu_cookie;
> +#endif
>  
>  	union {
>  		/* PCI MSI/X specific data */
> @@ -119,6 +122,29 @@ struct msi_desc {
>  #define for_each_msi_entry_safe(desc, tmp, dev)	\
>  	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
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
>  #ifdef CONFIG_PCI_MSI
>  #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
>  #define for_each_pci_msi_entry(desc, pdev)	\
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 5f3e2baefca9..8fee06625c37 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_MSI_IRQ
>  
> +config IRQ_MSI_IOMMU
> +	bool
> +
>  config HANDLE_DOMAIN_IRQ
>  	bool
>  
> 
