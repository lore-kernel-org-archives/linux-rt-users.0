Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A66AC67871
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Oct 2022 07:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiJ0HBl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiJ0HBe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Oct 2022 03:01:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACEE63FD0
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2022 00:01:31 -0700 (PDT)
Date:   Thu, 27 Oct 2022 09:01:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666854088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztr/WoAVyCzwfXOFI5zLxh/u/D/VVcswMhp7QMPcgXQ=;
        b=Ix4ByvUH/p3e6WeuprsXMvr3WRgYHWVyQ/NWuCvm8tVCPrwpaojleX65jNe0/Cuq97NRa3
        ApGX3HXjSYPw0EmpKJxDfm1t7Wvp5XVc11rtPiBpX8x5+ENAmUecpqUJXLuIAVrnoWFRer
        RhV3WREW5DnRehCe80d0+tLSczOVqH4JQxyPcyXPzf+oE4AKNv320Cazvl+Vdp8Xwqr9En
        KAAYz+4KapiCdpVa6h9Pym2uTc+SoN926BHeaSME+iGZhW6gs57lm5PJwKDhvnn7pyK2b5
        hO9/CBphhVqi0plWX+gLmarrk5M6c5A0LN/q6LIrAS1Au8Tdm+QI8TFnFy2KPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666854088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztr/WoAVyCzwfXOFI5zLxh/u/D/VVcswMhp7QMPcgXQ=;
        b=VBD5feJvZ+xV7E/mfCsMyt/8f/nadO+cLzQxOTrlGoeNFYd8ElbNyWOZf7J5LoZ5Fri9Me
        7/y4OSiheSp+2CCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: v6.0.3-rt12 does not compile (WAS: [ANNOUNCE] v6.1-rc2-rt1)
Message-ID: <Y1osx2Iw0qs3gWxu@linutronix.de>
References: <Y1lPqHjmytaSEnHn@linutronix.de>
 <Y1m0MXDKt0yqXdsu@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y1m0MXDKt0yqXdsu@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Please keep the list in Cc:

On 2022-10-27 00:26:45 [+0200], David Runge wrote:
> Hi Sebastian,

Hi David,

> I'm following the linux-rt development for the Arch Linux package [1].
> With 6.0.3-rt12 I have run into a bit of a pickle though.

I released it the other as the last one for the v6.0 series. Didn't
announce it officially since I made no RT relevant change.

> I'm seeing:
>=20
> ```
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function =E2=80=98a=
xienet_get_stats64=E2=80=99:
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1308:25: error: implici=
t declaration of function =E2=80=98u64_stats_fetch_begin_irq=E2=80=99; did =
you mean =E2=80=98u64_stats_fetch_begin=E2=80=99? [-Werror=3Dimplicit-funct=
ion-declaration]
>  1308 |                 start =3D u64_stats_fetch_begin_irq(&lp->rx_stat_=
sync);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                         u64_stats_fetch_begin
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1311:18: error: implici=
t declaration of function =E2=80=98u64_stats_fetch_retry_irq=E2=80=99; did =
you mean =E2=80=98u64_stats_fetch_retry=E2=80=99? [-Werror=3Dimplicit-funct=
ion-declaration]
>  1311 |         } while (u64_stats_fetch_retry_irq(&lp->rx_stat_sync, sta=
rt));
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                  u64_stats_fetch_retry
> ```

I addressed this for the v6.1 release, wasn't aware that it also managed
its way into the v6.0 series.

> Grepping for either =E2=80=98u64_stats_fetch_begin_irq=E2=80=99, or
> =E2=80=98u64_stats_fetch_retry_irq=E2=80=99 in the codebase, they are ind=
eed the only
> occurences of it in that file... which is strange.

Well, we are working on getting rid of this function. Upstream should
follow in ~v6.2.

> ```
> rg u64_stats_fetch_begin_irq
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 1308:           start =3D u64_stats_fetch_begin_irq(&lp->rx_stat_sync);
> 1314:           start =3D u64_stats_fetch_begin_irq(&lp->tx_stat_sync);
> ```
>=20
> If I check our own kernel or Greg's v6.0.3 tag there are plenty of
> occurences of the function all across the codebase, but not as soon as
> the patchset is merged.

There is
   0002-net-Remove-the-obsolte-u64_stats_fetch_-_irq-users.patch

which gets rid of drivers/net users and then there is
   u64_stat-Remove-the-obsolete-fetch_irq-variants.patch

which removes the API once all users are gone.

> When doing the release for 6.0.0-rt11 I already noticed a few missing
> options but was under the impression that they might be missing due to
> the realtime options disabling them. However, now it looks as if there
> are entire subsets missing oO
> Does the patchset drop a lot of network driver code and/or do the last
> occurences there also have to be removed?
> As is, I am unable to build v6.0.3-rt12.

I'm going to release -rt13 in a bit with this fixed.
There are few options like SLAB or TRANSPARENT_HUGEPAGE which are not
available on PREEMPT_RT for one reason or another. I try to avoid
dropping options if possible.

> Best,
> David

Sebastian
