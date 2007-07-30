From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt 6/9] spinlock/rt_lock random cleanups
Date: Mon, 30 Jul 2007 08:48:16 -0700
Message-ID: <1185810496.2636.14.camel@imap.mvista.com>
References: <20070730024534.369897977@mvista.com>
	 <20070730024720.357083990@mvista.com>  <20070730045804.GA7124@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:11537 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759242AbXG3P6p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 11:58:45 -0400
In-Reply-To: <20070730045804.GA7124@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-30 at 10:28 +0530, Ankita Garg wrote:
> On Sun, Jul 29, 2007 at 07:45:40PM -0700, Daniel Walker wrote:
> > Signed-off-by: Daniel Walker <dwalker@mvista.com>
> > 
> > ---
> >  include/linux/rt_lock.h  |    6 ++++--
> >  include/linux/spinlock.h |    5 +++--
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > Index: linux-2.6.22/include/linux/rt_lock.h
> > ===================================================================
> > --- linux-2.6.22.orig/include/linux/rt_lock.h
> > +++ linux-2.6.22/include/linux/rt_lock.h
> > @@ -128,12 +128,14 @@ struct semaphore name = \
> >   */
> >  #define DECLARE_MUTEX_LOCKED COMPAT_DECLARE_MUTEX_LOCKED
> > 
> > -extern void fastcall __sema_init(struct semaphore *sem, int val, char *name, char *file, int line);
> > +extern void fastcall
> > +__sema_init(struct semaphore *sem, int val, char *name, char *file, int line);
> > 
> >  #define rt_sema_init(sem, val) \
> >  		__sema_init(sem, val, #sem, __FILE__, __LINE__)
> > 
> > -extern void fastcall __init_MUTEX(struct semaphore *sem, char *name, char *file, int line);
> > +extern void fastcall
> > +__init_MUTEX(struct semaphore *sem, char *name, char *file, int line);
> >  #define rt_init_MUTEX(sem) \
> >  		__init_MUTEX(sem, #sem, __FILE__, __LINE__)
> > 
> > Index: linux-2.6.22/include/linux/spinlock.h
> > ===================================================================
> > --- linux-2.6.22.orig/include/linux/spinlock.h
> > +++ linux-2.6.22/include/linux/spinlock.h
> > @@ -126,7 +126,7 @@ extern int __lockfunc generic__raw_read_
> > 
> >  #ifdef CONFIG_DEBUG_SPINLOCK
> >   extern __lockfunc void _raw_spin_lock(raw_spinlock_t *lock);
> > -#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
> > +# define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
> 
> Any reason behind including a space here?

Yes . Sometimes a space is added when a define is embedded inside
#ifdefs , example below.

#ifdef CONFIG_DEBUG_SPINLOCK
# define DEBUG_MACRO do_somedebug_here()
#endif

That's usually the method Ingo uses, and it matches the code surrounding
it in this particular patch.

Daniel
