From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] 3.18.17-rt14 locktorture: Do NOT include rwlock.h
 directly
Date: Tue, 21 Jul 2015 18:45:27 +0200
Message-ID: <20150721164527.GA21978@linutronix.de>
References: <20150702152543.61bbb6eb@gandalf.local.home>
 <55ACC058.2040407@gmail.com>
 <20150720154753.GC9559@linutronix.de>
 <55AE5517.9040403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linuxball <linuxball@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34237 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933280AbbGUQp3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Jul 2015 12:45:29 -0400
Content-Disposition: inline
In-Reply-To: <55AE5517.9040403@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* linuxball | 2015-07-21 16:20:07 [+0200]:

>Including rwlock.h directly will cause kernel builds to fail
>if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
>(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
>is included by locktorture.c anyway.
>
>Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>

If you don't mind I set From: to you have here. If you intendent to sent
further patches I suggest that you get rid of "format=flowed" which adds
a white space for no reason to the diff. I won't fix it again.

Sebastian
