From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0-rt7 - Error with low latency desktop config
Date: Tue, 9 Aug 2011 17:07:49 +0200
Message-ID: <201108091707.49832.tim.sander@hbm.com>
References: <1312465990.16729.22.camel@twins> <201108091548.06875.tim.sander@hbm.com> <20110809140923.GA11398@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Zijlstra" <peterz@infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway.hbm.com ([213.157.30.2]:54418 "EHLO hbmntx5.hbm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1HIPIG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 11:08:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20110809140923.GA11398@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe

I just double checked.
> The config doesn't look like a 3.0-rt7 one. There is neither
>=20
> 	PREEMPT_RTB=3Dy
>=20
> nor
>=20
> 	# PREEMPT_RTB is not set
If i switch the configs with "Kernel Feature"-> "Preemption Model" -
>"(Preemtible Kernel) Low-Latency Desktop"
there are no such config options visible even with a -rt7 kernel.
(My workflow in ptxdist is
comment (in/out) rtpatch in patches/linux-3.0/series
ptxdist clean kernel && ptxdist targetinstall kernel
deploy.sh

Otherwise ptxdist would cheat on me and at=20
$(PROJECT_DIR)/configs/$(PLATFORM)/kernelconfig would be out of sync.)

Best regards
Tim


Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the commer=
cial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregist=
er des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhor=
st | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely fo=
r the addressee. If you are not the intended recipient, please let me k=
now and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und ledigli=
ch f=FCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Emp=
faenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail=
=2E

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
