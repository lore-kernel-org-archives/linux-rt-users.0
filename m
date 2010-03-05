From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Disabling lapic timer for a certain core
Date: Fri, 5 Mar 2010 14:54:51 +0100 (CET)
Message-ID: <8898.1267797291298.JavaMail.ngmail@webmail11.arcor-online.net>
References: <alpine.LFD.2.00.1003050659380.2014@localhost.localdomain> <6756648.1267736627501.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lclaudio@uudg.org, linux-rt-users@vger.kernel.org
To: tglx@linutronix.de, mathias_koehrer@arcor.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:43620 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820Ab0CENyw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Mar 2010 08:54:52 -0500
In-Reply-To: <alpine.LFD.2.00.1003050659380.2014@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,=20

thank you very much for the reply.
> Please do _NOT_ top post. Please reply inline and in context.
Sorry for that...

> > The issue is here, that the interrupt routine of the kernel
> > takes too long here.
> > It would be fine to have the timer interrupt called more=20
> > often and to process with each call only a subset of the=20
> > jobs to be done...
> > This would reduce the time the CPU the user mode=20
> > is interrupted by the timer routine.
>=20
> Err, by splitting the work you introduce even more overhead. That's
> the wrong approach. The first question is which timers are running on
> that CPU as you have isolated it.
You are right. The total overhead is of course larger.
However, the overhead that could appear within a single of our 40us loo=
ps
would be smaller. It is fine for me to have a 5us add on with each loop=
=2E
But it is not allowed to have a 15us add on with every 1000th loop...

>=20
> In theory it's possible to remove the timer interrupt from such an
> isolated core completely, but there needs to be some work done vs. th=
e
> scheduler, accounting, RCU etc. There are people looking into this,
> but we have no patches yet.
I have checked the LAPIC addresses via the MSRs.
All LAPIC addresses for all CPU cores are the same.=20
I assume they share the very same configuration, thus a minimum step=20
would be to make a copy of this configuration data and to let CPU core =
3
point to this copy. This would allow to disable the timer.

=20
>=20
> What kind of application is that ? Data acquistion or closed loop
> processsing ?
I am running a close loop application.

Thank you very much.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst=
 mit und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
