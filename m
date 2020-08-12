Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660BFC433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3822B20781
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5c7MUw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWDVxnDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHLPNN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:13:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPNL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 11:13:11 -0400
Date:   Wed, 12 Aug 2020 17:13:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597245189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCJiGTxrDLupMg+yO16LXfFAQR4TCNL4cbGhGUmaS3M=;
        b=E5c7MUw1hAOabGrMJkz+wUkYVb56y1C4pjThhNvYaG6Q8BgCxdbQ/Ni5NAIotJ4EdulYfu
        d6Mh+sUGSzLRCNKj/AVlPwX72cS4JldmQhwouevP++LzPFol6RE5PeujWW4mh77d4r370N
        vBHHnQkv1zmGZt1Sp886jsExRJdft+75MppzZ6B8gzIgucIorIsKI+6BH4cYsA/Z5QqUmV
        vhXZSalaX/k82WiW1BqS1esQMG89itxhJoL703lB0GPhdLwUuEgBQWOsCwskSha8Oes01t
        tTBUgdS5nqlho55R2+yMcYok5QPdqNIiDPO1VpSgf0ZNvzpWp2J8frTXeHln2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597245189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCJiGTxrDLupMg+yO16LXfFAQR4TCNL4cbGhGUmaS3M=;
        b=KWDVxnDT6R0PBhPUaht+xH0ck7102Z1DAAFSU8vI3t6hA23W9wEBpaSHasL5DhW8Bz4oVe
        Qeit6hPBPPLtAbBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     David Miller <davem@davemloft.net>, Jiafei.Pan@nxp.com,
        kuba@kernel.org, netdev@vger.kernel.org, claudiu.manoil@nxp.com,
        ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] enetc: use napi_schedule to be compatible
 with PREEMPT_RT
Message-ID: <20200812151308.rlbtrbxycxfu7tvi@linutronix.de>
References: <20200803201009.613147-1-olteanv@gmail.com>
 <20200803201009.613147-2-olteanv@gmail.com>
 <20200803.182145.2300252460016431673.davem@davemloft.net>
 <20200812135144.hpsfgxusojdrsewl@linutronix.de>
 <20200812143430.xuzg2ddsl7ouhn5m@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812143430.xuzg2ddsl7ouhn5m@skbuf>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-12 17:34:30 [+0300], Vladimir Oltean wrote:
> I expect the driver maintainers to have something to say about this. I
> didn't test on stable kernels, and at least for dpaa2-eth, the change
> would need to go pretty deep down the stable line.

Yes, each affected and maintained stable kernel. This would also ensure
that it is part stable-RT trees.

> Also, not really sure who is using the threadirqs option except for
> testing purposes.

Oh.

> Thanks,
> -Vladimir

Sebastian
