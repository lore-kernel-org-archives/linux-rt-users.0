From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 15 Jul 2016 15:23:05 +0200
Message-ID: <20160715132305.GD11606@linutronix.de>
References: <E1bNugf-00064t-KA@optimist>
 <4402302.GjsxlnvCX4@wuerfel>
 <20160715120527.GB11606@linutronix.de>
 <2319169.Jp9upmpu5F@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47031 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcGONXN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 09:23:13 -0400
Content-Disposition: inline
In-Reply-To: <2319169.Jp9upmpu5F@wuerfel>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Arnd Bergmann | 2016-07-15 14:29:31 [+0200]:

>Agreed, but it's hard for the compiler to figure that out. On mainline=
,

we have the same thing in drivers/tty/serial/8250/8250_port.c btw. Don'=
t
see the warning there.

>we have this instead:
>
>       local_irq_save(flags);
>       if (uap->port.sysrq)
>               locked =3D 0;
>       else if (oops_in_progress)
>               locked =3D spin_trylock(&uap->port.lock);
>       else
>               spin_lock(&uap->port.lock);
>=E2=80=A6
>       if (locked)
>               spin_unlock(&uap->port.lock);
>       local_irq_restore(flags);
>
>which looks like it's intentionally written to avoid the warning
>and was changed by Thomas in "tty/serial/pl011: Make the locking work =
on RT":
>
>http://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/com=
mit/drivers/tty/serial/amba-pl011.c?h=3Dv4.4-rt-rebase&id=3D7b537b66fcb=
12c40eb1b10eb352d570a9d34a657
>
>Maybe there is another way to write this upstream that avoids the
>warning.

I don't see any other way around except for initializing flags upfront:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2161,18 +2161,17 @@ pl011_console_write(struct console *co, const c=
har *s, unsigned int count)
 {
 	struct uart_amba_port *uap =3D amba_ports[co->index];
 	unsigned int old_cr =3D 0, new_cr;
-	unsigned long flags;
+	unsigned long flags =3D 0;
 	int locked =3D 1;
=20
 	clk_enable(uap->clk);
=20
-	local_irq_save(flags);
 	if (uap->port.sysrq)
 		locked =3D 0;
 	else if (oops_in_progress)
-		locked =3D spin_trylock(&uap->port.lock);
+		locked =3D spin_trylock_irqsave(&uap->port.lock, flags);
 	else
-		spin_lock(&uap->port.lock);
+		spin_lock_irqsave(&uap->port.lock, flags);
=20
 	/*
 	 *	First save the CR then disable the interrupts
@@ -2196,8 +2195,7 @@ pl011_console_write(struct console *co, const cha=
r *s, unsigned int count)
 		pl011_write(old_cr, uap, REG_CR);
=20
 	if (locked)
-		spin_unlock(&uap->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&uap->port.lock, flags);
=20
 	clk_disable(uap->clk);
 }

>	Arnd

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
