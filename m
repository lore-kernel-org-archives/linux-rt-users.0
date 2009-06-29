From: Jan Blunck <jblunck@gmail.com>
Subject: Re: [PATCH-rt 1/1] Fix spinlock issue in net/core/sock.c
Date: Mon, 29 Jun 2009 13:57:52 +0200
Message-ID: <4de7f8a60906290457v2c25839kd38273323e648428@mail.gmail.com>
References: <1245931645.6269.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, prtproj@linsyssoft.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Vivek Satpute <vivek@linsyssoft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:45371 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZF2L5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jun 2009 07:57:51 -0400
Received: by fg-out-1718.google.com with SMTP id e21so878402fga.17
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 04:57:53 -0700 (PDT)
In-Reply-To: <1245931645.6269.15.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jun 25, 2009 at 2:07 PM, Vivek Satpute<vivek@linsyssoft.com> wr=
ote:
> Kernel panic's and reboot while doing network operations such ifconfi=
g
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
> net/core/sock.c | =A0 =A08 ++++++++
> 1 file changed, 8 insertions(+)
>
> Index: linux-2.6.28.4/net/core/sock.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.28.4.orig/net/core/sock.c
> +++ linux-2.6.28.4/net/core/sock.c
> @@ -1752,12 +1752,20 @@ void lock_sock_nested(struct sock *sk, i
> =A0 =A0 =A0 =A0if (sk->sk_lock.owned)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__lock_sock(sk);
> =A0 =A0 =A0 =A0sk->sk_lock.owned =3D 1;
> +
> +#ifndef CONFIG_PREEMPT_RT
> =A0 =A0 =A0 =A0spin_unlock(&sk->sk_lock.slock);
> +#endif
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The sk_lock has mutex_lock() semantics here:
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_=
IP_);
> +
> +#ifdef CONFIG_PREEMPT_RT
> + =A0 =A0 =A0 spin_unlock_bh(&sk->sk_lock.slock);
> +#else
> =A0 =A0 =A0 =A0local_bh_enable();
> +#endif
> =A0}
>

I don't think you should move the unlock after the mutex_acquire(). I
guess that this will lead to false positive lockdep warnings.

Anyway, I wonder why using spin_unlock_bh() is fixing the problem that
you are having. Do you have more context about the problem or maybe an
Oops or so?

Thanks,
Jan

> =A0EXPORT_SYMBOL(lock_sock_nested);
>
>
>
>
> Thanks and Regards,
> Vivek Satpute
> System Software Engineer
> LinSysSoft Technologies, Pune
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
