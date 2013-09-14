From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Sat, 14 Sep 2013 14:24:34 +0200
Message-ID: <52345582.7020000@colorfullife.com>
References: <1379051751.5455.112.camel@marge.simpson.net> <1379052760.5455.127.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:44903 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3INMYj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Sep 2013 08:24:39 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so857782bkb.31
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Sep 2013 05:24:38 -0700 (PDT)
In-Reply-To: <1379052760.5455.127.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mike,

On 09/13/2013 08:12 AM, Mike Galbraith wrote:
> goto again loop can and does induce livelock in -rt.  Remove it.
>
> spin_unlock_wait(lock) in -rt kernels takes/releases the lock in question, so
> all it takes to create a self perpetuating loop is for one task to start the
> ball rolling by taking the array lock, other tasks see this, and react by
> take/release/retry endlessly.
>
> Signed-off-by: Mike Galbraith <bitbucket@online.de>
>
> ---
>   ipc/sem.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 38 insertions(+), 18 deletions(-)
>
> Index: linux-2.6/ipc/sem.c
> ===================================================================
> --- linux-2.6.orig/ipc/sem.c
> +++ linux-2.6/ipc/sem.c
> @@ -247,11 +256,22 @@ static inline int sem_lock(struct sem_ar
>   		 */
>    lock_array:
>   		spin_lock(&sma->sem_perm.lock);
> + wait_array:
>   		for (i = 0; i < sma->sem_nsems; i++) {
> -			struct sem *sem = sma->sem_base + i;
> +			sem = sma->sem_base + i;
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +			if (spin_is_locked(&sem->lock))
> +#endif
>   			spin_unlock_wait(&sem->lock);
>   		}
>   
I don't like this part of the change:
It reads like a micro-optimization for spin_unlock_wait() within the 
ipc/sem.c code.

If spin_unlock_wait() for CONFIG_PREEMPT_RT_BASE is broken, then the 
implementation of spin_unlock_wait() should be fixed.

Something like
#define spin_unlock_wait(x) if(spin_is_locked(x)) __spin_unlock_wait(x)

--
     Manfred
