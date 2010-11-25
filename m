From: Robin Gareus <robin@gareus.org>
Subject: Re: 2.6.3x-rty where x > 3 and y >= 1?
Date: Thu, 25 Nov 2010 01:29:23 +0100
Message-ID: <4CEDADE3.2020507@gareus.org>
References: <4CDAF425.4050800@ccrma.stanford.edu> <alpine.LFD.2.00.1011102154330.2900@localhost6.localdomain6> <4CDC0429.8090506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:25119 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0KYA32 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Nov 2010 19:29:28 -0500
In-Reply-To: <4CDC0429.8090506@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/11/10 15:56, Niccol=F2 Belli wrote:
> Il 10/11/2010 21:54, Thomas Gleixner ha scritto:
>> Working on it :)
>=20
> Glad to hear that, I can't use 2.6.33-rt anymore because of problems
> with my intel video card and my band is starting to blame because of =
xruns.
>
> Darkbasic

"Can't use it anymore" sounds weird. Is that related to some userspace
f.i. xorg update?

Did you try the 'i915.modeset=3D1' boot option with 2.6.33.7-rt29?

Said kernel works just fine here with both Intel and NVidia video cards
on debian/testing+sid.

best,
robin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
