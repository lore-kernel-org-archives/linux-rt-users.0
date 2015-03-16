From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.18.9-rt4
Date: Mon, 16 Mar 2015 18:50:42 +0100
Message-ID: <20150316175042.GE28130@linutronix.de>
References: <20150307141536.GA6485@linutronix.de>
 <loom.20150309T235034-919@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Neil Bradley <neil.bradley@windowslive.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36762 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbbCPRun (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 13:50:43 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150309T235034-919@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Neil Bradley | 2015-03-09 22:54:54 [+0000]:

>Hi there.
Hi,
>
>If I compile the rt patch with any pre-emption model other than full
>preemption, I get a compile error in kernel/irq_work:150:20.
>hirq_work_list Undeclared.
>
>Using current 3.18.9 sources & patch-3.18.9-rt4.
thx, Steven sent a fix, will be fixed in the next release.

>Cheers, Neil.

Sebastian
