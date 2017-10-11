From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] locking/rtmutex: do lockdep before actual locking in
 rt_spin_lock()
Date: Wed, 11 Oct 2017 12:48:51 -0400
Message-ID: <20171011124851.261415f0@gandalf.local.home>
References: <20171011161646.baxqesjqm4sip6em@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011161646.baxqesjqm4sip6em@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Oct 2017 18:16:46 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> rt_spin_lock() should first do the lock annotation via lockdep and then
> do the actual locking. That way we learn about the deadlock from lockdep
> before it happens.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 79f49d73e4d0..639cfdaae72f 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1153,8 +1153,8 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
>  void __lockfunc rt_spin_lock(spinlock_t *lock)
>  {
>  	migrate_disable();
> -	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
>  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> +	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
>  }
>  EXPORT_SYMBOL(rt_spin_lock);
>  

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
