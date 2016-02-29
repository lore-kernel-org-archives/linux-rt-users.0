From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] v4.4.3-rt9
Date: Mon, 29 Feb 2016 16:09:39 +0100
Message-ID: <1456758579.3488.125.camel@gmail.com>
References: <alpine.DEB.2.11.1602291212180.3638@nanos>
	 <1456756060.3488.120.camel@gmail.com>
	 <alpine.DEB.2.11.1602291538590.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35842 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbcB2PJo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 10:09:44 -0500
In-Reply-To: <alpine.DEB.2.11.1602291538590.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-02-29 at 16:00 +0100, Thomas Gleixner wrote:
> On Mon, 29 Feb 2016, Mike Galbraith wrote:
> 
> > On Mon, 2016-02-29 at 13:46 +0100, Thomas Gleixner wrote:
> > > Dear RT folks!
> > > 
> > > I'm pleased to announce the v4.4.3-rt9 patch set. v4.4.2-rt7 and v4.4.3-rt8
> > > are non-announced updates to incorporate the linux-4.4.y stable tree.
> > > 
> > > There is one change caused by the 4.4.3 update:
> > > 
> > >   The relaxed handling of dump_stack() on RT has been dropped as there is
> > >   actually a potential deadlock lurking around the corner. See: commit
> > >   d7ce36924344 upstream. This does not effect the other facilities which
> > >   gather stack traces.
> > 
> > Hrm.  I had rolled that dropped bit forward as below.  I was given
> > cause to do a very large pile of ltp oom4 testing (rt kernels will
> > livelock due to waitqueue workers waiting for kthreadd to get memory to
> > spawn a kworker thread, while stuck kworker holds manager mutex, unless
> > workers are run as rt tasks to keep us from getting that depleted in
> > the first place), which gives it oodles of exercise, and all _seemed_
> > well.  Only seemed?
> 
> Well, it will work nicely as long as you don't trigger a back trace in hard
> irq context. Hmm?

Poo.. that's a pretty darn good reason.  Thanks.

	-Mike
