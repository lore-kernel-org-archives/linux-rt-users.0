From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH -rt] kvm: lockdep annotate mmu_lock wait_lock
Date: Wed, 19 Jul 2017 15:31:29 -0500
Message-ID: <20170719203129.GA26784@jcartwri.amer.corp.natinst.com>
References: <20170718120347.GA25342@amt.cnet>
 <20170718121606.dvkwlnxiflrdmsn3@hirez.programming.kicks-ass.net>
 <20170718122238.GA5356@amt.cnet>
 <20170718124504.fzo4mqakvsfu624t@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
        <linux-rt-users@vger.kernel.org>, <kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:56540 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755185AbdGSUcD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jul 2017 16:32:03 -0400
Content-Disposition: inline
In-Reply-To: <20170718124504.fzo4mqakvsfu624t@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 02:45:04PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 18, 2017 at 09:22:38AM -0300, Marcelo Tosatti wrote:
> > > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > > index 7e80f62..6375db8 100644
> > > > --- a/virt/kvm/kvm_main.c
> > > > +++ b/virt/kvm/kvm_main.c
> > > > @@ -613,6 +613,8 @@ static struct kvm *kvm_create_vm(unsigned long =
type)
> > > >  		return ERR_PTR(-ENOMEM);
> > > > =20
> > > >  	spin_lock_init(&kvm->mmu_lock);
> > > > +
> > > > +	lockdep_set_novalidate_class(&kvm->mmu_lock.lock.wait_lock);
> > > >  	mmgrab(current->mm);
> > > >  	kvm->mm =3D current->mm;
> > > >  	kvm_eventfd_init(kvm);
> > >=20
> > > This doesn't make sense... It looks like a spin_lock_init() is missin=
g,
> > > at which point it'll try and use the lock address itself and then bai=
ls
> > > because that is in dynamic memory.
> >=20
> > Do you see the spin_lock_init just above, after "return
> > PTR_ERR(-ENOMEM)"... That should take care of wait_lock i suppose.
>=20
> D'0h... so much for being 'awake'..
>=20
> > "struct kvm" (which contains the mmu_lock spinlock) is allocated with
> > kmalloc, can LOCKDEP handle spinlocks in kmalloc'ed memory?
>=20
> Yep, what _should_ happen is that we use a macro like:
>=20
> (I don't have an -RT tree handy atm)
>=20
> # define raw_spin_lock_init(lock)                               \
> do {                                                            \
>         static struct lock_class_key __key;                     \
>                                                                 \
>         __raw_spin_lock_init((lock), #lock, &__key);            \
> } while (0)
>=20
> Which defines a key per callsite. So while the lock itself is in dynamic
> memory, the key will be static.

One other interesting observation: the dump_stack() comes from the
acquire path, not from the _init() path, even though the _init() path
itself includes a check to ensure that the lock_class_key points to
static data. (__raw_spin_lock_init -> lockdep_init_map -> if (!static_obj(k=
ey)) BUG)

So, that would lead me to believe that if we got this far, at some point
lock->key _was_ pointing to static data, but now is not?

   Julia

Caveat: I'm looking at v3.10.53-rt56; I guessed it was the closest
public stable tag to the undecipherable RHEL version.

>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAllvwZ4ACgkQjNrC4UVN
dG/UaAgAqJ1dMsbCGrNvHM7hj+1dzDLFJmXPwQtPTXExoxjTRd2J3/2TM4qSaeB/
RqJEG4vyzbfkSp6IzVyAmFwX2+jECcMgun7Ud/TVuNamOE1eqy/5vhf04tfv/daY
GWpAE9COI6mOQiDize2c6+1kS6dfpyrZX6RCeayO1KHQwjNVTGne3hLIKq22XVSV
8vy8Gr6/k4HQqGiXs92kqKIudj1s9J+WsYLPEb4z/dw/Z7fP1yX9Nsn2RpHtoBlI
onGtDbflfvPN4YtgZfxE9YqTQZt++R00szXFn9NXeCWJmk/eZzo5KKdqWpcg7Rq5
dVNn1BbR81iJQxVFosmiBB4sztaSFg==
=WNJw
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
