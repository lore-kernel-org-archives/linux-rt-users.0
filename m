From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Fri, 18 Oct 2013 16:35:59 +0200
Message-ID: <20131018143559.GB14569@linutronix.de>
References: <9BA84827B30CBE4996725F98F7DC91232F974979@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander
	<alexander.haenel-baas@sieb-meyer.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40963 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3JROgA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Oct 2013 10:36:00 -0400
Content-Disposition: inline
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91232F974979@SMExchange01.siebmeyer.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* H=C3=A4nel-Baas, Alexander | 2013-10-14 14:26:51 [+0000]:

>Hello Sebastian,
Hello Alexander,

>nice to hear from you.
>
>Yes I have disable ehci & ohci =C2=A0with no changes.
>
>But=C2=A0 the following dmesg shows the problem:
>
>[=C2=A0 335.682365] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER  =
    -> normal read
>[=C2=A0 335.693595] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.700148] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.713727] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.720236] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.733730] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.740482] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.746520] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER=C2=
=A0 =C2=A0=C2=A0-> normal read
>[=C2=A0 335.757582] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.764220] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.777721] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.784467] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.797842] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 335.804473] g_ether gadget: rndis req21.00 v0000 i0000 l36
>[=C2=A0 335.810456] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER=C2=
=A0=C2=A0=C2=A0 =C2=A0-> normal read
>[=C2=A0 335.821753] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
>[=C2=A0 348.741461] g_ether gadget: rndis req21.00 v0000 i0000 l12
>[=C2=A0 348.766563] pch_udc 0000:05:02.4: ES=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> !!! not normal what is=
 ES!!!

This is specific to the pch_udc you are using. The manual of your SoC
should describe this. But looking at the time stamps "348 - 335", there
were 13 seconds of nothing. The following packet might be a reminder of
the host=E2=80=A6

>[=C2=A0 348.770744] rndis_msg_parser: unknown RNDIS message 0x80000004=
 len 28
>[=C2=A0 348.777492] rndis_msg_parser00000000: 04 00 00 80 1c 00 00 00 =
d2 33 00 00 00 00 00 00=C2=A0 .........3......
>[=C2=A0 348.787334] rndis_msg_parser00000010: 04 00 00 00 10 00 00 00 =
41 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ........A...
>[=C2=A0 348.796795] RNDIS command error -524, 0/12=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0->=
 result of ES is a read error !?
>[=C2=A0 348.801379] g_ether gadget: reset config
>[=C2=A0 348.805549] g_ether gadget: rndis deactivated
>[=C2=A0 348.810159] usb0: gether_disconnect
>[=C2=A0 348.822880] pch_udc 0000:05:02.4: USB_RESET
>[=C2=A0 348.910541] pch_udc 0000:05:02.4: pch_udc_ep_clear_nak: RxFIFO=
 not Empty
>[=C2=A0 348.917637] pch_udc 0000:05:02.4: USB_ENUM
>[=C2=A0 354.814204] pch_udc 0000:05:02.4: ES=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0-> my new friend is here and he never leaves.

Maybe it is an error condition which is not processed and the error
remains. So if this interrupt source remains active then it would
explain your busy loop.=20
But back to rndis: ES does not mean read error. The message your host s=
ent
can not be processed by the gadget because it does not understand it.
You see this by "unknown RNDIS message" in the output and the command
err -524 aka -ENOTSUPP. As a result the gadget NAKs that requests and
the hosts does not like it, resets the USB bus and starts over.

>Ok. The pch_udc.c code tells me:
>
>/* ES interrupt, IDLE > 3ms on the USB */
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (dev_intr & UDC_DEVINT_ES)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(&dev->pdev->dev, "ES\n");
>
>Sebastian, =C2=A0can you tell my more about ES interrupt?

It is pch_udc specific. The manual should know more about it but seems
it shows up if the usb bus is idle. I have no idea why this should be a=
n
error condition.
If I remember RNDIS correctly, then the host sends a "few" ep0 requests
to query some informations. The UDC just waits for ep0 packets to arriv=
e
and us prcessing the requests. This is probably what the

| rndis req21.00 v0000 i0000 l12

output is showing you.
The ep0 communication is usually a little more compilcated compared to
ep1+ because you have only one endpoint in both direction and you need
know when you read and when you are allowed to write / send data. There
might be a timming related bug in the driver.
Since you control both sides, you should be able see which message the
hosts sends, which message the gadget recevies (is it the same) and the
other way around. Based on this you could atleast understand why the
hosts sends the "0x80000004" which the gadget does not understand. It
should not do so in non-RT case.
Once you see the messages exchanged in RT and non-RT case you should se=
e
a difference which should help you to track the bug.

>
>When I change the rt-config to low-latency-desktop (not RT) my ES frie=
nd comes never up an the gadget works well.
>
>
>Greetings
>
>Alexander

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
