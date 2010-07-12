From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] futex: convert hash_bucket locks to raw_spinlock_t
Date: Mon, 12 Jul 2010 15:05:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007121503010.3321@localhost.localdomain>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com> <1278714780-788-5-git-send-email-dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42498 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab0GLNGL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Jul 2010 09:06:11 -0400
In-Reply-To: <1278714780-788-5-git-send-email-dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 9 Jul 2010, Darren Hart wrote:

> The requeue_pi mechanism introduced proxy locking of the rtmutex.  This creates
> a scenario where a task can wake-up, not knowing it has been enqueued on an
> rtmutex. In order to detect this, the task would have to be able to take either
> task->pi_blocked_on->lock->wait_lock and/or the hb->lock.  Unfortunately,
> without already holding one of these, the pi_blocked_on variable can change
> from NULL to valid or from valid to NULL. Therefor, the task cannot be allowed
> to take a sleeping lock after wakeup or it could end up trying to block on two
> locks, the second overwriting a valid pi_blocked_on value. This obviously
> breaks the pi mechanism.
> 
> This patch increases latency, while running the ltp pthread_cond_many test
> which Michal reported the bug with, I see double digit hrtimer latencies
> (typically only on the first run after boo):
> 
> 	kernel: hrtimer: interrupt took 75911 ns

Eewwww. There must be some more intelligent and less intrusive way to
detect this.

Thanks,

	tglx
