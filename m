Return-Path: <SRS0=38ny=S7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77383C43219
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384492067D
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 19:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vrc7nCcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfD2Tfa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:35:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2Tfa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Apr 2019 15:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X4lzX+kb9hozXdpLjDP5xF1q9VeJj9RkW1ampMaw3Z8=; b=Vrc7nCcRed5ITfFUEFO6B2eYC
        dNF1BXdkQlXSw2RiJq+2F/xNrMpqubyPnTWodY2Os4ZpdbQsYO/zy/Z/KcCrLzxkC6jBZLCk3auqg
        K2QW9AqqN68EckGzq59tYqnK2+l2RsEjNM4Jn2YI1P+Fv3+yGl7ho0bb/JdUDeKmKMcHLlRm5ccju
        0mROVq1oX/lwzgDJmqGzHuLvUZHoF0avMV5rs0eoQi1mz1jqIrLDztiFtJ9w3SM3bEAJ7+apILSDR
        0LTcVqB2AFKteYZheAJT8Yg6hYKM5ihOGyFDI8NDWaNH8Yu4qkuAkfkDfHFS5lnFc8/eShikghtb0
        E6p1uWPEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLC3k-0005DD-Vc; Mon, 29 Apr 2019 19:35:28 +0000
Date:   Mon, 29 Apr 2019 12:35:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jason@lakedaemon.net,
        douliyangs@gmail.com, robin.murphy@arm.com,
        miquel.raynal@bootlin.com, tglx@linutronix.de, logang@deltatee.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in
 two parts
Message-ID: <20190429193528.GA14274@infradead.org>
References: <20190429144428.29254-1-julien.grall@arm.com>
 <646d035d-e160-a19d-8c3a-e1935cf691b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646d035d-e160-a19d-8c3a-e1935cf691b5@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 29, 2019 at 04:57:20PM +0100, Marc Zyngier wrote:
> Thanks for having reworked this. I'm quite happy with the way this looks
> now (modulo the couple of nits Robin and I mentioned, which I'm to
> address myself).
> 
> Jorg: are you OK with this going via the irq tree?

As-is this has a trivial conflict with my
"implement generic dma_map_ops for IOMMUs" series.  But I can tweak
it a bit to avoid that conflict.
