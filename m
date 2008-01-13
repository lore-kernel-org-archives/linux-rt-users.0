From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 15:48:33 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801131544430.10093@gandalf.stny.rr.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <20080113202522.GD27137@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49268 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYAMUtB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 15:49:01 -0500
In-Reply-To: <20080113202522.GD27137@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 13 Jan 2008, Robert Schwebel wrote:

> On Sun, Jan 13, 2008 at 02:00:01PM -0500, Steven Rostedt wrote:
> > We are pleased to announce the 2.6.24-rc7-rt1 tree
>
> Works fine on phyCORE-MPC5200B-tiny, here are the latest results:
> http://www.pengutronix.de/oselas/realtime/results/20080113-1/

That doesn't look too bad. Or is over a 100us not good for that box?

Also is it SMP?


>
> However, when I try to switch on the latency tracer, it ends with the
> warnings below. I've added early_printk() stubs in order to make it
> link at all.

Yeah, I didn't make any attempt to fix latency_tracing for PPC on this
release. I expected as much. I do have a couple of PPC boxes that I can
play with, and I'll see if I can get that working too before -rt2. But I
want to get a stable x86 release out fast.

Thanks,

-- Steve
