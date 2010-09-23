From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Help about Ubuntu Linux-rt
Date: Thu, 23 Sep 2010 10:17:09 -0700
Message-ID: <AANLkTi=4pv1JagFX8uWSfG2h+kDpjcvf5fOP5gsr2_cd@mail.gmail.com>
References: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: rafet ilgin <rafetilginmetu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58644 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0IWRRK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Sep 2010 13:17:10 -0400
Received: by wyb28 with SMTP id 28so1093624wyb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 10:17:09 -0700 (PDT)
In-Reply-To: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Check if IRQs are threaded. Do ps -e, and if you see lots of process
with IRQ-xx, then your kernel is RT.

There is nothing like Hard/Soft RT linux.

HTH,
Mani

On Wed, Sep 22, 2010 at 1:57 PM, rafet ilgin <rafetilginmetu@gmail.com>=
 wrote:
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
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Manik

Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
