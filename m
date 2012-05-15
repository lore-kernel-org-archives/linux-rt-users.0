From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Tue, 15 May 2012 17:58:41 -0500
Message-ID: <20120515225841.GA25360@grante>
References: <joemui$6v0$1@dough.gmane.org>
 <joepd0$e4f$1@dough.gmane.org>
 <4FAAEBF3.10907@netacquire.com>
 <joetve$hm5$1@dough.gmane.org>
 <1337103192.14207.340.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49428 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966436Ab2EOW6s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 18:58:48 -0400
Received: by yenm10 with SMTP id m10so132638yen.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 May 2012 15:58:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337103192.14207.340.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 15, 2012 at 01:33:12PM -0400, Steven Rostedt wrote:
> On Wed, 2012-05-09 at 23:18 +0000, Grant Edwards wrote:
> 
> > I eventually figured out that my increased interrupt latency is due to
> > my ISR being run in a kernel thread instead of as a real ISR.  Adding
> > the IRQF_NODELAY flag gets me the same average latency I had without
> > the RT patch.  [It looks like that flag has a different name in 2.6.39
> > and later?]
> 
> Note, adding a IRQF_NODELAY is very dangerous. To keep the kernel
> fully preemptible (well mostly), spin-locks have been converted into
> mutexes. If the irq handler has one of these spinlocks that have been
> converted, it may schedule in the interrupt handler and crash the
> kernel. You can not schedule in interrupt context, which is why the
> RT kernel makes the interrupt handlers into threads.

Noted.  Since the IRQF_NODELAY approach still misses the deadline 2-3%
of the time, that approach is probably off the list anyway.  Right now
we're looking at using either FIQ interrupt or Xenomai.

> Also note, you may get better response if you up the interrupt
> thread's priority. Up it to 98, and you should see much better
> responses.

Thanks for the tip.  I'll keep that in mind for some other projects
that would need latency times in the 100-200us range, which should be
doable.

> Now I don't think you will make the 20us under load, but you won't do
> that in the non-RT patch either.

Right.  With the non-RT patch, the average response is about the same,
but the worst-case numbers are 2X-3X.

-- 
Grant
