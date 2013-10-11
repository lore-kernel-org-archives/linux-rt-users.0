From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.9-rt5 with Atmel AT91SAM9G25 SoC triggers "Trying to free
 already-free IRQ 1"
Date: Fri, 11 Oct 2013 12:09:51 +0200
Message-ID: <20131011100951.GC6983@linutronix.de>
References: <EBD2DE4ADA47B94E831AED12A4B0CADA67E950BA@edb1.wapice.localdomain>
 <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sami =?utf-8?Q?Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>,
	linux-rt-users@vger.kernel.org
To: Michael Langfinger <linux-rt-users@langfinger.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60200 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab3JKKJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 06:09:53 -0400
Content-Disposition: inline
In-Reply-To: <aa8bdc572d2b3fc1f5c1c92293990143-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1FTQ11bSSoDXF1RQFtXWAhY-webmailer2@server02.webmailer.hosteurope.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Michael Langfinger | 2013-09-01 12:40:07 [+0200]:

>Hello Sami,
Hi Michael,

>I attached the output of the boot process (with your patch applied)
>below. The first one is from kernel 3.10.9-rt5 with
>CONFIG_PREEMPT_RT_FULL set, the second one is from kernel 3.10.9-rt5
>with CONFIG_PREEMPT_RTB.
>
>If you need any further information, please let me know!

The problem does not look -RT specific.
>
>Kind regards,
>Michael Langfinger
>
>
>Starting linux kernel ..., machid: 0x1035
>
>Uncompressing Linux... done, booting the kernel.
=E2=80=A6
>NR_IRQS:16 nr_irqs:16 16
>------------[ cut here ]------------
>WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
>Trying to free already-free IRQ 1

here someone calls free_irq() on IRQ1 but it was not requested.

>Modules linked in:
=E2=80=A6
>------------[ cut here ]------------
>WARNING: at kernel/irq/manage.c:1268 __free_irq+0x90/0x1a8()
>Trying to free already-free IRQ 1
The same thing here
>Modules linked in:
=E2=80=A6
>genirq: Flags mismatch irq 16. 00002080 (at91_rtc) vs. 000152a0
>(at91_tick)
The the RTC comes with IRF_ONESHOT but the tick does not want this.

>at91_rtc fffffeb0.rtc: IRQ 16 already in use.
>at91_rtc: probe of fffffeb0.rtc failed with error -16
=E2=80=A6
>genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0
>(at91_tick)
>atmel_serial: atmel_startup - Can't get irq
The same is true for your uart (ttyS0). Since it can't get the interrup=
t
it will unregister and your console will be soon gone.

>Waiting 1sec before mounting root device...
=E2=80=A6
>genirq: Flags mismatch irq 16. 00002080 (ttyS0) vs. 000152a0
>(at91_tick)
>atmel_serial: atmel_startup - Can't get irq
>
>[ the last two lines are repeated several times, then the system
>hangs ]

I don't understand why uart tries over and over to request that
interrupt but it simply doesn't work.
I am a little confused why at91 is having everything (or more than one
device) is on irq 16. It should have only one device on each
interrupt since they have usually dedicated irq lines.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
