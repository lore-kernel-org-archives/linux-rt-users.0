From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 14:46:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1304251445520.21884@ionos>
References: <1366760662.9609.176.camel@gandalf.local.home>  <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>  <1366893374.6139.5.camel@marge.simpson.net> <1366893787.10248.4.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Galbraith <bitbucket@online.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tim Sander <tim.sander@hbm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366893787.10248.4.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 25 Apr 2013, Steven Rostedt wrote:
> On Thu, 2013-04-25 at 14:36 +0200, Mike Galbraith wrote:
> > hrtimer: fix hrtimer free zone build bug
> 
> Perhaps the better solution is to select HIGH_RES_TIMERS when
> PREEMPT_RT_FULL is selected?

No, why ?
