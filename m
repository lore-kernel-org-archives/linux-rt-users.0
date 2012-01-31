From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: Unreliable Wireless network with 3.0.9-rt26
Date: Tue, 31 Jan 2012 17:08:30 +0100
Message-ID: <201201311708.30266.tim.sander@hbm.com>
References: <4F26D728.2090008@cmotion.eu>
Mime-Version: 1.0
Content-Type: text/Plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: "Christian Kapeller" <christian.kapeller@cmotion.eu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:51535 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753841Ab2AaQJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jan 2012 11:09:29 -0500
Content-Class: urn:content-classes:message
In-reply-to: <4F26D728.2090008@cmotion.eu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> I'm having trouble running wifi in combination with a rt enabled kern=
el
> 3.0.9-rt26 on an imx51 arm platform. The distro is openwrt-trunk.
>=20
> The device has 2 usb wifi interfaces (AR9271 chipset; driver: based o=
n
> compat-wireless-testing 2011-12-01). I am running an iperf load on bo=
th
> interfaces, one interface is in AP mode, the other in STA mode.
>=20
> When I configure the kernel without RT preemption, the device runs
> stable for >10 hours.
>=20
> With RT preemption enabled, after a couple of minutes some interface
> will stop transmitting data. Sometimes ifconfig wlan[0,1] down will
> hang, sometimes ifconfig wlan[0,1] down will work, but then ping will

Just my 5 cents: I am working on the imx 35 platform and i am also havi=
ng=20
problems with the network setup. I have sent a bugsplat to this list wh=
ich=20
occurs in the network setup with 3.2-rt. I suspect that these two error=
s are=20
related. Steven Rosted wanted to look after it, but it seems he hasn't =
until=20
now.

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
ch f=FCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Emp=
faenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
