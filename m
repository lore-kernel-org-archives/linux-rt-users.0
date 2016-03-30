From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v1] sched/completion: convert completions to use simple
 wait queues
Date: Wed, 30 Mar 2016 17:07:47 +0200
Message-ID: <20160330150747.GY3408@twins.programming.kicks-ass.net>
References: <1459349585-6527-1-git-send-email-wagi@monom.org>
 <1459349585-6527-2-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459349585-6527-2-git-send-email-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 30, 2016 at 04:53:05PM +0200, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> Completions have no long lasting callbacks and therefore do not need
> the complex waitqueue variant.  Use simple waitqueues which reduces
> the contention on the waitqueue lock.

Changelog really should have talk about the determinism thing. The last
time you posted this the point was raised that we should wake the
highest prio waiter in the defer case, you did not address this.

Also, you make no mention of the reduction of UINT_MAX to USHORT_MAX and
the implications of that.
