Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A02C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2278D23403
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 16:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbhAGQtq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:49:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGQtp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jan 2021 11:49:45 -0500
Date:   Thu, 7 Jan 2021 17:49:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610038144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlwRq281uwApEhhn6CKabkBpI9O0KLd5HjaXCPZW8OE=;
        b=Hum/lTSiSXKMO1/oNYtwmSdJJvI4JktfaXzrHLALtD3n5pKTU2v+SBDvarCULrk2jyXVg7
        cbnAI9EzovN0MKMl2+IvWfF1w7J1QHJCTQwPjAtrWCFL+mWf53OdrU5g7HOHfSmFLZr4bk
        XMioINj6yaybx/sKYh7cREdbMTehRzCFtptpoyUjyPpCJjjS7qunyoeBJdSjXQQk1F4DDq
        wYBWRZHlEXr4iLWeSWBsUQDFUgTCLYTOOizAZ6mAQERK7zOVRNHBX+dsnvRWa4j1p7fsaS
        lrfFd9LFfkP0nonak4ybPHuIDCvy6SbaEdaRw7XcdDEE9/yFkSeOvw2dEbucXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610038144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlwRq281uwApEhhn6CKabkBpI9O0KLd5HjaXCPZW8OE=;
        b=a28/s59fgto7BmHL7jmwlk3eMEwlHrYEKXKdA6lOhmz09OinqhRFt1796OsmrF+AxAxcba
        hIaDcB0Mj5LfwsBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sergei Poselenov <sposelenov@emcraft.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: kernel crash with ARM64 5.4.47 preempt_rt
Message-ID: <20210107164902.5guoavadivwugsz3@linutronix.de>
References: <20201230140917.50e86fc3@sergmir.emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201230140917.50e86fc3@sergmir.emcraft.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-30 14:09:17 [+0300], Sergei Poselenov wrote:
> Hello,
Hi,

> We applied patch-5.4.47-rt28.patch to NXP 5.4.47-2.2.0 release ARM64
> kernel running on IMX8M NANO chip, and enabled CONFIG_PRREMPT_RT. We
> are observing the following crash (below), on a system running an
> application that communicates with some SPI device. Obviously, the
> system doesn't crash without the patch applied.
> 
> Any thoughts on the reason of the failure would be appreciated. How would we start debugging the problem?

Can you give v5.10 a try v5.10 and/or enable SLUB_DEBUG?

> Thanks!
> 
> Regards,
> Sergei Poselenov,
> Emcraft Systems

Sebastian
