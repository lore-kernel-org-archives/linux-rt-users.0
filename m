From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [PATCH RT 0/4] [ANNOUNCE] 3.0.14-rt32-rc1
Date: Wed, 18 Jan 2012 14:50:17 +0100
Message-ID: <201201181450.17680.tim.sander@hbm.com>
References: <20120118034531.335521323@goodmis.org>
Mime-Version: 1.0
Content-Type: text/Plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Carsten Emde" <C.Emde@osadl.org>, "John Kacur" <jkacur@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:51662 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757530Ab2ARN5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 08:57:41 -0500
Content-Class: urn:content-classes:message
In-reply-to: <20120118034531.335521323@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve
> This is the RT stable review cycle of patch 3.0.14-rt32-rc1.
>=20
> Please scream at me if I messed something up. Please test the patches=
 too.
Well the error i described in other mails to this list are still persis=
tent:
* ksoftirq running wild due to fec ethernet tx interrupt.

Does patch nr 2 possibly fix the error reboot fails with "Unable to exe=
cute=20
shutdown: Bad address". The error occurs not to often so it is hard to =
say if=20
this 3.0.14-rt32 is still showing this error.

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
