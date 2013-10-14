From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
Subject: Re: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Mon, 14 Oct 2013 14:26:51 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC91232F974979@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Sebastian Andrzej Siewior (bigeasy@linutronix.de)"
	<bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smnotes1.sieb-meyer.de ([213.252.170.194]:49156 "EHLO
	mail.sieb-meyer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab3JNO0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Oct 2013 10:26:53 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Sebastian,

nice to hear from you.

Yes I have disable ehci & ohci =A0with no changes.

But=A0 the following dmesg shows the problem:

[=A0 335.682365] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER      =
-> normal read
[=A0 335.693595] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.700148] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.713727] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.720236] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.733730] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.740482] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.746520] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER=A0 =A0=
=A0-> normal read
[=A0 335.757582] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.764220] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.777721] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.784467] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.797842] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 335.804473] g_ether gadget: rndis req21.00 v0000 i0000 l36
[=A0 335.810456] gen_ndis_query_resp: RNDIS_OID_GEN_RCV_NO_BUFFER=A0=A0=
=A0 =A0-> normal read
[=A0 335.821753] g_ether gadget: rndis reqa1.01 v0000 i0000 l4096
[=A0 348.741461] g_ether gadget: rndis req21.00 v0000 i0000 l12
[=A0 348.766563] pch_udc 0000:05:02.4: ES=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> !!! not normal what is ES=
!!!
[=A0 348.770744] rndis_msg_parser: unknown RNDIS message 0x80000004 len=
 28
[=A0 348.777492] rndis_msg_parser00000000: 04 00 00 80 1c 00 00 00 d2 3=
3 00 00 00 00 00 00=A0 .........3......
[=A0 348.787334] rndis_msg_parser00000010: 04 00 00 00 10 00 00 00 41 0=
0 00 00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ........A...
[=A0 348.796795] RNDIS command error -524, 0/12=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-> result of E=
S is a read error !?
[=A0 348.801379] g_ether gadget: reset config
[=A0 348.805549] g_ether gadget: rndis deactivated
[=A0 348.810159] usb0: gether_disconnect
[=A0 348.822880] pch_udc 0000:05:02.4: USB_RESET
[=A0 348.910541] pch_udc 0000:05:02.4: pch_udc_ep_clear_nak: RxFIFO not=
 Empty
[=A0 348.917637] pch_udc 0000:05:02.4: USB_ENUM
[=A0 354.814204] pch_udc 0000:05:02.4: ES=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0-> my new friend is here and he never leaves.
[ =A0354.818381] g_ether gadget: setup complete --> -108, 0/18
[=A0 354.824112] pch_udc 0000:05:02.4: USB_RESET
[=A0 354.828589] pch_udc 0000:05:02.4: USB_ENUM
[=A0 360.794105] pch_udc 0000:05:02.4: ES
[=A0 360.798288] g_ether gadget: setup complete --> -108, 0/18
[=A0 360.804088] pch_udc 0000:05:02.4: USB_RESET
[=A0 360.808587] pch_udc 0000:05:02.4: USB_ENUM
[=A0 366.813821] pch_udc 0000:05:02.4: ES
[=A0 366.817946] g_ether gadget: setup complete --> -108, 0/18
[=A0 366.823648] pch_udc 0000:05:02.4: USB_RESET
[=A0 366.828116] pch_udc 0000:05:02.4: USB_ENUM
[=A0 372.293541] pch_udc 0000:05:02.4: ES
[=A0 372.297414] g_ether gadget: suspend
[=A0 372.304110] pch_udc 0000:05:02.4: USB_SUSPEND
[=A0 372.581917] g_ether gadget: setup complete --> -108, 0/18

Ok. The pch_udc.c code tells me:

/* ES interrupt, IDLE > 3ms on the USB */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dev_intr & UDC_DEVINT=
_ES)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dev_dbg(&dev->pdev->dev, "ES\n");

Sebastian, =A0can you tell my more about ES interrupt?

When I change the rt-config to low-latency-desktop (not RT) my ES frien=
d comes never up an the gadget works well.


Greetings

Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
