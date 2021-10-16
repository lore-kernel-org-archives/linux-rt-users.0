Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47942C433F5
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224DA60EE3
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 18:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbhJPSr2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:47:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbhJPSr0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 Oct 2021 14:47:26 -0400
Date:   Sat, 16 Oct 2021 20:45:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634409910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AJ1K1diObXliPt5GMidoXZ2j9jOwkcBcqeEEWTr3R4=;
        b=ySeDAzlaCSB8htVqxGgUeDVW7yzGTx/HJtfYVxvkoWS1DvhLp5ji4CG7Tk4+uWPeg9CKP6
        F+/tv4OkEWEOc+/9zysO7Ex+1Tp9wwABhP27YayRVERYdTsq/C4dhMu8OWNCvMVzOzxx8i
        MixNmqClW9obrpZu8ETf009FaLhxnZ0hohliu5VkoPyN4KTAX/Jz10LihskCIhDwd6fAbY
        l7GMEGIVR302sIMnSzcVQIfwocuukrhAqmkeE05vFG9WnJX1IgLCtIa+uKQq46yQ9gLkFn
        OYQ7nasKsCnXbU8drTDj7UiCieJT6uD/1mwKstSUQ8pRftJkaMsTUAYQRh6++w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634409910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AJ1K1diObXliPt5GMidoXZ2j9jOwkcBcqeEEWTr3R4=;
        b=eYyezp0BMX9UohyS0ODiDCfx1UbtYwBJ/DIGq4+mD0Oicc9doTYY/Y4aCAYlzWOidWj57U
        pzr7KzxM99YwOLBA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Joseph Salisbury <josephtsalisbury@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Question About Patch Set Tracking
Message-ID: <YWsdtdBZNQG1h7iF@lx-t490>
References: <CAGHUO11bZYViip313Kid+yRyvF9pRU6ktuaqJB7XO=VFcHu_xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHUO11bZYViip313Kid+yRyvF9pRU6ktuaqJB7XO=VFcHu_xQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Oct 16, 2021, Joseph Salisbury wrote:
>
>               Each section in the series file appears to have a title.
> Is there a decoder ring or something similar to understand what the
> section titles mean?  For example, '# Applied upstream' is pretty
> obvious, and can be confirmed by looking at the mainline tree.
> However, I see sections such as '# Posted an applied', '#Posted', '#
> Post', etc.  How can one understand the meaning of these titles?
>

Well, 'Posted' is what it says.

For example the printk work, or "[PATCH net-next 0/9] Try to simplify
the gnet_stats and remove qdisc->running sequence counter.", at netdev,
etc., etc.

Maybe the mainline maintainers have no comments and it's merged as-is,
maybe some additions are requested and some development is pending or
in-progress, and so on.

> The best way to learn may be to write some documentation about the
> patch set.  I will search the wiki for some hints on activities in
> that regard.

The rate of change is really quite quick.

AFAIK Sebastian already updates the quilt series file for each -rcX-rt
development -rt release, so that's the latest "source of truth" you can
follow.

Any more details than what's in that series file, you can search the
patch subject lines at https://lore.kernel.org, which can recently do a
"global" search inside all subsystems mailing lists in one shot. This
will usually give you all the nitty-gritty details.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
