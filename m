From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] kernel/futex: don't deboost too early
Date: Fri, 30 Sep 2016 20:43:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609302041410.5508@nanos>
References: <20160930083913.aqjpynzsj5d3xxho@linutronix.de> <20160930120038.5fe7d535@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930120038.5fe7d535@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 30 Sep 2016, Steven Rostedt wrote:
> This looks awfully complex. Would something as simple as this work?
> 
> What harm can happen by moving the holding of the lock after the
> wakeups for RT?

That's exactly bringing us back to the state before we added the delayed
wakeup so that the woken waiter will not be blocked on hb->lock right
away. That's 2 extra context switches for nothing.

Thanks,

	tglx
