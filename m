From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
Date: Fri, 25 Jul 2008 15:13:39 +1000
Message-ID: <1216962819.11188.82.camel@pasglop>
References: <20080724122352.3bc76bda@bull.net>
	 <20080724125044.53b604cb@bull.net>
	 <200807242111.35338.nickpiggin@yahoo.com.au>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sebastien Dugue <sebastien.dugue@bull.net>,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60679 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbYGYFOo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jul 2008 01:14:44 -0400
In-Reply-To: <200807242111.35338.nickpiggin@yahoo.com.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> >   Concurrency between readers and writers are handled by the intrinsic
> > properties of the concurrent radix tree. Concurrency between the tree
> > initialization which is done asynchronously with readers and writers access
> > is handled via an atomic variable (revmap_trees_allocated) set when the
> > tree has been initialized and checked before any reader or writer access
> > just like we used to check for tree.gfp_mask != 0 before.
> 
> Hmm, RCU radix tree is in mainline too for quite a while. I thought
> Ben had already converted this code over ages ago...
> 
> Nothing against the -rt patch, but mainline should probably be updated
> to use RCU as well?

No, I haven't updated that code yet, and yes, we should do it :-)

Cheers,
Ben.


