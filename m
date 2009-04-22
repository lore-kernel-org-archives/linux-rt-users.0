From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Triggering UserCode from KernelModule (IRQ)
Date: Wed, 22 Apr 2009 16:14:48 +0200 (CEST)
Message-ID: <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:45129 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991AbZDVOOu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 10:14:50 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mx.arcor.de (Postfix) with ESMTP id CD71E33AB13
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Apr 2009 16:14:48 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id C70E3ABAA8
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Apr 2009 16:14:48 +0200 (CEST)
Received: from webmail19.ha2.local (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 73664332B7A
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Apr 2009 16:14:48 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all!

I am currently evaluting the RT_PREEMPT kernel as a replacement for a X=
enomai based real time application.
(Intel Core2Duo PCs).
So far, everything works really fine and the performance is about the s=
ame as with Xenomai.
Great work!

However, I have one question:
I have a PCI hardware I/O board that exchanges data with the user mode=20
directly (by using mmap), this works fine.
However, there is one operation mode that uses interrupts to signal inc=
oming data.
The interrupt handler is realized as a tiny kernel module (that one tha=
t provides also=20
the mmap for the user mode application).
Now I am not sure how the signalling of the IRQ from kernel to user mod=
e could be realized=20
best (in terms of low latency).

The "classical" approach for this task is to provide a character driver=
 with a .poll file operation.
In Xenomai I could use a semaphore that was accessible from kernel and =
user space for this.
What is the best way in the RT_PREEMPT "world"?=20

Thanks a lot for all feedback on this question.

Regards

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
