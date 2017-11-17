From: Gene Heskett <gheskett@shentel.net>
Subject: Re: trying to build rt kernel, fails quickly
Date: Fri, 17 Nov 2017 13:13:41 -0500
Message-ID: <201711171313.41805.gheskett@shentel.net>
References: <201711160828.32811.gheskett@shentel.net> <20171117163155.GL872@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.144]:52107 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760101AbdKQSNq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Nov 2017 13:13:46 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda.cloud.shentel.net with ESMTP id BtoZHNPhOEzxTyh8 for <linux-rt-users@vger.kernel.org>; Fri, 17 Nov 2017 13:13:44 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 5E68F2033D
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Nov 2017 13:13:44 -0500 (EST)
In-Reply-To: <20171117163155.GL872@jcartwri.amer.corp.natinst.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 17 November 2017 11:31:55 Julia Cartwright wrote:

> On Thu, Nov 16, 2017 at 08:28:32AM -0500, Gene Heskett wrote:
> > Greetings all;
> >
> > I've had this downloaded for 2 or 3 weeks so its old.
> >
> > Tried to build it on a rock64 just now, and got this:
> >
> > rock64@rock64:/media/slash/home/rock64/4.11.12.rt15/linux-4.11$ time
> > make HOSTCC  scripts/kconfig/conf.o
> >   HOSTLD  scripts/kconfig/conf
> > scripts/kconfig/conf  --silentoldconfig Kconfig
> >   CHK     include/config/kernel.release
> >   UPD     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > "4.11.12-rt16--- localversion-rt +++ localversion-rt @@ -1 +1 @@
> > --rt15 +-rt16" exceeds 64 characters
>
> My suspicion is that your localversion-rt file in your working tree
> has a bizarre value, it should just contain "-rt16\n", instead it
> contains garbage which lookes like a patch/merge conflict.
>
> Can you check it's contents?
>
> I've checked the tags pushed to git, and they look just fine, so
> perhaps this is a leftover merge problem on your end?
>
>    Julia

Thanks for the reply Julia, but that is not the clanging bell, darn it.

rock64@rock64:/media/slash/home/rock64/4.11.12.rt15/linux-4.11$ cat localversion-rt
-rt16

rt15, FWIW, built just fine. An ls -l of that build directory shows a 
full build worked on Oct 17th 2017.

Thank you Julia.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
