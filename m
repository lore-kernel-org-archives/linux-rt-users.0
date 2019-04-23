Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9CC282DD
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 10:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7401206A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 10:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfDWKvy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:51:54 -0400
Received: from foss.arm.com ([217.140.101.70]:54156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfDWKvy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 06:51:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDBF6374;
        Tue, 23 Apr 2019 03:51:53 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064243F557;
        Tue, 23 Apr 2019 03:51:50 -0700 (PDT)
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, jason@lakedaemon.net,
        tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-2-julien.grall@arm.com>
 <7e77331c-4adf-5bb4-0c23-4d01a6ac5ab4@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <1bcdb72f-2116-756b-b74d-a48f89870782@arm.com>
Date:   Tue, 23 Apr 2019 11:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7e77331c-4adf-5bb4-0c23-4d01a6ac5ab4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/23/19 11:23 AM, Marc Zyngier wrote:
> Hi Julien,

Hi Marc,

> On 18/04/2019 18:26, Julien Grall wrote:
>> When an MSI doorbell is located downstream of an IOMMU, it is required
>> to swizzle the physical address with an appropriately-mapped IOVA for any
>> device attached to one of our DMA ops domain.
>>
>> At the moment, the allocation of the mapping may be done when composing
>> the message. However, the composing may be done in non-preemtible
>> context while the allocation requires to be called from preemptible
>> context.
>>
>> A follow-up patch will split the current logic in two functions
>> requiring to keep an IOMMU cookie per MSI.
>>
>> This patch introduces a new field in msi_desc to store an IOMMU cookie
>> when CONFIG_IOMMU_DMA is selected.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>> ---
>>   include/linux/msi.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 7e9b81c3b50d..d7907feef1bb 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -77,6 +77,9 @@ struct msi_desc {
>>   	struct device			*dev;
>>   	struct msi_msg			msg;
>>   	struct irq_affinity_desc	*affinity;
>> +#ifdef CONFIG_IOMMU_DMA
>> +	const void			*iommu_cookie;
>> +#endif
>>   
>>   	union {
>>   		/* PCI MSI/X specific data */
>>
> 
> Given that this is the only member in this structure that is dependent
> on a config option, you could also add a couple of accessors that would
> do nothing when IOMMU_DMA is not selected (and use that in the DMA code).

I haven't seen any use of the helpers so far because the DMA code is 
also protected by IOMMU_DMA.

I can add the helpers in the next version if you see any use outside of 
the DMA code.

Cheers,

-- 
Julien Grall
