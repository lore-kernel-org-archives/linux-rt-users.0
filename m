Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E907C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A5723A1E
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbhAUPcw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbhAUPaf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Jan 2021 10:30:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161EC0613ED
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jan 2021 07:29:55 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:29:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611242993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCBN6cnBaZhP7IubvFTi7tEzogwzIU6boA/2BHq7Gi4=;
        b=eEP2SPksKXkHTnlai3v+vhILbyyMX4k7554J8glPZvus3EtZiI8+2n+86u8CAnp0m5tRwg
        5ndVxCpAR/V3A0BIjD4MsgXI8GEFrj4H5BcEuitc5r77QlE7VUCiEpdTluZv4l8E7MwoWZ
        QuiBp4cGex65h7KoTCQqMxxYnn+nZMmP9bqH8fyt3P07Nqj04OsaJJKrfTZHggr3XLI2DM
        qXJYIcYmw6N1t+N2Xp/OPvEd2VM3VomGTEz8BCr1zhpvP6+pFZ2uexX2j0H01qwAxrTApP
        6osh6t0glo8/Uo0asH2dyGMZWJ1lpsxt81dCxbWBWNLgj1YXXMjUv3/pWcISXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611242993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCBN6cnBaZhP7IubvFTi7tEzogwzIU6boA/2BHq7Gi4=;
        b=Tilw5nmQacwGSee2C6bQruDGkqY9VIQrlJedMX6nm3u8wfvPcOtxAEliI7vVjoBAccYKnn
        lYglJCfOgD1vBtCg==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Message-ID: <20210121152953.jbqsi5d3isaxskoz@linutronix.de>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
 <20200814115848.w4m2bfqttkid6woi@linutronix.de>
 <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
 <20200817111311.zyqjznhferoqqxkh@linutronix.de>
 <4265e04810b55bea4f52f3c0c5057b808dcac814.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4265e04810b55bea4f52f3c0c5057b808dcac814.camel@ginzinger.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-19 10:57:36 [+0000], Roosen Henri wrote:
> Sebastian, did you have a chance to bring up a duration test on your
> imx6q board? Are there any results from testing?

I just took your config from the thread and just bootet v5.4.84-rt47.
For some reason I have no network so I started hackbench in the
background, redirecting it to dev/null and recording serial showing
cyclictest.
I took the v5.4-tree as reported.

> Thanks,
> Henri

Sebastian
