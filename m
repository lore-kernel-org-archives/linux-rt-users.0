From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/4 V2] futex: convert hash_bucket locks to
 raw_spinlock_t
Date: Fri, 09 Jul 2010 20:34:35 -0400
Message-ID: <1278722075.1537.174.camel@gandalf.stny.rr.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
	 <1278714780-788-5-git-send-email-dvhltc@us.ibm.com>
	 <4C37A945.2000606@us.ibm.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>, Mike Galbraith <efault@gmx.de>,
	linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:50214 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0GJAei (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 20:34:38 -0400
In-Reply-To: <4C37A945.2000606@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-07-09 at 15:57 -0700, Darren Hart wrote:
> This version pulls in the bits mistakenly left in 3/4.
> 
> 
> >From 9f8b4faac79518f98131464c2d21a1c64fb841d2 Mon Sep 17 00:00:00 2001
> From: Darren Hart <dvhltc@us.ibm.com>
> Date: Fri, 9 Jul 2010 16:44:47 -0400
> Subject: [PATCH 4/4 V2] futex: convert hash_bucket locks to raw_spinlock_t
> 
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
> 
> This might be addressed by changing the various loops in the futex code to be
> incremental, probably at an additional throughput hit. The private hash_bucket
> lists discussed in the past could reduce hb->lock contention in some scenarios.
> It should be noted that pthread_cond_many is a rather pathological case.
> 
> This also introduces problems for plists which want a spinlock_t rather
> than a raw_spinlock_t. Any thoughts on how to address this?
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: John Kacur <jkacur@redhat.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Cc: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/futex.c |   73 ++++++++++++++++++++++++++++++--------------------------
>  1 files changed, 39 insertions(+), 34 deletions(-)


