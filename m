From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 15:25:05 +0100
Message-ID: <201202021525.05606.tim.sander@hbm.com>
References: <4F292FE0.7090302@digi.com> <201202021338.44950.tim.sander@hbm.com> <4F2A8850.4080201@digi.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>, <lclaudio@uudg.org>,
	<rostedt@goodmis.org>, <efault@gmx.de>
To: "Hector Palacios" <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:55024 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756251Ab2BBO2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 09:28:14 -0500
Content-Class: urn:content-classes:message
In-reply-to: <4F2A8850.4080201@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> On 02/02/2012 01:38 PM, Tim Sander wrote:
>  > Mh, i think i am hit by the same problem. I have a i.mx 35 and whe=
n dhcp
>  > is enabled the ksoftirq is also running wild with 3.0-rt. This als=
o
>  > happens when static ip is configured and the probably during netwo=
rk
>  > transfer the network interface is reconfigured. Basically it seems=
 the
>  > sirq-net-tx thread tries to send a packet on a non configured
>  > interface.
>  >=20
>  > But one thing that makes me thinking, is that this thing is only
>  > happening on arm and not on x86. So Hector what platform are you
>  > working on. Are you by chance using the same fec.c ethernet driver=
?
>=20
> I'm working on an i.MX51 and using the fec.c driver as well. Interest=
ing
> that it is not happening on x86.
Well, at least no one else spoke out on this problem before

>  > I have verified that in my case the driver takes always the return
>  > statement in line fec.c:247: return NETXDEV_TX_BUSY;
>  > It never stops on a breakpoint set on line 250 which shows that th=
e
>  > interface gets never configured.
>=20
> Autonegotiation is triggered by phy_state_machine() at phy.c which is
> scheduled as a delayed work by phy_device.c upon PHY device creation.
> This is not even started when the fec_enet_start_xmit() function is c=
alled.
>=20
>  > I have taken some screenshots of my hw debugger:
> trace:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec=
_enet_
> start_xmit.png
>=20
> stack:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec=
_enet_
> start_xmit_stacktrace.png
>=20
> locals:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fe=
c_enet
> _start_xmit_stack+locals.png
>=20
>  > Whats interesting to note is that phy_dev and mii_dev are both nul=
l
>  > pointers.
>=20
> I'll check this but it is probably because the PHY device is not yet
> created or initialized.
Well the phy seems to be initialized in fec_enet_open->fec_enet_mii_pro=
be.
But opened is set to 0 so this codepath has not been run, so not initia=
lized.
If the device is not opended how does it tries to send packets?

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
