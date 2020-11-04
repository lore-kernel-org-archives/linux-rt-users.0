Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864AC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A324621734
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNeH0q1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGeQ7q0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKDKqV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgKDKqU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 05:46:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C8C0613D3;
        Wed,  4 Nov 2020 02:46:20 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:46:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604486779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09RLIlu4eRNwQr+YG+b3M4fMv/3sjSer9rFdnjy8Xbk=;
        b=aNeH0q1cm7l0Cxzw7BF+xVN4SnC22nZPJ83vJP//9Crr6TZn9zdRs1CNkZ6nXH92pUlJhG
        BND/B8Nvzz3TG4ibLGr8uAgKwiHRAz+nwAmlca+UhgkXJfY3F3I8/EbTzxjXXetSfzPe18
        a/00YOYrCr1yKVmHgnf2hAcq2Qa0BQHumu5+V8wiWDQhuMv+LmezET9+uYufxts4slRijC
        iPJw6dL8PVXkIb35iQc7Jx5TOLVeHG5lav3/5CBxtWvv9pUlK1VYI9X+qTBUTkEcky80Cs
        2xT3+NYcAsAeoCYHr9peK/yhP57ieQG4gPm4PFH0DaEvFx0/qTiSEQV9+shpxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604486779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09RLIlu4eRNwQr+YG+b3M4fMv/3sjSer9rFdnjy8Xbk=;
        b=QGeQ7q0m1vH4Cc2baBuJMOOqLLacGGikzuTTajWpzCXxbtMZtDK7+5KoCXxPJydR3T+iPV
        zDtzOppzZinvwhDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-04 11:38:09 [+0100], Daniel Wagner wrote:
> On Tue, Nov 03, 2020 at 08:57:31PM +0100, Sebastian Andrzej Siewior wrote:
> > I'm pleased to announce the v5.10-rc2-rt4 patch set.
> 
> All tests on passed in my lab. On arm64 and arm I saw slightly higher
> max latency values for signaltest and sigwaittest. Usually they are
> below 200us but currently I see up to 350us.

How reproducible are these numbers? If these numbers increase between
rt3 and rt4 then we have a hand full patches to look at.
 
> BTW, x86_64 also showed slightly higher numbers for signaltest for the
> v5.10-rc1-rt1 release. These are gone now.

just like that?

Sebastian
