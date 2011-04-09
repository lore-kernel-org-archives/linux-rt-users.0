From: =?ISO-8859-1?Q?Niccol=F2_Belli?= <darkbasic4@gmail.com>
Subject: Re: Preferred way for rt-linux using git
Date: Sat, 09 Apr 2011 16:56:52 +0200
Message-ID: <4DA073B4.5070006@gmail.com>
References: <BANLkTi=3s8bZLibMZX7y6_NGhHivErwS_Q@mail.gmail.com>	<BANLkTikP3ZEndzdOxA8aX29125h9MXG6xQ@mail.gmail.com>	<4D9F5F0F.1010600@osadl.org>	<4D9F86B9.1040003@gmail.com>	<4D9FA093.3080109@osadl.org> <BANLkTik1zrmp_dDBD===t2p+jAFfm1ou6Q@mail.gmail.com> <4DA0561E.3020306@gmail.com> <4DA05A89.9080008@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50109 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab1DIO4v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Apr 2011 10:56:51 -0400
Received: by wya21 with SMTP id 21so3786689wya.19
        for <linux-rt-users@vger.kernel.org>; Sat, 09 Apr 2011 07:56:49 -0700 (PDT)
In-Reply-To: <4DA05A89.9080008@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 09/04/2011 15:09, Carsten Emde ha scritto:
> Have you ever tried to backport the required drivers to 2.6.33? We did
> it with a number of recent kernel components; was not too difficult.
> Which drivers do you need?

Uhm... I fear it will not be simple, among other things I will have to
backport i2c, sata3, maybe ethernet and above all the whole intel
graphic stack from 2.6.40 aka intel drm git branch (hoping it will solve
the graphic corruption problems I have with 2.6.38 and 2.6.39-rc1). I
really hope rt will find its way into mainline, everything will be much
more simple.

Darkbasic
