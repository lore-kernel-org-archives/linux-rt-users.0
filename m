Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC75C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0F61139
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351236AbhI3NZF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbhI3NZF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:25:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31BCC06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 06:23:22 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:23:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633008200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubt7Dyn2ia7Sjwlm5OxFhTrZK9kqm7t2AIU2ZnHh0Ko=;
        b=F7xHFGZ/wkj3q02CZ28D+e1lVPZciiVpnY69rTr2oiV725wXEJbdF2PzyP4kBlLH2FtSVV
        xhRsi4CrVQjEQn0DdoHCu6fZdQ+VHu8vdT7WmlYaE3O+ZpxyhqCOeWVvY7wLw7e8+g2kLq
        MxwDqp9gc+FojW2qytyMh9abzFxt+fYwBRrHGVmznhuscOYtWDGZKSJQHSWVVsc3rPdIiZ
        biE7ScIRcgGaxFpspP+wdT9u55rOOSOLaO2sqXzUrsOxVGMpddOVZE/M04ZtJNtzi5m9Ov
        /hs0jQthTzsyas/6CuGG8VbwEvLFCS3LOnwc9sNCKht08RkazBS0wSZJXgIG4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633008200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ubt7Dyn2ia7Sjwlm5OxFhTrZK9kqm7t2AIU2ZnHh0Ko=;
        b=1QXqMdnQUvBvvscJnYus/j5+qBEOiGRbI/wpQe8tl36EhvygkiEf/zI0F59/ujUowV6lIH
        TY+q3RjKY3uAsFAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
Message-ID: <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y27e53a2.fsf@stealth>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30 09:13:25 [+0900], Punit Agrawal wrote:
> With hackbench, the system is sufficiently busy to avoid the going into
> idle.

Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
effect that it may disable some of the PM stuff in the system.
So your system appears good but then when cyclictest is gone, the
numbers go up.

Maybe we should drop that so we observe a system without altering its
behaviour?

Sebastian
