From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY
 explosions
Date: Tue, 10 Mar 2015 10:35:36 +0100
Message-ID: <1425980136.3507.17.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425911771.30469.8.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2015-03-09 at 15:36 +0100, Mike Galbraith wrote:
> On Mon, 2015-03-09 at 14:45 +0100, Sebastian Andrzej Siewior wrote:
> > * Mike Galbraith | 2015-02-18 12:21:54 [+0100]:
> > 
> > >On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:
> > >
> > >> Known issues:
> > >>
> > >>       - lazy preempt on x86_64 leads to a crash with some load.
> > >
> > >The below still works for me.  (it doesn't make nohz_full actually work
> > >in rt, but at least folks who want to tinker with it can do so)
> > So your box still crashes without it?
> > 
> > The thing is I tried to reproduce it and it does not occur anymore.
> > Neither in KVM nor on real HW.
> 
> Heh, well that's interesting, I just presumed it would still explode
> because you said it would.  I'll beat on it any let you know if I'm
> carrying a placebo patch or not :)

Yup, someone made kaboom go away.  I was able to easily blow my box out
of the water by running tbench + kbuild with nohz_full active.  No more.

nohz_full doesn't work though, due to an otherwise solo task trying to
shut the tick down having just awakened ksoftirqd.. but no more kaboom.

	-Mike
