From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] 3.18.17-rt14 locktorture: Do NOT include rwlock.h
 directly
Date: Mon, 20 Jul 2015 17:47:53 +0200
Message-ID: <20150720154753.GC9559@linutronix.de>
References: <20150702152543.61bbb6eb@gandalf.local.home>
 <55ACC058.2040407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linuxball <linuxball@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56413 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbbGTPrz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 11:47:55 -0400
Content-Disposition: inline
In-Reply-To: <55ACC058.2040407@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* linuxball | 2015-07-20 11:33:12 [+0200]:

>Including rwlock.h directly will cause kernel builds to fail
>if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
>(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
>is included by locktorture.c anyway.

Documentation/SubmittingPatches:
    11) Sign your work

Sebastian
