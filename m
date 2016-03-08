From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: dump_stack: avoid potential deadlocks
Date: Tue, 8 Mar 2016 10:34:04 +0100
Message-ID: <20160308093404.GB21842@linutronix.de>
References: <56D24D50.6010500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49770 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbcCHJeH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 04:34:07 -0500
Content-Disposition: inline
In-Reply-To: <56D24D50.6010500@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* DIXLOR | 2016-02-28 04:28:48 [+0300]:

>What do you think about commit e31e4672559674b0950885465a42968a86865d42
>
>https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/diff/lib/dump_stack.c?id=v4.4.3&id2=v4.4.2
>
>In RT instead preempt_disable() use migrate_disable()

What are you trying to say? What is the problem?

Sebastian
