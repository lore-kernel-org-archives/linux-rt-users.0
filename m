From: =?ISO-8859-1?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Subject: Re: 2.6.3x-rty where x > 3 and y >= 1?
Date: Thu, 25 Nov 2010 12:25:38 +0100
Message-ID: <4CEE47B2.1000304@gmail.com>
References: <4CDAF425.4050800@ccrma.stanford.edu> <alpine.LFD.2.00.1011102154330.2900@localhost6.localdomain6> <4CDC0429.8090506@gmail.com> <4CEDADE3.2020507@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60777 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0KYLZf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Nov 2010 06:25:35 -0500
Received: by wwa36 with SMTP id 36so831863wwa.1
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Nov 2010 03:25:34 -0800 (PST)
In-Reply-To: <4CEDADE3.2020507@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 25/11/2010 01:29, Robin Gareus ha scritto:
> On 11/11/10 15:56, Niccol=F2 Belli wrote:
>> Glad to hear that, I can't use 2.6.33-rt anymore because of problems
>> with my intel video card and my band is starting to blame because of=
 xruns.
> "Can't use it anymore" sounds weird. Is that related to some userspac=
e
> f.i. xorg update?

It's because the Intel KMS driver sucks hard, *VERY* hard.

Because of this:
http://bugs.freedesktop.org/show_bug.cgi?id=3D27169

And this:
http://bugs.freedesktop.org/show_bug.cgi?id=3D30352

And this:
http://bugs.freedesktop.org/show_bug.cgi?id=3D26664

And this:
http://bugs.freedesktop.org/show_bug.cgi?id=3D27168

=2E..and I can continue, but I think you get the point :-)

Intel driver is *SHIT*.

Darkbasic
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
