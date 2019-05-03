Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9822C43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49EB2070B
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfECOD5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 10:03:57 -0400
Received: from 8bytes.org ([81.169.241.247]:39222 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfECOD5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 10:03:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8499E41A; Fri,  3 May 2019 16:03:55 +0200 (CEST)
Date:   Fri, 3 May 2019 16:03:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        Eric Auguer <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg() in
 two parts
Message-ID: <20190503140355.GC6731@8bytes.org>
References: <20190501135824.25586-1-julien.grall@arm.com>
 <20190501135824.25586-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501135824.25586-3-julien.grall@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 01, 2019 at 02:58:19PM +0100, Julien Grall wrote:
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
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Eric Auguer <eric.auger@redhat.com>

Acked-by: Joerg Roedel <jroedel@suse.de>
