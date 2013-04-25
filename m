From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 15:23:52 +0200
Message-ID: <1366896232.6139.21.camel@marge.simpson.net>
References: <1366760662.9609.176.camel@gandalf.local.home>
	 <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>
	 <1366893374.6139.5.camel@marge.simpson.net>
	 <1366893787.10248.4.camel@gandalf.local.home>
	 <alpine.LFD.2.02.1304251445520.21884@ionos>
	 <1366894324.10248.6.camel@gandalf.local.home>
	 <alpine.LFD.2.02.1304251507370.21884@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tim Sander <tim.sander@hbm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1304251507370.21884@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-04-25 at 15:09 +0200, Thomas Gleixner wrote: 
> On Thu, 25 Apr 2013, Steven Rostedt wrote:
> 
> > On Thu, 2013-04-25 at 14:46 +0200, Thomas Gleixner wrote:
> > > On Thu, 25 Apr 2013, Steven Rostedt wrote:
> > > > On Thu, 2013-04-25 at 14:36 +0200, Mike Galbraith wrote:
> > > > > hrtimer: fix hrtimer free zone build bug
> > > > 
> > > > Perhaps the better solution is to select HIGH_RES_TIMERS when
> > > > PREEMPT_RT_FULL is selected?
> > > 
> > > No, why ?
> > 
> > Why not? ;-)
> > 
> > Except for the lack of support, one would think that if you want real
> > time responses, you would also want a real time clock.
> 
> Well, if your application is driven by an external interrupt, then you
> do not need highres timers at all.

(hey, that's cheating, generic config vs specialized;)
