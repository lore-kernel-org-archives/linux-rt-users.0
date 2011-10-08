From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: Serieal console on Samsung S3C6410 ARM11 CPU (Was [ANNOUNCE] 3.0.6-rt17)
Date: Sun, 9 Oct 2011 00:31:55 +0530
Message-ID: <CAJuYYwSB7CT=gyJTBcp4hrAR=Qwon=TzudR7ptA0kr+6RwCMFQ@mail.gmail.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
	<201110081326.58731.jbe@pengutronix.de>
	<CAJuYYwSEvA+EHwyhgeZkBX+bB_e1cmFnC6YdEx-CdHzk8peyEw@mail.gmail.com>
	<201110082015.17128.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42208 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab1JHTBz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Oct 2011 15:01:55 -0400
In-Reply-To: <201110082015.17128.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8 October 2011 23:45, Juergen Beisert <jbe@pengutronix.de> wrote:
> Hi Thomas,
>
> Thomas Abraham wrote:
>> On 8 October 2011 16:56, Juergen Beisert <jbe@pengutronix.de> wrote:
>> > Thomas Gleixner wrote:
>> >> I'm pleased to announce the 3.0.6-rt17 release.
>> >
>> > I have no idea where to search, but when I'm using the 3.0.6-rt17 =
on my
>> > Samsung S3C6410 ARM based system, the UART (serial console) does n=
ot work
>> > as expected. Typing only one char at a time is okay. Typing two ch=
ars
>> > immediately makes the system using 100 % CPU load and takes about =
2
>> > seconds to respond. It seems the interrupt handling is broken in t=
he UART
>> > driver, but I don't know how to fix it.
>> >
>> > This with a simple cursor up (one char to get the last command) an=
d a
>> > small pause to the next "ENTER" char:
>> >
>> > root@mini6410:~ cat /proc/interrupts | grep 18:
>> > =A018: =A0 =A05739107 =A0s3c-uart =A0s3c6400-uart
>> >
>> > Same again:
>> >
>> > root@mini6410:~ cat /proc/interrupts | grep 18:
>> > =A018: =A0 =A05739113 =A0s3c-uart =A0s3c6400-uart
>> >
>> > 6 interrupts seems reasonable.
>> >
>> > Now with cursor up and SPACE immediately, then a pause for ENTER:
>> >
>> > root@mini6410:~ cat /proc/interrupts | grep 18:
>> > =A018: =A0 =A05923815 =A0s3c-uart =A0s3c6400-uart
>> >
>> > 184702 interrupts looks strange.
>>
>> Just curious, do you have the following two commits?
>>
>> serial: samsung: Add unified interrupt handler for s3c64xx and later=
 SoC's
>> ARM: SAMSUNG: Remove uart irq handling from platform code
>
> Are they part of the current 3.0.6 vanilla kernel? I'm only using the=
 vanilla
> 3.0.6 with rt17 on my target.

No. I don't think they are part of 3.0.6 kernel. I am not sure of the
issue you have with serial console, but if you do not have these
patches already applied, you could try with them.

Thanks,
Thomas.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
