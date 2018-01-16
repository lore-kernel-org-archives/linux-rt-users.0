From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Mon, 15 Jan 2018 22:27:58 -0500
Message-ID: <201801152227.58933.gheskett@shentel.net>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:16074 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750764AbeAPD2E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Jan 2018 22:28:04 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda4.shentel.net with ESMTP id SILXjSttT2f1IpyF for <linux-rt-users@vger.kernel.org>; Mon, 15 Jan 2018 22:27:50 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id DADA422430
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jan 2018 22:27:49 -0500 (EST)
In-Reply-To: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 09 January 2018 07:34:33 Sebastian Andrzej Siewior wrote:

> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> v4.14.12-rt10

On 01/15/2018, this is still an instant failure from my place in West 
Virginia, USA.

rock64@rock64:/media/slash/home/rock64/Downloads$ 
git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git 
v4.14.12-rt10

-bash: 
git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git: No 
such file or directory

The git installed is: 2.11.0 if thats a clue.

uname -a on that machine is:
Linux rock64 4.4.77-rockchip-ayufan-130 #1 SMP Thu Sep 21 20:40:34 UTC 
2017 aarch64 GNU/Linux

Any clues why I can't pull it?

Thanks & Cheers

Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
