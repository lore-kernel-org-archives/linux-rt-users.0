From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: udelay and ndelay includes and linker
Date: Tue, 21 Jul 2015 03:51:04 +0200
Message-ID: <CA+Owze7B_Co0yrviS=wzenw=5uK02F6JLVp9VfGNa782VcrqQQ@mail.gmail.com>
References: <CA+Owze6yjuSdWZO_awTKbmP4m-iXadkABUB-z2OdvqRT1fnCHw@mail.gmail.com>
	<20150720064908.GO7013@pengutronix.de>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35894 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbbGUBvF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 21:51:05 -0400
Received: by ykay190 with SMTP id y190so153779189yka.3
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2015 18:51:04 -0700 (PDT)
In-Reply-To: <20150720064908.GO7013@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I encountered to performance problems caused by a memory leak. My
first idea was there must be
a bottle neck. So I was trying to optimize and searched the web. Some
sites were refiring to ndelay.

Best regards,
Jo=C3=ABl


On Mon, Jul 20, 2015 at 8:49 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Jul 17, 2015 at 11:15:01PM +0200, Jo=C3=ABl Kr=C3=A4hemann wr=
ote:
>> Hi, since on my system /usr/include/linux/delay.h is missing I'm
>> asking me how to include it and link against it.
>>
>> I'd like to use ndelay() instead of nanosleep().
> ndelay isn't callable from userspace. That's also the reason for not
> being defined in userspace includable header files.
>
> Why do you think there is an advantage when using ndelay over nanosle=
ep?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
