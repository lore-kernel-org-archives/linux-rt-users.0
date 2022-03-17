Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E35C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Mar 2022 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCQHLd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiCQHLd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Mar 2022 03:11:33 -0400
Received: from mwweb08oc.m2wprod.com (mwweb08oc.mail2world.com [74.202.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AC3616A6B0
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2022 00:10:15 -0700 (PDT)
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Thu, 17 Mar 2022 00:12:30 -0700
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Thu, 17 Mar 2022 00:11:30 -0700
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Thu, 17 Mar 2022 00:11:30 -0700
From:   gene heskett <gheskett@shentel.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: found linux-stable-rt-4.19.233-rt105-rebase
Date:   Thu, 17 Mar 2022 03:09:13 -0400
Message-ID: <2066930.VyunGXjrIA@coyote>
Organization: only accidental
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F1B.6232DE9B.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 17 Mar 2022 07:11:30.0276 (UTC) FILETIME=[39C61A40:01D839CE]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings rt-kernel-users;

I managed to trace thru git.kernel.org until I found the above rebase. 
Downloaded it, moved it to the rpi4, and unpacked it.

But to build it on an rpi4b for armhf, needs a bcm2711-defconfig, and it 
is not there in this tarball.

The newest I have on site is dated Jan 20, 2020 from a 4.19.y tarball.

I obviously got the wrong tarball, so where do I find the right tarball 
or git clone that will build on an rpi4b today?

I have since found this one:
<linux-stable-rt-d28ccbd42ce8c5b5d0b5f79160bfe0c5c98f9037.tar.gz>
Is this the one I need?

Thanks all.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis



