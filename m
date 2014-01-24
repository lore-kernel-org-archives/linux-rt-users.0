From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 15:35:42 -0500
Message-ID: <20140124153542.6a92ef27@gandalf.local.home>
References: <20140124145157.1f30d447@gandalf.local.home>
	<20140124150933.22d8c20a@gandalf.local.home>
	<20140124202039.GA32662@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>,
	Joakim Hernberg <jbh@alchemy.lu>,
	Joe Korty <joe.korty@ccur.com>,
	Muli Baron <muli.baron@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140124202039.GA32662@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Jan 2014 21:20:39 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2014-01-24 15:09:33 [-0500]:
> 
> >[ Talking with Sebastian on IRC, it seems that doing the irq_work_run()
> >  from the interrupt in -rt is a bad thing. Here we simply raise the
> >  softirq if there's irq work to do. This too boots on my i7 ]
> 
> It is okay in general because most of the users should not run in bare
> interrupt context. The only exception here is the nohz_full_kick_work
> thing.
> 

I know we discussed this on IRC, but I wanted to publicly state that
the missing irq work callback was the RCU's rsp_wakeup() function.

-- Steve
