From: =?ISO-8859-1?Q?Matthias_S=F6llner?= <m.soellner@haw-aw.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Wed, 18 Jan 2012 15:32:09 +0100
Message-ID: <4F16D7E9.9070707@haw-aw.de>
References: <4F143AB2.6070404@haw-aw.de> <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Austin Hendrix <ahendrix@willowgarage.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.haw-aw.de ([195.37.42.4]:32340 "EHLO smtp.haw-aw.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654Ab2AROcN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 09:32:13 -0500
In-Reply-To: <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ok.
Where do I get a 3.0 Kernel with included preempt-Patch for installing
in Debian 6.0?

By the way, is there any package which includes a Kernel with included
Preempt-Patch for use in Ubuntu 11.10 as it was available for ubuntu
8.04 (linux-rt)?

Thanks

Matthias


On 17.01.2012 02:03, Austin Hendrix wrote:
> It looks like you're using an old version of the realtime kernel, and=
 the
> maintainer has neglected to package headers for it. (see:
> http://debian.pengutronix.de/debian/pool/contrib/l/linuxrt-latest/ ).=
 If
> your CPU will support a 64-bit kernel, I suggest trying one of the 3.=
0
> kernels. It's more likely to have your network driver built in, and t=
here's
> a matching linux-headers package if you need it.
>=20
> -Austin
>=20
> 2012/1/16 Matthias S=F6llner <m.soellner@haw-aw.de>
>=20
>> Hello,
>> I installed a RT-Preempt Kernel in Debian 6
>> as shown on
>> http://pengutronix.de/software/linux-rt/debian_en.html
>>
>> I have a DELL Precision T1600 with onboard network card and addition=
al
>> PCI network-card.
>>
>> The onboard card is a Intel=AE 82579LM Gigabit-LAN.
>>
>> I used linux-image-2.6-rt-686 from Pengutronix APT repository.
>>
>> Installation worked fine, I can boot my debian with both kernels.
>>
>> If I boot normal debian kernel i have eth0 and eth1. both cards work=
 fine.
>>
>> But if I boot RT-Preempt-Kernel the  internal network card is not sh=
own
>> and I only have eth0.
>>
>> With normal debian kernel intel e1000e driver is loaded.
>>
>> What can I do to make my internal network card function properly wit=
h
>> realtime kernel ?
>>
>>
>> I tried to compile the intel network driver myself. But where to I g=
et
>> the right kernel-headers for my RT-Preempt-Kernel?
>>
>> Any hints?
>> Thanks a lot
>> Matthias
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20


Matthias S=F6llner, M.Sc.
Laboringenieur
Hochschule Amberg - Weiden (HAW)
=46akult=E4t f=FCr Elektro- und Informationstechnik
Kaiser-Wilhelm-Ring 23
92224 Amberg

Tel. 09621 482-3709
=46ax. 09621 482-4709
e-mail m.soellner@haw-aw.de
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
