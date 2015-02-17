From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT]  rt: add rwsem_is_contended() definition to rwsem_rt.h
Date: Tue, 17 Feb 2015 11:09:11 +0100
Message-ID: <20150217100911.GG26177@linutronix.de>
References: <20140827160928.6f323642@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140827160928.6f323642@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Clark Williams | 2014-08-27 16:09:28 [-0500]:

>Thomas,
>
>The latest btrfs code uses rwsem_is_contended() in the function
>caching_thread(). On RT systems, include/linux/rwsem.h is replaced with
>include/linux/rwsem_rt.h which does not provide a definition for
>rwsem_is_contended().  This commit provides a definition that should
>work on RT (where the lock is actually an rt_mutex).

I see that I added rwsem_is_contended() in v3.14-rt1 which does:
|static inline int rwsem_is_contended(struct rw_semaphore *sem)
|{
|      /* rt_mutex_has_waiters() */
|      return !RB_EMPTY_ROOT(&sem->lock.waiters);
|}

Do you lack this in kernel prior to v3.14?

Sebastian
