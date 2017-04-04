From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch RT 1/4] rtmutex: Make lock_killable work
Date: Tue, 4 Apr 2017 09:20:32 -0400
Message-ID: <20170404092032.0c7b58dc@gandalf.local.home>
References: <20170401105058.958246042@linutronix.de>
        <20170401112758.051867031@linutronix.de>
        <20170403112126.75504264@gandalf.local.home>
        <20170404071302.GB3093@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT-users <linux-rt-users@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>,
        rt-stable@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbdDDNUh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 09:20:37 -0400
In-Reply-To: <20170404071302.GB3093@worktop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 4 Apr 2017 09:13:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Apr 03, 2017 at 11:21:26AM -0400, Steven Rostedt wrote:
> > On Sat, 01 Apr 2017 12:50:59 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > Locking an rt mutex killable does not work because signal handling is
> > > restricted to TASK_INTERRUPTIBLE.
> > > 
> > > Use signal_pending_state() unconditionaly.  
> > 
> > Does this mean rt mutex killable is not INTERRUPTIBLE? because the
> > change log seems to just assume that.  
> 
> > > -		if (unlikely(state == TASK_INTERRUPTIBLE)) {  
> 
> #define TASK_KILLABLE           (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
> 
> 
> I don't think we need to consider people who don't know where to find
> the TASK_state definitions.

No where in the change log did it mention TASK_KILLABLE. It only talked
about "rt mutex killable". Yeah, I can figure this out, but that
doesn't change that the fact that it was a weak change log.

Thomas has yelled at me for some of my change logs in the past that
were better than this ;-)

-- Steve
