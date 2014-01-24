From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] timer: Raise softirq if there's irq_work
Date: Fri, 24 Jan 2014 21:20:39 +0100
Message-ID: <20140124202039.GA32662@linutronix.de>
References: <20140124145157.1f30d447@gandalf.local.home>
 <20140124150933.22d8c20a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20140124150933.22d8c20a@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2014-01-24 15:09:33 [-0500]:

>[ Talking with Sebastian on IRC, it seems that doing the irq_work_run()
>  from the interrupt in -rt is a bad thing. Here we simply raise the
>  softirq if there's irq work to do. This too boots on my i7 ]

It is okay in general because most of the users should not run in bare
interrupt context. The only exception here is the nohz_full_kick_work
thing.

>After trying hard to figure out why my i7 box was locking up with the
>new active_timers code, that does not run the timer softirq if there
>are no active timers, I took an extra look at the softirq handler and
>noticed that it doesn't just run timer softirqs, it also runs irq work.
>
>This was the bug that was locking up the system. It wasn't missing a
>timer, it was missing irq work. By always doing the irq work callbacks,
>the system boots fine.
>
>No need to check for defined(CONFIG_IRQ_WORK). When that's not set the
>"irq_work_needs_cpu()" is a static inline that returns false.
>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Thank you Steven, this makes sense.

Sebastian
