Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda1.shentel.net ([204.111.1.144]:39911 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932830AbeGFNMG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Jul 2018 09:12:06 -0400
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda4.shentel.net with ESMTP id HFr7obpiAkZNTWHx for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2018 09:12:03 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 5EFBC21D6A
        for <linux-rt-users@vger.kernel.org>; Fri,  6 Jul 2018 09:12:03 -0400 (EDT)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] 4.14.52-rt34
Date: Fri, 6 Jul 2018 09:12:02 -0400
References: <20180629190320.6316b93b@gandalf.local.home>
In-Reply-To: <20180629190320.6316b93b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201807060912.02886.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Friday 29 June 2018 19:03:20 Steven Rostedt wrote:

> Dear RT Folks,
>
> I'm pleased to announce the 4.14.52-rt34 stable release.
>
> This includes the merging of the stable releases, but also required
> pulling in ("Revert mm/vmstat.c: fix vmstat_update() preemption BUG")
> because v4.14.45 pulled in commit c7f26ccfb2c3 ("mm/vmstat.c: fix
> vmstat_update() preemption BUG") which broke RT.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

not found

>   branch: v4.14-rt
>   Head SHA1: 71fbfbcfbcea9e6e5aa9dac068602f633dca5ad8
>
>
> Or to build 4.14.52-rt34 directly, the following patches should be
> applied:
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

also not found by wget, claims moved permanently.
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.52.xz
>
>  
> http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.52-
>rt34.patch.xz
>
I have attached a 60GB cheap ssd to a pi-3b by way of plugging in its 
usb-3 adapter cable to one of the 3b's usb-2 ports, and gave it 2 
working partitions, 49 GB of workspace, and 10+GB of swap in hopes that 
would stop the binutils explosions.  Seems to have worked, it built a 
previously pulled 4.14.y.rt.zip in about 8 hours.  But now I'd like to 
try the latest, but this doesn't seem to exist. Or should I just wait 
for the next announcement?

Thank you.
>
>
> Enjoy,
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
