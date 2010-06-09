From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: At a loss: Kernel 2.6.19-rt15 with ixp425
Date: Wed, 09 Jun 2010 10:02:44 -0700
Message-ID: <1276102964.8203.7.camel@sven.thebigcorporation.com>
References: <20100608181752.GA19521@colorado.edu>
	 <1276022232.9420.17.camel@sven.thebigcorporation.com>
	 <20100608193204.GA13883@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Eric W Anderson <Eric.Anderson@Colorado.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37811 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab0FIRCx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jun 2010 13:02:53 -0400
Received: by pwj5 with SMTP id 5so1990902pwj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 10:02:52 -0700 (PDT)
In-Reply-To: <20100608193204.GA13883@colorado.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-06-08 at 13:32 -0600, Eric W Anderson wrote:
> Hi Sven,
> 
> The device manufacturer has made some kernel modifications to support their
> board, and those are specific to 2.6.19.  (In fact, they're specific to
> 2.6.19.2 OpenWRT patches).  There's also a large driver which is appropriate
> for an old kernel but would need some re-engineering to deal with API changes
> in 2.6.20 or 2.6.21, I believe.
> 
> So, if getting high-resolution timing with this kernel is going to be a
> nightmare, I can try taking on a newer kernel.  But it'll be an ordeal.
> 

Don't know really what to say.

With the device manufacturer not pushing / maintaining code upstream,
that sounds like a non-starter already. 

The ixp425 is supported by folks like MontaVista, maybe Wind River iirc.

The former has had some sort of HRT support for a long time, it might
get you the functionality you need.

But in any case, I'd try and walk the drivers forward, rather than try
to back-port HRT. 

You're unlikely to get much support for such an old Kernel if you run
into other issues, so the more up to date you can get, the better.

Good luck.

Sven

> -Eric
> 
> 
> Thus spake Sven-Thorsten Dietrich (thebigcorporation@gmail.com):
> 
> > On Tue, 2010-06-08 at 12:17 -0600, Eric W Anderson wrote:
> > > Hello All,
> > 
> > Hi Eric,
> > 
> > 2.6.19 is very very old.
> > 
> > What is preventing you from a Kernel upgrade?
> > 
> > Sven
> > 
> > 
> > > 
> > > I can't figure out (or haven't figured out) how to get actual high-resolution
> > > timers on the above platform.  I'm kind of stuck with 2.6.19, unfortunately.
> > > I've applied the -rt patch to stock 2.6.19, merged in some random patches to
> > > support my hardware, and gotten it to boot. But, here's what confuses me:  I
> > > have the hrtimer API, but my actual clock resolution is still shown as  10ms.
> > > 
> > >   root@patty:/# cat /proc/timer_list 
> > >   Timer List Version: v0.1
> > >   HRTIMER_MAX_CLOCK_BASES: 2
> > >   now at 2766685920305 nsecs
> > >   
> > >   cpu: 0
> > >    clock 0:
> > >     .index:      0
> > >     .resolution: 10000000 nsecs
> > >     .get_time:   ktime_get_real
> > >   active timers:
> > >    clock 1:
> > >     .index:      1
> > >     .resolution: 10000000 nsecs
> > >     .get_time:   ktime_get
> > >   active timers:
> > >    #0: <c4615ec8>, hrtimer_wakeup
> > >    # expires at 2766802147358 nsecs [in 116227053 nsecs]
> > >    #1: <c4615ec8>, it_real_fn
> > >    # expires at 2767494816966 nsecs [in 808896661 nsecs]
> > >    #2: <c4615ec8>, it_real_fn
> > >    # expires at 3642163204498 nsecs [in 875477284193 nsecs]
> > >    #3: <c4615ec8>, it_real_fn
> > >    # expires at 3643403169278 nsecs [in 876717248973 nsecs]
> > > 
> > > Additionally, I don't see CONFIG_HIGH_RES_TIMERS anywhere in my kernel
> > > menuconfig.  I've added a patch from Kevin Hilman and Milan Svoboda
> > > (http://lkml.indiana.edu/hypermail/linux/kernel/0607.1/2343.html) which
> > > purports to enable a high-resolution clock event source for this board, but
> > > that doesn't seem to change anything. 
> > > 
> > > I think I don't properly understand the preempt_rt / hrtimers /
> > > board-specific-bits ecosystem here.  What are the bits and pieces I need in
> > > order to have high-resolution timers on this platform?
> > > 
> > > Many, many thanks,
> > > Eric Anderson
> > > 
> > > 
> > 
> > 
> 


