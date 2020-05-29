Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA8C433E2
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 13:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284A320723
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgE2NbJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgE2NbJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 09:31:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A675C03E969;
        Fri, 29 May 2020 06:31:09 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jef6J-0005Dk-CF; Fri, 29 May 2020 15:31:07 +0200
Date:   Fri, 29 May 2020 15:31:07 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: linux-rt stall on imx6dl on patch-5.4.22-rt13.patch
Message-ID: <20200529133107.y65eta5btvgpk6pu@linutronix.de>
References: <CAOf5uw=DU4KdLXt=VEU+Uv3+W3jUMXE393FO3_v2smScR6Xf-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOf5uw=DU4KdLXt=VEU+Uv3+W3jUMXE393FO3_v2smScR6Xf-Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-29 10:08:01 [+0200], Michael Nazzareno Trimarchi wrote:
> Hi all
Hi,

> I get this stack trace
> echo 3 > /proc/sys/vm/drop_caches chrt -f 99 sysbench --test=cpu --num-threads=2
> 
> First of all, I need to know that if it is a valid use case because
> was raised by the testing team and
> how can I start and where to take a look at it

Assuming that there is a `;' in front of `chrt' then I wouldn't be
surprised. You are basically keeping two CPUs busy with sysbench at RT
priority and then wondering why the system isn't making any progress. If
it wouldn't be for the RT throttler, you might not even see any output
and box hardware would appear be dead.

> Best Regards
> Michael
> 
> [  161.709260] 001: sh (480): drop_caches: 3
> [  180.234358] 001: sched: RT throttling activated
> [  180.283363] 001: fec 2188000.ethernet eth0: MDIO read timeout
> [  180.283406] 001: ------------[ cut here ]------------
> [  180.283416] 001: WARNING: CPU: 1 PID: 133 at
> drivers/net/phy/phy.c:716 phy_er
> 
>                                                ror+0x24/0x64
> [  180.283460] 001: Modules linked in:
> [  180.283473] 001: CPU: 1 PID: 133 Comm: kworker/1:2 Tainted: G
>  W

This is hard to read. Especially later in that mail. In future please
try to not cut the lines.

Sebastian
