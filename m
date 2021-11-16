Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B5CC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234CD61B98
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhKPJpv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:45:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhKPJpu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 04:45:50 -0500
Date:   Tue, 16 Nov 2021 10:42:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637055772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fl90PGzBol4zySfKWQaaUTBGfFe1LZensjd8w+8c47U=;
        b=y6mK+Ew+PUaFKCyLl2eEiNNxWnuIntfhPCxQiKVwdwBb5cHWUosrVQtR8p8Je5DC5mXFxQ
        chg6NgCL+TX89teGfjIBxXa0f/xB/uAmW9Whxv/lYPDt0cnWKanBssR4r7UMpdxs7yhR5d
        qChn0IDKAOgHdlsr6DoplGFnbqzU1J1EbLBoXREfa9HOe4H0ygYfMtgUYQS42jossoOTaY
        nsRuXeTBHV+ID53ELoMUTlgt9yKcuB4WcRUOfuX/iJIAPuABueq0DFGWqmMcifSwxEa6ua
        ljF63dBzuXZMiQobjjy/8YJ0dZ2MbpSVuNKkou/qVZj/Rn8bIFyj4n+bqqifCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637055772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fl90PGzBol4zySfKWQaaUTBGfFe1LZensjd8w+8c47U=;
        b=Wqek87A4iaxXdTWH8Jr9Ih9Rjjfgk1V5NjCYZbtMou1DXDorBPlMN6fonb8OQJY4U/uKcS
        WdoAprKfnQJfksAw==
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        linux-rt-users@vger.kernel.org,
        'Thomas Gleixner' <tglx@linutronix.de>
Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Message-ID: <20211116094251.7nux2fwjn55pt5m5@linutronix.de>
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
 <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
 <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
 <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
 <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
 <5057a47c-dcdd-5420-9e09-7ade50553dd0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5057a47c-dcdd-5420-9e09-7ade50553dd0@suse.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-16 10:37:22 [+0100], Vlastimil Babka wrote:
> On 11/12/21 15:00, 'Sebastian Andrzej Siewior' wrote:
> > On 2021-11-05 10:41:40 [+0900], Chanho Park wrote:
> >> Hi,
> > Hi,
> > 
> >> I checked the same test on my aarch64 target. I'll do more realistic
> >> benchmark such as compile bench.
> >> 
> >> <5.10.73-rt54 aarch64>
> >> root@euto-v9-sadk:~# hackbench -l 10000
> >> Time: 24.994
> >> 
> >> <5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
> >> root@euto-v9-sadk:~# hackbench -l 10000
> >> Time: 31.372
> >> 
> >> <5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
> >> root@euto-v9-sadk:~# hackbench -l 10000
> >> Time: 35.269
> > 
> > The last two are equal, is that on purporse?
> 
> I see the first of last two is without SLUB_CPU_PARTIAL and the second with
> SLUB_CPU_PARTIAL, so not equal?

indeed. I didn't notice the missing o. Thanks!.

> > Any feedback on v5.14-rc3-rt1 and v5.14-rc3-rt2? v5.13-rt1 should be
> > identical to you 5.10 numbers.
> > 
> >> Best Regards,
> >> Chanho Park

Sebastian
