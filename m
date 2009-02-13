From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [patch] rt: sysprof hrtimer fix
Date: Fri, 13 Feb 2009 21:03:08 +0100
Message-ID: <20090213200305.GA5833@nowhere>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <20090213004812.GA5824@nowhere> <20090213021626.GA5807@nowhere> <20090213030919.GA5826@nowhere> <20090213072601.GA26946@elte.hu> <20090213120451.GA5782@nowhere> <20090213124928.GC5483@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48038 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZBMUDN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Feb 2009 15:03:13 -0500
Content-Disposition: inline
In-Reply-To: <20090213124928.GC5483@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Feb 13, 2009 at 01:49:28PM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
> > So, just a thing.
> > -rt make the hrtimer's timers running on softirq context because the hrtimer_interrupt
> > doesn't run as a threaded interrupt, and then it is not preemptible right?
> > 
> > In that case, sysprof will continue to run in hardirq context, as before, and
> > it will considerably increase the latency. And that matters here.
> > So I think it is important to put it on the reminder:
> 
> hm, not sure. Do you know it numerically how much worst-case overhead it
> induces?
> 
> 	Ingo

Not at all.
But when I find some time, I will compare some rt average tests with and without sysprof.

