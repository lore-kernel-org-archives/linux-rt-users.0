From: "Sarin, Suseelan" <suseelan@gmail.com>
Subject: Re: Calculating latency using high resolution timer
Date: Thu, 10 Jun 2010 11:41:22 +0530
Message-ID: <AANLkTimBtQ7xfQKZNzu4GQSVtlwFkSIc1_oJCGbVSkKK@mail.gmail.com>
References: <AANLkTikuWI08hHb2BdzicdEYKO4SdQlCL17gDQgqwrKz@mail.gmail.com>
	<AANLkTinCc-TibWfphYTZtXhDh2flvrcXNW_bO3SUetyV@mail.gmail.com>
	<4C0FD3E4.9090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Reagan Thomas <thomasraz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59009 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0FJGLY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jun 2010 02:11:24 -0400
Received: by gwj15 with SMTP id 15so541446gwj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jun 2010 23:11:23 -0700 (PDT)
In-Reply-To: <4C0FD3E4.9090304@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>
> Not a lot of information about your test (kernel version, kernel conf=
ig, -rt patch, your code, etc) in your mail, but I would expect a 2 mil=
lisecond deadline to be easy to meet. =A0At 5 milliseconds, I'd say you=
 aren't using RT scheduling at all.
>

Thank you for the response and for the code. I haven't seen your code
in detail, but will do that soon. I am running 2.6.29 with board
specific patches and patched with 2.6.29-rt3. ARMv5 running at about
700 bogo-mips. When the system is completely in use, the CPU usage
goes and stays at 99%+ for most of the time.

> The output below is from a pretty crude/simple chunk of test code tha=
t was run on kernel 2.6.26.8-rt16 (yes, it's old, but it's a box thats =
up and reachable by me right now). Times are in microseconds. =A0The co=
de sleeps for 100 microseconds, then checks how long it actually slept,=
 outputting some stats once a second.
>
> crappy test code is at:
> http://www.rato.us/ltest.c
> Compile with "gcc ltest.c -lrt -oltest".
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
