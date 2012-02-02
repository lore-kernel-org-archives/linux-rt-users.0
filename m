From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 13:38:44 +0100
Message-ID: <201202021338.44950.tim.sander@hbm.com>
References: <4F292FE0.7090302@digi.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>, <lclaudio@uudg.org>,
	<rostedt@goodmis.org>, <efault@gmx.de>
To: "Hector Palacios" <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:43722 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751249Ab2BBMjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 07:39:42 -0500
Content-Class: urn:content-classes:message
In-reply-to: <4F292FE0.7090302@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> When booting my platform with DHCP on, the DHCP request is sent by th=
e
> network driver before the PHY has even started the autonegotiation.
> Since the PHY is not ready, the TX interrupt returns with NETDEV_TX_B=
USY
> but the softirq [sirq-net-tx] seems to have entered an infinite spin,=
 as
> my system is practically hung and 'top' reveals [sirq-net-tx/0] is
> consuming 95% of CPU. This is preventing the PHY autonegotiation (whi=
ch is
> scheduled as a delayed work) to start, so the PHY is never ready and =
the
> packet never reaches the network.
Mh, i think i am hit by the same problem. I have a i.mx 35 and when dhc=
p is
enabled the ksoftirq is also running wild with 3.0-rt. This also happen=
s when
static ip is configured and the probably during network transfer the ne=
twork
interface is reconfigured. Basically it seems the sirq-net-tx thread tr=
ies to
send a packet on a non configured interface.

But one thing that makes me thinking, is that this thing is only happen=
ing on
arm and not on x86. So Hector what platform are you working on. Are you=
 by
chance using the same fec.c ethernet driver?

I have verified that in my case the driver takes always the return stat=
ement in
line fec.c:247: return NETXDEV_TX_BUSY; =20
It never stops on a breakpoint set on line 250 which shows that the int=
erface
gets never configured.

I have taken some screenshots of my hw debugger:

trace:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_e=
net_start_xmit.png
stack:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_e=
net_start_xmit_stacktrace.png
locals:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_=
enet_start_xmit_stack+locals.png

Whats interesting to note is that phy_dev and mii_dev are both null poi=
nters.

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
