From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rt: Make cpu_chill() use hrtimer instead of msleep()
Date: Fri, 07 Feb 2014 15:21:46 +0100
Message-ID: <52F4EBFA.3040401@linutronix.de>
References: <20140205115125.3cc950ce@gandalf.local.home>	<20140207113006.GD23668@linutronix.de>	<20140207090834.72774272@gandalf.local.home> <20140207091313.097f9059@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Ulrich Obergfell <uobergfe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140207091313.097f9059@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/07/2014 03:13 PM, Steven Rostedt wrote:
> On Fri, 7 Feb 2014 09:08:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>> could you please tell me which two locks are invovled here?
> 
> I should have also stated that it was only one lock that was involved.
> But the lock owner was doing a msleep() that requires a wakeup by
> ksoftirqd to continue. If ksoftirqd happens to be blocked on a lock
> held by the msleep() caller, then you have your deadlock.

That makes sense.

> It's best not to have any softirqs going to sleep requiring another
> softirq to wake it up. Note, if we ever require a timer softirq to do a
> cpu_chill() it will most definitely hit this deadlock.

Yes. And that sleep in softirq is also not really nice but this isn't
new. Thanks for the patch & explanation.
> 
> -- Steve

Sebastian
