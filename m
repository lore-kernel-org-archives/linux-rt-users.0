From: Jason Low <jason.low2@hp.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 11:12:09 -0700
Message-ID: <CAGQ1y=4YNpyztGyPb=rgnBduJfykB8tbG1FQWGEKQWVNeu+nNw@mail.gmail.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	<1428369962-74723-1-git-send-email-tmac@hp.com>
	<1428369962-74723-2-git-send-email-tmac@hp.com>
	<alpine.DEB.2.11.1504071255410.3845@nanos>
	<1428407236.3152.81.camel@gmail.com>
	<20150407120403.GN21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Jason Low <jason.low2@hp.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34571 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbDGSMK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 14:12:10 -0400
In-Reply-To: <20150407120403.GN21418@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 7, 2015 at 5:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> That smells like something we should be able to do without a lock.
>
> If we use {READ,WRITE}_ONCE() on those two fields (->active_timers and
> ->next_timer) we should be able to do this without the spinlock.

Yeah, when atomics were suggested earlier, I was wondering if we could
just use READ_ONCE/WRITE_ONCE.

> Races here aren't really a problem I think, if you manage to install a
> timer at the current jiffy and have already missed the tick you're in
> the same boat. You get to wait for the next tick.

The lock shouldn't be used in get_next_timer_interrupt() either right?

unsigned long get_next_timer_interrupt(unsigned long now)
{
...

#ifdef CONFIG_PREEMPT_RT_FULL
        /*
         * On PREEMPT_RT we cannot sleep here. If the trylock does not
         * succeed then we return the worst-case 'expires in 1 tick'
         * value.  We use the rt functions here directly to avoid a
         * migrate_disable() call.
         */
        if (!spin_do_trylock(&base->lock))
                return  now + 1;
#else
