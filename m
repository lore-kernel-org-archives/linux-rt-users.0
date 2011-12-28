From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 18:28:34 +0100
Message-ID: <1325093314.16165.40.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
	 <1324977605.5217.132.camel@marge.simson.net>
	 <1325049448.4726.16.camel@marge.simson.net>
	 <4EFB1B28.7090203@linux.intel.com>
	 <1325084349.16165.22.camel@marge.simson.net>
	 <1325091444.2651.1.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:39849 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753864Ab1L1R2j (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 12:28:39 -0500
In-Reply-To: <1325091444.2651.1.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-28 at 17:57 +0100, Peter Zijlstra wrote:
> On Wed, 2011-12-28 at 15:59 +0100, Mike Galbraith wrote:
> > 
> > > (and are you using a system where tsc/lapic can be used, or are you
> > > using one of those boatanchors that need hpet?)
> > 
> > Box is an HP DL980, 64 x X7560. 
> 
> That smells like NHM-EX, aka boatanchor.

I have a 32 core test box that has a minimum itimer fires -> task runs
of 6.79 usecs.. now _that_ box would make a great boat anchor.  DL980
may be a work horse, but it ain't a broken down old nag that should be
sent off to the glue factory.. yet.

	-Mike


