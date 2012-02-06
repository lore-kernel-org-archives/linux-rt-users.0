From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Mon, 6 Feb 2012 15:49:57 +0100
Message-ID: <201202061549.57382.tim.sander@hbm.com>
References: <4F292FE0.7090302@digi.com> <20120202201336.GF25594@pengutronix.de> <1328218466.5882.119.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	"Hector Palacios" <hector.palacios@digi.com>,
	<linux-rt-users@vger.kernel.org>, <lclaudio@uudg.org>,
	<efault@gmx.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:14934 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753135Ab2BFOuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 09:50:52 -0500
Content-Class: urn:content-classes:message
In-reply-to: <1328218466.5882.119.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi=20

Am Donnerstag, 2. Februar 2012, 22:34:26 schrieb Steven Rostedt:
> On Thu, 2012-02-02 at 21:13 +0100, Uwe Kleine-K=F6nig wrote:
> > enabled the ksoftirq is also running wild with 3.0-rt. This also ha=
ppens
> > when I fail to reproduce that on a pcm043 machine using 3.0.18-rt34=
=2E Can
> > you provide me your config. Does the problem occur on every boot fo=
r
> > you? If not, how often do I need to reboot?
>=20
> Note, you also said (on IRC) that you boot off this card via NFS root=
=2E
> I'm not sure Tim has the same setup, and that may be a big difference=
 in
> how this bug comes about.

As i said, it is not to easy to trigger. I needed to start connmand and=
=20
dhclient in parallel and then do "ifconfig eth0 up/down" to trigger it=20
sometimes. It is easier to trigger when the ubifs background task is ru=
nning.=20
But that apears normal "behaviour" for a race condition like this.
=20
> It's a race issue, and it may require enabling the network interface
> after the system is up and running.
Yep, it's "hard" to hit this error on the first time. We have this erro=
r for=20
more than a year now, and it only came to my attention after we had our=
 qa=20
test rack up and running.

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
