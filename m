From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 17:42:02 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710081734200.25146@localhost.localdomain>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>  <20070930183253.GW23573@pengutronix.de>  <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain>  <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com>
 <20071002065451.GM23573@pengutronix.de>  <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>  <20071008140650.GJ23573@pengutronix.de> <1985e0f60710080809k5f0e029ah27750ee01c87dee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60529 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbXJHPmT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 11:42:19 -0400
In-Reply-To: <1985e0f60710080809k5f0e029ah27750ee01c87dee6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 8 Oct 2007, Jaswinder Singh wrote:
> Hello Robert,
> 
> On 10/8/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> > On Sun, Oct 07, 2007 at 06:20:29PM +0530, Jaswinder Singh wrote:
> > > I am also getting :
> > > root@rd cycletest]# ./cyclictest -t 1 -p80 -n -i 10000 -l 10000 -q
> > > T: 0 ( 2709) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   16 Max:      44
> > > [root@rd cycletest]# ./cyclictest -t 1 -p80 -i 10000 -l 10000 -q
> > > T: 0 ( 2723) P:80 I:10000 C:  10000 Min:     21 Act:   30 Avg:   29 Max:     139
> > > [root@rd cycletest]#
> >
> > Doesn't look too bad.
> 
> 139 microseconds interrupt latency looks not too bad for Genral purpose OS.
> 
> But this is still bad in Realtime point of view.

Sigh. Realtime is not as fast as possible, it's as fast as
specified. It depends on your requirements whether it is sufficient or
not.

Also cyclictest is not about interrupt latency, it's about the full
chain of:

	timer interrupt
	scheduler
	user space execution

in the second test you did it's:
	
	timer interrupt
	softirq + signal delivery
	scheduler
	user space execution

	The softirq processing is causing the longer latency here.
	This problem is known and it can be fixed, but it's not high
	on the priority list.

Thanks,

	tglx
