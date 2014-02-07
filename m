From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] rt: Make cpu_chill() use hrtimer instead of msleep()
Date: Fri, 7 Feb 2014 09:08:34 -0500
Message-ID: <20140207090834.72774272@gandalf.local.home>
References: <20140205115125.3cc950ce@gandalf.local.home>
	<20140207113006.GD23668@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Ulrich Obergfell <uobergfe@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140207113006.GD23668@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 7 Feb 2014 12:30:06 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2014-02-05 11:51:25 [-0500]:
> 
> >Ulrich Obergfell pointed out that cpu_chill() calls msleep() which is woken
> >up by the ksoftirqd running the TIMER softirq. But as the cpu_chill() is
> >called from softirq context, it may block the ksoftirqd() from running, in
> >which case, it may never wake up the msleep() causing the deadlock.
> >
> >I checked the vmcore, and irq/74-qla2xxx is stuck in the msleep() call,
> >running on CPU 8. The one ksoftirqd that is stuck, happens to be the one that
> >runs on CPU 8, and it is blocked on a lock held by irq/74-qla2xxx. As that
> >ksoftirqd is the one that will wake up irq/74-qla2xxx, and it happens to be
> >blocked on a lock that irq/74-qla2xxx holds, we have our deadlock.
> 
> could you please tell me which two locks are invovled here?
> 

Looks to be the lock of the block softirq. I don't have the core dump
anymore, but from what I could tell the ksoftirqd was blocked on the
block softirq lock, where the block softirq handler did a msleep
(called by the qla2xxx interrupt handler).

Looking at trigger_softirq() in block/blk-softirq.c, it can do a
smp_callfunction() to another cpu to run the block softirq. If that
happens to be the cpu where the qla2xx irq handler is doing the block
softirq and is in a middle of a msleep(), I believe the ksoftirqd will
try to run the softirq. If it does that, then BOOM, it's deadlocked
because the ksoftirqd will never run the timer softirq either.

-- Steve
