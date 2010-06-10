From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: real time linux - which to use?
Date: Thu, 10 Jun 2010 15:01:00 +0200
Message-ID: <AANLkTikajmYx6EuuQqaJ6hYm0xXJc2e4QqRtvQ2Plj67@mail.gmail.com>
References: <AANLkTilcpfJLRqKzsN0n6Vx_EGHO7Q56uaOWBPYYaPx7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Neel Mehta <neelmehta89@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:40995 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab0FJNBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 09:01:05 -0400
Received: by ewy23 with SMTP id 23so73565ewy.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2010 06:01:03 -0700 (PDT)
In-Reply-To: <AANLkTilcpfJLRqKzsN0n6Vx_EGHO7Q56uaOWBPYYaPx7@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Neel,

On Thu, Jun 10, 2010 at 2:57 PM, Neel Mehta <neelmehta89@gmail.com> wro=
te:
>
> Hi. I am new to real time linux os. I need to set up one. I came
> across two realtime linux os/kernels/patches, and there may be more. =
I
> came across=A0http://www.rtlinuxfree.com/=A0and=A0https://www.rtai.or=
g/.

Real-time approaches to Linux are native real-time on Linux which is
what RT_PREEMPT tries to achieve. This fairly new compared to the
older approaches to provide real-time performance with Linux and that
is teh co-kernel approach. I have been using RT_PREEMPT for a few
years now and it has served me well.

> Are there more such patches? Is anyone better? What do people use
> normally? I need to set up realtime linux to get results from sensors
> every periodic intervals. I want this to be hard realtime. Any help
> will be greatly appreciated. Instructions or links for compilation
> will also be very helpful.

Check out http://rt.wiki.kernel.org .

regards
/prady

--
http://www.prady.in
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
