From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Why the mce reverts in 4.16-rt?
Date: Wed, 11 Jul 2018 09:23:11 +0200
Message-ID: <20180711072311.cprdgb2xqwag2iem@linutronix.de>
References: <20180710205624.19ff9ef0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180710205624.19ff9ef0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-10 20:56:24 [-0400], Steven Rostedt wrote:
> Hi Sebastian,
Hi Steven,

> I'm looking at backporting patches from 4.16-rt and noticed that you
> have:
> 
> Revert "x86: Convert mce timer to hrtimer"
> Revert "x86/mce: use swait queue for mce wakeups"
> 
> With no explanation to why they were reverted. When did things change?
> Should this be 4.14-rt material?

from the announce email:
|    Changes since v4.16.8-rt2:
|    
|      - Drop two MCE related patches. They are no longer required since the
|        timer wheel rework.

The timer wheel rework made it possible to have a raw_spin_lock_t in the
timer_list timer. The problem with MCE was that it enqueued a timer from
hardirq context which is now possible. So the patches are no longer
required. This revert does not fix a bug in v4.14 nor does it break
anything.

> Thanks,
> 
> -- Steve

Sebastian
