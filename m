Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86DC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8024A6145A
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 12:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhENMMa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 May 2021 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMM3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 May 2021 08:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B0C061574;
        Fri, 14 May 2021 05:11:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620994274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIAwkD/jRzI9tC6KpHVIn53v9oWTFSTWOyb/GzU2URA=;
        b=vs3d2hBAHPz+s3SkCdp49kBQ9AJlmMPPY1BjwONhFLr8Za0eeVPpTAcYiaiy+jk4dUBcMo
        D/ecmSSPHeuZjJrJ5xccG8frzfi8YYHKj5TjR/dDMzzrekSgHvlR4ICNarQwgIXTUHmk56
        XDVZGnQu20WJK6drvJgfCXZ+O1HGWJi4wts1qlfVhMZlTf+GWXsWrIDqi7UbXM2IYBwgnY
        XT5BGhPArFXuOPSEtAcrujJg+oz6VRgrSz2sUb97W2fQrBDYiBckzdY00GhvpWFp67d2cW
        Y2P7sMUfPAOPlozP1TCbdCxXGf3kdMPYj8nX/79MfHet6DGI+rbhzeq7f/7c0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620994274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIAwkD/jRzI9tC6KpHVIn53v9oWTFSTWOyb/GzU2URA=;
        b=RWhoIMBAOhBd6Kk2dUlpsilPoVPt/uR15qt+FmID1P2YWS4msPRP0Qb40Kxif0Xk+L0qQk
        4cpbjXQXohYNq/AQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH net-next] net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT
In-Reply-To: <20210513124310.1d8b33f0@gandalf.local.home>
References: <YJofplWBz8dT7xiw@localhost.localdomain> <20210512214324.hiaiw3e2tzmsygcz@linutronix.de> <87k0o360zx.ffs@nanos.tec.linutronix.de> <20210512205046.7eabe8fc@oasis.local.home> <20210513124310.1d8b33f0@gandalf.local.home>
Date:   Fri, 14 May 2021 14:11:13 +0200
Message-ID: <87zgwx4ise.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 13 2021 at 12:43, Steven Rostedt wrote:
> On Wed, 12 May 2021 20:50:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Thu, 13 May 2021 00:28:02 +0200
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> > No matter which variant we end up with, this needs to go into all stable
>> > RT kernels ASAP.  
>> 
>> Is this in rt-devel already?
>> 
>> I'll start pulling in whatever is in there.
>
> I don't see this in the rt-devel tree. The stable-rt releases always pull
> from there (following the stable vs mainline relationship).
>
> Is there going to be a new rt-devel release?

Once we have time to work on it.

The patch got applied to net-next, so please pick it up from there.

Thanks,

        tglx
