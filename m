Return-Path: <SRS0=sUiU=XF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D539C49ED7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45E2168B
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 19:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIJTBo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:01:44 -0400
Received: from barracuda2.shentel.net ([204.111.1.145]:50078 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726043AbfIJTBo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Sep 2019 15:01:44 -0400
X-ASG-Debug-ID: 1568142102-0ea5be49c22396e70001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda1.shentel.net with ESMTP id O4SKbHJbJ7F0AvFi for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 15:01:42 -0400 (EDT)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id AF8A71001F4
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 15:01:42 -0400 (EDT)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Date:   Tue, 10 Sep 2019 15:01:42 -0400
X-ASG-Orig-Subj: Re: [ANNOUNCE] v5.2.10-rt5
User-Agent: KMail/1.9.10
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de> <201909100733.16783.gheskett@shentel.net> <36472109.XBoHfvBAoT@ada>
In-Reply-To: <36472109.XBoHfvBAoT@ada>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201909101501.42282.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1568142102
X-Barracuda-URL: https://172.26.193.41:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 750
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76274
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday 10 September 2019 08:02:24 Alexander Dahl wrote:

> Hei hei,
>
> Am Dienstag, 10. September 2019, 07:33:16 CEST schrieb Gene Heskett:
> > No such file or directory?
>
> Go to https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/ and
> pick what you need.
>
> Or use the linux-rt-devel Git tree and look out for the tags
> 'v5.2.10-rt5' or 'v5.2.10-rt5-rebase'.
>
> HTH
> Alex

Got it, thanks Alex.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
