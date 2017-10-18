From: Gene Heskett <gheskett@shentel.net>
Subject: best list to get building help?
Date: Wed, 18 Oct 2017 13:58:24 -0400
Message-ID: <201710181358.24263.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.146]:33422 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750955AbdJRR62 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Oct 2017 13:58:28 -0400
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda.cloud.shentel.net with ESMTP id TQ25oUQyWnvqJObP for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2017 13:58:26 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 6E6AC20341
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2017 13:58:26 -0400 (EDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings all;

I've pulled the tarball for your latest rt kernel yesterday, and I don't 
appear to be getting an installable build, building it of an r-pi3b.

I'd not be playing with this if the currently available rt kernels didn't 
have a huge gotcha, that of needing to be rebooted several times to get 
a working keyboard and mouse, it normally throws away a high percentage 
of both keyboard and mouse events.  And its also true for an ssh -Y 
login.

I am currently running:

 4.4.4-rt9-v7+ #7 SMP PREEMPT RT

And running about 1500 lbs of a cnc lathe with it using linuxcnc of 
course.

There are newer versions extant, but the keyboard/mouse problem got worse 
with the newer versions. This one is usable at about 20% of the bootups.  
No difference whether they are wired or wireless.

So where can I find a pi expert to help me build and install this newest 
4.13.7-rt1 version?

Thank you.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
