From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 13:57:52 +0100
Message-ID: <4F2A8850.4080201@digi.com>
References: <4F292FE0.7090302@digi.com> <201202021338.44950.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"efault@gmx.de" <efault@gmx.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail37.messagelabs.com ([216.82.241.83]:29051 "EHLO
	mail37.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2BBM56 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 07:57:58 -0500
In-Reply-To: <201202021338.44950.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On 02/02/2012 01:38 PM, Tim Sander wrote:
 > Mh, i think i am hit by the same problem. I have a i.mx 35 and when =
dhcp is
 > enabled the ksoftirq is also running wild with 3.0-rt. This also hap=
pens when
 > static ip is configured and the probably during network transfer the=
 network
 > interface is reconfigured. Basically it seems the sirq-net-tx thread=
 tries to
 > send a packet on a non configured interface.
 >
 > But one thing that makes me thinking, is that this thing is only hap=
pening on
 > arm and not on x86. So Hector what platform are you working on. Are =
you by
 > chance using the same fec.c ethernet driver?

I'm working on an i.MX51 and using the fec.c driver as well. Interestin=
g that it is=20
not happening on x86.

 > I have verified that in my case the driver takes always the return s=
tatement in
 > line fec.c:247: return NETXDEV_TX_BUSY;
 > It never stops on a breakpoint set on line 250 which shows that the =
interface
 > gets never configured.

Autonegotiation is triggered by phy_state_machine() at phy.c which is s=
cheduled as a=20
delayed work by phy_device.c upon PHY device creation.
This is not even started when the fec_enet_start_xmit() function is cal=
led.

 > I have taken some screenshots of my hw debugger:
 >
 >=20
trace:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_e=
net_start_xmit.png
 >=20
stack:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_e=
net_start_xmit_stacktrace.png
 >=20
locals:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_=
enet_start_xmit_stack+locals.png
 >
 > Whats interesting to note is that phy_dev and mii_dev are both null =
pointers.

I'll check this but it is probably because the PHY device is not yet cr=
eated or=20
initialized.

Best regards,
--=20
H=E9ctor Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
