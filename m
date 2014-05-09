From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Fri, 09 May 2014 16:18:00 +0200
Message-ID: <1399645080.31219.14.camel@marge.simpson.net>
References: <20140503170110.GA10652@linutronix.de>
	 <1399449247.5142.14.camel@marge.simpson.net>
	 <20140507094807.229d88d8@gandalf.local.home>
	 <1399471264.5248.5.camel@marge.simpson.net>
	 <1399472415.5248.15.camel@marge.simpson.net>
	 <20140509132713.GH29014@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45568 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbaEIOSE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 10:18:04 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so2731706eei.19
        for <linux-rt-users@vger.kernel.org>; Fri, 09 May 2014 07:18:02 -0700 (PDT)
In-Reply-To: <20140509132713.GH29014@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2014-05-09 at 15:27 +0200, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2014-05-07 16:20:15 [+0200]:
> 
> >> > This looks like it reverse applies?
> >> Nope, I thought Thomas's whacked the one he did on purpose.  
> >I should learn to speak lockdep.  How about this instead?
> >
> >locking/rt: fix rt_read_trylock() lockdep annotation.
> >
> >rt-rw-lockdep-annotations.patch dropped a rwlock_acquire_read
> >
> >Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> >---
> > kernel/locking/rt.c |    3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >--- a/kernel/locking/rt.c
> >+++ b/kernel/locking/rt.c
> >@@ -217,7 +217,7 @@ int __lockfunc rt_read_trylock(rwlock_t
> > 		migrate_disable();
> > 		ret = rt_mutex_trylock(lock);
> > 		if (ret)
> >-			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
> >+			rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
> 
> Think we should drop rwlock_acquire_read() and use rwlock_acquire()
> instead (like the previous patch) because on -RT there is no difference
> between a read and a write lock. Or is there more to it?

No, I had done the right thing in the first patch, as confirmed by what
landed in 12-rt.  The lock ain't "shared" is why I whacked it.  You saw
what happened to my confidence in that logic when Steven spoke.  Eek :)

-Mike

