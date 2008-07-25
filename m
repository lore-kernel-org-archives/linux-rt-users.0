From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
 tree lockless
Date: Fri, 25 Jul 2008 10:34:18 +0200
Message-ID: <20080725103418.2ae898f5@bull.net>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
	<20080724141839.477de30b@bull.net>
	<1216972177.7257.351.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Tim Chavez <tinytim@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41406 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYGYIdt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jul 2008 04:33:49 -0400
In-Reply-To: <1216972177.7257.351.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  Hi Peter,

On Fri, 25 Jul 2008 09:49:37 +0200 Peter Zijlstra <peterz@infradead.org=
> wrote:

> On Thu, 2008-07-24 at 14:18 +0200, Sebastien Dugue wrote:
> > On Thu, 24 Jul 2008 21:11:34 +1000 Nick Piggin <nickpiggin@yahoo.co=
m.au> wrote:
> >=20
> > > On Thursday 24 July 2008 20:50, Sebastien Dugue wrote:
> > > > From: Sebastien Dugue <sebastien.dugue@bull.net>
> > > > Date: Tue, 22 Jul 2008 11:56:41 +0200
> > > > Subject: [PATCH][RT] powerpc - Make the irq reverse mapping rad=
ix tree
> > > > lockless
> > > >
> > > >   The radix tree used by interrupt controllers for their irq re=
verse
> > > > mapping (currently only the XICS found on pSeries) have a compl=
ex locking
> > > > scheme dating back to before the advent of the concurrent radix=
 tree on
> > > > preempt-rt.
> > > >
> > > >   Take advantage of this and of the fact that the items of the =
tree are
> > > > pointers to a static array (irq_map) elements which can never g=
o under us
> > > > to simplify the locking.
> > > >
> > > >   Concurrency between readers and writers are handled by the in=
trinsic
> > > > properties of the concurrent radix tree. Concurrency between th=
e tree
> > > > initialization which is done asynchronously with readers and wr=
iters access
> > > > is handled via an atomic variable (revmap_trees_allocated) set =
when the
> > > > tree has been initialized and checked before any reader or writ=
er access
> > > > just like we used to check for tree.gfp_mask !=3D 0 before.
> > >=20
> > > Hmm, RCU radix tree is in mainline too for quite a while. I thoug=
ht
> > > Ben had already converted this code over ages ago...
> >=20
> >   Mainline does not have the concurrent radix tree which this patch
> > is based on, but maybe it's overkill and the RCU radix tree is enou=
gh.
> > Not sure, will have to think about it a bit more.
>=20
> Should be. The model of the concurrent radix tree can be mapped to
> spinlock + rcu radix tree.
>=20
> So instead of:
>=20
> > =EF=BB=BF+               DEFINE_RADIX_TREE_CONTEXT(ctx, tree);
> > +               radix_tree_lock(&ctx);
> > +               radix_tree_insert(ctx.tree, hwirq, &irq_map[virq]);
> > +               radix_tree_unlock(&ctx);
>=20
>=20
> you then write:
>=20
> 	spin_lock(&host->revmap_data.tree_lock);
> 	radix_tree_insert(&host->revmap_data.tree, hwirq, &irq_map[virq]);
> 	spin_unlock(&host->revmap_data.tree_lock);
>=20

  Cool, that will indeed makes it much easier to have something applica=
ble
to mainline which works with preempt-rt.

>=20
> The only advantage of the concurrent radix tree over this model is th=
at
> it can potentially do multiple modification operations at the same ti=
me.

  Well in theory that can happen if a module is loaded which creates a =
mapping
while another one is unloaded at the same time. The time window is pret=
ty narrow,
but still present nonetheless. That's why I chose to use the concurrent=
 version.

>=20
> Still, cool that you used it ;-)


  Yep, looked like what was needed until I realized it was not availabl=
e in
mainline. Nice work though and good paper for explaining it all.

  Sebastien.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
