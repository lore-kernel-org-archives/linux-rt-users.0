From: Andy Ritger <aritger@nvidia.com>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Fri, 10 Feb 2017 10:09:29 -0800
Message-ID: <20170210180929.GC9583@prokofiev.nvidia.com>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
 <20170126170109.6zhoohgodtvxot54@linutronix.de>
 <20170130173534.GA24966@prokofiev.nvidia.com>
 <20170203155434.utptndmoskcyimn7@linutronix.de>
 <20170203164924.GB19814@prokofiev.nvidia.com>
 <20170210175049.3cvrk5ki7c6uiblg@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Andy Ritger <aritger@nvidia.com>, Alex Goins <agoins@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170210175049.3cvrk5ki7c6uiblg@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 10, 2017 at 06:50:50PM +0100, Sebastian Andrzej Siewior wrote:
> On 2017-02-03 08:49:24 [-0800], Andy Ritger wrote:
> > > So your problem is simply that your non-GPL module can't link anymore
> > > with -RT.  Would it help you if I simply replace the export for
> > > mutex_destroy with EXPORT_SYMBOL and leave it the function as is?
> > 
> > Yes, definitely.
> 
> So this is what I intend to add to the RT patch and I hope Ingo won't
> object:
> 
> Alex Goins reported that mutex_destroy() on RT will force a GPL only symbol
> which won't link and therefore fail on a non-GPL kernel module.
> This does not happen on !RT and is a regression on RT which we would like to
> avoid.
> I try here the easy thing and to not use rt_mutex_destroy() if
> CONFIG_DEBUG_MUTEXES is not enabled. This will still break for the DEBUG
> configs so instead of adding a wrapper around rt_mutex_destroy() (which we have
> for rt_mutex_lock() for instance) I am simply dropping the GPL part from the
> export.

Is the

    WARN_ON(rt_mutex_is_locked(lock));

in rt_mutex_destroy() valuable in non-CONFIG_DEBUG_MUTEXES kernels,
such that it would be better to always call it, and not noop away mutex_destroy()
non-CONFIG_DEBUG_MUTEXES kernels?  I thought that was your objection to
Alex's original patch.

But, with or without the noop-mutex_destroy diff hunk,

    Reviewed-by: Andy Ritger <aritger@nvidia.com>

Thanks,
- Andy

> Reported-by: Alex Goins <agoins@nvidia.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/mutex_rt.h |    5 +++++
>  kernel/locking/rtmutex.c |    3 +--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/mutex_rt.h
> +++ b/include/linux/mutex_rt.h
> @@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(str
>  #define mutex_lock_killable(l)		_mutex_lock_killable(l)
>  #define mutex_trylock(l)		_mutex_trylock(l)
>  #define mutex_unlock(l)			_mutex_unlock(l)
> +
> +#ifdef CONFIG_DEBUG_MUTEXES
>  #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
> +#else
> +static inline void mutex_destroy(struct mutex *lock) {}
> +#endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -2027,8 +2027,7 @@ void rt_mutex_destroy(struct rt_mutex *l
>  	lock->magic = NULL;
>  #endif
>  }
> -
> -EXPORT_SYMBOL_GPL(rt_mutex_destroy);
> +EXPORT_SYMBOL(rt_mutex_destroy);
>  
>  /**
>   * __rt_mutex_init - initialize the rt lock
> 
> Sebastian
