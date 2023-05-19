Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658ECC77B75
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjESSGX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESSGW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 14:06:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64341107
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 11:06:21 -0700 (PDT)
Date:   Fri, 19 May 2023 20:06:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684519579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFiiA1y1KiyXD1GfbxB+h0lYmF4ra2AHUx/x18oWr00=;
        b=U5cC5TVs4D0pu1h2byeOQyEVe+U+RVP4/WfJM8PrNU5OCJF/FFswOLid/uKbTR4njMDzNM
        p7ZFmLONp8+7YZ+Vvy5SIyRo2v1ib3FiGpcBFmdyTcVQUE77wC1a3mMyVhgJrammLnOKpI
        5JZTvjfOA2oq3w8P+BVAM+AhZHgiwR1igcOIs5QOWzFuSqUF9dO3wKIw95lx2mDvQNy1ra
        zsHvYYEOTYyKm591YwAM+VS+y3X2iXW/8NXwUegIo9kzh2Wx71phKW9SPXyLSh1HsqUBE5
        KKEy35k/Y4IIX8gj3B9liEGu6fVivYIXPi7/8brbg+XFjReAhHv8u+JVMNcV2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684519579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFiiA1y1KiyXD1GfbxB+h0lYmF4ra2AHUx/x18oWr00=;
        b=ft63PASTVnoNbgxfTbXReKwX73+ORXyN1vlJh8uwGiVdGLeNLDEYDuRCkLZY209WrWyp34
        Oaxd3iK9Rwx+7EBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] ARM: vfp: Fixes for PREEMP_RT
Message-ID: <20230519180616.JZIGG3C7@linutronix.de>
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de>
 <CAMj1kXFGfmCNJGgCV+St7B--08moBF=QzbH=qELE6XKaKdA0RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGfmCNJGgCV+St7B--08moBF=QzbH=qELE6XKaKdA0RQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-19 18:14:38 [+0200], Ard Biesheuvel wrote:
> This looks reasonable to me - thanks for taking the time.
> 
> However, I was about to hit send on my PR to Russell for the following series:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-vfp-softirq-fixes
> 
> which moves all of the VFP processing to C, and so this is going to
> conflict at the very least, but also provide a cleaner base for patch
> #2 in this series.

Okay. PR? Is this still the rmk's patch tracking system or did something
change? Either way, please let me know once this get through so I can
rebase accordingly. In the mean I throw this into -RT.

> Also, aren't there a few other places in the VFP code where BH are
> disabled and enabled again? Do those need the same treatment?

If so I haven't found them. A grep in arch/arm/ for bh_disable() has now
hit and this is vfp_lock().

> Thanks,
> Ard.

Sebastian
