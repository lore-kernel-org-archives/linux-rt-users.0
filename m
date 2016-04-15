From: Clark Williams <williams@redhat.com>
Subject: Re: [RT PATCH] cputime: remove raw locks introduced by RT patchset
Date: Fri, 15 Apr 2016 08:43:52 -0500
Message-ID: <20160415084352.3dae9145@sluggy.hsv.redhat.com>
References: <20160414220943.3d4d7dd2@sluggy.hsv.redhat.com>
	<5710949E.1020407@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/wEkyG2FdFVyFAt3eZIDYDu6"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5710949E.1020407@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/wEkyG2FdFVyFAt3eZIDYDu6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Apr 2016 09:13:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Frederic's patch made it into 4.5-rc1. What I did yesterday was:
>=20
> * sched/cputime: Convert vtime_seqlock to seqcount
> * sched/cputime: Clarify vtime symbols and document them
> * Revert "vtime: Split lock and seqcount"
>=20
> which is what you want, correct?
> >=20
> > Signed-off-by: Rik van Riel <riel@redhat.com>
> > Signed-off-by: Clark Williams <williams@redhat.com> =20
>=20
> Sebastian
>=20

Yes, that's it. I just wanted to get rid of the redundant locking operation=
s and reduce the accounting overhead by a bit.=20

Thanks!
Clark

--Sig_/wEkyG2FdFVyFAt3eZIDYDu6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXEPAYAAoJEOI5asVwYXLr8UUP/jHT73EzKnqQlXo88vkDeWBJ
I7Xc/IunRIOETTz6gzogAizYIFpfOdRYm0TWsYS21B6805vOhws4HadDevWZ9JRH
unubMFwoeNqC78jpIr9v7o+hfy0NaR7Y80Z8XurXp18mtq6q+uPYYbkpQKtv1WR3
R0+BfiwbZmbsEi8ZdNxeh249rxXoCnh1+sQUfbJVpIbKHKsG39BV3QYXIADa1zdd
bsUT87ekQuqZBz298cldhUiy2+MvKSxx5CZVi9UUbr/ivO0cUMcMz1nQ4Ya+DgJ1
A81mTVNSbJaP4JVQ9+ftt+8wijqmDjuysxnpjKQeTrwIOkLUcQ9hth4/QQcci6FA
emroYzfaQvOd+BddALwtBLIkcow1T+3msknY16E56LaoYuj0AAdpcC/a1xiWW5DO
hcW+QBBjboCLgGRW3FjEYPZGV4OJFiz8XpDATyHftLzxuzuV4EW+u5JshtJh1EpO
4CaM6YwMtYtt0+rQ7TzuhOr87f26OsAQCHQWUmwqoRJYxXEUVuL9+Ne0/ozuQ9kq
0atyNc4Br+bMHBUXTCZsUdgHw7fWSpyF7yuqxPyZhE4QVK6/uXGdR1mWNQf8E0mo
XeSi0UViy7F6+svNTPnFqGZqm7OjIPx+ChhG4g9OOxbyUWPIO9TmH/logGPT42e3
p1/+eam0sbyBs4yaOMnS
=2Gjm
-----END PGP SIGNATURE-----

--Sig_/wEkyG2FdFVyFAt3eZIDYDu6--
