From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: UDP jitter
Date: Fri, 8 Nov 2013 11:51:42 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA33967BEB68783@KEBMXSPMB01.keba.co.at>
References: <20130429222238.2b440d8c@sanja.asnn.org>
 <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
 <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
 <20131107103325.65938975@sanja.asnn.org>
 <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
 <527CB16D.3040909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam03.mdcs.at ([217.13.183.27]:20985 "EHLO xlspam03.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab3KHKvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 05:51:43 -0500
In-Reply-To: <527CB16D.3040909@meduna.org>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> -----Urspr=FCngliche Nachricht-----
> Von: Stanislav Meduna [mailto:stano@meduna.org]=20
> Gesendet: Freitag, 08. November 2013 10:40
> An: Thomas Gleixner; Neboj=B9a =C6osi=E6
> Cc: eg Engleder Gerhard; linux-rt-users
> Betreff: Re: UDP jitter
>
> I cannot comment on the code as I did not analyze it myself=20
> (at least yet), but I think Nebojsa is worried by the=20
> situation where the high-prio thread is not able to _queue_=20
> its packets because of the low-prio thread is sitting in some=20
> lock being preempted by something unrelated.

The high-prio thread is able to queue the packet. Thus for the
thread itself everthing is fine, no priority inversion for the thread.
At least in my case. In my situation the transmission of the
packet from the high-prio thread is delayed until the low-prio
thread is scheduled again.

Is there any possibility to transmit high-prio traffic and low-prio
traffic over the same network interface, with limited delay for
the high-prio traffic? The delay of a full ring buffer of the network
device is at least limited with e.g. 10ms, this is acceptable
in my application.

regards, gerhard--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
