From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Wed, 16 May 2007 12:47:07 +0200
Message-ID: <1179312428.3764.29.camel@chaos>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
	 <1179228729.5139.6.camel@godzilla.tecnorama.it>
	 <1179229315.5704.25.camel@localhost.localdomain>
	 <200705152008.54949.jbe@pengutronix.de>
	 <1179309761.7610.16.camel@godzilla.tecnorama.it>
	 <20070516101224.GG12319@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alessio Igor Bogani <abogani@texware.it>,
	Juergen Beisert <jbe@pengutronix.de>,
	Peter Feuerer <peter@piie.net>, linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:39145 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756773AbXEPKm4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 06:42:56 -0400
In-Reply-To: <20070516101224.GG12319@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-05-16 at 12:12 +0200, Robert Schwebel wrote:
> > > Once again. On this piece of hardware there is no other useful timer as the 
> > > PIT.
> > 
> > Cyclictest tell me this:
> > 
> > "WARNING: High resolution timers not available"
> > 
> > also if i add "clocksource=pit" in the kernel command line!  :-(
> 
> Looks like it didn't switch to highres mode. You can check this by
> looking into /proc/timer_list.

It can _NOT_ switch into highres mode on a machine, where the only clock
source is the PIT.

Highres / dyntick mode requires a reliable continuous counting clock
source to keep track of time.

PIT is not continuous. We can use PIT as clock source only when PIT is
in periodic mode, but it is slow and unreliable.

If we would switch to highres/dyntick with PIT we would lose track of
time completely, because we would try to read the time from the device
which we use to program the next event interrupt.

There is no way to solve this on systems, which have only a PIT.

	tglx
