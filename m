Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D9EC10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7292F214DA
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 19:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbfDRT2W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:28:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38041 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRT2W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 15:28:22 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHChh-0003PF-0E; Thu, 18 Apr 2019 21:28:13 +0200
Date:   Thu, 18 Apr 2019 21:28:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, joro@8bytes.org, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
In-Reply-To: <20190418172611.21561-2-julien.grall@arm.com>
Message-ID: <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
References: <20190418172611.21561-1-julien.grall@arm.com> <20190418172611.21561-2-julien.grall@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 18 Apr 2019, Julien Grall wrote:

> When an MSI doorbell is located downstream of an IOMMU, it is required
> to swizzle the physical address with an appropriately-mapped IOVA for any
> device attached to one of our DMA ops domain.
> 
> At the moment, the allocation of the mapping may be done when composing
> the message. However, the composing may be done in non-preemtible
> context while the allocation requires to be called from preemptible
> context.
> 
> A follow-up patch will split the current logic in two functions
> requiring to keep an IOMMU cookie per MSI.
> 
> This patch introduces a new field in msi_desc to store an IOMMU cookie
> when CONFIG_IOMMU_DMA is selected.

# git grep 'This patch' Documentation/process/

Applied to the whole series.

Thanks

	tglx
