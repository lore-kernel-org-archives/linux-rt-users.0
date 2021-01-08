Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B8C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 08:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F22E23435
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 08:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAHI3y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 03:29:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhAHI3y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 03:29:54 -0500
Date:   Fri, 8 Jan 2021 09:29:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610094552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CFU1S95Dp2PF9kFBV/R53JL6m8D25G5ngRHGs+2FJU=;
        b=z9I6zel+ijQxqJeM7XjJarXg1LiSUdcCuaMbiWkMajjFGnBSBnzPrp2bC7TalOXGPypgOs
        l7KVLvD9QcWoViy1PcC2ck+z7zbGHxM/8k8m5N6ty3UZhB7bE+DjT92mpidTtig+BxilUB
        et1xoHwoAf7gApPGMHnhK4V+u9RW0h1P/gnZS64vMN+DCWPO/pvjDPp+dSGkYCCO3sipqk
        etrucXre6RAZE/+WnIijT8N1v2IQDulstGR5sInBJEYyQtYpFX6XsWD5kVpMavt89is5fJ
        RT7r+xGVYtpLoBNXD3sdyQa5d6Fl/HjpFeUFbgsu5ikDN0QQ3F6kduwfmAM/gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610094552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CFU1S95Dp2PF9kFBV/R53JL6m8D25G5ngRHGs+2FJU=;
        b=QcgWdd7ZtF2wCMHlR6ST3KYSheJxMLkUgUvc6yjlgyOCF1IPnSn5kd0ob2RKoyd+nLH4fF
        8fQEO75Da8Un+pDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sergei Poselenov <sposelenov@emcraft.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: kernel crash with ARM64 5.4.47 preempt_rt
Message-ID: <20210108082911.cz7oropmnezhqx5p@linutronix.de>
References: <20201230140917.50e86fc3@sergmir.emcraft.com>
 <20210107164902.5guoavadivwugsz3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107164902.5guoavadivwugsz3@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-07 17:49:02 [+0100], To Sergei Poselenov wrote:
> On 2020-12-30 14:09:17 [+0300], Sergei Poselenov wrote:
> > Hello,
> Hi,
> 
> > We applied patch-5.4.47-rt28.patch to NXP 5.4.47-2.2.0 release ARM64
> > kernel running on IMX8M NANO chip, and enabled CONFIG_PRREMPT_RT. We
> > are observing the following crash (below), on a system running an
> > application that communicates with some SPI device. Obviously, the
> > system doesn't crash without the patch applied.
> > 
> > Any thoughts on the reason of the failure would be appreciated. How would we start debugging the problem?
> 
> Can you give v5.10 a try v5.10 and/or enable SLUB_DEBUG?

Now that I look at it again, you need update to more recent v5.4-RT
kernel. The current is v5.4.84-rt47, the bug was fixed in v5.4.54-rt33.

> > Thanks!
> > 
> > Regards,
> > Sergei Poselenov,
> > Emcraft Systems
> 
Sebastian
