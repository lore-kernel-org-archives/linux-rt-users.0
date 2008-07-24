From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
 tree lockless
Date: Thu, 24 Jul 2008 14:18:39 +0200
Message-ID: <20080724141839.477de30b@bull.net>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35283 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYGXMSN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jul 2008 08:18:13 -0400
In-Reply-To: <200807242111.35338.nickpiggin@yahoo.com.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 24 Jul 2008 21:11:34 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> On Thursday 24 July 2008 20:50, Sebastien Dugue wrote:
> > From: Sebastien Dugue <sebastien.dugue@bull.net>
> > Date: Tue, 22 Jul 2008 11:56:41 +0200
> > Subject: [PATCH][RT] powerpc - Make the irq reverse mapping radix tree
> > lockless
> >
> >   The radix tree used by interrupt controllers for their irq reverse
> > mapping (currently only the XICS found on pSeries) have a complex locking
> > scheme dating back to before the advent of the concurrent radix tree on
> > preempt-rt.
> >
> >   Take advantage of this and of the fact that the items of the tree are
> > pointers to a static array (irq_map) elements which can never go under us
> > to simplify the locking.
> >
> >   Concurrency between readers and writers are handled by the intrinsic
> > properties of the concurrent radix tree. Concurrency between the tree
> > initialization which is done asynchronously with readers and writers access
> > is handled via an atomic variable (revmap_trees_allocated) set when the
> > tree has been initialized and checked before any reader or writer access
> > just like we used to check for tree.gfp_mask != 0 before.
> 
> Hmm, RCU radix tree is in mainline too for quite a while. I thought
> Ben had already converted this code over ages ago...

  Mainline does not have the concurrent radix tree which this patch
is based on, but maybe it's overkill and the RCU radix tree is enough.
Not sure, will have to think about it a bit more.

> 
> Nothing against the -rt patch, but mainline should probably be updated
> to use RCU as well?
> 

  If rcu radix tree is enough, then definitely yes.

  Sebastien.

