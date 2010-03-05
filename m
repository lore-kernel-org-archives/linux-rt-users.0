From: Remy Bohmer <linux@bohmer.net>
Subject: Re: new to linux RT
Date: Fri, 5 Mar 2010 21:39:43 +0100
Message-ID: <3efb10971003051239p1d2bd857w1fe198850b52aafe@mail.gmail.com>
References: <615761851003051217u733c4717wd04679de318f5153@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Michael Mueller <ss7box@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:22591 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab0CEUjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Mar 2010 15:39:45 -0500
Received: by fg-out-1718.google.com with SMTP id l26so395145fgb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Mar 2010 12:39:44 -0800 (PST)
In-Reply-To: <615761851003051217u733c4717wd04679de318f5153@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2010/3/5 Michael Mueller <ss7box@gmail.com>:
> Hi,
>
> I am new to linux RT. =A0Not so new to rtos. =A0Have compiled/loaded/=
run
> kernels from kernel.org with success in past.
> I am trying to find a kernel and RT patch combination that are
> compatible. =A0Not so much success. =A0Latest attempt is with
> linux-2.6.31.12 where I am getting:
>
> =A0LD =A0 =A0 =A0init/built-in.o
> =A0LD =A0 =A0 =A0.tmp_vmlinux1
> drivers/built-in.o(.init.text+0x3c5e): In function `con_init':
> : undefined reference to `.L1446'
> make: *** [.tmp_vmlinux1] Error 1

> ... <snip>

> my gcc is:
> gcc version 3.4.6 20060404 (Red Hat 3.4.6-11)

=46irst start by using a recent compiler.

> ... <snip>

> any ideas, pointers, corrections, admonishments, chastisements,
> thoughts, etc. would be appreciated

Then start reading this:
http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

You can find the latest RT-patches here:
http://www.eu.kernel.org/pub/linux/kernel/projects/rt/
The patches suit the same base kernel as listed in the name of the patc=
h.

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
