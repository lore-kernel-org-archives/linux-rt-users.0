From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Wed, 7 Dec 2011 01:32:15 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112070131300.2735@ionos>
References: <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org> <alpine.LFD.2.02.1112041428560.2735@ionos> <4EDCC978.3060401@cedwards.geek.nz>
 <alpine.LFD.2.02.1112051740510.2735@ionos> <20111205181450.GK7834@aftab> <alpine.LFD.2.02.1112052200190.2735@ionos> <4EDD8314.3060904@cedwards.geek.nz> <20111206111703.GB17926@aftab>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Edwards <cedwards.linux@cedwards.geek.nz>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Borislav Petkov <bp@amd64.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34395 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab1LGAcZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Dec 2011 19:32:25 -0500
In-Reply-To: <20111206111703.GB17926@aftab>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Dec 2011, Borislav Petkov wrote:

> On Tue, Dec 06, 2011 at 03:51:00PM +1300, Chris Edwards wrote:
> > On 06/12/11 10:02, Thomas Gleixner wrote:
> > >On Mon, 5 Dec 2011, Borislav Petkov wrote:
> > >>On Mon, Dec 05, 2011 at 05:56:01PM +0100, Thomas Gleixner wrote:
> > >>
> > >>>You could try the following patch. Be aware that it might not work at
> > >>>all, but I don't expect that you need a fire extinguisher :)
> > 
> > No smoke or flames noted. :)  And that appears to have solved the
> > problem.  Firewire audio works, and even after running NetPIPE a
> > couple of times over that Ethernet interface, there's only a handful
> > of interrupts on the Firewire IRQ (as seems to be normal):
> 
> Oh ok, good.
> 
> I started poking at hw people for comments, let's see what happens. Please let
> us know should there be other issues.
> 
> @tglx: You could give me a couple of days to confirm the workaround but
> this is old stuff so don't hold your breath for too long :).

Sure, I'm not in a hurry. It seems only Chris has one of these oddballs :)
