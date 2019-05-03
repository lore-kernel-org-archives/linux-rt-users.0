Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC2C43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D4F2070B
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfECOEM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 10:04:12 -0400
Received: from 8bytes.org ([81.169.241.247]:39236 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfECOEM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 10:04:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 83CEA41A; Fri,  3 May 2019 16:04:10 +0200 (CEST)
Date:   Fri, 3 May 2019 16:04:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Message-ID: <20190503140410.GD6731@8bytes.org>
References: <20190501135824.25586-1-julien.grall@arm.com>
 <20190501135824.25586-8-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501135824.25586-8-julien.grall@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 01, 2019 at 02:58:24PM +0100, Julien Grall wrote:
> A recent change split iommu_dma_map_msi_msg() in two new functions. The
> function was still implemented to avoid modifying all the callers at
> once.
> 
> Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
> be removed.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Joerg Roedel <jroedel@suse.de>
