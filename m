From: Bernardo Barros <bernardobarros2@gmail.com>
Subject: Re: Help about Ubuntu Linux-rt
Date: Wed, 22 Sep 2010 19:32:37 -0300
Message-ID: <AANLkTikjz4=qtrsuBKWnaKk3KDVvtLZ5=MRMG8khz9Ep@mail.gmail.com>
References: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: rafet ilgin <rafetilginmetu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43529 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0IVWci convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Sep 2010 18:32:38 -0400
Received: by gxk9 with SMTP id 9so371030gxk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Sep 2010 15:32:38 -0700 (PDT)
In-Reply-To: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

try
    uname -r

and see what kernel your system is using.


2010/9/22 rafet ilgin <rafetilginmetu@gmail.com>:
> I have installed real time image on my ubuntu karmic(9.10) by using
> the command apt-get install linux-rt(2.6.31.9-rt). After installing
> the image I have booted my system from real time kernel(2.6.31.9-rt).
> Can I say that is it now real time? And is it soft real time or hard
> real time? I looked at the file /boot/config-2.6.31.9-rt and saw that
> CONFIG_PREEMPT_RT=3Dy is set. If you reply me I would really apprecia=
te
> it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
