Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611C4C77B60
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Apr 2023 08:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjD1Ivy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbjD1Ivb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6F4C34
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 01:51:26 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:51:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682671884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRoKpxv836uh4sbDOlcys2c1ItKv95+q85a/RSBk/kw=;
        b=r9wPJyZq4xFkf15U2iEIBCGd6BVDyPv0EpLHioPmYMY/wJqFl0dq67rRE0Ati/RxrexnwM
        srTA8VWDbxc1qFyZt61drZrAv+5WqWwobgEHkJFB7eqshrBmAgZEkM1I2ViB8FoQOWSEaI
        0AXZcLT2bWdZ71yk7B+oqZPQBP+gZFmLKRjfGtAwVKMX5ubkxQ/wCZXP96Y/VKhUIjC3VL
        q4KJ8mYbFNAJK9Hr2rDXb63JwfCHVgsRpAo+diQMfASd59OuuihOYPBfxwTKXG80E+eipg
        gVDJaxuOuy5EhqwQQDjg4RZWDeK7OQ+U7QmJzkmXVamX5wu2k69vj9/KUBEXjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682671884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRoKpxv836uh4sbDOlcys2c1ItKv95+q85a/RSBk/kw=;
        b=SzNxaNTXRKWyU647s6grjSQ98W0CO+DGGO2UiodONmkOmWanrXzFMOPu8i8d1yBzMvFhVY
        TcPtX3XpacHgJLDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rod Webster <rod@vmn.com.au>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al
 NIC
Message-ID: <20230428085123.HX02J4Ym@linutronix.de>
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-04-18 13:23:12 [+1000], Rod Webster wrote:
> Hi guys,
Hi,

> A number of PC's in use by our members have recently been experiencing
> excessive Real Time network latency since the 5.10 kernel and above.

Are you using the Preempt-RT patches?

> We are excited to see this seems to have been mostly resolved with the
> 6.3 kernel compiled from patched kernel.org source.

This would suggest you do not.

> But we are also experiencing excessive Real time network latency on
> some NIC hardware, mostly with  Realtek NIC's in this list.
> 
> https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
> Many modern industrial PC's are using Realtek NIC drivers that cannot
> be changed out so this is a problem for us.
> 
> It's our understanding that the R8169 kernel driver module should
> provide support for this hardware. It does indeed do this but real
> time network latency is unacceptable. Debian offers  a R8168-dkms
> driver.  I understand it is being deprecated in favor of the R8169
> kernel module driver.
> 
> Installing the R8168-dkms driver on the 6.3 kernel improves RT network
> latency/jitter by 400% over the R8169 driver.
> 
> We are users not kernel developers. How can we escalate this issue so
> acceptable RT performance is restored?

First we need to figure out if you are using PREEMPT_RT patchset and if
the problem is related to that. Depending on that we can try to analyse
it further.
If you do not use them and you started to experience the problem
starting v5.10 and only with that NIC it might be related to some
optimisations that this NIC is doing and the driver might have enabled
in v5.10 for instance. This might be batching of RX packets which can be
configured with ethtool (look for "coalesce").

> end
> -Regards
> -Rod Webster

Sebastian
