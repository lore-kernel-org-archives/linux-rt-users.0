From: Remy Bohmer <linux@bohmer.net>
Subject: Re: preempt-rt amd uClibc
Date: Fri, 15 Apr 2011 21:59:42 +0200
Message-ID: <BANLkTimpnyLHDOnFBp=H2YNqEeMnST9WPg@mail.gmail.com>
References: <1302885584.4da874d08c74a@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Johannes Bauer <hannes_bauer@aon.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45786 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1DOT7n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Apr 2011 15:59:43 -0400
Received: by gwaa18 with SMTP id a18so1227508gwa.19
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Apr 2011 12:59:42 -0700 (PDT)
In-Reply-To: <1302885584.4da874d08c74a@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2011/4/15 Johannes Bauer <hannes_bauer@aon.at>:
> Hi everybody!
>
> I downloaded the newest uClinux dist a while ago and compiled it with 2.6.33 kernel and the 2.6.33.7.2-rt30 patch applied.
> Then i by hand implemeted an old patch for arm lpc22xx machine (ARMv4T), since i am running a lpc2478 board from embedded artists.
> I had to implement a clockevent/source timer to add hrtimer support. I compiled it all with uClibc since it as a NOMMU system.
>
> Now i have some questions:
> Is it possible to run the preempt-rt patch with the uClinux distribution and uClibc?

The preempt-RT patch runs just fine with a uClibc userspace, I have no
idea what it will do in a NOMMU system (never tried it)

> I read a few times that if doesnt support PI mutexes, but arent those RT mutexes part of the kernel?

The kernel itself has PI-mutexes support, _internally_within_ the
kernel; regardless what type of userspace C-library is being used.
However, for _userspace_ PI-mutexes, you will need a C-library that
supports it (search for example for PTHREAD_PRIO_INHERIT in the
library code). 2 options:
* Glibc since version 2.5 (actually 2.4.90 and higher)
* uClibc master. You might have some luck since there is now NPTL
support in uClibc master. So, get the master tree of uClibc and see if
it works for you.
(http://git.uclibc.org/uClibc/snapshot/uClibc-master.tar.gz)
I have not tested it myself though, but if it works, please share the
good news.

Have Fun!

Remy
