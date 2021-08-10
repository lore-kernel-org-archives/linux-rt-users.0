Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4BC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6260F94
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 16:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhHJQfr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhHJQfn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 12:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E3C0613C1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 09:35:20 -0700 (PDT)
Date:   Tue, 10 Aug 2021 18:35:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628613319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kdkb72cjlZdjPfmuEuu2uQeMdcwQGOW/xgXcncNVYA=;
        b=lHrCpufY9m9BVZ/8S7McOCuxNK/0/vAdEzl0+y8qfmyjbk51FV9B6qMfTAp5TX0oVq2xse
        6QHT+aYqnP1JPgBA7ymRaCaeuMyHBDVm/wkF7QMJtKtepr8FT/uIYsYddHtQ81AkE5FA7p
        F2aZucixD2xRduO0Bb3AF4rYgFrYz1t0YA8IBorE/RYPTeocVx31Z5KheJq2tRLzL8SrPT
        pS3+JL0qiGRbE9/uH70wqY5L2jWItKyRViGf3h6KtP6fqyoE4C2p+j557B4ahWD6dvkJSs
        1165pJOyK6u6dcUjXPz7VJXSJL90Yv+cZvFUJkvtrIRhV2CLBAETXWKCQgckLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628613319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kdkb72cjlZdjPfmuEuu2uQeMdcwQGOW/xgXcncNVYA=;
        b=W8BIr29hOSpU4dMe310HSIFOXG2ECwKzozxyY0XA5W0cJwAtWixfTRd5QF2MLdvvoEXzDA
        KRU/I9ThcbloruCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] usb: chipidea: fix RT issue for udc
Message-ID: <20210810163518.xzfnnheaet3kofrr@linutronix.de>
References: <20210810065749.GA3369716@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810065749.GA3369716@ubuntu>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-10 15:57:49 [+0900], Jeaho Hwang wrote:
> hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.
> to prevent local_irq_save should keep the function from irqs.
> 
> I am not sure where is the best to submit this patch, between RT and USB
> community so sending to both. thanks.

If this applies to upstream as of v5.14-rc5 it should be sent upstream
to linux-usb@vger with the relevant maintainers in Cc.
Please run via checkpatch before sending.

> Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>

Sebastian
