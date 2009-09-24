From: yi li <liyi.dev@gmail.com>
Subject: Re: 2.6.31-rt11 freeze on userland start on ARM
Date: Thu, 24 Sep 2009 17:27:07 +0800
Message-ID: <a0e7fce50909240227g47575398x7714a2839b90460c@mail.gmail.com>
References: <3efb10970909211136g4e74c8b3vc339d548cdd0959f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:36453 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZIXJfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 05:35:14 -0400
In-Reply-To: <3efb10970909211136g4e74c8b3vc339d548cdd0959f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I met similar problem on Blackfin (BF537) using 2.6.31-rt10 (I made
some local changes to make 2.6.31-rt10 built for Blackfin).
The "init" process tries to print on serial console, but it can't.

But in my case, I do NOT think the reason is that "kernel continuously
schedules a IRQ-thread, namely IRQ1-atmel_serial".
Instead, the serial TX irq handler thread never get scheduled  - this
irq handler has no chance to run.

Setting serial TX/RX irqs to "IRQF_NODELAY" would boot the kernel. But
this should no be a correct fix.

So this looks like a common issue. Is there any way to debug or fix thi=
s?

Regards,
-Yi

On Tue, Sep 22, 2009 at 2:36 AM, Remy Bohmer <linux@bohmer.net> wrote:
> Hi all,
>
> I am integrating the 2.6.31-rt11 kernel on our ARM9 based (Atmel
> at91sam9261) board.
> Kernel boots fine but when userland starts the linuxrc process, and
> the first 'echo' from the /etc/init.d/rcS script is printed to the
> serial console (DBGU) the system locks up completely, from userland n=
o
> character ever makes it to the terminal.
>
> I found the reason of the lockup and know a workaround, but I can use
> some good suggestions to solve it the correct way.
>
> What happens is that the kernel continuously schedules a IRQ-thread;
> namely IRQ1-atmel_serial. And this IRQ thread keeps getting scheduled
> forever...
>
> Looking more closely I noticed that it is new compared to 2.6.24/26-R=
T
> that a IRQ thread is started for this driver.
> Notice that the DBGU interrupt is called the system-interrupt and it
> is shared with the timer interrupt. The timer interrupt has IRQF_TIME=
R
> set which incorporates IRQF_NODELAY. This is different compared to
> 2.6.24/26 where a sharing with a IRQF_NODELAY interrupt would make al=
l
> shared handlers also run in IRQF_NODELAY context.
> As such we have here a interrupt handler running as NODELAY handler,
> that is shared with a interrupt handler that runs in thread context.
>
> So, as workaround/test I made this change:
>
> Index: linux-2.6.31/drivers/serial/atmel_serial.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/serial/atmel_serial.c =A0 =A0 2009-09-2=
1
> 19:44:48.000000000 +0200
> +++ linux-2.6.31/drivers/serial/atmel_serial.c =A02009-09-21
> 19:45:15.000000000 +0200
> @@ -808,7 +808,8 @@ static int atmel_startup(struct uart_por
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Allocate the IRQ
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt, IRQF=
_SHARED,
> + =A0 =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SHARED | IRQF_NODE=
LAY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tty ? tty->name : "atm=
el_serial", port);
> =A0 =A0 =A0 =A0if (retval) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("atmel_serial: atmel_startup - =
Can't get irq\n");
> ---
>
> This change makes the atmel-serial driver interrupt handler run as
> IRQF_NODELAY handler again, just as on 2.6.24/26, and the board is
> booting properly again with 2.6.31.
> Anyone any ideas how to fix it properly? Or interested in more
> debugging information. (I have an ETM tracer hooked up...)
>
> Notice that this driver actually needs the NODELAY flag set on
> preempt-RT to prevent missing characters with its 1 byte FIFO-hardwar=
e
> without flow-control ;-) =A0(I will provide a clean patch later)
> For now, at least it shows a bug in the new irq-threading mechanisms.=
=2E.
>
> I also have a few related questions, besides investigating the
> root-cause of this bug:
> What is the rationale behind the per-driver irq-thread? What is the
> gain here for RT? My first impression is that this would increase the
> latencies in case of sharing interrupts with NODELAY interrupts. All
> handlers need to run, so the master interrupt cannot be enabled again
> until all IRQ-threads have run, so the NODELAY handler must wait unti=
l
> all IRQ-threads have run. So, giving different prios to the
> IRQ-threads that share the same source would increase the latencies
> even more.
> If different drivers share the same interrupt line, even additional
> schedule overhead can be added to the latencies...
> On first impression the former implementation seems more efficient. I
> guess it is changed for a good reason, so, I must be missing somethin=
g
> here... I hope someone can explain...
>
> Kind regards,
>
> Remy
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
