From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 1/2] remove recursive call to migrate_disable in
	read_lock_bh
Date: Fri, 22 Nov 2013 00:58:46 +0100
Message-ID: <20131121235846.GB11774@opentech.at>
References: <20131120102107.GA12022@opentech.at> <20131121102213.GA10022@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:57775 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab3KUX6w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Nov 2013 18:58:52 -0500
Content-Disposition: inline
In-Reply-To: <20131121102213.GA10022@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 21 Nov 2013, Peter Zijlstra wrote:

> On Wed, Nov 20, 2013 at 11:21:07AM +0100, Nicholas Mc Guire wrote:
> > From 46393dc3185026c8500c2b734747d7c8785f3dc9 Mon Sep 17 00:00:00 2001
> > From: Nicholas Mc Guire <der.herr@hofr.at>
> > Date: Tue, 19 Nov 2013 23:31:05 -0500
> > Subject: [PATCH 1/2] remove recursive call to migrate_disable in read_lock_bh
> > 
> >  read_lock_bh/read_unlock_bh unconditionally calls local_bh_disable/enable 
> >  which already does a migrate_disable/enable - no need for this recursive call.
> > 
> >  patch is on top of 3.12-rt2
> > 
> >  No change of functionality
> > 
> > Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> > ---
> >  include/linux/rwlock_rt.h |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
> > index 853ee36..87f5a1d 100644
> > --- a/include/linux/rwlock_rt.h
> > +++ b/include/linux/rwlock_rt.h
> > @@ -53,7 +53,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
> >  #define read_lock_bh(lock)				\
> >  	do {						\
> >  		local_bh_disable();			\
> > -		migrate_disable();			\
> >  		rt_read_lock(lock);			\
> >  	} while (0)
> >  
> > @@ -83,7 +82,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
> >  #define read_unlock_bh(lock)				\
> >  	do {						\
> >  		rt_read_unlock(lock);			\
> > -		migrate_enable();			\
> >  		local_bh_enable();			\
> >  	} while (0)
> 
> So the problem with this patch and the next is that:
> 
> 	read_lock_bh();
> 
> 	read_unlock();
> 	local_bh_enable();
> 
> Is a valid pattern; and you'll notice that the release part has 2
> migrate put refs. So if you can make a patch similar to:
> 
> lkml.kernel.org/r/20131120162736.624493595@infradead.org
> 
> That allows read_lock_bh() to obtain 2 migrate disable refs in one go,
> then it would all work out just fine.

yup thats what was causing the oops - fixed by the patch below
with this my two boxes here survived cyclictest over night
showing the same results as without the recursive calls to
migrate_disable/enable removed.


>From 2c8e669b691b825c0ed2a02bd7a698d8ed5c6d29 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Thu, 21 Nov 2013 18:22:55 -0500
Subject: [PATCH] rebalance locks by converting write_lock_bh to write_lock+local_bh_disable
 
 This patch just rebalances the lock api

 in __neigh_event_send write_lock_bh(&neigh->lock) is implicitly balanced by
 write_unlock(&neigh->lock)+local_bh_disable() - while this is equivalent with
 respect to the effective low level locking primitives it breaks balancing
 in the locking api. This makes automatic lock-checking trigger false 
 positives, creates an implicit dependency between *_lock_bh and *_lock 
 functions as well as making the extremly simply locking of net core even
 easier to understand.

 No change of functionality

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 net/core/neighbour.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ca15f32..d681c75 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -966,7 +966,8 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb)
 	int rc;
 	bool immediate_probe = false;
 
-	write_lock_bh(&neigh->lock);
+	local_bh_disable();
+	write_lock(&neigh->lock);
 
 	rc = 0;
 	if (neigh->nud_state & (NUD_CONNECTED | NUD_DELAY | NUD_PROBE))
-- 
1.7.2.5

