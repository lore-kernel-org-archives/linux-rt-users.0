From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 14:25:01 +0100
Message-ID: <1200317101.3733.14.camel@homer.simson.net>
References: <1200250801.9190.7.camel@localhost.localdomain>
	 <200801132143.34889.m.kozlowski@tuxland.pl>
	 <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
	 <1200299260.4665.17.camel@homer.simson.net>
	 <478B0B7C.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750846AbYANNZF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 08:25:05 -0500
In-Reply-To: <478B0B7C.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-01-14 at 07:13 -0500, Gregory Haskins wrote:
> >>> On Mon, Jan 14, 2008 at  3:27 AM, in message
> <1200299260.4665.17.camel@homer.simson.net>, Mike Galbraith <efault@gmx.de>
> wrote: 
> 
> > On Sun, 2008-01-13 at 15:54 -0500, Steven Rostedt wrote:
> > 
> >> OK, -rt2 will take a bit more beating from me before I release it, so it
> >> might take some time to get it out (expect it out on Monday).
> > 
> > Ah, that reminds me (tests, yup) I still need the patchlet below to
> > resume from ram without black screen of death.
> 
> I had forgotten about this issue over the holidays...Sorry Mike.

I forgot about it too.  I'll likely poke at it again.

> So does that BUG_ON trip if you remove the first hunk?

No, I just copied the matching paranoia while leering at it.

	-Mike
