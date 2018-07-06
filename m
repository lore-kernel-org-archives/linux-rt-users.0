Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda1.shentel.net ([204.111.1.144]:19237 "EHLO
        barracuda3.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932448AbeGFPRK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Jul 2018 11:17:10 -0400
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda3.shentel.net with ESMTP id byL8qhAVDLgNcQvt for <linux-rt-users@vger.kernel.org>; Fri, 06 Jul 2018 11:17:07 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id AC6BC21D6A
        for <linux-rt-users@vger.kernel.org>; Fri,  6 Jul 2018 11:17:07 -0400 (EDT)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] 4.14.52-rt34
Date: Fri, 6 Jul 2018 11:17:07 -0400
References: <20180629190320.6316b93b@gandalf.local.home> <201807060912.02886.gheskett@shentel.net> <20180706133737.mvv5lnryslh2m4dp@linutronix.de>
In-Reply-To: <20180706133737.mvv5lnryslh2m4dp@linutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201807061117.07204.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Friday 06 July 2018 09:37:37 Sebastian Andrzej Siewior wrote:

> On 2018-07-06 09:12:02 [-0400], Gene Heskett wrote:
> > On Friday 29 June 2018 19:03:20 Steven Rostedt wrote:
> > >  
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.g
> > >it
> >
> > not found
>
> Link is correct including tags and everything.
>
> > >   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz
> >
> > also not found by wget, claims moved permanently.
>
> this is correct http handling and this "moved permanently" is handled
> by wget just fine.
>
That didn't seem to be the case for the armhf jessie version of wget this 
morning. I'd copy/paste what I got, but found the 4.4.4 .config its 
running right now, and used it as seed for a make oldconfig. That took 
about 1:30, but its timing a new make right now, and the shell history 
isn't deep enough to access it.

The old, running kernel has a problem with local keyboard/mouse events, 
it likes to throw them away. Not at all good when it told 1500 lbs of 
machinery to move, but threw away the key up event that would/should 
have stopped it.

So I'm trying to build a kernel that doesn't do that. And frankly no clue 
what I should poke at, or the size stick I need to actually accomplish 
this.

I'll try to pull it again after this make is completed.

Thanks Sebastian.

> > previously pulled 4.14.y.rt.zip in about 8 hours.  But now I'd like
> > to try the latest, but this doesn't seem to exist. Or should I just
> > wait
>
> It does, I just verified everything step by step.
>
> > Thank you.
>
> Sebastian



-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
