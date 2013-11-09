From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: UDP jitter
Date: Sat, 9 Nov 2013 11:26:12 +0100
Message-ID: <20131109112612.4b45942e@sanja.asnn.org>
References: <20130429222238.2b440d8c@sanja.asnn.org>
	<517FE1A5.1090702@osadl.org>
	<20130430192653.5c6c08b6@sanja.asnn.org>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
	<20131106125709.2e091182@sth491dt.servo.net>
	<alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
	<20131107103325.65938975@sanja.asnn.org>
	<alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
	<527CB16D.3040909@meduna.org>
	<alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
	<alpine.DEB.2.02.1311081432300.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:43255 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab3KIK0R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Nov 2013 05:26:17 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b31.telenor.se (Postfix) with ESMTP id 5FD0DEBDB2
	for <linux-rt-users@vger.kernel.org>; Sat,  9 Nov 2013 11:26:15 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1311081432300.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=D0=94=D0=B0=D0=BD=D0=B0 Fri, 8 Nov 2013 14:35:44 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
:

> On Fri, 8 Nov 2013, eg Engleder Gerhard wrote:
> >  > -----Urspr=C3=BCngliche Nachricht-----
> > > Von: Thomas Gleixner [mailto:tglx@linutronix.de]=20
> > > Gesendet: Freitag, 08. November 2013 12:31
> > > An: Stanislav Meduna
> > > Cc: Neboj=C5=A1a =C4=86osi=C4=87; eg Engleder Gerhard; linux-rt-u=
sers
> > > Betreff: Re: UDP jitter
> > >=20
> > > There are other ways to solve this without touching a single=20
> > > line of kernel code. The technology is all there, you just=20
> > > have to use it. Of course that requires to understand it in=20
> > > the first place, though this seems to be way harder than=20
> > > spending a lot of time tracing the problem and then yelling=20
> > > "priority inversion" and hope that the RT folks are going to "fix=
" it.
> >=20
> > Can you give us a hint which technology to use? Currently I am
> > trying to use QoS Multi Band Priority Queueing.
>=20
> Well, it really depends on your requirements. Assuming you have a
> simple binary decision (Bulk and VIP traffic) a simple 2 band priorit=
y
> queue should work.
And how exactly is it going to help? You still have fifo, and you still
get messages from higher priority thread stuck waiting for low priority
task to finish sending whatever it has in there (please note how I
avoid mentioning priority inversion here).
By the way, by default you have pfifo_fast in there, which is capable
enough to do the priority based queuing.

>=20
> Thanks,
>=20
> 	tglx

Excuse my ignorance
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
