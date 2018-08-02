Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lizzard.sbs.de ([194.138.37.39]:36869 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbeHBSoh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Aug 2018 14:44:37 -0400
Date: Thu, 2 Aug 2018 18:42:55 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: CONFIG_RT_GROUP_SCHED on RT
Message-ID: <20180802184255.75776464@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180802162201.uoa7w443wp3hgkba@linutronix.de>
References: <20180801145238.777d71a7@md1pvb1c.ad001.siemens.net>
        <20180802162201.uoa7w443wp3hgkba@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <cbe@osadl.org>, linux-rt-users@vger.kernel.org

Am Thu, 2 Aug 2018 18:22:02 +0200
schrieb Sebastian Andrzej Siewior <bigeasy@linutronix.de>:

> On 2018-08-01 14:52:38 [+0200], Henning Schild wrote:
> > Hi,  
> Hi,
> 
> > i just wanted to have a look at RT_GROUP_SCHED as a way to prevent
> > crashing real-time applications from starving other rt application,
> > in the case of prio based scheduling.
> > I had to find out that the feature is not compatible with PREEMPT_RT
> > and quickly traced it down to the following commit:
> > 
> > "sched: Disable CONFIG_RT_GROUP_SCHED on RT"
> > 
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulg/3.4-rt-patches/+/1b19454df58db731fa9ca09b34909d28d4eef968/patches/0133-sched-Disable-CONFIG_RT_GROUP_SCHED-on-RT.patch  
> 
> please use one of the two git trees in git.kernel.org if you refer to
> RT patches:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/rt/
> 
> Also, the v3.4 is very old and unsupported.

I am using 4.16 as well, just did not find the patch online to provide
a better link.

> > My current theory is that there never was a problem with the two not
> > being compatible ... it was more likely a broken userland, more
> > specific a broken cgroups setup.
> > Further my theory is, if you set cgroups up correctly both featues
> > can most likely be combined without a problem ... 
> > But maybe i am totally wrong and there are some reasons, in that
> > case the commit should be a little more verbose. And i would be
> > happy to hear about it.  
> 
> As far as I recall, that test case on that FC setup was the reason to
> disable it.
> 
> > On newer systems ... systemd is the reason ... fits the "works in
> > ssh but not in rc.local"  
> 
> So I have here v4.16.18-rt11 RT with RT_GROUP_SCHED enabled and I
> can't reproduce the issue anymore on Debian Sid with systemd 238. So
> either it does not setup the cgroups the same way it did (or FC still
> does) or the issue has been fixed in the meantime.
> Can you please test if this works as expected? I would be happy to
> revert the patch if there are no problems with it anymore.

I already reverted the patch on my side and did some testing. That
compiled when i wrote the first mail ;). If nobody sees a reason to
keep the restriction, it should be removed.

Henning

> > regards,
> > Henning  
> 
> Sebastian

