Return-Path: <SRS0=sUiU=XF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DBC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53C21019
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 11:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfIJLuH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:50:07 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:45064 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbfIJLuG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Sep 2019 07:50:06 -0400
X-Greylist: delayed 1007 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 07:50:06 EDT
X-ASG-Debug-ID: 1568115197-0ea5c115ff6c1d9d0001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda4.shentel.net with ESMTP id 7pK1qGLuBBjU9tQz for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 07:33:17 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 2B9B11001F4
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 07:33:17 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     "linux-rt-users" <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Date:   Tue, 10 Sep 2019 07:33:16 -0400
X-ASG-Orig-Subj: Re: [ANNOUNCE] v5.2.10-rt5
User-Agent: KMail/1.9.10
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
In-Reply-To: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201909100733.16783.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1568115197
X-Barracuda-URL: https://172.26.193.44:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 1292
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76259
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday 27 August 2019 06:55:42 Sebastian Andrzej Siewior wrote:

> Dear RT folks!
>
> I'm pleased to announce the v5.2.10-rt5 patch set.
>
> Changes since v5.2.10-rt4:
>
>   - Take care of compile issue within the timer-atmel-tcb driver on
>     AT91. Reported by Alexander Dahl, patched by Alexandre Belloni.
>
>   - Fixes to the hrtimer code to finally avoiding warnings while
>     canceling a running hrtimer in IRQ context. Patches by Julien
> Grall.
>
> Known issues
>      - rcutorture is currently broken on -RT. Reported by Juri Lelli.
>
> The delta patch against v5.2.10-rt4 is appended below and can be found
> here:
>
>     
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2
>.10-rt4-rt5.patch.xz
>
> You can get this release via the git tree at:
>
>    
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> v5.2.10-rt5

No such file or directory?

Thanks for any clarification.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
