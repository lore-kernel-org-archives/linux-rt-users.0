From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Sat, 3 May 2014 14:31:46 +0200
Message-ID: <20140503123146.GB15945@opentech.at>
References: <1399029159.5233.124.camel@marge.simpson.net> <5363840B.6020402@pavlinux.ru> <1399031023.5233.145.camel@marge.simpson.net> <20140503083257.GA16242@opentech.at> <1399113657.5326.58.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pavel@pavlinux.ru, RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:38604 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbaECMbr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2014 08:31:47 -0400
Content-Disposition: inline
In-Reply-To: <1399113657.5326.58.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 03 May 2014, Mike Galbraith wrote:

> On Sat, 2014-05-03 at 10:32 +0200, Nicholas Mc Guire wrote: 
> > On Fri, 02 May 2014, Mike Galbraith wrote:
> > 
> > > On Fri, 2014-05-02 at 15:39 +0400, Pavel Vasilyev wrote: 
> > > > 02.05.2014 15:12, Mike Galbraith ??????????:
> > > > > The following patches are fixes that fell out of testing rt1.  Patches
> > > > > 1-4 are intended to be folded into existing patches, 5-6 are
> > > > > replacements.
> > > > >
> > > > > fold:
> > > > > 1/6 - preempt-lazy-support.patch
> > > > > 2/6 - x86-preempt-lazy.patch
> > > > > 3/6 - hotplug-light-get-online-cpus.patch
> > > > > 4/6 - stomp-machine-raw-lock.patch
> > > > >
> > > > > replace:
> > > > > 5/6 - (prep)
> > > > > 6/6 - stomp-machine-deal-clever-with-stopper-lock.patch
> > > > >
> > > > > drop: (buggy - calls migrate_disable() _after_ maybe blocking)
> > > > > migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch
> > > > 
> > > > 
> > Why would calling migrate_disable be buggy after blocking ?
> > at that point any per cpu data is not yet being accessed so its perfectly fine
> > to
> > 
> >   lock->block
> >    -> migrate 
> >     -> unblock->lock 
> >      -> migrate_disable on a new CPU
> >       -> access per_cpu object
> >      -> migrate_enable
> >   -> unlock
> > 
> > what problems would there be ?
> 
> You tell me.   Why do we bother at all if it's ok to migrate with a lock
> in your pocket, or the CPU can go away on you while you're acquiring?

The lock in your pocket is not the issue (unless its a per_cpu lock in which
case we are pinned already anyway) and the cpu can go away with a global
lock held in my opinion - why not ? 

> If this is in fact safe, you should be able to move each and every
> migrate_disable() to post acquisition.

yup

> I have a virtual nickle that
> says your box will have a severe allergic reaction to such a patch.
>
Actually that is what the pushdowns in the read_lock/write_lock api did and
I did not notice any of the systems having problems with that.

Not saying that there is no case in the pushdown that is wrongly 
handled but before looking at that lets clarify if the assumptions 
made for the migrate pushdowns was right in the first place.

migrate_disable() provides referencial consistency on per_cpu objects so that
preemption is safe with a per_cpu ref held - nothing else.

So:
 if the lock is global then it is safe to migrate while blocked on a lock as
  the referencial consistency of the lock is not affected the reference to
  a protected per_cpu object not yet set (if it were that is a bug if the
  method used to access the per_cpu objects ref did not migrate_disable 
  already).
 if it is a per-cpu lock then migrate_disable() would need to be called before
  accessing the lock object any way and the problem is not related to
  blocking on a lock - the get_ primitives would have disable migration before
  you got access to the lock object and thus you are safe.

Regarding the CPU going away while blocked on a lock we have:
 if the lock is global then the CPU going away would push you off first without
   that the reference to the lock object is invalidated - so that is safe.
 if the lock is per_cpu then the get_cpu_var or what ever you use to get that
   per_cpu lock object would have disable migration BEFORE you got access to
   the per_cpu lock object, so once you have access to the per_cpu lock you
   would again be safe against the cpu going away as well via pin_current_cpu

>From my understanding for a globally visible lock:

            per_cpu
 lock pin   access   unpin unlock
 pin lock   access   unlock unpin

are semantically equivalent and safe
even
            per_cpu
 lock pin   access   unlock unpin
 pin lock   access   unpin unlock

is safe (while strange) - in no constelation would you lose
referencial consistency of the per_cpu object within the crticial
section (access).

If code relies on these two (semantically orthogonal functions) to be
in a particuular order I would suspect that the code has a bug.

If one now looks at the cases of
            per_cpu
 lock pin   access   ...

and assume that you got migrated away while aquireing the lock,
or actually simply before you got temporarily pinned to the cpu,
then this is safe for global locks - if the CPU went away and
we got pushed to another CPU then the per_cpu object access
is on the cpu we got pushed to but stays consistent and safe.

for a per_cpu lock the pin/unpin is implied in access to the per_cpu 
lock object it self so the migrate_disable done in the locking api is 
not needed but no harme either and the position of the same (before or 
after aquisition of the lock) is irrelevant.

So what case did I miss ?

thx!
hofrat
