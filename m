From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Replacement for Xenomai's Message queues?
Date: Thu, 28 Jan 2010 09:09:56 +0100 (CET)
Message-ID: <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:35972 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679Ab0A1IJ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 03:09:57 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id AC5C528B024
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 09:09:56 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 99A7A10109
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 09:09:56 +0100 (CET)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 78B6F1AFCF9
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 09:09:56 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I am about to switch an realtime application from Xenomai to the RT_PRE=
EMPTION patch.
Everything works really smooth, however I have one question.
With my Xenomai application I use the message queue which combine trans=
fer (including queuing)
of data with activation of the thread.
In my Xenomai application I use this feature quite frequently. Now, I a=
m not sure how to do an equivalent
with the RT_PREEMPT patch.
(see http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__n=
ative__queue.html)
Of course I could use condition variables and a struct or array to hold=
 the data I want to pass with the activation
of a thread. However, using this approach I do not have the queuing (wh=
ich is some extra effort I could spent...).
Another idea I have: I could use sockets which realize the queuing but =
the overhead is too high.

Is there any suitable way to implement a message queue like approach us=
ing RT_PREEMPT patch?
I am running x86 (Dual/Quad Cores).

Thanks for all answers on this question.

Regards

Mathias



--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Immer auf dem Laufenden! Sport, Auto, Reise, Politik und Promis. Von un=
s f=FCr Sie: der neue Arcor.de-Newsletter!
Jetzt anmelden und einfach alles wissen: http://www.arcor.de/rd/footer.=
newsletter
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
