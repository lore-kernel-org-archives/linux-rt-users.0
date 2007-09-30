From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Cyclictest expected results
Date: Mon, 1 Oct 2007 00:00:58 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:45428 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbXI3WjO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Sep 2007 18:39:14 -0400
In-Reply-To: <20070930183253.GW23573@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 30 Sep 2007, Robert Schwebel wrote:
> On Sun, Sep 30, 2007 at 09:07:19PM +0530, Jaswinder Singh wrote:
> > Here are my results on Intel Pentium 4 :
> >
> > Command line :  ./cyclictest -t 1 -p 80 -i 10000 -l 10000 -q
> 
> Can you post the output of /proc/timer_list?

The output of /sys/devices/system/clocksource/clocksource0/available_clocksource
and a full boot log are more interesting.

> > 2.6.23-rc8-rt1 :
> > WARNING: High resolution timers not available

We need to know, why the box did not switch into high resolution timer
mode, which is not visible from the /proc/timer_list output.

> > T: 0 ( 2003) P:80 I:10000 C:  10000 Min:   1500 Act: 6129 Avg: 4502 Max:    7832
> 
> That one should give you sane results.

Those results _are_ sane for a non high resolution timer kernel.

> > CONFIG_HIGH_RES_TIMERS=y are defined in .config then why I am getting
> > "WARNING: High resolution timers not available".

We need to look at the information I requested above. I'm not good in
witchcraft :)

	   tglx
