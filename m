From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt1
Date: Wed, 16 Jan 2008 18:53:27 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801161852570.17781@gandalf.stny.rr.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <20080113202522.GD27137@pengutronix.de> <Pine.LNX.4.58.0801131544430.10093@gandalf.stny.rr.com>
 <20080114200836.GR27137@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:32946 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYAPXxq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 18:53:46 -0500
In-Reply-To: <20080114200836.GR27137@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 14 Jan 2008, Robert Schwebel wrote:

> On Sun, Jan 13, 2008 at 03:48:33PM -0500, Steven Rostedt wrote:
> > Yeah, I didn't make any attempt to fix latency_tracing for PPC on this
> > release. I expected as much. I do have a couple of PPC boxes that I
> > can play with, and I'll see if I can get that working too before -rt2.
> > But I want to get a stable x86 release out fast.
>
> It compiles now, although I still don't get any kernel output any more
> if I enable CONFIG_FUNCTION_TRACE. Sorry for not being more verbose, I'm
> out of office right now and my arms are not long enough to connect the
> BDI ;)

Hmm, I wonder if the bootup is calling mcount before mcount is ready. This
could be the issue.

-- Steve
