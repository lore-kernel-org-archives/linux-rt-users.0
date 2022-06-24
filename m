Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132BCCA473
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 14:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiFXOj3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiFXOj2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 10:39:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0E64780
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 07:39:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 16:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656081565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCUyCAW7QbtHoKM6NF6oJ9BrCBzUsH9pnjQtef5t6K0=;
        b=h6j1UFipe26+WQIryJHaVmLko7kosGc34spbeUCTGfrDFNgVoXMBx52SQMWj2untrz9X+W
        02GtAOcjFH11aYeIoWwj+5mA1Yc2mu1qCBNeBrrEYgtmEG0Nuo8ChQsknszdEHkJ4Xm9z0
        +TO9waXymgtsX7dz9VlMao/8uZfM4eda5S4Y23WD6Q1VVdKqdkfslqTBH07wumHFpf3riQ
        J6LesflNoNnbvTPpjOr7h8X2SFWM2f8fYHrrnfgJ5j0SDSIhahVBKH+ikS5o4AdjwmJjfK
        LvLz1NB18hgCxtX8crBq6vnq1aAGASj5XbiXfq11Wm9FHNLWIPDMvgVEEy9Mwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656081565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCUyCAW7QbtHoKM6NF6oJ9BrCBzUsH9pnjQtef5t6K0=;
        b=Fg+Qh+zYO38DzwHHfJfhzmaDJHdpNmtvklFNTwMPFjnDgMfBqo6qj6ZkurGiCjDniSpr60
        K5c9tLIYTkErKUDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>, RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
Message-ID: <YrXMnCDoO2QPD9np@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de>
 <87wnd616ds.fsf@jogness.linutronix.de>
 <87tu8a16bm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tu8a16bm.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-24 16:37:25 [+0206], John Ogness wrote:
> On 2022-06-24, John Ogness <john.ogness@linutronix.de> wrote:
> > As to this the actual problem reported in this thread, I believe this
> > patch solves it:
> >
> > https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com
> 
> There was a cleaner v2 later in the thread:
> 
> https://lore.kernel.org/lkml/20220609123319.17576-1-Jason@zx2c4.com

In that case v5.19-rc3-rt5 should no longer show it but I am still
confused why we need to disable interrupts within vsnprintf().

Sebastian
