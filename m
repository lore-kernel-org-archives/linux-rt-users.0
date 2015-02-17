From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: 3.14.23-rt20 - softirq: resurrect softirq threads
Date: Tue, 17 Feb 2015 15:00:20 +0100
Message-ID: <1424181620.2955.5.camel@gmail.com>
References: <20141031170326.1491a63f@gandalf.local.home>
	 <1414910967.5380.81.camel@marge.simpson.net>
	 <1414913507.5380.117.camel@marge.simpson.net>
	 <20150217130553.GL26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217130553.GL26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-17 at 14:05 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2014-11-02 08:31:47 [+0100]:
> 
> >(sirqs suck, this makes them suck less for some boxen/loads)
> >
> >Subject: softirq: resurrect softirq threads
> >From: Mike Galbraith <mgalbraith@suse.de>
> >Date: Mon Jan  6 08:42:11 CET 2014
> >
> >Some loads cannot tolerate the jitter induced by all softirqs being processed
> >at the same priority.  Let the user prioritize them again.
> >
> >Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
> 
> I'm going to postpone this. While it might make sense in general I'm
> going to wait for tglx, Steven and others to see if this is what we want
> or if there are some plans redoing the softirq handling.

You can postpone this one forever, they don't want it.  I posted it for
folks who may want the option.

	-Mike
