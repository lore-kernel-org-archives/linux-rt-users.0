Return-Path: <SRS0=4n46=TA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274ACC43219
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35BC21670
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 12:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfD3Me5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfD3Me4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Apr 2019 08:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2F173087921;
        Tue, 30 Apr 2019 12:34:55 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC46600C2;
        Tue, 30 Apr 2019 12:34:52 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] irqchip/gic-v3-its: Don't map the MSI page in
 its_irq_compose_msi_msg()
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, miquel.raynal@bootlin.com,
        tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-5-julien.grall@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
Date:   Tue, 30 Apr 2019 14:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-5-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Apr 2019 12:34:55 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Julien,

On 4/29/19 4:44 PM, Julien Grall wrote:
> its_irq_compose_msi_msg() may be called from non-preemptible context.
> However, on RT, iommu_dma_map_msi_msg requires to be called from a
> preemptible context.
> 
> A recent change split iommu_dma_map_msi_msg() in two new functions:
> one that should be called in preemptible context, the other does
> not have any requirement.
> 
> The GICv3 ITS driver is reworked to avoid executing preemptible code in
> non-preemptible context. This can be achieved by preparing the MSI
> maping when allocating the MSI interrupt.
mapping
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     Changes in v2:
>         - Rework the commit message to use imperative mood
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7577755bdcf4..12ddbcfe1b1e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  	msg->address_hi		= upper_32_bits(addr);
>  	msg->data		= its_get_event_id(d);
>  
> -	iommu_dma_map_msi_msg(d->irq, msg);
> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
>  }
>  
>  static int its_irq_set_irqchip_state(struct irq_data *d,
> @@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  {
>  	msi_alloc_info_t *info = args;
>  	struct its_device *its_dev = info->scratchpad[0].ptr;
> +	struct its_node *its = its_dev->its;
>  	irq_hw_number_t hwirq;
>  	int err;
>  	int i;
> @@ -2574,6 +2575,8 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	if (err)
>  		return err;
>  
> +	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
Test err as in gicv2m driver?
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
>  		if (err)
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

