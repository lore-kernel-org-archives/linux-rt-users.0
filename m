From: =?ISO-8859-1?Q?Matthias_S=F6llner?= <m.soellner@haw-aw.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Thu, 09 Feb 2012 11:27:48 +0100
Message-ID: <4F339FA4.5070804@haw-aw.de>
References: <4F143AB2.6070404@haw-aw.de> <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com> <4F16D7E9.9070707@haw-aw.de> <20120118191955.GA4066@pengutronix.de> <4F3298E8.9090303@haw-aw.de> <20120208184454.GJ8621@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Austin Hendrix <ahendrix@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.haw-aw.de ([195.37.42.4]:39151 "EHLO smtp.haw-aw.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757679Ab2BIK1y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Feb 2012 05:27:54 -0500
In-Reply-To: <20120208184454.GJ8621@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ok, this was the problem to see the package. I installed a fresh
debian-squeeze 6.04 stable for amd64 and now I can find the package.

But if i do an sudo apt-get install I get the following error:

Die folgenden Pakete haben unerf=FCllte Abh=E4ngigkeiten:
 linux-image-3.0.0-2-rt-amd64 : H=E4ngt ab von: linux-base (>=3D 3~) ab=
er
2.6.32-41 soll installiert werden
                                Empfiehlt: firmware-linux-free (>=3D 3~=
)
soll aber nicht installiert werden
                                Besch=E4digt: initramfs-tools (< 0.99~)
aber 0.98.8 soll installiert werden


Any suggestions?

Thanks
Best Regards
Matthias


On 08.02.2012 19:44, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 08, 2012 at 04:46:48PM +0100, Matthias S=F6llner wrote:
>> On 18.01.2012 20:19, Uwe Kleine-K=F6nig wrote:
>>> On Wed, Jan 18, 2012 at 03:32:09PM +0100, Matthias wrote:
>>>> Ok.
>>>> Where do I get a 3.0 Kernel with included preempt-Patch for instal=
ling
>>>> in Debian 6.0?
>>> if you're on amd64 install linux-image-3.0.0-2-rt-amd64 from
>>> http://debian.pengutronix.de/debian sid main.=20
>>
>> I can't find the package in
>> http://debian.pengutronix.de/debian sid main
>>
>> Added it to /etc/apt/sources.list, and made a sudo apt-get update.
>> But the package is not there.
>>
>> What am I doing wrong?
> What is the output of $(dpkg --print-architecture)?
> debian.pengutronix.de only has the 3.x-rt kernels for amd64. The same=
 is
> true for Debian itself BTW.
>=20
> Best regards
> Uwe
>=20

--=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
