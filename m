From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: How to modify priority uart/serial interrupt on 3.14.23-rt20?
Date: Tue, 18 Nov 2014 10:40:50 -0800
Message-ID: <CANGgnMZqGLhRUaCRfD1egLp-qvsUX0hZWKcaGJzLwnj3_khGtQ@mail.gmail.com>
References: <CEE27071B8F0914B91B3076CEB63C2B6104C7C8F43@de01ex08.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59558 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaKRSlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Nov 2014 13:41:12 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so10458968wgh.9
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Nov 2014 10:41:10 -0800 (PST)
In-Reply-To: <CEE27071B8F0914B91B3076CEB63C2B6104C7C8F43@de01ex08.GLOBAL.JHCN.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2 ways come to mind.  I've done one of them.  Others may have better
suggestions.

1) After you open the uart, iterate through /proc/, find the uart
interrupt thread, and bump it's priority.

2) Set up a background task which polls /proc/ for the uart interrupt
thread and bumps the priority.

(Sigh, resending since I forgot to use plain-text again...)

Austin

On Tue, Nov 18, 2014 at 1:11 AM, Lampersperger Andreas
<lampersperger.andreas@heidenhain.de> wrote:
> Hello,
>
> does anyone have a hint how modify (increase) the priority of
> the serial/uart interrupt on a 3.14.23-rt20 kernel?
>
> AFAIK the kernel thread for serial communication is created
> when the communication starts, but I want to change the
> priority when the driver loads (modprobe 8250).
>
> Thank's for your help!
> Andreas
>
> ---------------------------------------------------------------------=
---------------------------------
> Registergericht: Traunstein / Registry Court: HRB 275 - Sitz / Head O=
ffice: Traunreut
> Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Bur=
khard
> Gesch=C3=A4ftsf=C3=BChrung / Management Board: Thomas Sesselmann (Vor=
sitzender / Chairman), Michael Grimm
>
> E-Mail Haftungsausschluss / E-Mail Disclaimer: http://www.heidenhain.=
de/disclaimer
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
