From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Where IOSCHED ?
Date: Thu, 23 Jul 2015 14:39:22 +0200
Message-ID: <20150723123922.GA31936@linutronix.de>
References: <55AFF784.7040900@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43858 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbGWMjY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jul 2015 08:39:24 -0400
Content-Disposition: inline
In-Reply-To: <55AFF784.7040900@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Pavel Vasilyev | 2015-07-22 23:05:24 [+0300]:

>[    0.388079] io scheduler cfq registered (default)
># cat /sys/block/sda/queue/scheduler
>none

Does the same thing happen with plain v3.18.17? Because if it does then
it is not a -RT problem.

># uname -a
>Linux localhost 3.18.17-rt14 #1 SMP PREEMPT RT Wed Jul 22 18:49:51
>MSK 2015 x86_64 GNU/Linux

Sebastian
