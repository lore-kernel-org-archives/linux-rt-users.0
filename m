From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Suggesting to include timerfd patch
Date: Wed, 8 Feb 2012 21:09:41 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1202082109250.2794@ionos>
References: <CAFQPvXf7JS98_FH_nwHsEa0WX7H6QT8vBAJwo2Yt-r--aO6mcA@mail.gmail.com> <1328678109.2200.116.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60486 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2BHUJo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 15:09:44 -0500
In-Reply-To: <1328678109.2200.116.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 8 Feb 2012, Steven Rostedt wrote:

> On Tue, 2012-02-07 at 22:56 -0600, Sankara Muthukrishnan wrote:
> > Steven,
> > 
> > Could you please include the patch that Thomas suggested for the
> > timerfd hangs in the email thread (link below), if Thomas is fine with
> > the patch? I did verify that that patch fixed the hangs that I saw on
> > a panda board (ARM Cortex A9 dual core).
> > 
> > http://marc.info/?l=linux-rt-users&m=132753755612168&w=2
> > 
> 
> Hi Sankara,
> 
> I follow the same stable rules that the stable mainline follows. I will
> not add any patch to the stable release that is not in either mainline,
> or in Thomas's -rt development branch. This keeps the stable tree from
> forking and getting a fix that is not upstream. A fix to stable that is
> not included upstream, may be forgotten about.
> 
> If Thomas adds it, or if this patch is in mainline (which it is
> obviously not, as it is -rt specific), then I will be happy to apply it.

It's on the way.
