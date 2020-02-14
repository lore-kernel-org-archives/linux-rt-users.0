Return-Path: <SRS0=/68O=4C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25DC2BA83
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 14:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE42217F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgBNOLj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:11:39 -0500
Received: from barracuda2.shentel.net ([204.111.1.145]:24059 "EHLO
        barracuda3.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729215AbgBNOLj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Feb 2020 09:11:39 -0500
X-ASG-Debug-ID: 1581689497-0ea5c051ba132d10001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda3.shentel.net with ESMTP id iiL1lv8ZwWFbYKgj for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2020 09:11:37 -0500 (EST)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 401C610243B
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2020 09:11:37 -0500 (EST)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Crash tool issue since printk re-implementation
Date:   Fri, 14 Feb 2020 09:11:36 -0500
X-ASG-Orig-Subj: Re: Crash tool issue since printk re-implementation
User-Agent: KMail/1.9.10
References: <PR2PR08MB4681072153BF9E79416BD305951B0@PR2PR08MB4681.eurprd08.prod.outlook.com> <20200214123431.rsgw62fftclifs3l@linutronix.de> <874kvtffoe.fsf@linutronix.de>
In-Reply-To: <874kvtffoe.fsf@linutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202002140911.36953.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1581689497
X-Barracuda-URL: https://172.26.193.43:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 1519
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79996
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Friday 14 February 2020 08:42:57 John Ogness wrote:

> On 2020-02-14, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > On 2020-02-12 12:10:23 [+0000], Sebastien Fabre wrote:
> >> Since kernel v5.0, PREEMPT_RT patches contain printk
> >> re-implementation. This re-implementation removes some log symbols
> >> in VMCOREINFO and crash tool cannot retrieve kernel logs (because
> >> symbols no more exist).  Is this impact on crash expected? If so,
> >> how can we retrieve a functional crash tool with kernel v5.0 (and
> >> following) ?
> >
> > It is known, yes. I'm aware of crash and the gdb scritps should also
> > suffer from this.
>
> Perhaps this should be listed under the "Known issues" of the
> PREEMPT_RT release announcements.
>
> John Ogness

I would like to agree, as I think that explains why an attempt to build 
5+ in this preempt-rt flavor, on an rpi4, for an rpi4 has been a no boot 
failure. 

Plus it appears I'd have to replace the bootloader because raspian puts 
the overlays in a /boot/overlays subdir whereas you are putting them 
in /boot (I think, I haven't found the .config magic twanger that puts 
them in the overlays subdir.)

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
