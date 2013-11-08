From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: UDP jitter
Date: Fri, 8 Nov 2013 13:07:41 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
References: <20130429222238.2b440d8c@sanja.asnn.org>
 <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
 <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
 <20131107103325.65938975@sanja.asnn.org>
 <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
 <527CB16D.3040909@meduna.org>
 <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam01.mdcs.at ([217.13.183.26]:18174 "EHLO xlspam01.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243Ab3KHMIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 07:08:05 -0500
In-Reply-To: <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 > -----Urspr=FCngliche Nachricht-----
> Von: Thomas Gleixner [mailto:tglx@linutronix.de]=20
> Gesendet: Freitag, 08. November 2013 12:31
> An: Stanislav Meduna
> Cc: Neboj=B9a =C6osi=E6; eg Engleder Gerhard; linux-rt-users
> Betreff: Re: UDP jitter
>=20
> There are other ways to solve this without touching a single=20
> line of kernel code. The technology is all there, you just=20
> have to use it. Of course that requires to understand it in=20
> the first place, though this seems to be way harder than=20
> spending a lot of time tracing the problem and then yelling=20
> "priority inversion" and hope that the RT folks are going to "fix" it=
=2E

Can you give us a hint which technology to use? Currently I am
trying to use QoS Multi Band Priority Queueing.

regards, gerhard--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
