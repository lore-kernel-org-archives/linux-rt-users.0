From: "Heinz Egger" <heinz.egger@linutronix.de>
Subject: AW: Linux RT newbie question
Date: Mon, 8 Feb 2016 16:31:41 +0100
Message-ID: <013901d16285$cf927770$6eb76650$@linutronix.de>
References: <41302A7145AC054FA7A96CFD03835A0A0BA89C7D@EX10MBX02.EU.NEC.COM> <56B8A042.5000604@meduna.org> <41302A7145AC054FA7A96CFD03835A0A0BA8AD12@EX10MBX02.EU.NEC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "'David Aldrich'" <David.Aldrich@EMEA.NEC.COM>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60918 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbcBHPbo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Feb 2016 10:31:44 -0500
In-Reply-To: <41302A7145AC054FA7A96CFD03835A0A0BA8AD12@EX10MBX02.EU.NEC.COM>
Content-Language: de
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello David,

there are a number of well known and reputaded companies in the area of
digital audio, video or digital simulation (automotive), just to name a=
 few
areas, which are using a standard PC, Linux and the Preempt-RT patch. W=
ith
latencies down to the single-digit microseconds region. =20

So it is shown that Linux and realtime will work pretty fine here.=20

br
Heinz

> -----Urspr=FCngliche Nachricht-----
> Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] Im Auftrag von David Aldrich
> Gesendet: Montag, 8. Februar 2016 15:28
> An: Stanislav Meduna; linux-rt-users@vger.kernel.org
> Betreff: RE: Linux RT newbie question
>=20
> Hi Stano
>=20
> Thanks for your reply ...
>=20
> > > For a new project we need to demonstrate a Linux RT-Kernel runnin=
g
> > > a 'standard' x86 desktop PC.
> >
> > What is the goal of this presentation?
>=20
> The goal is to demonstrate that a communication system previously
> implemented on embedded digital signal processors can be implemented =
on
> a high spec PC desktop. Sorry that I can't give more details.
>=20
> > Are you aware that a standard desktop
> > PC might spoil your realtime attempts in various ways (SMI interrup=
ts,
> power
> > management, ...)?
>=20
> Well, I was not aware of this until reading your email and I read ' H=
OWTO:
> Build an RT-application' on rt.wiki.kernel.org. The HowTo suggests wa=
ys of
> reducing the impact of SMI interrupts. Is this possible?
>=20
> > > I wonder if a standard Linux distro + RT kernel patch would be a
better
> > choice?
> >
> > As long as you are using a RT kernel, sane pthreads support such as
modern
> > glibc and you know what you are doing (ksoftirqd priority and simil=
ar
fun)
> > the particular distribution does not matter much. We are using stoc=
k
> Debian
> > with custom kernel as our embedded rt platform.
>=20
> Do you build your kernel yourselves?
>=20
> Best regards
>=20
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> -----
> E-Mail ist virenfrei.
> Von AVG =FCberpr=FCft - www.avg.de
> Version: 2015.0.6176 / Virendatenbank: 4522/11563 - Ausgabedatum:
> 05.02.2016

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
