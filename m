From: "mikhail.avkhimenia@emlid.com" <mikhail.avkhimenia@emlid.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Fri, 06 Mar 2015 00:26:48 +0300
Message-ID: <845351425590808@web20g.yandex.ru>
References: <3671201425478878@web10j.yandex.ru> <20150305130111.GB668@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jeff Epler <jepler@unpythonic.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward20.mail.yandex.net ([95.108.253.145]:45084 "EHLO
	forward20.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbCEVf0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Mar 2015 16:35:26 -0500
In-Reply-To: <20150305130111.GB668@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for the good hint!

I started setting priority 49 for interrupt threads (while running cycl=
ictest -p49) and most of them showed no effect, but as soon as I did th=
at to one of the three dwc_otg interrupts it hanged.=20
Tried with the other two dwc_otg interrupt threads and also got a hang.=
=20

I've found that dwc_otg driver was updated for BCM2709 and probably tha=
t's the source of a problem:
https://github.com/Clouded/linux-rt-rpi2/commits/rpi-3.18.7-rt2/drivers=
/usb/host/dwc_otg

--=9A
Best regards,
Mikhail

05.03.2015, 16:01, "Jeff Epler" <jepler@unpythonic.net>:
> =9A=9AIt occurs to me that you could adjust the priority of IRQs (by =
sudo
> =9A=9Achrt). =9AWith cyclictest running at priority 49, adjust each i=
rq down
> =9A=9Afrom 50 to 48 in turn and see if you get your hang. =9AOnce you=
 have a
> =9A=9Aspecific irq, perhaps that will in turn point toward an actual =
cause.
>
> =9A=9AJeff

--=9A
Best regards,
Mikhail Avkhimenia
Emlid Ltd
emlid.com


05.03.2015, 16:01, "Jeff Epler" <jepler@unpythonic.net>:
> =9AIt occurs to me that you could adjust the priority of IRQs (by sud=
o
> =9Achrt). =9AWith cyclictest running at priority 49, adjust each irq =
down
> =9Afrom 50 to 48 in turn and see if you get your hang. =9AOnce you ha=
ve a
> =9Aspecific irq, perhaps that will in turn point toward an actual cau=
se.
>
> =9AJeff
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
