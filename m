From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] kernel/futex: don't deboost too early
Date: Fri, 30 Sep 2016 18:10:45 +0200
Message-ID: <20160930161045.hueqm3pesy3yqkps@linutronix.de>
References: <20160930083913.aqjpynzsj5d3xxho@linutronix.de>
 <20160930120038.5fe7d535@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160930120038.5fe7d535@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-09-30 12:00:38 [-0400], Steven Rostedt wrote:
> This looks awfully complex. Would something as simple as this work?
> 
> What harm can happen by moving the holding of the lock after the
> wakeups for RT?
If the waiter has a higher priority he will get on the CPU and remove
_this_ task. Since the woken up task will access the hb lock
immediately _or_ before going to sleep so it will boost in order to get
the hb lock.
That is way we introduced this delayed wake up in the first place.

Sebastian
