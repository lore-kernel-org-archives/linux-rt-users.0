From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date: Mon, 7 Jan 2019 17:50:57 +0100
Message-ID: <20190107165056.2lhd53umgt4vod5o@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546634001-4450-1-git-send-email-swood@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> __down_read() bypasses the rtmutex frontend to call
> rt_mutex_slowlock_locked() directly, and thus it needs to call
> blk_schedule_flush_flug() itself.

we don't do this in the spin_lock() case because !RT doesn't do it. We
do it for rtmutex because !RT does it for mutex.
Now I can't remember why this was skipped for a rw_sem since it is
performed for !RT as part of the schedule() invocation.

If I don't come up with a plausible explanation then I will apply this
plus a hunk for the __down_write_common() case which should also be
required (right?).

> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/locking/rwsem-rt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
> index 660e22caf709..f73cd4eda5cd 100644
> --- a/kernel/locking/rwsem-rt.c
> +++ b/kernel/locking/rwsem-rt.c
> @@ -1,5 +1,6 @@
>  /*
>   */
> +#include <linux/blkdev.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -88,6 +89,15 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
>  	if (__down_read_trylock(sem))
>  		return 0;
>  
> +	/*
> +	 * If sem->rtmutex blocks, the function sched_submit_work will not
> +	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
> +	 * true).  We must call blk_schedule_flush_plug here; if we don't
> +	 * call it, an I/O deadlock may occur.
> +	 */
> +	if (unlikely(blk_needs_flush_plug(current)))
> +		blk_schedule_flush_plug(current);
> +
>  	might_sleep();
>  	raw_spin_lock_irq(&m->wait_lock);
>  	/*

Sebastian
