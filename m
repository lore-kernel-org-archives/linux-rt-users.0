From: Vivek Satpute <vivek@linsyssoft.com>
Subject: Re: [PATCH-rt 1/1] Fix spinlock issue in net/core/sock.c
Date: Mon, 29 Jun 2009 19:24:17 +0530
Message-ID: <fae6a9700906290654w1e4e258aw3690bf9403c1b777@mail.gmail.com>
References: <1245931645.6269.15.camel@localhost.localdomain>
	 <4de7f8a60906290457v2c25839kd38273323e648428@mail.gmail.com>
	 <fae6a9700906290649j176493f7u39c4ce674a3a66fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: prtproj@linsyssoft.com
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:22084 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZF2NyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Jun 2009 09:54:19 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1668996qwb.37
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2009 06:54:21 -0700 (PDT)
In-Reply-To: <fae6a9700906290649j176493f7u39c4ce674a3a66fc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jan,

(Sending mail again as first mail to mailing-list got bounced due to
Rich Text Format)

On Mon, Jun 29, 2009 at 5:27 PM, Jan Blunck <jblunck@gmail.com> wrote:
>
> On Thu, Jun 25, 2009 at 2:07 PM, Vivek Satpute<vivek@linsyssoft.com> =
wrote:
> > Kernel panic's and reboot while doing network operations such ifcon=
fig
> > and ping on MIPS architecture after RT-patches applied.
> >
> > In case of CONFIG_PREEMPT_RT, after releasing the lock with
> > "spin_unlock", context switch might occur before enabling the botto=
m
> > half with local_bh_enable and this causes the kernel to panic.
> > The issue is resolved by releasing the lock afer acquiring the mute=
x
> > using spin_unlock_bh.
> >
> > Tested the fix on MIPS and X86 architecture.
> >
> > Signed-off-by: Vivek Satpute <vivek@linsyssoft.com>
> > ---
> > net/core/sock.c | =A0 =A08 ++++++++
> > 1 file changed, 8 insertions(+)
> >
> > Index: linux-2.6.28.4/net/core/sock.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.28.4.orig/net/core/sock.c
> > +++ linux-2.6.28.4/net/core/sock.c
> > @@ -1752,12 +1752,20 @@ void lock_sock_nested(struct sock *sk, i
> > =A0 =A0 =A0 =A0if (sk->sk_lock.owned)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__lock_sock(sk);
> > =A0 =A0 =A0 =A0sk->sk_lock.owned =3D 1;
> > +
> > +#ifndef CONFIG_PREEMPT_RT
> > =A0 =A0 =A0 =A0spin_unlock(&sk->sk_lock.slock);
> > +#endif
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * The sk_lock has mutex_lock() semantics here:
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RE=
T_IP_);
> > +
> > +#ifdef CONFIG_PREEMPT_RT
> > + =A0 =A0 =A0 spin_unlock_bh(&sk->sk_lock.slock);
> > +#else
> > =A0 =A0 =A0 =A0local_bh_enable();
> > +#endif
> > =A0}
> >
>
> I don't think you should move the unlock after the mutex_acquire(). I
> guess that this will lead to false positive lockdep warnings.
>
> Anyway, I wonder why using spin_unlock_bh() is fixing the problem tha=
t
> you are having. Do you have more context about the problem or maybe a=
n
> Oops or so?

On firing command "ifconfig", I get following messages:

--------------------------------<snip>--------------------------------
# ifconfig
Kernel panic - not syncing: Aiee, killing interrupt handler!
Rebooting in 1 seconds..
--------------------------------<snip>--------------------------------


If kernel compiled with Lock Debugging options then it gives following
call trace:

--------------------------------<snip>--------------------------------
Call Trace:
[<80111768>] dump_stack+0x8/0x34
[<8012e9a0>] warn_on_slowpath+0x60/0x88
[<80135b48>] local_bh_enable+0x40/0x11c
[<8035d05c>] lock_sock_nested+0xf8/0x11c
[<803bbba8>] inet_bind+0x100/0x210
[<803d7888>] xs_bind4+0x70/0x158
[<803d9ac0>] xs_udp_connect_worker4+0x120/0x1a4
[<801440f8>] run_workqueue+0x1d0/0x264
[<801450ac>] worker_thread+0x7c/0xec
[<80148f70>] kthread+0x58/0x94
[<8010cc2c>] kernel_thread_helper+0x10/0x18
--------------------------------<snip>--------------------------------


>
> Thanks,
> Jan
>
> > =A0EXPORT_SYMBOL(lock_sock_nested);
> >
> >
> >
> >
> > Thanks and Regards,
> > Vivek Satpute
> > System Software Engineer
> > LinSysSoft Technologies, Pune
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >

Thanks and Regards,
Vivek Satpute
System Software Engineer
LinSysSoft Technologies, Pune
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
