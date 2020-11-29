Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B0C3E8C5
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 11:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EC0207BC
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Nov 2020 11:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="pWeETqbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgK2LaH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Nov 2020 06:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgK2LaH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Nov 2020 06:30:07 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CAFC0613CF;
        Sun, 29 Nov 2020 03:29:26 -0800 (PST)
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 197798B3B96;
        Sun, 29 Nov 2020 12:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606649363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sF8XCvJqTkyy+3B7MTwnlGdMjCa6TL1aBnFxb7P7jys=;
        b=pWeETqbI5g8QRDYwiq37mZkwL4JUnHA2rLrJ52YB8p5uBwt/wVaHqFaLTIC0MoO0cUWZvZ
        v7QjUoHaVuQXkzomeVl87agmzkzVM2xJNm2BJXMDJ+Z9MFQYxSNBRLnQACvFgUbBwqEqct
        h/E/TQpofgl189N0U6cY3X59Umx4l58=
Date:   Sun, 29 Nov 2020 12:29:22 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201129112922.db53kmtpu76xxukj@spock.localdomain>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
 <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
 <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
 <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Nov 29, 2020 at 11:56:55AM +0100, Mike Galbraith wrote:
> On Sun, 2020-11-29 at 10:21 +0100, Mike Galbraith wrote:
> > On Sun, 2020-11-29 at 08:48 +0100, Mike Galbraith wrote:
> > > On Sun, 2020-11-29 at 07:41 +0100, Mike Galbraith wrote:
> > > > On Sat, 2020-11-28 at 15:27 +0100, Oleksandr Natalenko wrote:
> > > > >
> > > > > > > Shouldn't the list manipulation be protected with
> > > > > > > local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
> > > > >
> > > > > Totally untested:
> > > >
> > > > Hrm, the thing doesn't seem to care deeply about preemption being
> > > > disabled, so adding another lock may be overkill.  It looks like you
> > > > could get the job done via migrate_disable()+this_cpu_ptr().
> > >
> > > There is however an ever so tiny chance that I'm wrong about that :)
> >
> > Or not, your local_lock+this_cpu_ptr version exploded too.
> >
> > Perhaps there's a bit of non-rt related racy racy going on in zswap
> > thingy that makes swap an even less wonderful idea for RT than usual.
> 
> Raciness seems to be restricted to pool compressor.  "zbud" seems to be
> solid, virgin "zsmalloc" explodes, as does "z3fold" regardless which of
> us puts his grubby fingerprints on it.
> 
> Exploding compressors survived zero runs of runltp -f mm, I declared
> zbud to be at least kinda sorta stable after box survived five runs.

Ummm so do compressors explode under non-rt kernel in your tests as
well, or it is just -rt that triggers this?

I've never seen that on both -rt and non-rt, thus asking.

-- 
  Oleksandr Natalenko (post-factum)
