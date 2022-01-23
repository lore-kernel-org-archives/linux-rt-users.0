Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A25C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 Jan 2022 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiAWOkG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 Jan 2022 09:40:06 -0500
Received: from mwweb08oc.mail2world.com ([74.202.142.113]:58629 "EHLO
        mwweb08oc.m2wprod.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233561AbiAWOkG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 Jan 2022 09:40:06 -0500
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Sun, 23 Jan 2022 06:42:12 -0800
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Sun, 23 Jan 2022 06:42:10 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Sun, 23 Jan 2022 06:42:09 -0800
From:   gene heskett <gheskett@shentel.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
Date:   Sun, 23 Jan 2022 09:40:01 -0500
Message-ID: <8448352.jqPtiG1ysD@coyote>
Organization: only accidental
In-Reply-To: <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
References: <YcSgQY8lzb6MkQPx@linutronix.de> <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F16.61ED68C3.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 23 Jan 2022 14:42:10.0057 (UTC) FILETIME=[66D87F90:01D81067]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Friday, December 24, 2021 9:16:57 PM EST you wrote:
> On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> > 
> > I'm pleased to announce the v5.16-rc6-rt12 patch set.
> 
> > Changes since v5.16-rc6-rt11:
> ...
> 
> >   - The "Memory controller" (CONFIG_MEMCG) can be enabled again.
> 
> FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
> Full LTP with maximally bloated config was as uninteresting as one can
> hope for.
> .

Unforch and after many try's, I can't get it to reboot when installed, 
sorta, on an rpi4b.

I say sorta, because no matter how many times I rebuild it, the build 
does not generate an arch/arm/boot/dts/overlays directory.  The build 
itself is error free.

The raspi kernel build instructions from their somewhat dated wiki also 
say to use the bcm2711_defconfig, but it does not now exist in a git 
clone. And a hwinfo of the rpi4b says I should use the bcm2835_defconfig 
for a starter .config.

Is there any hope of making this work?

I have been using a 4.19 rt-preempt I built on a rpi4 running buster, 
driving 3/4 ton of 75 yo Sheldon lathe, and now I'm trying to help a guy 
at the west end of the country rig an rpi4b to run a good sized cinci 
mill. The pi4 has more than enough power to run LinuxCNC.

Thanks for any guidance.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>



