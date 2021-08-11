Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045AC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEF661058
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 12:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhHKMcB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhHKMb6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Aug 2021 08:31:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303FC029836;
        Wed, 11 Aug 2021 05:28:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3CyKvJaEwwphnaIVpCFl46BS2WMQuydG6Z8cqn8/sI=;
        b=Mk2d2aB9aImBYcA7SGIdR5B8V+7ToAlmLvva2lilX9fJ15PIGwsH/DLzqlnV4UQXoPynFX
        Cx89eyTyx9YI2H3S/Xfu+pal8SPg1YqSchb2ycdhLt6Vmc3AjiF6MeqE99nPYqPW4BIGOg
        BgGeWH+mvdf63Y8NG/IOASWAPzhBMlXFo/O8pxwjKcsng7W2MKhEyc0sys9on3bEWYcHSE
        WOe34U+S0ZEy7Wx9rgbMzewFNOZEn0xb+qJHYBD7sXVInmTTUJGxyt5BiNkhmUJkWBFgYz
        eXN2yqUd6g1GMpNNG662I5P9OIzrDgk4y6y/U3cuoDiNJYqX6WmqD5KfGRYn0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3CyKvJaEwwphnaIVpCFl46BS2WMQuydG6Z8cqn8/sI=;
        b=BSsIIwvRVuLmwPE6k7Z6GJb6pkJ7BpmY7Pcu7PKjdASNEOJUJQAoxA6q7STVlkNzYavErX
        zGQZmCIPdaNWZUCQ==
To:     Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down
 gic_reserve_range()
In-Reply-To: <87y2989xhh.wl-maz@kernel.org>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-3-valentin.schneider@arm.com>
 <87y2989xhh.wl-maz@kernel.org>
Date:   Wed, 11 Aug 2021 14:28:21 +0200
Message-ID: <87a6lop3mi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 11 2021 at 09:50, Marc Zyngier wrote:
> On Tue, 10 Aug 2021 14:41:26 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> The issue is that although the redistributor tables have been
> allocated ahead of time (outside of any cpuhp callback), they cannot
> be programmed into the RDs until the corresponding CPUs have been
> brought up (the registers may not be accessible).
>
> For the same reason, we don't know whether we can free them (because
> there is already a table programmed there) or have to reserve them
> with an efi_mem_reserve_persistent() call. efi_mem_reserve_iomem()
> uses GFP_ATOMIC for its allocation, but this is not sufficient for RT
> anymore.
>
> We could postpone the reservation of the memory to a later point (it
> is only useful for kexec), but it isn't clear where that point is. The
> CPU is not quite up yet, and we can't easily IPI the boot CPU to do
> the reserve call.

Right, but don't you know about the need for reservation _before_
bringing the CPU up?

Thanks,

        tglx
