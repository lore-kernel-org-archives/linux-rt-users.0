From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: Serieal console on Samsung S3C6410 ARM11 CPU (Was [ANNOUNCE] 3.0.6-rt17)
Date: Sat, 8 Oct 2011 18:59:18 +0530
Message-ID: <CAJuYYwSEvA+EHwyhgeZkBX+bB_e1cmFnC6YdEx-CdHzk8peyEw@mail.gmail.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
	<201110081326.58731.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65519 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab1JHN3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Oct 2011 09:29:19 -0400
In-Reply-To: <201110081326.58731.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Juergen,

On 8 October 2011 16:56, Juergen Beisert <jbe@pengutronix.de> wrote:
> Thomas Gleixner wrote:
>> I'm pleased to announce the 3.0.6-rt17 release.
>
> I have no idea where to search, but when I'm using the 3.0.6-rt17 on =
my
> Samsung S3C6410 ARM based system, the UART (serial console) does not =
work as
> expected. Typing only one char at a time is okay. Typing two chars
> immediately makes the system using 100 % CPU load and takes about 2 s=
econds
> to respond. It seems the interrupt handling is broken in the UART dri=
ver, but
> I don't know how to fix it.
>
> This with a simple cursor up (one char to get the last command) and a=
 small
> pause to the next "ENTER" char:
>
> root@mini6410:~ cat /proc/interrupts | grep 18:
> =A018: =A0 =A05739107 =A0s3c-uart =A0s3c6400-uart
>
> Same again:
>
> root@mini6410:~ cat /proc/interrupts | grep 18:
> =A018: =A0 =A05739113 =A0s3c-uart =A0s3c6400-uart
>
> 6 interrupts seems reasonable.
>
> Now with cursor up and SPACE immediately, then a pause for ENTER:
>
> root@mini6410:~ cat /proc/interrupts | grep 18:
> =A018: =A0 =A05923815 =A0s3c-uart =A0s3c6400-uart
>
> 184702 interrupts looks strange.

Just curious, do you have the following two commits?

serial: samsung: Add unified interrupt handler for s3c64xx and later So=
C's
ARM: SAMSUNG: Remove uart irq handling from platform code

Thanks,
Thomas.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
