Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC04C10F14
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6053206BA
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfDWKzj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:55:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54268 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWKzj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 06:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D7A374;
        Tue, 23 Apr 2019 03:55:39 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5470A3F557;
        Tue, 23 Apr 2019 03:55:36 -0700 (PDT)
Subject: Re: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two
 parts
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-3-julien.grall@arm.com>
 <20190423070823.GA12114@infradead.org>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <7af177e1-dfd9-2a91-3fd9-dfe53a6a9014@arm.com>
Date:   Tue, 23 Apr 2019 11:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423070823.GA12114@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 4/23/19 8:08 AM, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 06:26:06PM +0100, Julien Grall wrote:
>> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   {
>> +	struct device *dev = msi_desc_to_dev(desc);
>>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   	struct iommu_dma_cookie *cookie;
>>   	unsigned long flags;
>>   
>> +	if (!domain || !domain->iova_cookie) {
>> +		desc->iommu_cookie = NULL;
>> +		return 0;
>> +	}
>>   
>>   	cookie = domain->iova_cookie;
>>   
>> @@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>   	 * of an MSI from within an IPI handler.
>>   	 */
>>   	spin_lock_irqsave(&cookie->msi_lock, flags);
>> +	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
>>   	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>>   
>> +	return (desc->iommu_cookie) ? 0 : -ENOMEM;
> 
> No need for the braces.  Also I personally find a:
> 
> 	if (!desc->iommu_cookie)
> 		return -ENOMEM;
> 	return 0;
> 
> much more readable, but that might just be personal preference.

I am happy either way. I will use your suggestion in the next version.

Cheers,

-- 
Julien Grall
