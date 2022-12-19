Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F0C4332F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Dec 2022 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSNaP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSNaO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Dec 2022 08:30:14 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F5A2BFC
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 05:30:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AF47DADAE;
        Mon, 19 Dec 2022 14:30:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1671456606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=TjCiTHvN37p4p+LkayMNDNuyxKyIkYwd+KICWnBr3Co=;
        b=iadM5e1cvgpo15zpWkD8aWMZECDEu79XN5f6OYbwvlzOwR16S8sLIcQv4ncIoy1awHJFP7
        e3vVrlYnWt0AdoY2+xp7BBOSv44BwtxU+s5lBpuUpF02GmfM9NbXbxjmnyANvvYHEZ7BiE
        DLv0yFpy1uLPxP3bmQvmeDl2PefDrxRMRhJZx3IJghB8D/M8IBOoKqAjDASmGdyQWuQbH0
        j3Fi2o7YedJdv2KxKsNh38ev2sQWUqOOcfRFpm8oUIREbIYMvh3W/XXuv4qFr8V6+gkKl+
        RdPCNxhwXcNhg7zNI5CV4n/o2l+aNyNh9HGUbe2zZyRIc4/yehuKNNuto+E9PA==
Date:   Mon, 19 Dec 2022 14:30:03 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Danilo Cezar Zanella <danilo.zanella@iag.usp.br>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: pci_alloc_irq_vectors problem further investigation
Message-ID: <20221219133003.uy6zigxl5vwoilnw@carbon.lan>
References: <CAAxUTH4L-eRTdnOE6cPaa6wZUawJ2sU_aToKygR98xmXJvu+QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAxUTH4L-eRTdnOE6cPaa6wZUawJ2sU_aToKygR98xmXJvu+QA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Dec 12, 2022 at 07:35:14AM -0300, Danilo Cezar Zanella wrote:
> There is a driver developed by EmbeddedTS (the board is Marvell
> armada-385, dual core processor) that tries to allocate 32 MSI
> interrupts, using pci_alloc_irq_vectors(..,32,32,...). When I ran the
> Kernel (4.14 NON RT) provided by them, it worked fine, but when I
> recompiled the kernel (4.19.249 using the RT_FULL options), it didn't,
> returning -ENOSPC.

Does the kernel 'provided by them' carry additional patches for your
board?

> In RT_FULL Kernel:
> - First fact, when I ran pci_msi_vec_count, it returned 32.
> - Second, if I changed to 16, calling
> pci_alloc_irq_vectors(..,16,16,...), it  worked.
> I traced this kernel and I found that:
> pci_alloc_irq_vectors_affinity
>   __pci_enable_msi_range
>     msi_capability_init
>       pci_msi_setup_msi_irqs
>         msi_domain_alloc_irqs
>           __irq_domain_alloc_irqs
>             irq_domain_alloc_descs
>               Then I stopped here...
> 
> I searched on the Internet, but I couldn't find anything.
> Has someone had a similar problem?
> Is there something that I missed? Some configuration??

Vendor kernels usually ship changes which are not ported to upstream and
hence upstream kernels might not work or work differently.

Daniel
