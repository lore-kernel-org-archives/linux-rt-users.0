Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753EC282DD
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56122206BA
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 07:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJKCOfQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDWHIZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:08:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHIZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 03:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VjRQSeCu/MmbgpwmU6TxjyQsYSPXCIK8gZfKVhcf1cU=; b=AJKCOfQSyIEDeMXFpdO2cAYp2
        oZz0VUyQsTLqRK3AeXuClr5XJSD/0iAjcVpjQtnAWzRxTh8Dadag8yXB2/5Xu/Rw4tlzVd6cyorP8
        eaVHfMCZZJGRFxsH6/PNsHJwIkxdIVtKomaO3cU6IJXHjB1hY8L2GxE+g0ciNUG6z9iOYO6aWRlnp
        +YMpH9FnFihhxlEVk6sUCMOLV3+HjDgheYrKRVei6K+BIylDeGwpIxVH80hoAEWPXrQyA+BZTxJfx
        CXpLxImW2bpxE7H/EF5DOzNxB8+8QRMOAIyKzhqjEpHrFMYQrOt9jEpL/Bpde+C896Jt1w6WsOZ9V
        D1AaMvgnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIpXT-0004qy-DK; Tue, 23 Apr 2019 07:08:23 +0000
Date:   Tue, 23 Apr 2019 00:08:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two
 parts
Message-ID: <20190423070823.GA12114@infradead.org>
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418172611.21561-3-julien.grall@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 18, 2019 at 06:26:06PM +0100, Julien Grall wrote:
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
> +	struct device *dev = msi_desc_to_dev(desc);
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  	struct iommu_dma_cookie *cookie;
>  	unsigned long flags;
>  
> +	if (!domain || !domain->iova_cookie) {
> +		desc->iommu_cookie = NULL;
> +		return 0;
> +	}
>  
>  	cookie = domain->iova_cookie;
>  
> @@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  	 * of an MSI from within an IPI handler.
>  	 */
>  	spin_lock_irqsave(&cookie->msi_lock, flags);
> +	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>  
> +	return (desc->iommu_cookie) ? 0 : -ENOMEM;

No need for the braces.  Also I personally find a:

	if (!desc->iommu_cookie)
		return -ENOMEM;
	return 0;

much more readable, but that might just be personal preference.
