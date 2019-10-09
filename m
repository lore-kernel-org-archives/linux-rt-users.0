Return-Path: <SRS0=K+Cf=YC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C8C47404
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E02133F
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Oct 2019 10:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIKV6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:21:58 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:42980 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbfJIKV6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Oct 2019 06:21:58 -0400
X-ASG-Debug-ID: 1570616516-0ea5c16c433c59b50001-YwjLzG
Received: from mta-out2.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda4.shentel.net with ESMTP id RN7TuKpX9q8FXSmd for <linux-rt-users@vger.kernel.org>; Wed, 09 Oct 2019 06:21:56 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out2.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 2CF981D
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Oct 2019 06:21:56 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] 4.19.72-rt25
Date:   Wed, 9 Oct 2019 06:21:55 -0400
X-ASG-Orig-Subj: Re: [ANNOUNCE] 4.19.72-rt25
User-Agent: KMail/1.9.10
References: <20190916173921.6368cd62@gandalf.local.home> <201910071516.04269.gheskett@shentel.net> <74795460.9uHKpU0Xat@ada>
In-Reply-To: <74795460.9uHKpU0Xat@ada>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201910090621.55733.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1570616516
X-Barracuda-URL: https://172.26.193.44:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 2527
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 1.00
X-Barracuda-Spam-Status: No, SCORE=1.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=BSF_SC1_TG070, WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77242
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
        0.50 BSF_SC1_TG070          Custom Rule TG070
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wednesday 09 October 2019 03:23:49 Alexander Dahl wrote:

> Hello Gene,
>
> Am Montag, 7. Oktober 2019, 15:16:04 CEST schrieb Gene Heskett:
> > On Monday 07 October 2019 15:10:05 Gene Heskett wrote:
> > > Unfortunately, this does not work for the pi3-4 family. When its
> > > all pulled in and patched, there is no arch/arm/configs
> > > bcm2709_defconfig or bcm2711_defconfig for either a pi3b or the
> > > new pi4b.
> > >
> > > I'll go find the 5.2.14 announce and see if its any more complete.
> >
> > Its disappeared.
>
> Not quite. Those were never (?) there. ;-)
>
> You'll find those files in the raspberrypi tree [1], but not in
> mainline.
>
> It is possible to run a vanilla kernel on RPi 1 to 3, I guess the
> 'multi_v7_defconfig' is a good start for 2 and 3. (This works, I have
> a running RPi 3 with unpatched mainline kernel on my desk, without RT
> however.)
>
> IIRC from linux-arm-kernel list, basic support for RPi 4 is still
> under review and not yet present in mainline?
>
> So you could try a RPi 2 or 3 with mainline + RT or you try to apply
> the RT patches to the vendor/raspberry tree, but I would not count on
> anyone supporting the latter.
>
> HTH & Greets
> Alex
>
Its being done by at least 3 people on the lcnc forum right now, but they 
are also using an ethernet interface, which it will cost me around $250 
to swap to, AND cost me my net connection. Thats not going to happen if 
I can help it, spi is working quite well on the pi3's. Bertho has it 
working on the pi4's he thinks but I'm the only one running that 
hardware so its up to me to prove it.

But my push right now is to get the new, 40x faster video available in 
later stretch, working with lcnc on the pi3. I can't touch buster 
because of the wayland virus.

Once thats done, then putting in the pi4 with only the hm2_rpspi.so 
update should get it working with the pi4. One step at a time IOW. The 
pi4 is powered up, and theoreticly all I have to do is change the 
default rt defconfig from a bm2709 to a bcm2711, build and install. 
Theoretically...  Damn thats a big word ;-)

Thanks Alexander.

> [1] https://github.com/raspberrypi/linux


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
