Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76AC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Jan 2022 04:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiAQEeP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 16 Jan 2022 23:34:15 -0500
Received: from mwweb08oc.mail2world.com ([74.202.142.113]:49481 "EHLO
        mwweb08oc.m2wprod.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229563AbiAQEeN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 16 Jan 2022 23:34:13 -0500
X-Greylist: delayed 1082 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jan 2022 23:34:13 EST
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Sun, 16 Jan 2022 20:17:52 -0800
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Sun, 16 Jan 2022 20:17:48 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Sun, 16 Jan 2022 20:17:48 -0800
From:   gene heskett <gheskett@shentel.net>
To:     linux-rt-users@vger.kernel.org
Subject: What replaces the 4.19.y scripts/mkknlimg in 5.16-rc6-rt12?
Date:   Sun, 16 Jan 2022 23:15:39 -0500
Message-ID: <19384294.dZ2EVBas6m@coyote>
Organization: only accidental
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F26.61E4ED6D.0007,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 17 Jan 2022 04:17:48.0535 (UTC) FILETIME=[2F8F6070:01D80B59]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings all;

That script/mkknlimg is missing in v5.16-rc6-rt2. What replaces it?

Or, can this script be copied to a v5.16-rc6-rt12 build and used?

Thanks a bunch, I'm trying to build a v5.16-rc6-rt12 on a rpi4 for the 
rpi4. The build itself was flawless.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>



