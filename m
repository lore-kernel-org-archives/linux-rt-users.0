Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FAC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Mar 2022 12:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiCIMaH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCIMaG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Mar 2022 07:30:06 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 04:29:05 PST
Received: from mwweb08oc.m2wprod.com (mwweb08oc.mail2world.com [74.202.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC734BFC7
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Mar 2022 04:29:04 -0800 (PST)
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Wed, 9 Mar 2022 04:30:16 -0800
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Wed, 9 Mar 2022 04:29:14 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Wed, 09 Mar 2022 04:29:14 -0800
From:   gene heskett <gheskett@shentel.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: dirty-pipe ?
Date:   Wed, 09 Mar 2022 07:26:58 -0500
Message-ID: <2658635.4HAHC1xCac@coyote>
Organization: only accidental
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F24.62289D14.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 09 Mar 2022 12:29:14.0604 (UTC) FILETIME=[49B1B2C0:01D833B1]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings all;

Is this kernel vulnerable?
4.19.71-rt24-v7l+ #1 SMP PREEMPT RT Thu Feb 6 07:09:18 EST 2020 armv7l 
GNU/Linux

If so, link to update patch please

Thank you.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis



