From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.2-rc1-rt1 - Compile errors also for rc1 vanilla
Date: Tue, 22 Nov 2011 10:34:15 +0100
Message-ID: <201111221034.16018.tim.sander@hbm.com>
References: <alpine.LFD.2.02.1111132213220.2694@ionos> <201111141014.06906.tim.sander@hbm.com> <1321896657.20742.16.camel@frodo>
Mime-Version: 1.0
Content-Type: text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"John Kacur" <jkacur@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1321896657.20742.16.camel@frodo>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve
> arch/arm/mach-imx/built-in.o: In function `imx31_soc_init':
> /work/rt/rt.git/arch/arm/mach-imx/mm-imx3.c:186: undefined reference =
to
> `mx31_revision' make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
>=20
> Which is not the error you saw. I'm curious to what I did wrong.
As i wrote i had some platform modifications which i took from my 3.0 k=
ernel.
When compiling vanilla 3.2-rc2 i have the same error as you above.

I've just send an error report to the arm kernel mailing list.

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
ch f=C3=BCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-M=
ail.
