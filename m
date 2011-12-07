From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Wed, 7 Dec 2011 01:37:24 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112070132210.2735@ionos>
References: <4ECCE979.5080109@cedwards.geek.nz> <1322056363.20742.45.camel@frodo> <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org>
 <alpine.LFD.2.02.1112041428560.2735@ionos> <4EDCC978.3060401@cedwards.geek.nz> <alpine.LFD.2.02.1112051740510.2735@ionos> <20111205181450.GK7834@aftab> <alpine.LFD.2.02.1112052200190.2735@ionos> <4EDD8314.3060904@cedwards.geek.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Borislav Petkov <bp@amd64.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Borislav Petkov <borislav.petkov@amd.com>
To: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34419 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab1LGAhb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Dec 2011 19:37:31 -0500
In-Reply-To: <4EDD8314.3060904@cedwards.geek.nz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Dec 2011, Chris Edwards wrote:
> On 06/12/11 10:02, Thomas Gleixner wrote:
> > On Mon, 5 Dec 2011, Borislav Petkov wrote:
> > > On Mon, Dec 05, 2011 at 05:56:01PM +0100, Thomas Gleixner wrote:
> > > 
> > > > You could try the following patch. Be aware that it might not work at
> > > > all, but I don't expect that you need a fire extinguisher :)
> 
> No smoke or flames noted. :)  And that appears to have solved the problem.
> Firewire audio works, and even after running NetPIPE a couple of times over
> that Ethernet interface, there's only a handful of interrupts on the Firewire
> IRQ (as seems to be normal):
> 
> I'll try reinstalling my other expansion cards and check that all remains
> well.
> 
> Thank you very much for the help.  Einfach Klasse!

Thank you very much for your persistance and providing all the info I
asked for! That kind of problems are extremly hard to decode without
the help of a competent reporter. I hope that Boris can figure
something out with his hardware folks.

Vielen Dank,

       Thomas
