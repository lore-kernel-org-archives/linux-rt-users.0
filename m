From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Preferred way for rt-linux using git
Date: Sat, 09 Apr 2011 15:09:29 +0200
Message-ID: <4DA05A89.9080008@osadl.org>
References: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com>	<BANLkTikP3ZEndzdOxA8aX29125h9MXG6xQ@mail.gmail.com>	<4D9F5F0F.1010600@osadl.org>	<4D9F86B9.1040003@gmail.com>	<4D9FA093.3080109@osadl.org> <BANLkTik1zrmp_dDBD===t2p+jAFfm1ou6Q@mail.gmail.com> <4DA0561E.3020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:58133 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab1DINKI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Apr 2011 09:10:08 -0400
In-Reply-To: <4DA0561E.3020306@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/09/2011 02:50 PM, Niccol=F2 Belli wrote:
> Il 09/04/2011 03:05, Oon-Ee Ng ha scritto:
> It may not be fair, but on the desktop (a sandy bridge one) it doesn'=
t
> even boot because of lack of drivers and on my laptop it crashs every=
 5
> minutes because of the buggy intel drivers.
> For _me_ it's 'useless and ancient' because it's too old to run on th=
e
> desktop and too buggy (it's a 2.6.33 vanilla fault, not an rt one) to
> run on my laptop. I have nothing against rt.
Have you ever tried to backport the required drivers to 2.6.33? We did=20
it with a number of recent kernel components; was not too difficult.=20
Which drivers do you need?

	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
