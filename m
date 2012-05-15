From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 15 May 2012 11:42:22 -0400
Message-ID: <1337096542.14207.315.camel@gandalf.stny.rr.com>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
	 <1337094383.27694.62.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26523 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965236Ab2EOPmY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 11:42:24 -0400
In-Reply-To: <1337094383.27694.62.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-15 at 17:06 +0200, Peter Zijlstra wrote:
> On Tue, 2012-05-15 at 10:03 -0400, Steven Rostedt wrote:
> > 
> > where readers may nest (the same task may grab the same rwsem for
> > read multiple times), but only one task may hold the rwsem at any
> > given
> > time (for read or write).
> 
> Humm, that sounds iffy, rwsem isn't a recursive read lock only rwlock_t
> is.

In that case, current -rt is broken. As it has it being a recursive lock
(without my patch).

> 
> > The idea here is to have an rwsem create a rt_mutex for each CPU.
> > Actually, it creates a rwsem for each CPU that can only be acquired by
> > one task at a time. This allows for readers on separate CPUs to take
> > only the per cpu lock. When a writer needs to take a lock, it must
> > grab
> > all CPU locks before continuing. 
> 
> So you've turned it into a global/local or br or whatever that thing was
> called lock.

Yeah, basically I'm doing what that silly thing did.

> > 
> > Also, I don't use per_cpu sections for the locks, which means we have
> > cache line collisions, but a normal (mainline) rwsem has that as well.
> > 
> Why not?

Because it was hard to figure out how to do it transparently from the
rest of the kernel (with non-rt being unaffected). For now I wanted a
proof of concept. If we can figure out how to make this real per cpu,
I'm all for it. In fact, I'm wondering if that wouldn't make normal
rwsems even faster in mainline (no cacheline bouncing from readers).

I'll have to look at the br_lock thingy again and see how they did it. I
couldn't remember what lock did that, thanks for the reminder ;-)


> 
> > Thoughts?
> 
> Ideally someone would try and get rid of mmap_sem itself.. but that's a
> tough nut.

Yeah, that would be the best scenario, but we are getting complaints
about today's -rt. :-/

> 
> 
> 
> >  void  rt_down_write(struct rw_semaphore *rwsem)
> >  {
> > -       rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
> > -       rt_mutex_lock(&rwsem->lock);
> > +       int i;
> > +       initialize_rwsem(rwsem);
> > +       for_each_possible_cpu(i) {
> > +               rwsem_acquire(&rwsem->lock[i].dep_map, 0, 0,
> > _RET_IP_);
> > +               rt_mutex_lock(&rwsem->lock[i].lock);
> > +       }
> >  }
> >  EXPORT_SYMBOL(rt_down_write);
> > 
> That'll make lockdep explode.. you'll want to make the whole set a
> single lock and not treat it as nr_cpus locks.

Yeah, I thought about making it a single entity, but I was thinking the
write lock would complain or something. But looking back, I think we can
do this. Also note, I wrote this at 4am this morning as I had insomnia
and couldn't sleep. I thought of this then and decided to write it out.

Thus this is a I-can't-sleep-let-me-write-a-patch-to-piss-off-tglx
patch.

-- Steve


