From: Gene Heskett <gheskett@shentel.net>
Subject: Status of latest vulnerability fixes vs these kernels?
Date: Fri, 12 Jan 2018 09:22:54 -0500
Message-ID: <201801120922.54247.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:32269 "EHLO
        barracuda2.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933738AbeALOWv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Jan 2018 09:22:51 -0500
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda2.shentel.net with ESMTP id EO7uKvHs7a4J30RR for <linux-rt-users@vger.kernel.org>; Fri, 12 Jan 2018 09:22:45 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 49B5121BDF
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Jan 2018 09:22:45 -0500 (EST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Rather curious as I have a couple armhf and arm64 boards to update an rt 
kernel for. But until this last huge flaw is fixed, I don't want to do 
it 20+ times.

One is a pi, and its running a cnc lathe, the other is a rock64 which I 
intend to replace the pi with at some point since the best kernel we've 
found runs the machine well, but throws away keyboard events. Dangerous 
when its a key up it throws away...

I've been building on the rock64, your last took about 3 hours, but its 
u-boot makes it dicey to upgrade w/o plenty of u-sd rams to write in a 
usb adapter.

So will there ever be a simple "make install" to update a u-boot machine 
with?

Thanks everybody.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
