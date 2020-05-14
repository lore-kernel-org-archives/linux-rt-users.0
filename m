Return-Path: <SRS0=z+Xj=64=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411AC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 May 2020 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB95F20575
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 May 2020 16:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgENQuM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 May 2020 12:50:12 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:19414 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726184AbgENQuM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 May 2020 12:50:12 -0400
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 12:50:11 EDT
X-ASG-Debug-ID: 1589473838-0ea5c168064592df0001-YwjLzG
Received: from mta-out2.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda4.shentel.net with ESMTP id ewSbhf9urOFe9vWF for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2020 12:30:38 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out2.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id 3C755D
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2020 12:30:38 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     "linux-rt-users" <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 5.4.40-rt24
Date:   Thu, 14 May 2020 12:30:37 -0400
X-ASG-Orig-Subj: Re: [ANNOUNCE] 5.4.40-rt24
User-Agent: KMail/1.9.10
References: <20200514104356.57de2ebe@gandalf.local.home>
In-Reply-To: <20200514104356.57de2ebe@gandalf.local.home>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202005141230.37924.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1589473838
X-Barracuda-URL: https://172.26.193.44:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 1222
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81848
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thursday 14 May 2020 10:43:56 Steven Rostedt wrote:

Am I to assume that r-pi support has been deleted?
There are no default bcm configs in the arch tree.
> Dear RT Folks,
>
> I'm pleased to announce the 5.4.40-rt24 stable release.
>
>
> This release is just an update to the new stable 5.4.40 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v5.4.40-rt
>   Head SHA1:
>
>
> Or to build 5.4.40-rt24 directly, the following patches should be
> applied:
>
>   http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.40.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.40.xz
>
>  
> http://www.kernel.org/pub/linux/kernel/projects/rt/5.4.40/patch-5.4.40
>-rt24.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
