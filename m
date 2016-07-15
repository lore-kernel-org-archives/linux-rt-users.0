From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 15 Jul 2016 14:29:31 +0200
Message-ID: <2319169.Jp9upmpu5F@wuerfel>
References: <E1bNugf-00064t-KA@optimist> <4402302.GjsxlnvCX4@wuerfel> <20160715120527.GB11606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51758 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbcGOM3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 08:29:46 -0400
In-Reply-To: <20160715120527.GB11606@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday, July 15, 2016 2:05:27 PM CEST Sebastian Andrzej Siewior wrot=
e:
> * Arnd Bergmann | 2016-07-15 09:07:20 [+0200]:
>=20
> >Cc linux-rt-users@vger.kernel.org, let's have a look at the individu=
al warnings:
> thanks.
>=20
> >
> >> Warnings Summary: 5
> >> 	  9 ../kernel/sched/core.c:3473:12: warning: 'preemptible_lazy' d=
efined but not used [-Wunused-function]
> >
> >This was introduced by the rt patchset, I'd suggest adding a fix to =
the next
> >v4.4-rt release. This is almost certainly harmless.
>=20
> has been adressed in 4.6.4-rt8 and is harmless.

Ok.

> |drivers/tty/serial/amba-pl011.c: In function =E2=80=98pl011_console_=
write=E2=80=99:
> |include/linux/spinlock.h:246:3: warning: =E2=80=98flags=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
> |   _raw_spin_unlock_irqrestore(lock, flags); \
> |   ^
> |drivers/tty/serial/amba-pl011.c:2065:16: note: =E2=80=98flags=E2=80=99=
 was declared here
> |  unsigned long flags;
> |                ^
>=20
> and relevant part of the source:
> |pl011_console_write(struct console *co, const char *s, unsigned int =
count)
> |{
> =E2=80=A6
> |        unsigned long flags;
> |        int locked =3D 1;
> |
> =E2=80=A6
> |        if (uap->port.sysrq)
> |                locked =3D 0;
> |        else if (oops_in_progress)
> |                locked =3D spin_trylock_irqsave(&uap->port.lock, fla=
gs);
> |        else
> |                spin_lock_irqsave(&uap->port.lock, flags);
> =E2=80=A6
> |        if (locked)
> |                spin_unlock_irqrestore(&uap->port.lock, flags);
> =E2=80=A6
> |}
>=20
> looks like a false positive to me.

Agreed, but it's hard for the compiler to figure that out. On mainline,
we have this instead:

       local_irq_save(flags);
       if (uap->port.sysrq)
               locked =3D 0;
       else if (oops_in_progress)
               locked =3D spin_trylock(&uap->port.lock);
       else
               spin_lock(&uap->port.lock);
=E2=80=A6
       if (locked)
               spin_unlock(&uap->port.lock);
       local_irq_restore(flags);

which looks like it's intentionally written to avoid the warning
and was changed by Thomas in "tty/serial/pl011: Make the locking work o=
n RT":

http://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/comm=
it/drivers/tty/serial/amba-pl011.c?h=3Dv4.4-rt-rebase&id=3D7b537b66fcb1=
2c40eb1b10eb352d570a9d34a657

Maybe there is another way to write this upstream that avoids the
warning.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
