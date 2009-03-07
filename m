From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 2.6.29-rc6-rt3 crash on PXA270
Date: Sat, 7 Mar 2009 07:58:31 +0100
Message-ID: <20090307065831.GA13816@pengutronix.de>
References: <f96d234e0903061433t3a3c5817oc47a064474917b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41110 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZCGG6e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Mar 2009 01:58:34 -0500
Content-Disposition: inline
In-Reply-To: <f96d234e0903061433t3a3c5817oc47a064474917b53@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 06, 2009 at 05:33:57PM -0500, Cliff Brake wrote:
> Hello,
>=20
> I'm using running code from the following source:
>=20
>    git://git.pengutronix.de/git/ukl/linux-2.6.git rt-master
>=20
> and getting the below trace on a PXA270.
>=20
> Is 2.6.29-rc6-rt3 stable on ARM?  Should this work?  Any suggestions
> for debugging?
Up to now it only compiles. =20
>=20
> It seems this fault occurred while udevd was loading, so it might be =
a
> driver issue.
>=20
> Thanks,
> Cliff
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Cliff Brake
> http://bec-systems.com
>=20
> INIT: version 2.86 booting
> Starting udevudevd[514]: lookup_group: specified group 'scanner' unkn=
own
>=20
> udevd[514]: lookup_group: specified group 'scanner' unknown
>=20
> udevd[514]: lookup_group: specified group 'scanner' unknown
>=20
> udevd[514]: lookup_group: specified group 'scanner' unknown
>=20
> udevd[514]: lookup_group: specified group 'nvram' unknown
>=20
> udevd[514]: lookup_user: specudevd version 124 started
> ified user 'tss' unknown
>=20
> udevd[514]: lookup_group: specified group 'tss' unknown
>=20
> udevd[514]: lookup_group: specified group 'fuse' unknown
>=20
> udevd[514]: lookup_group: specified group 'kvm' unknown
>=20
> udevd[514]: lookup_group: specified group 'rdma' unknown
>=20
> udevd[514]: lookup_group: specified group 'rdma' unknown
>=20
> udevd[514]: lookup_group: specified group 'rdma' unknown
This is not the kernel's fault.  I assume you know how to fix it :-)

> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
This is triggered by BUG().

> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 817 [#1] PREEMPT
> Modules linked in:
> CPU: 0    Not tainted  (2.6.29-rc6-rt3 #185)
> PC is at exit_mmap+0x1a4/0x1bc
> LR is at rt_spin_lock_slowunlock+0x50/0xa8
> pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
> sp : c3943ee8  ip : c3943e78  fp : c3943f14
> r10: 0001c168  r9 : 00000001  r8 : c0027024
> r7 : c2ec6200  r6 : 00000000  r5 : 00000000  r4 : c2ec6040
> BUG: scheduling while atomic: mount.sh/0x00000001/553, CPU#0
If I read it correctly it's just a sleeping lock taken after a
rt_spinlock.  That is the type of some locks needs fixing.

Best regards,

Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
