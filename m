Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC9C10F14
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 09:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D951A206A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 09:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDWJ0Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:26:16 -0400
Received: from foss.arm.com ([217.140.101.70]:52386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfDWJ0Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 05:26:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918EB374;
        Tue, 23 Apr 2019 02:26:15 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4991C3F557;
        Tue, 23 Apr 2019 02:26:13 -0700 (PDT)
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, joro@8bytes.org, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-2-julien.grall@arm.com>
 <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <943b0907-f2ee-63c1-7134-997ffaf6f348@arm.com>
Date:   Tue, 23 Apr 2019 10:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Thomas,

On 4/18/19 8:28 PM, Thomas Gleixner wrote:
> On Thu, 18 Apr 2019, Julien Grall wrote:
> 
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
> 
> # git grep 'This patch' Documentation/process/
> 
> Applied to the whole series.

Sorry for that. I will rework all the commit messages and resend the series.

Cheers,

-- 
Julien Grall
