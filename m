From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 09:00:57 +0200 (CEST)
Message-ID: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:36829 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995AbZD3HA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 03:00:58 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id A45F839A3FA
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 09:00:57 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 9D8A32D376D
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 09:00:57 +0200 (CEST)
Received: from webmail19.ha2.local (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 7EA0633A794
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 09:00:57 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have an application which is (so far) running using Xenomai and Rtnet=
=2E
I am about to evaluate this using the rt_preemption patch (V2.6.29.1-rt=
9).
It works quite smoothly, however I have some questions on the prioritie=
s that are used for
Ethernet, UDP/IP based network communication.
I have one separate NIC in my (Intel QuadCore) PC, that is used for a p=
oint-to-point connection
with an embedded device. Communication is done via UDP.
I have now a user thread (RT prio: 80) to do some computation and also =
the communication with
the embedded device. This thread is the only running on core 3.

My questions are now:
A call of send() in my user space application to transmit a UDP message=
=20
ends up in the network stack of Linux.
Which real time priority will be used in the network stack?
Is it the priority of the user space thread that is calling send()?
Or is it the priority of the kernel thread [sirq-net-tx/3]?

On the receive side (calling recv()):
Which threads are relevant here?
IRQ-XX for the NIC's irq thread, [sirq-net-rx/3] or also the user space=
 thread that is calling recv()?

Thanks for all feedback on that basic question!

Best regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Arcor.de Gaming Area - kostenfrei daddeln bis der Arzt kommt!
Jetzt checken und aus =FCber 80 Spielen w=E4hlen!
http://www.arcor.de/footer-gaming/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
