From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Cyclictest expected results
Date: Mon, 1 Oct 2007 01:14:00 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710010104160.5677@localhost.localdomain>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de> <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain> <20070930222629.GB23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48130 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbXI3XOI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Sep 2007 19:14:08 -0400
In-Reply-To: <20070930222629.GB23573@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 1 Oct 2007, Robert Schwebel wrote:
> On Mon, Oct 01, 2007 at 12:00:58AM +0200, Thomas Gleixner wrote:
> > > Can you post the output of /proc/timer_list?
> >
> > The output of /sys/devices/system/clocksource/clocksource0/available_clocksource
> > and a full boot log are more interesting.
> >
> > > > 2.6.23-rc8-rt1 :
> > > > WARNING: High resolution timers not available
> >
> > We need to know, why the box did not switch into high resolution timer
> > mode, which is not visible from the /proc/timer_list output.
> 
> Hmm, it would show which clock event devices are currently selected.

Right. But it does not tell us _why_.
 
> > > > T: 0 ( 2003) P:80 I:10000 C:  10000 Min:   1500 Act: 6129 Avg: 4502 Max:    7832
> > >
> > > That one should give you sane results.
> >
> > Those results _are_ sane for a non high resolution timer kernel.
> 
> Yup, sure. It's probably not what the original poster considered to be
> sane for a hrt realtime system :)

Well, it is not hrt enabled for whatever reason.

> On Mon, Oct 01, 2007 at 12:03:23AM +0200, Thomas Gleixner wrote:
> > On Sun, 30 Sep 2007, Robert Schwebel wrote:
> > ....
> > 
> > Please do not trim the CC list. 
> 
> Oh, sorry, no offense intended. I assumed you'd read your core mailing
> lists anyway :)

In general it's not a good idea to trim cc lists, but assumptions of
other peoples mail reading habits are definitely a _bad_ idea.

Thanks,

	tglx
