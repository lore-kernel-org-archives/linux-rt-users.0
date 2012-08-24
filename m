From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.4.9-rt17
Date: Fri, 24 Aug 2012 10:32:14 +0200
Message-ID: <1494830.WYyVmtosNh@dabox>
References: <1345144963.3708.1.camel@gandalf.local.home> <10950377.h1F1h7Gs2a@dabox> <1843545.6vtXSYEOLB@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Carsten Emde" <C.Emde@osadl.org>, "John Kacur" <jkacur@redhat.com>
To: "RT" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
In-Reply-To: <1843545.6vtXSYEOLB@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi=20

After fixing the realtime prios which got shuffled due to other irq thr=
ead names
I just tested the realtime latency for interrupts on the i.mx35. With o=
ur own=20
systemtimer which does not get into the way of  the measurement interru=
pt this=20
kernel has 30=B5s worst time (caveat: short measurement period) interru=
pt=20
latency and usermode can keep up with a 2400kHz interrupt rate. While t=
he=20
usermode performance seems to be largely unchanged (but i haven't teste=
d very=20
thoroughly) the interrupt latency went down about 10=B5s coming from th=
e 3.0-rt=20
series. Its really nice to see that kind of improvement.=20

Thanks
Tim

Ignore the legalese please:


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
