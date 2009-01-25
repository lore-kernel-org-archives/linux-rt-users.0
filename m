From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Sun, 25 Jan 2009 12:07:45 -0200
Message-ID: <20090125140745.GC12776@khazad-dum.debian.net>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org> <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com> <alpine.LFD.2.00.0901241716540.3424@localhost.localdomain> <1232845026.3990.71.camel@perihelion.bos.jonmasters.org> <alpine.LFD.2.00.0901251032060.3424@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Masters <jcm@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
	linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44382 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753928AbZAYOYs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2009 09:24:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901251032060.3424@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 25 Jan 2009, Thomas Gleixner wrote:
> On Sat, 24 Jan 2009, Jon Masters wrote:
> > > The only reasonable thing you can do on a SMI plagued system is to
> > > identify the device which makes use of SMIs. Legacy ISA devices and
> > > USB are usually good candidates. If that does not help, don't use it
> > > for real-time :)
> > 
> > Indeed. This is why I wrote an smi_detector that sits in kernel space
> > and can be reasonably sure measured discrepancies are attributable to
> > SMI behavior. We want to log and detect such things before RT systems
> > are deployed, not have users actively trying to work around SMI overhead
> > after the fact.
> 
> Agreed. A tool to detect SMI disturbance is a good thing. It just
> needs to be documented that users should take the results and talk to
> their board vendor. I know that off the shelf hardware will not be
> fixed, but industrial grade hardware vendors usually have an interest
> to get such problems resolved.

"gamer enthusiast" hardware might also get fixed.  You just need two or
three posts to the "enthusiasts" forums about how SMI steals CPU cycles and
slow down their framerates, and suddenly, benchmarks will start going on and
on about how MoBo x has a high number of SMIs per minute, where MoBo y
doesn't...

The people who want low-latency desktops for audio work will also pay
attention to such benchmarks and will vote with their wallet.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
