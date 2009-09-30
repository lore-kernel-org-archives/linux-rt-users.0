From: Remy Bohmer <linux@bohmer.net>
Subject: Re: 2.6.31-rt11 freeze on userland start on ARM
Date: Wed, 30 Sep 2009 18:11:01 +0200
Message-ID: <3efb10970909300911j44638434mc22adfd64aaef421@mail.gmail.com>
References: <3efb10970909211136g4e74c8b3vc339d548cdd0959f@mail.gmail.com>
	 <alpine.LFD.2.00.0909301448030.2518@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754872AbZI3QK7@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0909301448030.2518@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

Thanks for your answer. But it is not entirely clear to me...

2009/9/30 Thomas Gleixner <tglx@linutronix.de>:
> On Mon, 21 Sep 2009, Remy Bohmer wrote:
>> So, as workaround/test I made this change:
>>
>> Index: linux-2.6.31/drivers/serial/atmel_serial.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.31.orig/drivers/serial/atmel_serial.c =A0 2009-09-21
>> 19:44:48.000000000 +0200
>> +++ linux-2.6.31/drivers/serial/atmel_serial.c =A0 =A0 =A0 =A02009-0=
9-21
>> 19:45:15.000000000 +0200
>> @@ -808,7 +808,8 @@ static int atmel_startup(struct uart_por
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Allocate the IRQ
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt, IRQF_SH=
ARED,
>> + =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SHARED | IRQF_NODELAY=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty ? tty->name : "atmel=
_serial", port);
>> =A0 =A0 =A0 if (retval) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("atmel_serial: atmel_startup - Ca=
n't get irq\n");
>
> The serial irq cannot run in hard irq context.

Indeed most drivers cannot, but for this particular handler can you
please explain me why?
Maybe I am missing some new mechanism that prevents it that was not
there on older RT-kernels (tested up-to latest 2.6.24-rt +
2.6.26-rt)...
The atmel_serial IRQ was adapted such (I think it was mainlined in
2.6.25 already) to make it suitable to run in hard-irq context. (I
know, because I did that myself)
=46WIW... it seems to run stable in hard-irq context on 2.6.31-rt with
the patch above as well... (coincidence?)

> There are two solutions to this problem:
>
> 1) Use the other timer which is available on AT91.

You mean the TC-timer? This is what I am actually using as well. But
that does not solve the problem... Hmm, I do not use the clockevent
part of that TC-lib, because I needed that 3th block for something
else. (and 32kHz is not a very pleasant timer to use as well...)
So, I guess this is not an option for me, and need to move to the next =
option...

> 2) Make the serial driver explicitely threaded and check in the
> hardirq handler whether the irq originated from the serial driver. If
> yes, disable it in the serial device and return IRQ_WAKE_THREAD
> otherwise return IRQ_NONE.

Interesting, this sounds new, and I have to dig into it to find out
how this is supposed to work... Do you happen to have any good
pointers for examples or doc?
TOL: could the generic interrupt code not check for this? It can see
the timer interrupt handler not returning 'IRQ_HANDLED', and still see
the interrupt being active, and know that there is a IRQ thread on the
same line, so it can conclude itself to mask the source in the
interrupt controller and wake the thread... Or am I wrong?

Kind regards,

Remy
