From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Fri, 29 Oct 2010 15:52:46 +0200
Message-ID: <AANLkTim1aj1Pc33qJ66AbnAf+SQQxoSVk--a1d=hpgNn@mail.gmail.com>
References: <AANLkTi=TyvXEtoZGatP5pxymLSna9g6ULV46i72bYgc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <david-b@pacbell.net>,
	ARM Linux Mailing List
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Aras Vaichas <arasv@magellan-technology.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65188 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377Ab0J2Nwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Oct 2010 09:52:47 -0400
Received: by gxk23 with SMTP id 23so1968830gxk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Oct 2010 06:52:47 -0700 (PDT)
In-Reply-To: <AANLkTi=TyvXEtoZGatP5pxymLSna9g6ULV46i72bYgc4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2010/10/29 Aras Vaichas <arasv@magellan-technology.com>:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0On AT91 David Brownell noticed seve=
ral months
>> > ago that the DBGU can miss some characters on NO_HZ. I would expec=
t
>> > that this would be better now due to the shorter interrupt handler=
,
>> > although it was not my goal to solve it with these patches.
>> The current (kernel.org git) AT91 timer handler incorporates a bugfi=
x
>> in that area, which seemed to resolve most of those problems.
>> - Dave
>
> Hello,
>
> I'm sorry to bother you two off-list, but I'm trying to avoid too muc=
h
> noise on the lists.

Please, always at least CC to the mailinglist as well.

> My issue is related to these two posts (and the re: above):
>
> http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg02115.h=
tml
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/94652
>
> If I change the Atmel serial interrupt to IRQF_NODELAY, then *most* o=
f
> the overruns go away and DBGU works as it should.
>
> --- A/drivers/serial/atmel_serial.c =A0 2010-08-03 03:27:18.000000000=
 +1000
> +++ B/drivers/serial/atmel_serial.c 2010-10-29 10:24:54.000000000 +11=
00
> @@ -808,7 +818,7 @@
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Allocate the IRQ
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt, IRQF=
_SHARED,
> + =A0 =A0 =A0 retval =3D request_irq(port->irq, atmel_interrupt, IRQF=
_NODELAY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tty ? tty->name : "atm=
el_serial", port);
> =A0 =A0 =A0 =A0if (retval) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("atmel_serial: atmel_startup - =
Can't get irq\n");
>
>
> But shouldn't the DBGU interrupt already be running in NODELAY contex=
t
> according to Remy's post? =A0I understand that NODELAY has many other
> complications, this is just a test to get an idea of which direction
> to move in.

On preempt-RT this driver always has NODELAY set by default. AFAIK, it
is not in mainline.

Notice that on recent kernels also the request_threaded_irq()
mechanism can be used, which is much cleaner compared to the NODELAY
change.
So, I guess the NODELAY change will never hit mainline since this
better solution exist.

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
