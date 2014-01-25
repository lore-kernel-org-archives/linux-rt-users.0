From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 16:19:36 -0800
Message-ID: <20140125001936.GB9012@linux.vnet.ibm.com>
References: <20140124145157.1f30d447@gandalf.local.home>
 <20140124150933.22d8c20a@gandalf.local.home>
 <20140124202039.GA32662@linutronix.de>
 <20140124153542.6a92ef27@gandalf.local.home>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>,
	Joakim Hernberg <jbh@alchemy.lu>,
	Joe Korty <joe.korty@ccur.com>,
	Muli Baron <muli.baron@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140124153542.6a92ef27@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jan 24, 2014 at 03:35:42PM -0500, Steven Rostedt wrote:
> On Fri, 24 Jan 2014 21:20:39 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > * Steven Rostedt | 2014-01-24 15:09:33 [-0500]:
> > 
> > >[ Talking with Sebastian on IRC, it seems that doing the irq_work_run()
> > >  from the interrupt in -rt is a bad thing. Here we simply raise the
> > >  softirq if there's irq work to do. This too boots on my i7 ]
> > 
> > It is okay in general because most of the users should not run in bare
> > interrupt context. The only exception here is the nohz_full_kick_work
> > thing.
> 
> I know we discussed this on IRC, but I wanted to publicly state that
> the missing irq work callback was the RCU's rsp_wakeup() function.

Failing to invoke rsp_wakeup() when it was needed could potentially
stop RCU grace periods from happening, so having rsp_wakeup() happen
when it is needed is pretty important...

But I would guess that you knew that already.  ;-)

							Thanx, Paul
