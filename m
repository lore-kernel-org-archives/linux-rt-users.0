From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 1/6] preempt_lazy: remove redundant test_thread_flag()
 call
Date: Fri, 9 May 2014 15:17:47 +0200
Message-ID: <20140509131747.GG29014@linutronix.de>
References: <1399020080.5233.96.camel@marge.simpson.net>
 <1399029166.5233.125.camel@marge.simpson.net>
 <20140505223728.5a07e6e1@gandalf.local.home>
 <1399354431.5192.67.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35838 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaEINRt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 09:17:49 -0400
Content-Disposition: inline
In-Reply-To: <1399354431.5192.67.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-05-06 07:33:51 [+0200]:

>> Hmm, do all archs check? Perhaps we need to also update
>> include/asm-generic/preempt.h?
>
>Per cpu preempt_count is x86, and tif_need_resched() handles laziness,
>so all should be well.  Did I just manage to overlook the obvious for
>the second time?

In include/asm-generic/preempt.h we have
| static __always_inline bool __preempt_count_dec_and_test(void)
| {
|         return !--*preempt_count_ptr() && tif_need_resched();
| }

and tif_need_resched() is in include/linux/thread_info.h
| #ifdef CONFIG_PREEMPT_LAZY
| #define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED) || \
|                 test_thread_flag(TIF_NEED_RESCHED_LAZY))
| #else
| #define tif_need_resched() (test_thread_flag(TIF_NEED_RESCHED))
| #endif  

So I guess we are fine.

>-Mike

Sebastian
