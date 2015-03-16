From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 00/39] Linux 3.14.34-rt32-rc1
Date: Mon, 16 Mar 2015 14:59:10 +0100
Message-ID: <20150316135910.GA28130@linutronix.de>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35404 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbCPN7N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 09:59:13 -0400
Content-Disposition: inline
In-Reply-To: <20150312191307.081068717@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-03-12 15:13:07 [-0400]:

>Please scream at me if I messed something up. Please test the patches too.

So Paul remided us about the dead lock thingy that has been reported.
Users reported that it does not occur with v3.18-RT and they think it is
due to 'Revert "timers: do not raise softirq unconditionally"' in 
Revert-timers-do-not-raise-softirq-unconditionally.patch.

I reverted it because I couldn't get highres to get to work at all on
v3.18 due to different synchronisation / expectaion of the timer
framework. Since the trylock might record a different lock owner it is
possible that this causes the deadlock (it thinks). Therefore it has no
stable tag nor any reference to the deadlock problem.

With this patch applied FULL_NOHZ should not properly work (again) due
to timer softirq wake ups (but this is a different problem).

Sebastian
