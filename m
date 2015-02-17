From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT]  rt: add rwsem_is_contended() definition to
 rwsem_rt.h
Date: Tue, 17 Feb 2015 13:08:57 -0600
Message-ID: <20150217130857.24e233ea@sluggy>
References: <20140827160928.6f323642@sluggy>
	<20150217100911.GG26177@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Ucr2bKFykdCmvlboJvk9Lrm"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217100911.GG26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/Ucr2bKFykdCmvlboJvk9Lrm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Feb 2015 11:09:11 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Clark Williams | 2014-08-27 16:09:28 [-0500]:
>=20
> >Thomas,
> >
> >The latest btrfs code uses rwsem_is_contended() in the function
> >caching_thread(). On RT systems, include/linux/rwsem.h is replaced with
> >include/linux/rwsem_rt.h which does not provide a definition for
> >rwsem_is_contended().  This commit provides a definition that should
> >work on RT (where the lock is actually an rt_mutex).
>=20
> I see that I added rwsem_is_contended() in v3.14-rt1 which does:
> |static inline int rwsem_is_contended(struct rw_semaphore *sem)
> |{
> |      /* rt_mutex_has_waiters() */
> |      return !RB_EMPTY_ROOT(&sem->lock.waiters);
> |}
>=20
> Do you lack this in kernel prior to v3.14?
>=20
> Sebastian

Yes, that was the problem. I was back-porting to a 3.10 and was missing
the definition. Sorry for the noise.

Clark

--Sig_/Ucr2bKFykdCmvlboJvk9Lrm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU45HNAAoJEEersVlSw9Nzp5gQAJgeaxEmza6O7aSyoNDqgwrV
dUd2Er3NdeERY+kfuf3NbDZrYT2u3wzSjT3alitHReyLtP1qIMzNQ6iCYTQIvka+
OL42SHFJR+Nc4+xV9QhxbqAWtTfK6YLMCwZdqwrOmYMWzorJCGnvD+KDgjiZuULe
wbBD599DteGhbouPL2trloPZL2P1Ap+mPar/dGfKQszNLhoVqMFf6b+ye5OQXFKA
IqlX5maEYX3FyLobaXySiLKiQnC8iXsbPP5amVuNy9VzmEZ/M0aEETla4nM8NAT8
opB6l9EIJVbUHkFCwLRt0kXED9VtlO+y5kqly/ZBlQPY++bUUwigF+9LmgQkLKkO
AdJDNqTquI4yLS67dEWh/WqR6JsfxJ7NcSfJP0xLh6I90oKKwWfo2wSoFPuO0a+s
XPDU+geUx20KBKNzALxfPV24T62Lk7gdi1QFNKMEKelk5AxVUIG4/gQgPWEC9FOH
Ekp8w5Ismhc2nqfBABvxkq0gzt9LSNCrWzj45cpQVgmMDKJeFQZJMg9Lz+AUZXaH
zKbv9iLaVfn2T+HHV+p+ieeqiKXGOMeknQb05S08OaVe+ZgbZDl1dedEHOt5V6ij
+ImCN5eYH/fPvelb8+JKW2XSA2c2/z96HRyfPRxX3pYVl4/2ri2BjdQXvKSqjZHG
e/iv/wWF3wa0iRRttLcG
=Z6KZ
-----END PGP SIGNATURE-----

--Sig_/Ucr2bKFykdCmvlboJvk9Lrm--
