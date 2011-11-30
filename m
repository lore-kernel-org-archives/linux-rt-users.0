From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [PATCH RT] tasklet/rt: Prevent tasklets from going into infinite spin in RT
Date: Wed, 30 Nov 2011 09:46:52 +0100
Message-ID: <201111300946.53146.tim.sander@hbm.com>
References: <1322618120.17003.104.camel@frodo>
Mime-Version: 1.0
Content-Type: text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"Clark Williams" <williams@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:36092 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752469Ab1K3IrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 03:47:24 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <1322618120.17003.104.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven
> I booted this patch against 3.0-rt stable, and it didn't crash ;)
> Could you apply it and see if it fixes the hang that you've been seei=
ng.
Unfortunatly i am also experiencing these problems with ksoftirq runnin=
g wild.

So i am also going to test this patch and see if it fixes our problem. =
It seems=20
as if this bug is much more probable after UBIFS update and when=20
"sched: RT throttling activated" hits.

Best regards
Tim

PS: Steven i just forgot the cc list so you got this mail twice, sorry.

Please ignore or at your wish use as "Deutschkurs" in german legalese:

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
