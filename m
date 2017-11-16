From: Gene Heskett <gheskett@shentel.net>
Subject: trying to build rt kernel, fails quickly
Date: Thu, 16 Nov 2017 08:28:32 -0500
Message-ID: <201711160828.32811.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.147]:44623 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754009AbdKPN2i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Nov 2017 08:28:38 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda.cloud.shentel.net with ESMTP id zehD9cT5qh4p0i4L for <linux-rt-users@vger.kernel.org>; Thu, 16 Nov 2017 08:28:36 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 1F00C20617
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Nov 2017 08:28:36 -0500 (EST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings all;

I've had this downloaded for 2 or 3 weeks so its old.

Tried to build it on a rock64 just now, and got this:

rock64@rock64:/media/slash/home/rock64/4.11.12.rt15/linux-4.11$ time make
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --silentoldconfig Kconfig
  CHK     include/config/kernel.release
  UPD     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
"4.11.12-rt16--- localversion-rt +++ localversion-rt @@ -1 +1 @@ --rt15 
+-rt16" exceeds 64 characters
Makefile:1107: recipe for target 'include/generated/utsrelease.h' failed
make: *** [include/generated/utsrelease.h] Error 1

real    0m7.793s
user    0m4.585s
sys     0m2.396s
rock64@rock64:/media/slash/home/rock64/4.11.12.rt15/linux-4.11$ cat 
include/generated/utsrelease.h
#define UTS_RELEASE "4.11.12-rt16"

That doesn't look like 64+ chars.

What might be the real problem?

This is on the rock64, but is being built on a 1TB spinning rust drive 
plugged in and mounted at /media/slash.  This did build a 4.10.0-rc3 
just fine a month ago but its not been boot tested because I'm a 
greenhorn at u-boot. If there is a boot updater for it, I've not found 
it yet so its actually running an "ayufan" kernel, which is not real 
time. Original debian stretch install.

Looks like I need some help.

Thank you.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
