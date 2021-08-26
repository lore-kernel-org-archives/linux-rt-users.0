Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558AC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98BC6101C
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhHZO6I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:58:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZO6I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 10:58:08 -0400
Date:   Thu, 26 Aug 2021 16:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629989839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqNQV6IZu+Z6S1b/C9OL1Xo3Rhb4iqS/07nuy9GsgTs=;
        b=iaI1+ivJR/MlxGSo6pAzz3a0YlFEMqpHcvptzPGubtiH98yF5OJes4BSzGd6lm0Y868/X4
        cvt3WJeqZYgMMo9zVQp73dEZAbqb7i+Ng11kW+sfDS5ceqs2rhhPuZTzl7pj3eR8XWSwW1
        03gD6a9iUR815bB/glA4xkK7ITWlARuiS66kcpXLNGNowyiCjbm7QKOsa/qPhpChsCQCN6
        AhdQkKJR3jECGhhMxXZeKgz3TQjREGd0peLxXBO4+yYuzXtO8RZ9GrEE5q9MxI1k5nFjkF
        rT6LrJN22z7NUF9zkRKg5AbZjclrTFMuTyzhuXIyHCLSuzS1B8yJDikNjmA0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629989839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqNQV6IZu+Z6S1b/C9OL1Xo3Rhb4iqS/07nuy9GsgTs=;
        b=QIuXJz3Rqx4N2TrJBYsCChnz/8raeIqYcOqpZxRdIS1S6Wh1cjdUvsWYF3WuIHLTYWwp8e
        SEl0BldwmUW6lxBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
Message-ID: <20210826145718.3jwe2ndlfu3nveqw@linutronix.de>
References: <70cc66840bbd9446061fc40088575565d8d98e37.camel@gmx.de>
 <b8a39e05-696a-d459-c651-a3415bc09886@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8a39e05-696a-d459-c651-a3415bc09886@suse.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-24 13:14:52 [+0200], Vlastimil Babka wrote:
> On 8/24/21 13:08, Mike Galbraith wrote:
> > 
> > local_lock_t becoming a synonym of spinlock_t had consequences for the RT
> > mods to zsmalloc, which were taking a mutex while holding a local_lock,
> > inspiring a lockdep "BUG: Invalid wait context" gripe.
> > 
> > Converting zsmalloc_handle.lock to a spinlock_t restored lockdep silence.
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> BTW, does anyone really run zswap on a RT system?

The bit spinlock is problematic for RT and needs a replacement. Having a
page not available in RT is a no no. But then it might be a good
testcase if mlock() has been setup properly :) But other than that, I
can't imagine a real use case.

I'm going to apply that patch for the time being.

Sebastian
