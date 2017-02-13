From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Mon, 13 Feb 2017 14:04:35 +0100
Message-ID: <20170213130435.zlfznlkqmainxqod@linutronix.de>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com>
 <20170126170109.6zhoohgodtvxot54@linutronix.de>
 <20170130173534.GA24966@prokofiev.nvidia.com>
 <20170203155434.utptndmoskcyimn7@linutronix.de>
 <20170203164924.GB19814@prokofiev.nvidia.com>
 <20170210175049.3cvrk5ki7c6uiblg@linutronix.de>
 <20170213112052.GA6557@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andy Ritger <aritger@nvidia.com>, Alex Goins <agoins@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170213112052.GA6557@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-02-13 12:20:52 [+0100], Peter Zijlstra wrote:
> > --- a/include/linux/mutex_rt.h
> > +++ b/include/linux/mutex_rt.h
> > @@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(str
> >  #define mutex_lock_killable(l)		_mutex_lock_killable(l)
> >  #define mutex_trylock(l)		_mutex_trylock(l)
> >  #define mutex_unlock(l)			_mutex_unlock(l)
> > +
> > +#ifdef CONFIG_DEBUG_MUTEXES
> >  #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
> > +#else
> > +static inline void mutex_destroy(struct mutex *lock) {}
> > +#endif
> >  
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -2027,8 +2027,7 @@ void rt_mutex_destroy(struct rt_mutex *l
> >  	lock->magic = NULL;
> >  #endif
> >  }
> > -
> > -EXPORT_SYMBOL_GPL(rt_mutex_destroy);
> > +EXPORT_SYMBOL(rt_mutex_destroy);
> 
> I don't understand:
> 
> $ git grep "EXPORT_SYMBOL.*mutex_destroy"
> kernel/locking/mutex-debug.c:EXPORT_SYMBOL_GPL(mutex_destroy);
> kernel/locking/rtmutex.c:EXPORT_SYMBOL_GPL(rt_mutex_destroy);
> 
> Your proposed patch makes it different from mainline.

as discussed off-list, I will drop that _GPL removal hunk and keep only
the (first) inline hunk.
!GPL users should compile with !CONFIG_DEBUG_MUTEXES and
!CONFIG_DEBUG_RT_MUTEXES so there should be no regression.

Sebastian
