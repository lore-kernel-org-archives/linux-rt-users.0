From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: NOHZ: local_softirq_pending
Date: Sun, 14 Jun 2009 17:28:28 +0200
Message-ID: <4A35171C.9090800@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Iratxo Pichel Ortiz <ipichel@albentia.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsc199-a04.servidoresdns.net ([82.223.190.46]:60596 "EHLO
	llsc199-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755540AbZFNPhI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Jun 2009 11:37:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi there,

I hope that someone in this list could help me trace down this issue I=20
am seeing.

I am using 2.6.30-rt16 RT Kernel on a IXP425 system. The system is=20
running an experimental comm stack that has been working quite well wit=
h=20
2.6.26-rt2 for a very long time (> 100days).

When the system boots, every 180s aprox, I see this traces in the dmesg=
:
42949422.930000] NOHZ: local_softirq_pending 02
[42949422.940000] NOHZ: local_softirq_pending 02
[42949422.950000] NOHZ: local_softirq_pending 02
[42949422.960000] ISR HIHG LATENCY 30073
[42949596.920000] NOHZ: local_softirq_pending 02
[42949596.930000] NOHZ: local_softirq_pending 02
[42949596.940000] NOHZ: local_softirq_pending 02
[42949596.950000] NOHZ: local_softirq_pending 02
[42949596.960000] ISR HIHG LATENCY 40066

The "ISR HIGH LATENCY" is small latency measurement that I have done in=
=20
the ISR function of the driver. Hw is ticking the system every 2.5ms an=
d=20
the usual run-time of the ISR handler is well under 200us. Every aprox=20
180seconds, suddenly this run-time get as high as 50ms.

It is very highly probable that the problem is inside my driver, becaus=
e=20
if I dont load the modules, this "NOHZ..." trace is not shown. Anyway, =
I=20
would like to know if this "issue" is triggered by some known cause, or=
=20
at least any idea where to start looking at.

Please, CC me as I am not subscribed to the list.

Thank you very much in advance and best regards!

    Iratxo.


Another run:
[   96.950000] NOHZ: local_softirq_pending 02
[   96.960000] NOHZ: local_softirq_pending 02
[   96.970000] NOHZ: local_softirq_pending 02
[   97.000000] ISR HIGH LATENCY 50068
[  270.000000] ISR HIGH LATENCY 50048
[  463.000000] ISR HIGH LATENCY 50049
[  643.000000] ISR HIGH LATENCY 50047

--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
