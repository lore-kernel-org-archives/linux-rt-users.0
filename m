From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Fri, 12 Jan 2018 17:41:07 -0500
Message-ID: <201801121741.07887.gheskett@shentel.net>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de> <201801090929.19444.gheskett@shentel.net> <20180112184200.aufikphsttb2zbqk@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:47986 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965236AbeALWlO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Jan 2018 17:41:14 -0500
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda1.shentel.net with ESMTP id wlpoyXsEsaZjo7iu for <linux-rt-users@vger.kernel.org>; Fri, 12 Jan 2018 17:40:59 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id DE8C021BD4
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Jan 2018 17:40:58 -0500 (EST)
In-Reply-To: <20180112184200.aufikphsttb2zbqk@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 12 January 2018 13:42:00 Sebastian Andrzej Siewior wrote:

> On 2018-01-09 09:29:19 [-0500], Gene Heskett wrote:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.gi
> > >t v4.14.12-rt10
> >
> > No such file or directory. Browsing the site, I am pulling
> > v4.14.y.rt10.tar.gz. Is this the correct file?
>
> forgot to push the tag. It has been done now and should show up in a
> few secs.
>
> Sebastian

I built the one I did pull, took a hair over 3 hours on a rock64, but I 
think I did not strip it to what the rock64 needed, so theres no doubt a 
bunch of gingerbread it will never use.
I have another Q floating around, about installing on a u-boot system. 

Seems to me with 4 gigs of ram, there ought to be room for grub, but I've 
read it will need a firmware update to change that, and I have not found 
one of those.  Hints gleefully checked out as my google-foo has been 
known to be bad in the past.

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
