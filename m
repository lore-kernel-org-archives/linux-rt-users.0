From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kenrel panic with 3.18.7-rt2  - Was: Kenrel panic with
 3.18.7-rt2 - rootfs at MMC
Date: Fri, 6 Mar 2015 19:21:28 +0100
Message-ID: <20150306182128.GF10155@linutronix.de>
References: <20150306174336.2eb1fea9@archlinux>
 <20150306174700.29fc83bf@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56281 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbbCFSVa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 13:21:30 -0500
Content-Disposition: inline
In-Reply-To: <20150306174700.29fc83bf@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ralf Mardorf | 2015-03-06 17:47:00 [+0100]:

>On Fri, 6 Mar 2015 13:24:41 +0100, Sebastian Andrzej Siewior wrote:
>>if the system is still responsible you could "dmesg > file" and then
>>that file would interresting as long as there is no systemd crap in
>>it.
>
>That's the problem, the system isn't responsive anymore. There also is
>no file /var/log/dmesg. I can reboot and run the dmesg command, but it
>only shows the messages for the last boot.
So if you don't get the crash message anymore then it gets tricky. You
could use the serial console and read it there (if you have a serial
port and another machine). The other trick might be to use "printk
delay" and then memorize it or use a camera :)

Sebastian
