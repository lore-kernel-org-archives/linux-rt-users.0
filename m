Return-Path: <SRS0=pfzm=CY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5ECC433E2
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Sep 2020 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EF6221E5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Sep 2020 08:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpSeLpdD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TJARyVS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIOIZP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Sep 2020 04:25:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOIM7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Sep 2020 04:12:59 -0400
Date:   Tue, 15 Sep 2020 10:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600157575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=df2KM6FrDujliKQ7wiOtr/3jSderU/hQhzxC8Z1rOi4=;
        b=CpSeLpdDnyvJs2RFI8JmdglWsneT0n1hl6I5+u+zEVfe3KDLkPeppCvTYQasHicq1PLOFz
        GXKmbMqL5B17ngvGW9qcphFMB1CkuPHtx6RR2NQqNHEGgtZtV2CTmQ22XCXcid9hOcsofQ
        6vtBbANgzxGMfvuxofKtp53/uUc8EfRlplFn0BXmmy9Uc+zjf37TgNj6lkZZYMUDoYhnxe
        wv7rEXeIObxAIeVmgJNSocyw0IIPsCgg6krEp9+nNOIxq3deY1iTmZxGCgeQ4gbdElnVF3
        8ysLqUG7cEIe+XCcQQF+QcY/EvPlBYIpHaq9FPj+9pDpu9sH3OHa/V2rP4F5pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600157575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=df2KM6FrDujliKQ7wiOtr/3jSderU/hQhzxC8Z1rOi4=;
        b=TJARyVS8WJd5AckJ3ICljUj08Kfru8o8lrETsGgtiI5zh8TMRT/+IDA1Mc3XLriDaGw17o
        PRfZOIGlsINhLIDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: "RTOS unfriendly" in chipidea udc code
Message-ID: <20200915081254.urefcscoqe42rglg@linutronix.de>
References: <CAJk_X9g7+AiD0mq4ZUq02stOg3FvMEzrwXjDfaRJNB7SfD2qgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJk_X9g7+AiD0mq4ZUq02stOg3FvMEzrwXjDfaRJNB7SfD2qgg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-14 10:01:46 [+0900], Jeaho Hwang wrote:
> The function hw_usb_reset, called by isr_reset_handler, is using
> udelay to wait hw reset and commented "RTOS unfriendly". Can I be sure
> RT-safe is it? Could you suggest any better alternative?

If I traced it right, that function is used as an interrupt handler
which should run threaded on PREEMPT_RT (it should be requested via
request_irq() or so). That means that the udelay() can be preempted by a
task with higher priority.

> Thanks. Regards

Sebastian
