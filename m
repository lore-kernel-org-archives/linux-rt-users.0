From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Triggering UserCode from KernelModule (IRQ)
Date: Thu, 23 Apr 2009 08:36:38 +0200 (CEST)
Message-ID: <20485155.1240468598325.JavaMail.ngmail@webmail14.arcor-online.net>
References: <200904221628.27659.claus.gindhart@kontron.com> <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: claus.gindhart@kontron.com, mathias_koehrer@arcor.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:53742 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753515AbZDWGgj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 02:36:39 -0400
In-Reply-To: <200904221628.27659.claus.gindhart@kontron.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Claus,=20

thanks for the feedback.
> simply write an UIO driver for your I/O-HW. You find an excellent how=
to in
> http://www.osadl.org/UIO.uio0.0.html
>=20
> The UIO-driver has 2 benefits for you:
> 1. It provides you with direct access to the mmapped area from user s=
pace,=20
> freeing you from the necessity to communicate via the /dev interface.
> 2. It can invoke a handler function in user space, if an interrupt oc=
curs.
That is really cool for a new driver, however I have an already existin=
g driver
(that works with Xenomai) and in the first step I do not want to change=
 too much...
The only missing piece here is the "triggering" of my user space task w=
henever
an interrupt occurred.
Is the .poll approach real time capable or is there another approach be=
tter?

Thanks a lot

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
