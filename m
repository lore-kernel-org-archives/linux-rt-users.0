From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet driver to blame? Yep
Date: Wed, 18 Jan 2012 12:11:44 +0100
Message-ID: <201201181211.45011.tim.sander@hbm.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com> <201201171527.19165.tstone@iss.tu-darmstadt.de> <1326822011.7386.40.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/Plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tim Sander" <tstone@iss.tu-darmstadt.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
To: "Mike Galbraith" <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:36193 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750715Ab2ARLRm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 06:17:42 -0500
Content-Class: urn:content-classes:message
In-reply-to: <1326822011.7386.40.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mike and others

Thanks for your reply Mike.

Am Dienstag, 17. Januar 2012, 18:40:11 schrieb Mike Galbraith:
> I have a patchlet lying about that will show the likely culprit, but =
if
> ksoftirqd is eating CPU, someone has to raising softirqs at a frightf=
ul
> rate, and the culprit it shows would almost certainly be ksoftirqd.  =
I
> mean, what else is running during boot that is RT other than kernel
> threads.  Nada.
Well thanks for your patch. It didn't apply cleanly due to some moved l=
ines,=20
but nothing to serious. I now have a machine where top just shows me th=
e
culprit:
sirq-net-tx/0=20

It seems to be triggered not as often as the mainline rt kernel though.=
 But
after some starts and stops of "connmand" and "ifconfig eth0 down" i go=
t back
this errornous behaviour. The only question is what next? Still i have =
some=20
more observations which might help to nail down this bug:
* ifconfig does not return when sirq-net-tx/0 eats all cpu
* sometimes sirq-net-tx/0 sits on the cpu for a couple of seconds and g=
oes=20
away, somtimes it just stays there when "ifconfig eth0 up" is issued.
* There are suspicious "FEC: MDIO read timeout" kernel log messages fro=
m the=20
ethernet driver.
* The ethernet phy uses polling since i do not know how to set the phy =
irq in=20
the board definition. I tried using "phy_register_fixup_for_uid" and th=
en=20
setting the phy_dev->irq int the fixup routine but that seems to be to =
late and=20
the interrupt is deregisterd but has not been registered when the netwo=
rk=20
device is shut down.=20
I also didn't found a example in the source and there has been no word =
in the=20
phy.txt documentation about it? So input on how to set the phy irq in t=
he=20
board config of the pcm043 would be really nice.

> You can find out easy easy enough, just edit kernel/softirq.c, commen=
t
> out ksoftirqd_set_sched_params() in run_ksoftirqd().  If the throttle
> doesn't kick in (because ksoftirqd is now not RT), box boots but
> ksoftirqd still chewing up a CPU, you have the same info the throttle
> hacklet would show.
>=20
> If that's it, you can apply the below, do the same edit, and see whic=
h
> thread is grinding away.  From there, I'd set a trap.  Let sirq threa=
ds
> detect that they are being awakened too fast (hey, I can't go to slee=
p,
> the sirq I just processed is busy again, N times in a row) and leave =
a
> note for wakeup_softirqd().  There, WARN_ON(ksoftirqd)[i].help_me) or
> such, to see who is flogging which softirq mercilessly.
I didn't use this tricks, since top was already doing its job good enou=
gh :-).

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
