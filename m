From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Mon, 2 Mar 2015 04:34:04 +0100
Message-ID: <20150302043404.13bdf10e@archlinux>
References: <54EC487F.8020109@gmail.com>
	<CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail229c50.megamailservers.eu ([91.136.10.239]:55161 "EHLO
	mail36c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753447AbbCBEAV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Mar 2015 23:00:21 -0500
Received: from archlinux (g224210086.adsl.alicedsl.de [92.224.210.86])
	(authenticated bits=0)
	by mail36c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id t223Y32J032557
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 2 Mar 2015 03:34:06 +0000
In-Reply-To: <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 1 Mar 2015 20:25:24 -0500, Paul Gortmaker wrote:
>In the future, putting the log lines in line (vs attachment) makes
>it easier to reply and comment - meaning more people will look
>at the report.

I get kernel panic for 3.18.7-rt2 on an AMD Athlon dual-core x86_64
machine, but I don't know what log files to post.

When first booting

$ pacman -Q linux-rt
linux-rt 3.18.7_rt2-3

at the beginning the startup messages were as usual, but after a while
a high amount of unreadable fast messages scrolled, finished with
something similar to "recursive fixed, restart is needed".

When booting for the second time at the beginning the startup messages
were as usual, but then several kernel panic messages were displayed.

$ journalctl -b -1
$ journalctl -b -2
etc. would take much too long to display something, I only hear the HDD
working.

$ journalctl --since "15 min ago"
$ journalctl -k
$ dmesg
don't show useful output, at least they don't show the strange startup
messages.

Regards,
Ralf
