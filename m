From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Wed, 25 May 2016 18:33:23 +0200
Message-ID: <20160525163323.GB18036@linutronix.de>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
 <20160512085946.GB19035@linutronix.de>
 <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41146 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcEYQd0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 May 2016 12:33:26 -0400
Content-Disposition: inline
In-Reply-To: <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Brian Silverman | 2016-05-16 14:05:54 [-0700]:

Thank you for the explanation.

>It happens when realtime (SCHED_RR/SCHED_FIFO) processes which have
>called mlockall(MCL_CURRENT | MCL_FUTURE) exit.

Why can't the application drop the RT priority before its exit? Wouldn't
that be appropriate?

>One of them:
> queue_cyclictes-5298  [000] ....1..   290.366030: remove_vma <-exit_mmap
> queue_cyclictes-5298  [000] ....1..   290.366032: __might_sleep <-remove_vma
> queue_cyclictes-5298  [000] ....1..   290.366033: ___might_sleep
><-__might_sleep
> queue_cyclictes-5298  [000] ....1..   290.366035: kmem_cache_free <-remove_vma
> queue_cyclictes-5298  [000] ....1..   290.366036: preempt_count_add
><-kmem_cache_free
> queue_cyclictes-5298  [000] ....2..   290.366037: preempt_count_sub
><-kmem_cache_free
> queue_cyclictes-5298  [000] ....1..   290.366039: __slab_free <-kmem_cache_free
> queue_cyclictes-5298  [000] d...1..   290.366040: preempt_count_add
><-__slab_free
> queue_cyclictes-5298  [000] d...2..   290.366041: preempt_count_sub
><-__slab_free
> queue_cyclictes-5298  [000] ....1..   290.366043: kmem_cache_free:
>call_site=c0147054 ptr=ebb93cb8

In this trace and the others you attached, you have a preempt count of
at least one. Is this a function trace? For events I recently figure out
that the counter in event tracing is recorded wrongly [0]. So my
question here is basically is this a long preempt disable section or
not.

[0] http://permalink.gmane.org/gmane.linux.kernel/2227774

Sebastian
