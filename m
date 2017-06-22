From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Thu, 22 Jun 2017 23:36:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706222331020.2221@nanos>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>  <1497687277.6908.31.camel@gmx.de>  <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>  <1497867291.19618.52.camel@gmx.de>  <20170619100838.343faaee@gandalf.local.home>  <20170619141341.m243ivutmwlzyhc4@linutronix.de>
  <20170619104131.05fdc76f@gandalf.local.home>  <1497889784.15817.17.camel@gmx.de> <1497944706.5454.7.camel@gmx.de>  <20170622163453.iymm3ctqv2a76k6k@linutronix.de> <1498152607.5559.19.camel@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2032092997-1498167370=:2221"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498152607.5559.19.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2032092997-1498167370=:2221
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Jun 2017, Mike Galbraith wrote:
> On Thu, 2017-06-22 at 18:34 +0200, Sebastian Andrzej Siewior wrote:
> > On 2017-06-20 09:45:06 [+0200], Mike Galbraith wrote:
> > > See ! and ?
> > 
> > See see.
> > What about this:
> 
> I'll give it a go, likely during the weekend.
> 
> I moved 4.11-rt today (also repros nicely) due to ftrace annoying me.
>  After yet more staring at ever more huge traces (opposite of goal;),
> then taking a break to stare at source again, I decided that the dual
> wake_q business should die.. and the stall died with it.

The dual wake_q business is the semantically correct seperation. The evils
of 'sleeping spinlocks' require to preserve the task state accross the lock
sleep and act upon the real wakeup (not the lock wakeup) proper.

The TASK_ALL wakeup of lock sleepers was hiding that non seperation of
these two except for the resulting wreckage of ptrace, which we simply
ignored for a long time because ....

Now that we figure out that TASK_ALL is wrong we exposed the convolution of
competing lock wakeups and regular wakeups. Seperating wake_q for those is
the only sane solution.

Thanks,

	tglx
--8323329-2032092997-1498167370=:2221--
