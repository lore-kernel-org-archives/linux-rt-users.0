From: <Martin.Wirth@dlr.de>
Subject: AW: Large latencies with 4.4.1-rt6
Date: Fri, 4 Mar 2016 07:40:31 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB691B6A4814@DLREXMBX01.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <tglx@linutronix.de>, <bigeasy@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailhost.dlr.de ([129.247.252.32]:21069 "EHLO mailhost.dlr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbcCDHkg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Mar 2016 02:40:36 -0500
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Josh,
> -----Urspr=FCngliche Nachricht-----
> Von: Josh Cartwright [mailto:joshc@ni.com]
> Gesendet: Donnerstag, 3. M=E4rz 2016 16:42
> An: Wirth, Martin
> Cc: tglx@linutronix.de; bigeasy@linutronix.de; linux-rt-
> users@vger.kernel.org
> Betreff: Re: AW: AW: Large latencies with 4.4.1-rt6
>=20
> > > cyclictest -Sp99 -m -i200 -f -b500
>=20
> Cyclictest should have mentioned which CPU was triggering the break, =
the
> most valuable traces are from that CPU.
>=20

This one came from CPU 0

=20
> Do you have more complete traces of what's going on on the other CPUs=
 as
> well?  As far as I can see here, CPU0 is handling a couple interrupts=
, which
> trigger remote wakeups of irqthreads running on the other CPUs..nothi=
ng
> unusual?

To me it looked like the CPU kept IRQs disabled over the 100 =B5s, but =
it seems=20
that this is a misinterpretation.=20

The complete trace, including all CPUs, is about 12 MB (600 KB compress=
ed) and
therefore  much too large for the mailing list. If anyone is interested=
 to get the
complete file I will send it to his e-mail only.

Thanks,

Martin=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
