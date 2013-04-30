From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Tue, 30 Apr 2013 14:08:15 -0400
Message-ID: <1367345295.30667.68.camel@gandalf.local.home>
References: <20130429201202.GB7979@linutronix.de>
	 <20130429161925.2a6ea78a@riff.lan> <20130430170948.GB4688@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130430170948.GB4688@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-04-30 at 19:09 +0200, Sebastian Andrzej Siewior wrote:

> The next thing that happens is that RCU assumes nobody is doing any
> progress (for almost 28secs) and triggers NMIs & printks to get some
> attention. I have a trace where
> - CPU0: arch_trigger_all_cpu_backtrace_handler() => printk()
>         has "lock" and is spinning for logbuf_lock
> 
> - CPU1: print_cpu_stall() => printk() (spinning for the lock) => NMI =>
>   arch_trigger_all_cpu_backtrace_handler()
>         it may have logbuf_lock and is spinning for "lock"
> 
> I can't tell if CPU1 got the logbuf_lock at this time but it seemed that
> it made no progress until I ended it.
> This NMI releated deadlock is a problem which should also trigger
> mainline, right?

Well, yeah, as sending out a NMI stack dump is sorta the last resort,
and is dangerous to do printks from NMI context.

> 
> Now, the time jump on the other hand is the real issue here and is
> RT-only. It looks like we get a big number of timer updates via
> tick_do_update_jiffies64() because according to ktime_get() that much
> time really passed by.

As the NMI dump only happens because of the time jump, which as you
said, is -rt only, I wouldn't say that the NMI deadlock is a mainline
bug.

-- Steve
