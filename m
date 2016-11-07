From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 12:39:31 -0600
Message-ID: <20161107123931.2ddccc4d@tagon>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <20161107122221.299d026a@tagon>
        <20161107133046.7e4458c1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/J4Y6mqUDHSkBtz9hfHA/JqQ"; protocol="application/pgp-signature"
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107133046.7e4458c1@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/J4Y6mqUDHSkBtz9hfHA/JqQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Nov 2016 13:30:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 7 Nov 2016 12:22:21 -0600
> Clark Williams <williams@redhat.com> wrote:
>=20
> > I'm still reviewing the patch, but I have to wonder why bother with mak=
ing it a scheduler feature?
> >=20
> > The SCHED_FIFO definition allows a fifo thread to starve others
> > because a fifo task will run until it yields. Throttling was added as
> > a safety valve to allow starved SCHED_OTHER tasks to get some cpu
> > time.  Adding this unconditionally gets us a safety valve for
> > throttling a badly written fifo task, but allows the fifo task to
> > continue to consume cpu cycles if it's not starving anyone.=20
> >=20
> > Or am I missing something that's blazingly obvious? =20
>=20
> Or I say make it the default. If people want the old behavior, they can
> modify SCHED_FEATURES to do so.
>=20

Ok, I can see wanting the previous behavior.=20

Clark

--Sig_/J4Y6mqUDHSkBtz9hfHA/JqQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYIMpjAAoJEOI5asVwYXLr/lwQAI4CfDz8KmtY76rEytEyrVvr
0RcTGxYuyqZfTXq+PkFNWo50JIPL1EMvvxl60G12RfGLep8zJk2YU0jv24/XwguG
EZKN2xbXveQbOUvb3cVVGQBVggxExXLA2DzNZjx2sTZk1c/yLJXNfLiM6oUavQrj
wSBXpQOAf6wS1hIfabFLwsTJXjAco2gLEQok/ZFTcywhfrSxAUUcYSds2HYdBZJe
JXDIWLeE6B+QuC9pj58noaYi/X4kLuqRfqKXENrKtWzg5W7tTsw9hVA3sI5Z5VoE
O/d1WUy6CkJIprYBJeAJKozyBStq2Qoi6nxfVLCazhLcyGcdXIIkWzqYm1gsGf5u
8LmPfUEYiPCbx72z/nHa4uth/G1BOPbSwe+TC2Wu8VRFarB8Vzeik6AyP9+oh4I3
R28EKDPwtQgljSLsNsi4Aqhfo3mobTSwTiA/O+Y+lfcWR2d8nNiIAV0IYshNUIVo
WHCqzgxDdupW+3riFNfZfTQMzRZ2sQxaVVZjLR2PndacBNzAf1A3BSs5WD2FTizC
cprjAbh+qS7Ylx8bHM00tXq6CB9qlruClfCkppDfHuHbHDlBu9iyMSwwyXpKWZ/A
1HwHes24v68DFqEuLp7vf6TWxjw/JmwmMQKR0rNsoPfon/BX79ZP6C49aLnn9xNt
u7i69QBg+4OFYJXGfxG0
=tATf
-----END PGP SIGNATURE-----

--Sig_/J4Y6mqUDHSkBtz9hfHA/JqQ--
