Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFEC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 05:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D58423122
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 05:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhAVFd3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 00:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAVFd0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 00:33:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50262C06174A;
        Thu, 21 Jan 2021 21:32:46 -0800 (PST)
Date:   Fri, 22 Jan 2021 06:32:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611293564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpop0D8s8nOkm9rdOZPW1e/bZ7HTuTOJtdfsGUyL5BI=;
        b=SglP/ud0Rlh5BIhnLdj41nuNgqK0WNPyKV/f6xkDKtq00Vy6AnrzDNlA+x86vSrnkWFLR4
        EIKGJoJIIms/LWkwcan8//MRqg6qS9BQYxQMR62uJBKJPaKQmFQFJL1UoCmIC4+QzYLY//
        NGBasA4LNG++ZhqPkJVf9nm1x97ldRbJ5FTkcohWAOYOHFD0Wr+F0CAuImvLPy4n0dyPSU
        WY1w8T9itCwc6My6tSayrrTq2bj2uvB0I3q1fGL5OmZqmA13elgHIOB7WOk3+4yx+yiL1A
        8m0OlC6mvdlId+MePUUU0kd0F0Wqpifi5VSXg9Rv8gTZn7LDLCkymAC39pz8mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611293564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpop0D8s8nOkm9rdOZPW1e/bZ7HTuTOJtdfsGUyL5BI=;
        b=UETyxT9V57QK+YQNu16L1bE56S7jPGyUg+nHfMNOapvm47nLZ+8VMWZNGTtHpvEKZO4EOH
        6s8bixWXRQasSXDw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.11-rc4-rt1
Message-ID: <YApjeinzJWKYNbYb@lx-t490>
References: <20210121134509.bagsesi4vdtwmdky@linutronix.de>
 <20210121205008.GA7149@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121205008.GA7149@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 21, 2021 at 09:50:08PM +0100, Pavel Machek wrote:
> Hi!
>
> > I'm pleased to announce the v5.11-rc4-rt1 patch set.
> >
> > Changes since v5.10.8-rt24:
> >
> >   - Updated to v5.11-rc4
> >
> > Known issues
> >      - kdb/kgdb can easily deadlock.
> >      - kmsg dumpers expecting not to be called in parallel can clobber
> >        their temp buffer.
> >      - netconsole triggers WARN.
>
> I noticed... lot of code using in_interrupt() to decide what to do is
> making it to 5.10-stable at the moment (and I guess that means
> vanilla, too).
>
> I have recollection that that is not okay thing to do. Am I right?
>

Correct. These macros should not be added to new, non-core, kernel code.

There's an on-going effort to clear them already, as in:

  - https://lkml.kernel.org/r/20201019100629.419020859@linutronix.de		(merged)
  - https://lkml.kernel.org/r/20201126132952.2287996-1-bigeasy@linutronix.de	(merged)
  - https://lkml.kernel.org/r/20210118100955.1761652-1-a.darwish@linutronix.de	(to be merged)

> Examples: 8abec36d1274bbd5ae8f36f3658b9abb3db56c31,
> d68b29584c25dbacd01ed44a3e45abb35353f1de.
>

That's sad.

Maybe it would be wise to let a bot scan lore regularly, and send an
automatic notification to authors whenever their patches reintroduce
these macros to non-core kernel code.

Thanks,

--
Ahmed S. Darwish
