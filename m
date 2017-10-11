From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] locking/rtmutex: do lockdep before actual locking in
 rt_spin_lock()
Date: Wed, 11 Oct 2017 18:20:10 +0200
Message-ID: <20171011162010.izit6ycymwxqic6w@hirez.programming.kicks-ass.net>
References: <20171011161646.baxqesjqm4sip6em@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011161646.baxqesjqm4sip6em@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 11, 2017 at 06:16:46PM +0200, Sebastian Andrzej Siewior wrote:
> rt_spin_lock() should first do the lock annotation via lockdep and then
> do the actual locking. That way we learn about the deadlock from lockdep
> before it happens.

Yep, that's the right order.
