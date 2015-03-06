From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Fri, 6 Mar 2015 13:24:41 +0100
Message-ID: <20150306122441.GB10155@linutronix.de>
References: <54EC487F.8020109@gmail.com>
 <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
 <20150302043404.13bdf10e@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54956 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbCFMYn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 07:24:43 -0500
Content-Disposition: inline
In-Reply-To: <20150302043404.13bdf10e@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ralf Mardorf | 2015-03-02 04:34:04 [+0100]:

>On Sun, 1 Mar 2015 20:25:24 -0500, Paul Gortmaker wrote:
>>In the future, putting the log lines in line (vs attachment) makes
>>it easier to reply and comment - meaning more people will look
>>at the report.

It would be usefull not to reply to this thread since what I read it
does not seem to be MMC related.

>I get kernel panic for 3.18.7-rt2 on an AMD Athlon dual-core x86_64
>machine, but I don't know what log files to post.

The dmesg output / kernel log would be usefull. If you can get it out of
serial or logged on disk, that would be good.

>a high amount of unreadable fast messages scrolled, finished with
>something similar to "recursive fixed, restart is needed".

if the system is still responsible you could "dmesg > file" and then
that file would interresting as long as there is no systemd crap in it.

>Regards,
>Ralf

Sebastian
