From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kernel/futex: don't deboost too early
Date: Sun, 2 Oct 2016 06:01:37 -0400
Message-ID: <20161002060137.2716b089@grimm.local.home>
References: <20160930083913.aqjpynzsj5d3xxho@linutronix.de>
        <20160930120038.5fe7d535@grimm.local.home>
        <alpine.DEB.2.20.1609302041410.5508@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:53694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750912AbcJBKBn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 2 Oct 2016 06:01:43 -0400
In-Reply-To: <alpine.DEB.2.20.1609302041410.5508@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 30 Sep 2016 20:43:26 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 30 Sep 2016, Steven Rostedt wrote:
> > This looks awfully complex. Would something as simple as this work?
> > 
> > What harm can happen by moving the holding of the lock after the
> > wakeups for RT?  
> 
> That's exactly bringing us back to the state before we added the delayed
> wakeup so that the woken waiter will not be blocked on hb->lock right
> away. That's 2 extra context switches for nothing.

Ah crap, that's the wake up of the owner that's about to grab the lock,
in which case (if on the same CPU) may preempt this guy, just to grab
the hb->lock and block again.

Grumble, how come the easy way is never a possibility :-p

-- Steve
