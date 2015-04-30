From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Thu, 30 Apr 2015 15:07:24 -0400
Message-ID: <20150430150724.519d4054@gandalf.local.home>
References: <20150430123303.30f5bd12@gandalf.local.home>
	<20150430180721.GX5029@twins.programming.kicks-ass.net>
	<20150430143226.061202df@gandalf.local.home>
	<CANGgnMZSiNXRxESzdCCU9F-aAc_sa0nfBFqSdX3t4W8ThpwVhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANGgnMZSiNXRxESzdCCU9F-aAc_sa0nfBFqSdX3t4W8ThpwVhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 30 Apr 2015 11:40:07 -0700
Austin Schuh <austin@peloton-tech.com> wrote:

> On Thu, Apr 30, 2015 at 11:32 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 30 Apr 2015 20:07:21 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >> The irony, this is distinctly non deterministic code you're putting
> >> under a RT specific preempt_disable ;-)
> >
> > I know :-(
> >
> > Unfortunately, a RT behaving fix would be much more invasive and would
> > probably require the help of the xfs folks. For now, this just prevents
> > a live lock that can happen and halt the system, where it becomes
> > deterministic catastrophe.
> >
> > -- Steve
> 
> Would it work to instead create a lock to replace the
> preempt_enable_rt/preempt_disable_rt pair in XFS?

Not just the place where the preempt_enable and disable is done, but it
would need to replace all the per cpu bit spin locks (the
XFS_ICSB_FLAG_LOCK bit in icsbp->icsb_flags).

If we can replace them with a rtmutex (spin_lock() in vanilla kernel),
then that would work.

-- Steve
