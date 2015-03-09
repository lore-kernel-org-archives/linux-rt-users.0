From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-3.18.7-rt1] sched/context-tracking: fix PREEMPT_LAZY
 explosions
Date: Mon, 9 Mar 2015 14:45:35 +0100
Message-ID: <20150309134535.GA13768@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <1424258514.3819.39.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35476 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbbCINph (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 09:45:37 -0400
Content-Disposition: inline
In-Reply-To: <1424258514.3819.39.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2015-02-18 12:21:54 [+0100]:

>On Mon, 2015-02-16 at 12:18 +0100, Sebastian Andrzej Siewior wrote:
>
>> Known issues:
>>
>>       - lazy preempt on x86_64 leads to a crash with some load.
>
>The below still works for me.  (it doesn't make nohz_full actually work
>in rt, but at least folks who want to tinker with it can do so)
So your box still crashes without it?

The thing is I tried to reproduce it and it does not occur anymore.
Neither in KVM nor on real HW.

Sebastian
