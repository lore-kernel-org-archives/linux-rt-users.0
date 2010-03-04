From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Disabling lapic timer for a certain core
Date: Thu, 4 Mar 2010 13:29:53 +0100 (CET)
Message-ID: <14900780.1267705793289.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:51839 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754171Ab0CDM34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Mar 2010 07:29:56 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id A27D31B3DF4
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Mar 2010 13:29:53 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 626B0D46FB
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Mar 2010 13:29:53 +0100 (CET)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 4FCD11AF6D1
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Mar 2010 13:29:53 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all!

I am running the RT_PREEMPT kernel 2.6.31.2-rt13 on a Intel Quad Core C=
PU.
I start my kernel with isolcpus=3D1-7 option to force all processes to =
run on CPU core 0 only.
Now we have the need for a very fast loop. Within this loop some access=
es from/to a PCIe I/O board
(mapped in user space) and some additional computation has to be done.
=46or this, I use a real time thread, run this on CPU core 3 and let it=
 run in an endless polling loop.
So far everything works fine.
This thread is the only running user mode thread on CPU core 3.
However, we measure some run time jitters when accessing the I/O board =
in the range of up to=20
15 microseconds which are not tolerable by the application.
I see that on all cores the "Local Timer Interrupt" occurs 100 times a =
second (of course this is the timer frequency=20
select in the kernel configuration).

My question is now:
Is it possible to disable the "Local Timer Interrupt" for core 3 as it =
is actually not required here?
I want to use the full 100% CPU core time for this single loop.

Any help or ideas are welcome!

Thanks a lot.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@arcor.de


Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst=
 mit und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
