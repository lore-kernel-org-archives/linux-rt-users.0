From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0-rt7 - Error with low latency desktop config
Date: Wed, 10 Aug 2011 18:33:54 +0200
Message-ID: <201108101833.54661.tim.sander@hbm.com>
References: <1312465990.16729.22.camel@twins> <201108091707.49832.tim.sander@hbm.com> <20110809173310.GB11398@pengutronix.de>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20110809173310.GB11398@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Uwe

I triple checked.
> I think targetinstall should ask about the changed config items.
It only asks one way, when going from an upatched kernel to an patched =
one.
Since i was coming from an preempt rt kernel to an unpatched one no que=
stions
where asked (probably since all settings where still in place as i wasn=
't=20
using the preempt rt feature with the preempt rt patched kernel source
aka "Low latency desktop")

> check if ${PROJECT_DIR}/${PLATFORMNAME}/build/linux-3.0/ (or similar)
> really has the rt patch applied. (e.g. is there a localversion-rt fil=
e?)
Yes, one version has rt7 appended the other not.

But i think the regression when going from 3.0-rt7 to 3.0.1-rt8 with=20
CONFIG_PREEMPT_RTB is more worthwhile to discuss. Which i detailed in t=
he=20
other mail.

Best regards
Tim

Sorry for the noise:

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
