From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0.4-rt13
Date: Mon, 12 Sep 2011 09:24:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109120923410.2723@ionos>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>  <1315737307.6544.1.camel@marge.simson.net> <1315760482.6352.10.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60045 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab1ILHYw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Sep 2011 03:24:52 -0400
In-Reply-To: <1315760482.6352.10.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 11 Sep 2011, Mike Galbraith wrote:

> On Sun, 2011-09-11 at 12:35 +0200, Mike Galbraith wrote:
> > On Sat, 2011-09-10 at 11:12 +0200, Thomas Gleixner wrote: 
> > > Dear RT Folks,
> > > 
> > > I'm pleased to announce the 3.0.4-rt13 release.
> > > 
> > > Changes versus 3.0.2-rt11
> > > 
> > >   * Migrate disable cure (Mike, Peter)
> > 
> > The warning triggers.
> 
> Seems in_atomic() is not pair inclusive.  This does not gripe.

I'd rather like to figure out why it is not symetric. Just working
around it makes me nervous. I'll have a look.

Thanks,

	tglx

 
