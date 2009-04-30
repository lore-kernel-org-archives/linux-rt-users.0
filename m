From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: Re: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 13:17:30 +0200 (CEST)
Message-ID: <438094.1241090250891.JavaMail.ngmail@webmail11.arcor-online.net>
References: <921ca19c0904300404x5193a9d0s1c52c688826d7912@mail.gmail.com> <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
	 <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com>
	 <14844227.1241088061552.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: sjt.kar@gmail.com, mathias_koehrer@arcor.de,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:45398 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbZD3LRb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 07:17:31 -0400
In-Reply-To: <921ca19c0904300404x5193a9d0s1c52c688826d7912@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sujit,

now I got your point!
I think I did not tell it clearly:
I want to replace a running Xenomai/RTNET approach by completely
using the RT_PREEMPT patch. I do not want to do any mix of Xenomai and =
RT_PREEMPT.
The target is to have a RT_PREEMPT only system that performs similar to=
 the Xenomai/rtnet
approach.

Sorry for any confusion here...

Thus, the concrete question (in short) is:
- Which (user/kernel) threads (prio, affinity) are relevant for using E=
thernet (UDP/IP) communication
with the RT_PREEMPT patch.

> I think you have a point it certainly needs to be checked whether
> the RT_PREEMPT patch behaves with an package like Xenomai.
> My initial reaction is just that in the case of Xenomai, it just appl=
ies
> an Hard Real time constraint on the RT_PREEMPT patch.
>=20
> But it is certainly much better to investigate what happens when we
> have an Xenomai like RT System behave otherwise. Does it change
> the RT_PREEMPT patch.
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
