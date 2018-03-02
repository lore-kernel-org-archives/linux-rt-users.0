From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC/PATCH RT] Revert "rt,ntp: Move call to schedule_delayed_work()
 to helper thread"
Date: Fri, 2 Mar 2018 12:26:03 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803021221010.1803@nanos.tec.linutronix.de>
References: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2 Mar 2018, Sebastian Andrzej Siewior wrote:

> I've been looking at this in v3.10-RT where it got in. The patch
> description says
> 
> |The ntp code for notify_cmos_timer() is called from a hard interrupt
> |context.
> 
> I see only one caller of ntp_notify_cmos_timer() and that is
> do_adjtimex() after "raw_spin_unlock_irqrestore()".
> I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
> and posix_clock_realtime_adj() which in turn is called by
> SYS_clock_adjtime().
> 
> I can't find the hard interrupt context. May I revert this patch?

That really looks bogus. ntp_notify_cmos_timer() has never been invoked
from hard interrupt context or from a atomic region. No idea how that patch
ended up in RT...

Thanks,

	tglx
