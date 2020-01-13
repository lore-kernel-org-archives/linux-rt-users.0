Return-Path: <SRS0=eho5=3C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE235C33CA9
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Jan 2020 02:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45BA20678
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Jan 2020 02:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgAMCkH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:40:07 -0500
Received: from barracuda2.shentel.net ([204.111.1.145]:33497 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732487AbgAMCkH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Jan 2020 21:40:07 -0500
X-Greylist: delayed 1074 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 21:40:06 EST
X-ASG-Debug-ID: 1578882131-0ea5be4f80cbb0780001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda1.shentel.net with ESMTP id a9ZFCfClIpWUI2KO for <linux-rt-users@vger.kernel.org>; Sun, 12 Jan 2020 21:22:11 -0500 (EST)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 39A831001B6
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Jan 2020 21:22:11 -0500 (EST)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     "linux-rt-users" <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
Date:   Sun, 12 Jan 2020 21:22:10 -0500
X-ASG-Orig-Subj: Re: [ANNOUNCE] v5.4.10-rt5
User-Agent: KMail/1.9.10
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de>
In-Reply-To: <20200110201430.vl3sxiwntj5o4z74@linutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202001122122.10938.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1578882131
X-Barracuda-URL: https://172.26.193.41:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 1552
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79300
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Friday 10 January 2020 15:14:30 Sebastian Andrzej Siewior wrote:

> Dear RT folks!
>
> I'm pleased to announce the v5.4.10-rt5 patch set.
>
> Changes since v5.4.10-rt4:
>
>   - Dick Hollenbeck reported that the printk rework had a negative
>     impact on the 8250 driver if not used as a console. Patch by John
>     Ogness.
>
> Known issues
>      - None
>
> The delta patch against v5.4.10-rt4 is appended below and can be found
> here:
>
>     
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4
>.10-rt4-rt5.patch.xz
>
> You can get this release via the git tree at:
>
>    
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> v5.4.10-rt5

I grabbed a copy of this, then turned off anything not needed to run 
LinuxCNC on an rpi4 in armhf config.  Then I noted its make had a make 
deb-pkg option.  But it isn't making what I told it to make as I'm 
sitting here watching it ALL go by. Did I miss something in  a make 
menuconfig that triggered a make all? It was supposedly set for armhf.  
But I'm even seeing x86 stuff go by. Obviously I know just enough to 
screw it up. Point me at the right docs for arm builds please.

Thank you.
[...]

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
