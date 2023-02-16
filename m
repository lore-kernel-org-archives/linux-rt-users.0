Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB02C636CC
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Feb 2023 22:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBPW3H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPW3G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2023 17:29:06 -0500
X-Greylist: delayed 119 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 14:29:04 PST
Received: from mwweb08oc.mail2world.com (mwweb08oc.mail2world.com [74.202.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12013CE11
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Feb 2023 14:29:04 -0800 (PST)
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Thu, 16 Feb 2023 14:27:04 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Thu, 16 Feb 2023 14:27:04 -0800
Message-ID: <1b046315-6dd4-bacc-4f3b-38b011bc0c82@shentel.net>
Date:   Thu, 16 Feb 2023 17:27:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     rt-users <linux-rt-users@vger.kernel.org>
Content-Language: en-US
From:   gene heskett <gheskett@shentel.net>
Subject: sorta related timer comment
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F18.63EEADB8.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 16 Feb 2023 22:27:04.0927 (UTC) FILETIME=[CC2C9EF0:01D94255]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sebastion;

I should probably point out that there is a group of linuxcnc users who 
depend on that 1 kilohertz thread while controlling their cnc machinery.
I personally have even used 4 kilohertz for the servo update loop but 
only on the faster intel cpu's. Older AMD's don't cut it.

We, several hundred of us planet wide, would not be well served if 250 
hz became the default, we could crash a machine because we couldn't stop 
it in time. To save hardware costs, we even use a 25 microsecond thread, 
but only allow integer math there, driving stepper motors directly in 
slower home hobby stuff.  We would be well served by arm64 stuff if it 
can be worked in. I am running a bigger lathe with an rpi4b, 2 gigs of 
dram but the kernel I'm using is now a 3 years old 4.19-preempt-rt for 
armhf getting long in the tooth now.

Take care & stay well all.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
  soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
  - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/>
