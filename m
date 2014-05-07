From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Wed, 07 May 2014 16:01:04 +0200
Message-ID: <1399471264.5248.5.camel@marge.simpson.net>
References: <20140503170110.GA10652@linutronix.de>
	 <1399449247.5142.14.camel@marge.simpson.net>
	 <20140507094807.229d88d8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:42505 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbaEGOBI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 10:01:08 -0400
Received: by mail-ee0-f52.google.com with SMTP id e53so785460eek.39
        for <linux-rt-users@vger.kernel.org>; Wed, 07 May 2014 07:01:07 -0700 (PDT)
In-Reply-To: <20140507094807.229d88d8@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2014-05-07 at 09:48 -0400, Steven Rostedt wrote: 
> On Wed, 07 May 2014 09:54:07 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> 
> > 
> > rt-rw-lockdep-annotations.patch missed an rwlock_acquire_read()
> > 
> > Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> > ---
> >  kernel/locking/rt.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- a/kernel/locking/rt.c
> > +++ b/kernel/locking/rt.c
> > @@ -244,13 +244,12 @@ void __lockfunc rt_read_lock(rwlock_t *r
> >  {
> >  	struct rt_mutex *lock = &rwlock->lock;
> >  
> > -
> >  	/*
> >  	 * recursive read locks succeed when current owns the lock
> >  	 */
> >  	if (rt_mutex_owner(lock) != current) {
> >  		migrate_disable();
> > -		rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
> > +		rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
> >  		__rt_spin_lock(lock);
> 
> This looks like it reverse applies?


Nope, I thought Thomas's whacked the one he did on purpose.  

-Mike

