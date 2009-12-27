From: Vivek Satpute <vivek@linsyssoft.com>
Subject: Re: [PATCH-rt 1/1] Fix spinlock issue in net/core/sock.c
Date: Sun, 27 Dec 2009 13:45:44 +0530
Message-ID: <1261901744.1820.143.camel@localhost>
References: <1245931645.6269.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41863 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZL0ILv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Dec 2009 03:11:51 -0500
Received: by pzk1 with SMTP id 1so2343124pzk.33
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Dec 2009 00:11:49 -0800 (PST)
In-Reply-To: <1245931645.6269.15.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I want to keep this thread alive. Has anyone encountered/tested this
issue ?

Thanks and Regards,
Vivek Satpute
System Software Engineer
LinSysSoft Technologies, Pune


On Thu, 2009-06-25 at 17:37 +0530, Vivek Satpute wrote:
> Kernel panic's and reboot while doing network operations such ifconfig
> and ping on MIPS architecture after RT-patches applied.
> 
> In case of CONFIG_PREEMPT_RT, after releasing the lock with
> "spin_unlock", context switch might occur before enabling the bottom
> half with local_bh_enable and this causes the kernel to panic.
> The issue is resolved by releasing the lock afer acquiring the mutex
> using spin_unlock_bh.
> 
> Tested the fix on MIPS and X86 architecture.
> 
> Signed-off-by: Vivek Satpute <vivek@linsyssoft.com>
> ---
> net/core/sock.c |    8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> Index: linux-2.6.28.4/net/core/sock.c
> ===================================================================
> --- linux-2.6.28.4.orig/net/core/sock.c
> +++ linux-2.6.28.4/net/core/sock.c
> @@ -1752,12 +1752,20 @@ void lock_sock_nested(struct sock *sk, i
>  	if (sk->sk_lock.owned)
>  		__lock_sock(sk);
>  	sk->sk_lock.owned = 1;
> +
> +#ifndef CONFIG_PREEMPT_RT
>  	spin_unlock(&sk->sk_lock.slock);
> +#endif
>  	/*
>  	 * The sk_lock has mutex_lock() semantics here:
>  	 */
>  	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
> +
> +#ifdef CONFIG_PREEMPT_RT
> +	spin_unlock_bh(&sk->sk_lock.slock);
> +#else
>  	local_bh_enable();
> +#endif
>  }
>  
>  EXPORT_SYMBOL(lock_sock_nested);
> 
> 
> 
> 
> Thanks and Regards,
> Vivek Satpute
> System Software Engineer
> LinSysSoft Technologies, Pune
> 


