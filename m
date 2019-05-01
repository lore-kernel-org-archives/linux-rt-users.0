Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E820BC43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A9821670
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfEALOe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 07:14:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfEALOe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 07:14:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B7480D;
        Wed,  1 May 2019 04:14:33 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300633F5C1;
        Wed,  1 May 2019 04:14:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] irqchip/gic-v3-its: Don't map the MSI page in
 its_irq_compose_msi_msg()
To:     Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, miquel.raynal@bootlin.com,
        tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-5-julien.grall@arm.com>
 <17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <59ff2eda-74d4-6925-6ed0-8d40e8a892fa@arm.com>
Date:   Wed, 1 May 2019 12:14:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 30/04/2019 13:34, Auger Eric wrote:
> Hi Julien,

Hi Eric,

Thank you for the review!

> 
> On 4/29/19 4:44 PM, Julien Grall wrote:
>> its_irq_compose_msi_msg() may be called from non-preemptible context.
>> However, on RT, iommu_dma_map_msi_msg requires to be called from a
>> preemptible context.
>>
>> A recent change split iommu_dma_map_msi_msg() in two new functions:
>> one that should be called in preemptible context, the other does
>> not have any requirement.
>>
>> The GICv3 ITS driver is reworked to avoid executing preemptible code in
>> non-preemptible context. This can be achieved by preparing the MSI
>> maping when allocating the MSI interrupt.
> mapping
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      Changes in v2:
>>          - Rework the commit message to use imperative mood
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 7577755bdcf4..12ddbcfe1b1e 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>   	msg->address_hi		= upper_32_bits(addr);
>>   	msg->data		= its_get_event_id(d);
>>   
>> -	iommu_dma_map_msi_msg(d->irq, msg);
>> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
>>   }
>>   
>>   static int its_irq_set_irqchip_state(struct irq_data *d,
>> @@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>   {
>>   	msi_alloc_info_t *info = args;
>>   	struct its_device *its_dev = info->scratchpad[0].ptr;
>> +	struct its_node *its = its_dev->its;
>>   	irq_hw_number_t hwirq;
>>   	int err;
>>   	int i;
>> @@ -2574,6 +2575,8 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>   	if (err)
>>   		return err;
>>   
>> +	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
> Test err as in gicv2m driver?

Hmmm yes. Marc, do you want me to respin the patch?

Cheers,

-- 
Julien Grall
