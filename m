From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Fri, 9 May 2014 15:27:13 +0200
Message-ID: <20140509132713.GH29014@linutronix.de>
References: <20140503170110.GA10652@linutronix.de>
 <1399449247.5142.14.camel@marge.simpson.net>
 <20140507094807.229d88d8@gandalf.local.home>
 <1399471264.5248.5.camel@marge.simpson.net>
 <1399472415.5248.15.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35956 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaEIN1Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 09:27:16 -0400
Content-Disposition: inline
In-Reply-To: <1399472415.5248.15.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-05-07 16:20:15 [+0200]:

>> > This looks like it reverse applies?
>> Nope, I thought Thomas's whacked the one he did on purpose.  
>I should learn to speak lockdep.  How about this instead?
>
>locking/rt: fix rt_read_trylock() lockdep annotation.
>
>rt-rw-lockdep-annotations.patch dropped a rwlock_acquire_read
>
>Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
>---
> kernel/locking/rt.c |    3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>--- a/kernel/locking/rt.c
>+++ b/kernel/locking/rt.c
>@@ -217,7 +217,7 @@ int __lockfunc rt_read_trylock(rwlock_t
> 		migrate_disable();
> 		ret = rt_mutex_trylock(lock);
> 		if (ret)
>-			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
>+			rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);

Think we should drop rwlock_acquire_read() and use rwlock_acquire()
instead (like the previous patch) because on -RT there is no difference
between a read and a write lock. Or is there more to it?

> 		else
> 			migrate_enable();
> 

Sebastian
