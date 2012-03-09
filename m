From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Fri, 9 Mar 2012 11:23:05 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203091042040.2742@ionos>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>   <1331230991.25686.452.camel@gandalf.stny.rr.com>   <1331231287.11248.396.camel@twins>   <1331232159.25686.456.camel@gandalf.stny.rr.com>   <1331235579.11248.402.camel@twins>  <1331237441.25686.469.camel@gandalf.stny.rr.com>
  <alpine.LFD.2.02.1203090111240.2742@ionos> <1331261425.25686.527.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45770 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2CIKXK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Mar 2012 05:23:10 -0500
In-Reply-To: <1331261425.25686.527.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 8 Mar 2012, Steven Rostedt wrote:
> On Fri, 2012-03-09 at 01:20 +0100, Thomas Gleixner wrote:
> > So yopu need to replace the trylock by try_deadlock() and boost the
> > lock owner w/o blocking on the lock. That means that you need some
> > other means to tell the lock owner that you are waiting for it w/o
> > actually waiting. 
> 
> Actually, you don't need to tell the lock owner you are waiting for it,
> you only need to make the lock itself have a priority, and the owner
> will inherit that priority as long as it holds the lock.

Hmm, that would actually work, though I'm not too enthusiastic about
sched_yield().

Thanks,

	tglx
