From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet driver to blame? Yep
Date: Tue, 24 Jan 2012 11:52:21 +0100
Message-ID: <201201241152.21472.tim.sander@hbm.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com> <1326822011.7386.40.camel@marge.simson.net> <201201181211.45011.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mike Galbraith" <efault@gmx.de>,
	"Tim Sander" <tstone@iss.tu-darmstadt.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Gerlando Falauto" <gerlando.falauto@keymile.com>,
	"Micha Nelissen" <micha@neli.hopto.org>,
	"Holger Brunck" <holger.brunck@keymile.com>
To: "RT" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:19760 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755802Ab2AXKxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jan 2012 05:53:13 -0500
Content-Class: urn:content-classes:message
In-reply-to: <201201181211.45011.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi=20

I have some more info on the error report, please see below.
> Well thanks for your patch. It didn't apply cleanly due to some moved
> lines, but nothing to serious. I now have a machine where top just sh=
ows
> me the culprit:
> sirq-net-tx/0
>=20
> It seems to be triggered not as often as the mainline rt kernel thoug=
h. But
> after some starts and stops of "connmand" and "ifconfig eth0 down" i =
got
> back this errornous behaviour. The only question is what next? Still =
i
> have some more observations which might help to nail down this bug:
> * ifconfig does not return when sirq-net-tx/0 eats all cpu
> * sometimes sirq-net-tx/0 sits on the cpu for a couple of seconds and=
 goes
> away, somtimes it just stays there when "ifconfig eth0 up" is issued.
> * There are suspicious "FEC: MDIO read timeout" kernel log messages f=
rom
> the ethernet driver.
> * The ethernet phy uses polling since i do not know how to set the ph=
y irq
> in the board definition. I tried using "phy_register_fixup_for_uid" a=
nd
> then setting the phy_dev->irq int the fixup routine but that seems to=
 be
> to late and the interrupt is deregisterd but has not been registered =
when
> the network device is shut down.
> I also didn't found a example in the source and there has been no wor=
d in
> the phy.txt documentation about it? So input on how to set the phy ir=
q in
> the board config of the pcm043 would be really nice.
>=20
I would like to point out that the running wild softirq seems to bee fi=
xed by
9ec14c04ec6be93ff397adf250bc91ee77742bfb of the stable git tree.
At least i could not reproduce the ksoftirq error with 3.0.17-rt33. Wit=
h the=20
above commit reverted i could reproduce this error. As this running wil=
d=20
ksoftirq did not occur regularly there is a small chance that this erro=
r just=20
didn't show up with the new kernel but i doubt it.

There is still the case that on network configuration the systemload wi=
th=20
ksoftirq goes suspicoiusly high but at least it gets to normal levels=20
afterwards.=20

Best regards
Tim

PS: I have added the cc list of that commit to this report. If you guys=
 have =20
some insight on this you could share that would be great.

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
