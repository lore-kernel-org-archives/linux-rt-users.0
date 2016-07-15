From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 15 Jul 2016 21:48:55 +0200
Message-ID: <77528485.4aTSS092zh@wuerfel>
References: <E1bNugf-00064t-KA@optimist> <2319169.Jp9upmpu5F@wuerfel> <20160715132305.GD11606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160715132305.GD11606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday, July 15, 2016 3:23:05 PM CEST Sebastian Andrzej Siewior wrot=
e:
> * Arnd Bergmann | 2016-07-15 14:29:31 [+0200]:
>=20
> >Agreed, but it's hard for the compiler to figure that out. On mainli=
ne,
>=20
> we have the same thing in drivers/tty/serial/8250/8250_port.c btw. Do=
n't
> see the warning there.

Interesting, I also see no substantial difference, my best guess is
that the warning appears or disappears based on some inlining
choices that can vary.

I also notice that your "tty: serial: 8250: don't take the trylock
during oops" patch would apply on the pl011 driver as well.

> >we have this instead:
> >
> >       local_irq_save(flags);
> >       if (uap->port.sysrq)
> >               locked =3D 0;
> >       else if (oops_in_progress)
> >               locked =3D spin_trylock(&uap->port.lock);
> >       else
> >               spin_lock(&uap->port.lock);
> >=E2=80=A6
> >       if (locked)
> >               spin_unlock(&uap->port.lock);
> >       local_irq_restore(flags);
> >
> >which looks like it's intentionally written to avoid the warning
> >and was changed by Thomas in "tty/serial/pl011: Make the locking wor=
k on RT":
> >
> >http://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/c=
ommit/drivers/tty/serial/amba-pl011.c?h=3Dv4.4-rt-rebase&id=3D7b537b66f=
cb12c40eb1b10eb352d570a9d34a657
> >
> >Maybe there is another way to write this upstream that avoids the
> >warning.
>=20
> I don't see any other way around except for initializing flags upfron=
t:

Sure, that always works, it's just a bit ugly since the flags word
should never be zero when it gets written back to the hardware irq
state, at least in portable code.

Maybe something like the version below?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
index 8a9e213387a7..676fcfa7fce4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2158,22 +2158,9 @@ static void pl011_console_putchar(struct uart_po=
rt *port, int ch)
 }
=20
 static void
-pl011_console_write(struct console *co, const char *s, unsigned int co=
unt)
+__pl011_console_write(struct uart_amba_port *uap, const char *s, unsig=
ned int count)
 {
-	struct uart_amba_port *uap =3D amba_ports[co->index];
 	unsigned int old_cr =3D 0, new_cr;
-	unsigned long flags;
-	int locked =3D 1;
-
-	clk_enable(uap->clk);
-
-	local_irq_save(flags);
-	if (uap->port.sysrq)
-		locked =3D 0;
-	else if (oops_in_progress)
-		locked =3D spin_trylock(&uap->port.lock);
-	else
-		spin_lock(&uap->port.lock);
=20
 	/*
 	 *	First save the CR then disable the interrupts
@@ -2195,10 +2182,24 @@ pl011_console_write(struct console *co, const c=
har *s, unsigned int count)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
+}
=20
-	if (locked)
-		spin_unlock(&uap->port.lock);
-	local_irq_restore(flags);
+
+static void
+pl011_console_write(struct console *co, const char *s, unsigned int co=
unt)
+{
+	struct uart_amba_port *uap =3D amba_ports[co->index];
+	unsigned long flags;
+
+	clk_enable(uap->clk);
+
+	if (uap->port.sysrq || oops_in_progress) {
+		__pl011_console_write(uap, s, count);
+	} else {
+		spin_lock_irqsave(&uap->port.lock, flags);
+		__pl011_console_write(uap, s, count);
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+	}
=20
 	clk_disable(uap->clk);
 }
