Return-Path: <SRS0=K+Cf=YC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA8C47404
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 07:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2420B7C
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJIHXz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:23:55 -0400
Received: from mail.thorsis.com ([92.198.35.195]:57054 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIHXz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Oct 2019 03:23:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id E36591D96;
        Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WXhAdvPmirQB; Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id C44664755; Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Gene Heskett <gheskett@shentel.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.72-rt25
Date:   Wed, 09 Oct 2019 09:23:49 +0200
Message-ID: <74795460.9uHKpU0Xat@ada>
In-Reply-To: <201910071516.04269.gheskett@shentel.net>
References: <20190916173921.6368cd62@gandalf.local.home> <201910071510.05101.gheskett@shentel.net> <201910071516.04269.gheskett@shentel.net>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Gene,

Am Montag, 7. Oktober 2019, 15:16:04 CEST schrieb Gene Heskett:
> On Monday 07 October 2019 15:10:05 Gene Heskett wrote:
> > Unfortunately, this does not work for the pi3-4 family. When its all
> > pulled in and patched, there is no arch/arm/configs bcm2709_defconfig
> > or bcm2711_defconfig for either a pi3b or the new pi4b.
> > 
> > I'll go find the 5.2.14 announce and see if its any more complete.
> 
> Its disappeared.

Not quite. Those were never (?) there. ;-)

You'll find those files in the raspberrypi tree [1], but not in mainline. 

It is possible to run a vanilla kernel on RPi 1 to 3, I guess the 
'multi_v7_defconfig' is a good start for 2 and 3. (This works, I have a 
running RPi 3 with unpatched mainline kernel on my desk, without RT however.)

IIRC from linux-arm-kernel list, basic support for RPi 4 is still under review 
and not yet present in mainline?

So you could try a RPi 2 or 3 with mainline + RT or you try to apply the RT 
patches to the vendor/raspberry tree, but I would not count on anyone 
supporting the latter.

HTH & Greets
Alex

[1] https://github.com/raspberrypi/linux

