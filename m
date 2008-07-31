From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] powerpc - Initialize the irq radix tree earlier
Date: Thu, 31 Jul 2008 15:26:06 +0200
Message-ID: <20080731152606.5ae7c379@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
	<1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
	<1217504456.9817.22.camel@localhost>
	<20080731140002.31bbe4a0@bull.net>
	<1217509104.19050.11.camel@localhost>
	<1217509299.19050.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, benh@kernel.crashing.org,
	paulus@samba.org, jean-pierre.dion@bull.net,
	gilles.carry@ext.bull.net, tinytim@us.ibm.com, tglx@linutronix.de,
	rostedt@goodmis.org
To: michael@ellerman.id.au
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51244 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYGaNZg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 09:25:36 -0400
In-Reply-To: <1217509299.19050.15.camel@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 31 Jul 2008 23:01:39 +1000 Michael Ellerman <michael@ellerman.i=
d.au> wrote:

> On Thu, 2008-07-31 at 22:58 +1000, Michael Ellerman wrote:
> > On Thu, 2008-07-31 at 14:00 +0200, Sebastien Dugue wrote:
> > > On Thu, 31 Jul 2008 21:40:56 +1000 Michael Ellerman <michael@elle=
rman.id.au> wrote:
> > > >=20
> > > > This boot ordering stuff is pretty hairy, so I might have misse=
d
> > > > something, but this is how the code is ordered AFAICT:
> > > > =EF=BB=BF
> > > > start_kernel()
> > > > 	init_IRQ()
> > > > 	...
> > > > 	local_irq_enable()
> > > > 	...
> > > > 	rest_init()
> > > > 		kernel_thread()
> > > > 			kernel_init()
> > > > 				smp_prepare_cpus()
> > > > 					smp_xics_probe()	(via smp_ops->probe())
> > > >=20
> > > >=20
> > > > What's stopping us from taking an irq between local_irq_enable(=
) and
> > > > smp_xics_probe() ?  Is it just that no one's request_irq()'ed t=
hem yet?
> > >=20
> > >   It's hairy, I agree, but as you've mentioned no one has done a =
request_irq()
> > > at that point. The first one to do it is smp_xics_probe() for the=
 IPI.
> >=20
> > Hmm, I don't think that's strong enough. I can trivially cause irqs=
 to
> > fire during a kexec reboot just by mashing the keyboard.
> >=20
> > And during a kdump boot all sorts of stuff could be firing. Even du=
ring
> > a clean boot, from firmware, I don't think we can guarantee that
> > nothing's going to fire.
> >=20
> > .. after a bit of testing ..
> >=20
> > It seems it actually works (sort of).=20
> >=20
> > xics_remap_irq() calls irq_radix_revmap_lookup(), which calls:
> >=20
> > ptr =3D radix_tree_lookup(&host->revmap_data.tree, hwirq);
> >=20
> > And because =EF=BB=BFhost->revmap_data.tree was zalloc'ed we trip o=
n the first
> > check here:
>=20
> @#$% ctrl-enter =3D=3D send!
>=20
> Continuing ...
>=20
> void *radix_tree_lookup(struct radix_tree_root *root, unsigned long i=
ndex)
> {
>         unsigned int height, shift;
>         struct radix_tree_node *node, **slot;
>=20
>         node =3D rcu_dereference(root->rnode);
>         if (node =3D=3D NULL)
>                 return NULL;
>=20
> Which means =EF=BB=BFirq_radix_revmap_lookup() will return NO_IRQ, wh=
ich is cool.

  Which is what I intended so that as long as no IRQ is registered we
return NO_IRQ.

>=20
>=20
> So I think it can fly, as long as we're happy that we can't reverse m=
ap
> anything until smp_xics_probe() - and I think that's true, as any irq=
 we
> take will be invalid.

  That's true as no IRQs are registered before smp_xics_probe() and for=
 any
interrupt we might get before that, irq_radix_revmap_lookup() will retu=
rn
NO_IRQ.

  Thanks,

  Sebastien.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
