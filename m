From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch RT 1/4] rtmutex: Make lock_killable work
Date: Tue, 4 Apr 2017 09:13:02 +0200
Message-ID: <20170404071302.GB3093@worktop>
References: <20170401105058.958246042@linutronix.de>
 <20170401112758.051867031@linutronix.de>
 <20170403112126.75504264@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT-users <linux-rt-users@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>,
        rt-stable@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403112126.75504264@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Apr 03, 2017 at 11:21:26AM -0400, Steven Rostedt wrote:
> On Sat, 01 Apr 2017 12:50:59 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Locking an rt mutex killable does not work because signal handling is
> > restricted to TASK_INTERRUPTIBLE.
> > 
> > Use signal_pending_state() unconditionaly.
> 
> Does this mean rt mutex killable is not INTERRUPTIBLE? because the
> change log seems to just assume that.

> > -		if (unlikely(state == TASK_INTERRUPTIBLE)) {

#define TASK_KILLABLE           (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)


I don't think we need to consider people who don't know where to find
the TASK_state definitions.
