From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [PATCH 00/11] [ANNOUNCE] 3.0.12-rt30-rc2
Date: Wed, 7 Dec 2011 09:09:56 +0100
Message-ID: <201112070909.56992.tim.sander@hbm.com>
References: <20111204185444.411298317@goodmis.org> <201112051011.59858.tim.sander@hbm.com> <1323091398.30977.74.camel@frodo>
Mime-Version: 1.0
Content-Type: text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"Tim Sander" <tim01@vlsi.informatik.tu-darmstadt.de>,
	<linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"Carsten Emde" <C.Emde@osadl.org>, "John Kacur" <jkacur@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:50293 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752100Ab1LGIKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Dec 2011 03:10:31 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <1323091398.30977.74.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve
> > I should also point out, that this phenomen was not always happenin=
g, but
> > only sometimes and then again disapeared without any known reason.
>=20
> Hmm, then are you sure that the tasklet patch causes the bug? Or perh=
aps
> it only changes the timing to cause it. The bug may be without the pa=
tch
> too.
Well, we are running the preempt rt patchset 3.0 since the rt-9 release=
 and we=20
have not seen this kind of error. It just started popping up after i ap=
plied=20
the patch which i took directly from the mailing list when it was poste=
d,=20
since we had this ksoftirq issue especially after firmware update when =
ubifs=20
has been updated.

The bad thing is that it is not happening deterministic but seemingly a=
t=20
random. But i will try your next prerelease and will report any results=
=2E

My patch is also not completly vanilla mainline. I am using the recomen=
ded=20
patch from ubifs/master, some small platform patches and some timer pat=
ches=20
Thomas Gleixner knows best about.

Best regards
Tim

Please ignore:

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
ch f=C3=BCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-M=
ail.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
