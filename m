From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] Align rt_mutex inlining with upstream behavior
Date: Sat, 11 Feb 2017 21:15:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702112114180.3734@nanos>
References: <1485312350-1265-1-git-send-email-agoins@nvidia.com> <20170126170109.6zhoohgodtvxot54@linutronix.de> <20170130173534.GA24966@prokofiev.nvidia.com> <20170203155434.utptndmoskcyimn7@linutronix.de> <20170203164924.GB19814@prokofiev.nvidia.com>
 <20170210175049.3cvrk5ki7c6uiblg@linutronix.de> <20170210180929.GC9583@prokofiev.nvidia.com> <20170210182807.6gzs3xn3ga727xsb@linutronix.de> <20170211175241.GA30998@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1750608412-1486844104=:3734"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Ritger <aritger@nvidia.com>,
        Alex Goins <agoins@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170211175241.GA30998@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1750608412-1486844104=:3734
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 11 Feb 2017, Ingo Molnar wrote:

> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2017-02-10 10:09:29 [-0800], Andy Ritger wrote:
> > > Is the
> > > 
> > >     WARN_ON(rt_mutex_is_locked(lock));
> > > 
> > > in rt_mutex_destroy() valuable in non-CONFIG_DEBUG_MUTEXES kernels,
> > > such that it would be better to always call it, and not noop away mutex_destroy()
> > > non-CONFIG_DEBUG_MUTEXES kernels?  I thought that was your objection to
> > > Alex's original patch.
> > 
> > It kind of was…
> > So first I removed the GPL symbol. Then I wasn't too happy about it
> > especially since it was not introduced as part of RT. So I reverted that
> > changed and aligned with mainline behaviour (the mutex_rt.h hunk). But
> > then I noticed that with CONFIG_DEBUG_MUTEXES=n and
> > CONFIG_DEBUG_RT_MUTEXES=y we still have a regression compared to !RT and
> > this was the initial motivation to fix things.
> > Then I got curious why mutex_lock() (which is essential rt_mutex_lock())
> > works and noticed the wrapper around it. And while looking at it I
> > decided to go back to strip the GPL part from export symbol instead of
> > adding a wrapper. And here I am.
> > Then I was looking at the patch and decided to align with mainline (and
> > keep that one hunk) in case Ingo ask for his GPL symbol.
> 
> tglx and Peter Zijlstra are main co-authors of kernel/locking/rtmutex.c, and every 
> author (copyright holder) has to agree to changing a GPL export of a kernel 
> subsystem's API to a non-GPL export.

I'm fine with that change as it really hurts users and makes RT behave the
same way as mainline.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
--8323329-1750608412-1486844104=:3734--
