From: Romain Perier <romain.perier@gmail.com>
Subject: Re: rt patch
Date: Tue, 9 Jun 2015 17:12:07 +0200
Message-ID: <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com>
References: <5576FC70.8050908@numalliance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?St=C3=A9phane_ancelot?= <sancelot@numalliance.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33161 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbFIPMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2015 11:12:08 -0400
Received: by qkhg32 with SMTP id g32so10980586qkh.0
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Jun 2015 08:12:07 -0700 (PDT)
In-Reply-To: <5576FC70.8050908@numalliance.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

did you try the patches located at
https://www.kernel.org/pub/linux/kernel/projects/rt/ ?
Use the corresponding mainline kernel, for example if you want to use
3.18.13-rt10, download linux 3.18.13 (from torvald's repo for example)
and apply the rt patch on it .
Latest rt patches are for linux 3.18 and 4.0, so if you use the
correct version it should work just fine.

Everything is explained on the wiki,
Regards,
Romain

2015-06-09 16:47 GMT+02:00 St=C3=A9phane ancelot <sancelot@numalliance.=
com>:
> Hi,
> I have tried the rt patches available on kernel.org.
> Unfortunately none patches correctly with latests kernel !
>
> Where can I download the good ones ?
> Regards,
> Steph
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
