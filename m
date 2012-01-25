From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet driver to blame? Yep
Date: Wed, 25 Jan 2012 10:31:48 +0100
Message-ID: <201201251031.48983.tim.sander@hbm.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com> <201201181211.45011.tim.sander@hbm.com> <201201241152.21472.tim.sander@hbm.com>
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
Received: from relay.medianet-world.de ([213.157.0.172]:63488 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754240Ab2AYJcx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 04:32:53 -0500
Content-Class: urn:content-classes:message
In-reply-to: <201201241152.21472.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

> > Well thanks for your patch. It didn't apply cleanly due to some mov=
ed
> > lines, but nothing to serious. I now have a machine where top just =
shows
> > me the culprit:
> > sirq-net-tx/0
> >=20
> > It seems to be triggered not as often as the mainline rt kernel tho=
ugh.
> > But after some starts and stops of "connmand" and "ifconfig eth0 do=
wn" i
> > got back this errornous behaviour. The only question is what next? =
Still
> > i have some more observations which might help to nail down this bu=
g: *
> > ifconfig does not return when sirq-net-tx/0 eats all cpu
> > * sometimes sirq-net-tx/0 sits on the cpu for a couple of seconds a=
nd
> > goes away, somtimes it just stays there when "ifconfig eth0 up" is
> > issued. * There are suspicious "FEC: MDIO read timeout" kernel log
> > messages from the ethernet driver.
> > * The ethernet phy uses polling since i do not know how to set the =
phy
> > irq in the board definition. I tried using "phy_register_fixup_for_=
uid"
> > and then setting the phy_dev->irq int the fixup routine but that se=
ems
> > to be to late and the interrupt is deregisterd but has not been
> > registered when the network device is shut down.
> > I also didn't found a example in the source and there has been no w=
ord in
> > the phy.txt documentation about it? So input on how to set the phy =
irq in
> > the board config of the pcm043 would be really nice.
>=20
> I would like to point out that the running wild softirq seems to bee =
fixed
> by 9ec14c04ec6be93ff397adf250bc91ee77742bfb of the stable git tree.
> At least i could not reproduce the ksoftirq error with 3.0.17-rt33. W=
ith
> the above commit reverted i could reproduce this error. As this runni=
ng
> wild ksoftirq did not occur regularly there is a small chance that th=
is
> error just didn't show up with the new kernel but i doubt it.

Bad news, the ksoftirq(sirq-net-tx) error seems to happen not so often =
any=20
more but it still happens :-(.

So any input on that is highly apreciated.
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
