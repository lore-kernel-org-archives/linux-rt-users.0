From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 12:41:01 +0200 (CEST)
Message-ID: <14844227.1241088061552.JavaMail.ngmail@webmail12.arcor-online.net>
References: <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com> <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: sjt.kar@gmail.com, mathias_koehrer@arcor.de,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:45890 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754591AbZD3KlE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 06:41:04 -0400
In-Reply-To: <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sujit,

thanks for your response.
I am actually interested in the way, the communication with the RT_PREE=
MPT patch=20
works to get an understanding what pieces of the overall system can be =
tuned and=20
which priorities of threads are relevant and which SMP affinities are r=
elevant.

As rtnet can only handle UDP it is obvious, that it is performing sligh=
tly better,
however a good understanding is important in any case.

> 1. Is Xenomai is Configured to take care of Multicore Hard real time
> Computation? Since
>   you say that the Thread is running in Processor 3. How is Xenomai
> Configured in case
>   of the Multicore Solution
> 2. What are these hard real time computations in this particular thre=
ad?
> 3. How is Xenomai Taking care of this thread?
> 4. RTNET is running the UDP Part of Thread or Does not fork in Xenoma=
i.
>=20

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
