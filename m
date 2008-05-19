From: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: 2.6.25.4-rt2
Date: Tue, 20 May 2008 01:43:57 +0200
Message-ID: <1211240637.19845.46.camel@localhost>
References: <1211237032.14697.76.camel@localhost.localdomain>
	 <1211239147.19845.42.camel@localhost>
	 <Pine.LNX.4.58.0805191936120.4125@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:55906 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757184AbYESXs3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 19:48:29 -0400
In-Reply-To: <Pine.LNX.4.58.0805191936120.4125@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-05-19 at 19:44 -0400, Steven Rostedt wrote:
> On Tue, 20 May 2008, Kasper Sandberg wrote:
> 
> > On Mon, 2008-05-19 at 18:43 -0400, Steven Rostedt wrote:
> > > We are pleased to announce the 2.6.25.4-rt2 tree, which can be
> 
> > Forgive me if i ask an obvious stupid question. But what is the status
> > of this -rt tree for .25 in relation with the BKL stuff?
> 
> Well, the BKL is still a semaphore in 25.

I just asked because i have read a bit of the discussion, and have
personally noticed that there is no option to "preempt the bkl" in
my .25 configuration

<snip>
> 
> 
> Here it is no better, and the BKL has been converted into a spin lock.
oh nice, i thought this was being postponsed to .27
> 
> But I'm very much busy working on -rt right now to dig deeper into this
> regression.

No worries. I shall give this tree a try.

> 
> -- Steve
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

