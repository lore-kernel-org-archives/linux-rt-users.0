From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: AW: CONFIG_PREEMPT_RT_FULL an usb gadget
Date: Thu, 29 Aug 2013 20:58:14 +0200
Message-ID: <521F99C6.1010200@linutronix.de>
References: <9BA84827B30CBE4996725F98F7DC91232F954E81@SMExchange01.siebmeyer.org> <20130829113521.GB15360@linutronix.de> <9BA84827B30CBE4996725F98F7DC91232F955F47@SMExchange01.siebmeyer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?B?IkjDpG5lbC1CYWFzLCBBbGV4YW5kZXIi?=
	<alexander.haenel-baas@sieb-meyer.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52213 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab3H2S6Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 14:58:16 -0400
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91232F955F47@SMExchange01.siebmeyer.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


please keep the list in Cc.

On 08/29/2013 04:36 PM, H=C3=A4nel-Baas, Alexander wrote:
> Hi Sebastian,

Hi Alexander,

> yes i use a x86 machine with 3.10.4-rt1 patch.
> No, there is no other gadget's or usb device active.

I meant try another gadget (like storage) or rndis on a linux host
where you can debug since Windows isn't that cooperative.

> Now I have enabled the lock debug (I hope so), but I can't see a mess=
age that the kernel complains about something.
>=20
> Yes that the point. In the debugging msg. is no difference between th=
e working or not working situation.
>=20
> I attached my kernel config's:=20
> Config_3.10.4_PREEMPT_FULL -> Fully preemptible
> Config_3.10.4_PREEMPT_LL	-> Low-Latency
>=20
> The other files are the corresponding  dmesg.
> preempt_full_dmesg.txt
> preempt_ll_dmesg.txt

Sorry, I have currently no time look at those, I'm on the run=E2=80=A6

>=20
> Ok, I look for another linux machine to connect:  (Traget: linux) <->=
 usb --- RNDIS --- usb <-> (linux:Host)=20

Good. Note that that most gadgets attach RDNIS as an additional
function that means under normal circumstances Linux ignores RNDIS and
goes for CDC.

> Thank you for help,
>=20
> Alex

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
