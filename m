From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Tue, 29 Nov 2011 21:36:53 -0500
Message-ID: <1322620613.17003.110.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:35059 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab1K3Cgz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Nov 2011 21:36:55 -0500
In-Reply-To: <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-11-29 at 15:31 +0100, John Kacur wrote:
> On Mon, 28 Nov 2011, John Kacur wrote:

> > Hmm, I think I see how this can happen.
> > 
> > cache_flusharray()
> > spin_lock(&l3->list_lock);
> > free_block(cachep, ac->entry, batchcount, node);
> >         slab_destroy()
> >         kmem_cache_free()
> >                 __cache_free()
> >                 cache_flusharray()
> > 
> 
> Could you try the following patch to see if it gets rid of your lockdep 
> splat? (plan to neaten it up and send it to lkml if it works for you.)
> 
> >From 29bf37fc62098bc87960e78f365083d9f52cf36a Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Tue, 29 Nov 2011 15:17:54 +0100
> Subject: [PATCH] Drop lock in free_block before calling slab_destroy to prevent lockdep splats
> 
> This prevents lockdep splats due to this call chain
> cache_flusharray()
> spin_lock(&l3->list_lock);
> free_block(cachep, ac->entry, batchcount, node);
>        slab_destroy()
>        kmem_cache_free()
>                __cache_free()
>                cache_flusharray()

John,

No, this is a false positive, and the code is correct, lockdep just
needs to be tweaked. If this was a real bug, then it would have locked
up here and not have continued, as spinlocks are not recursive.

This was complained about in mainline too:

  https://lkml.org/lkml/2011/10/3/364

There was a fix to a similar bug that Peter pointed out, but this bug
doesn't look like it was fixed.

Peter?

-- Steve


> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  mm/slab.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index b615658..635e16a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3667,7 +3667,9 @@ static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
>  				 * a different cache, refer to comments before
>  				 * alloc_slabmgmt.
>  				 */
> +				spin_unlock(&l3->list_lock);
>  				slab_destroy(cachep, slabp, true);
> +				spin_lock(&l3->list_lock);
>  			} else {
>  				list_add(&slabp->list, &l3->slabs_free);
>  			}


