From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 15 Jul 2016 14:05:27 +0200
Message-ID: <20160715120527.GB11606@linutronix.de>
References: <E1bNugf-00064t-KA@optimist>
 <4402302.GjsxlnvCX4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46787 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906AbcGOMFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 08:05:35 -0400
Content-Disposition: inline
In-Reply-To: <4402302.GjsxlnvCX4@wuerfel>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Arnd Bergmann | 2016-07-15 09:07:20 [+0200]:

>Cc linux-rt-users@vger.kernel.org, let's have a look at the individual=
 warnings:
thanks.

>
>> Warnings Summary: 5
>> 	  9 ../kernel/sched/core.c:3473:12: warning: 'preemptible_lazy' def=
ined but not used [-Wunused-function]
>
>This was introduced by the rt patchset, I'd suggest adding a fix to th=
e next
>v4.4-rt release. This is almost certainly harmless.

has been adressed in 4.6.4-rt8 and is harmless.

>> 	  2 ../include/linux/spinlock.h:246:3: warning: 'flags' may be used=
 uninitialized in this function [-Wmaybe-uninitialized]
>
>I'm missing context here, so I don't know what caused it, but the warn=
ing is
>not present in v4.4.12 (without -rt), so it's worth looking into.

the full log:

|In file included from include/linux/seqlock.h:35:0,
|                 from include/linux/time.h:5,
|                 from include/uapi/linux/timex.h:56,
|                 from include/linux/timex.h:56,
|                 from include/linux/sched.h:19,
|                 from arch/arm64/include/asm/compat.h:25,
|                 from arch/arm64/include/asm/stat.h:23,
|                 from include/linux/stat.h:5,
|                 from include/linux/module.h:10,
|                 from drivers/tty/serial/amba-pl011.c:37:
|drivers/tty/serial/amba-pl011.c: In function =E2=80=98pl011_console_wr=
ite=E2=80=99:
|include/linux/spinlock.h:246:3: warning: =E2=80=98flags=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
|   _raw_spin_unlock_irqrestore(lock, flags); \
|   ^
|drivers/tty/serial/amba-pl011.c:2065:16: note: =E2=80=98flags=E2=80=99=
 was declared here
|  unsigned long flags;
|                ^

and relevant part of the source:
|pl011_console_write(struct console *co, const char *s, unsigned int co=
unt)
|{
=E2=80=A6
|        unsigned long flags;
|        int locked =3D 1;
|
=E2=80=A6
|        if (uap->port.sysrq)
|                locked =3D 0;
|        else if (oops_in_progress)
|                locked =3D spin_trylock_irqsave(&uap->port.lock, flags=
);
|        else
|                spin_lock_irqsave(&uap->port.lock, flags);
=E2=80=A6
|        if (locked)
|                spin_unlock_irqrestore(&uap->port.lock, flags);
=E2=80=A6
|}

looks like a false positive to me.

>	Arnd

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
