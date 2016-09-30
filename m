From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kernel/futex: don't deboost too early
Date: Fri, 30 Sep 2016 12:00:38 -0400
Message-ID: <20160930120038.5fe7d535@grimm.local.home>
References: <20160930083913.aqjpynzsj5d3xxho@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930083913.aqjpynzsj5d3xxho@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 30 Sep 2016 10:39:14 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The sequence:
>  T1 holds futex
>  T2 blocks on futex and boosts T1
>  T1 unlocks futex and holds hb->lock
>  T1 unlocks rt mutex, so T1 has no more pi waiters
>  T3 blocks on hb->lock and adds itself to the pi waiters list of T1
>  T1 unlocks hb->lock and deboosts itself
>  T4 preempts T1 so the wakeup of T2 gets delayed
> 
> As a workaround I attempt here do unlock the hb->lock without a deboost
> and perform the deboost after the wake up of the waiter.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/spinlock.h    |  6 +++++
>  include/linux/spinlock_rt.h |  2 ++
>  kernel/futex.c              |  2 +-
>  kernel/locking/rtmutex.c    | 53 +++++++++++++++++++++++++++++++++++++++------
>  4 files changed, 55 insertions(+), 8 deletions(-)
> 

This looks awfully complex. Would something as simple as this work?

What harm can happen by moving the holding of the lock after the
wakeups for RT?

-- Steve

diff --git a/kernel/futex.c b/kernel/futex.c
index 2d572ed..bb900bd 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1347,9 +1347,14 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	 * deboost first (and lose our higher priority), then the task might get
 	 * scheduled away before the wake up can take place.
 	 */
+#ifndef CONFIG_PREEMPT_RT_FULL
 	spin_unlock(&hb->lock);
+#endif
 	wake_up_q(&wake_q);
 	wake_up_q_sleeper(&wake_sleeper_q);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	spin_unlock(&hb->lock);
+#endif
 	if (deboost)
 		rt_mutex_adjust_prio(current);
 
