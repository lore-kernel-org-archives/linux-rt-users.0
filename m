From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH rt-tests 2/9] cyclictest: fixup documentation for
 --priority option
Date: Tue, 1 Sep 2015 16:11:51 -0500
Message-ID: <20150901211151.GN9309@jcartwri.amer.corp.natinst.com>
References: <cover.1441038216.git.joshc@ni.com>
 <01e06fd455b51323577b0af9bb144e892281ecf8.1441038216.git.joshc@ni.com>
 <alpine.LFD.2.20.1509012301520.19826@riemann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:45248 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751180AbbIAVLy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Sep 2015 17:11:54 -0400
In-Reply-To: <alpine.LFD.2.20.1509012301520.19826@riemann>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2015 at 11:03:08PM +0200, John Kacur wrote:
> On Mon, 31 Aug 2015, Josh Cartwright wrote:
>=20
> > Commit 15c6d81986b6 ("[cyclictest] added priority spreading option
> > --priospread") introduced an additional option with the prefix 'prio';
> > this means that it is no longer possible for a user to specify '--prio'
> > instead of the full '--priority'.  Doing so results in the following
> > error:
> >=20
> >   $ cyclictest --prio=3D4
> >   cyclictest: option '--prio=3D4' is ambiguous; possibilities: '--prior=
ity' '--priospread'
> >=20
> > Fix this up by updating the 'help' output.
> >=20
> > Signed-off-by: Josh Cartwright <joshc@ni.com>
> > ---
> >  src/cyclictest/cyclictest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 9aebe32..4ced67f 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1062,7 +1062,7 @@ static void display_help(int error)
> >  	       "-N       --nsecs           print results in ns instead of us =
(default us)\n"
> >  	       "-o RED   --oscope=3DRED      oscilloscope mode, reduce verbos=
e output by RED\n"
> >  	       "-O TOPT  --traceopt=3DTOPT   trace option\n"
> > -	       "-p PRIO  --prio=3DPRIO       priority of highest prio thread\=
n"
> > +	       "-p PRIO  --priority=3DPRIO   priority of highest prio thread\=
n"
> >  	       "-P       --preemptoff      Preempt off tracing (used with -b)=
\n"
> >  	       "-q       --quiet           print only a summary on exit\n"
> >  	       "	 --priospread       spread priority levels starting at speci=
fied value\n"
> > --=20
> > 2.5.0
>=20
> This was already fixed in v0.93
> 417ddb5db0ab cyclictest: Fix long priority help text option

Ahh, so it was.  Sorry about that, I had my git remote pointed at
clrkwllms/rt-tests.git instead of rt-tests/rt-tests.git which hadn't
been updated.

The rest should still be relevant.

Thanks,

  Josh

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV5hSUAAoJEKp7ZBKwQFAryKIIAIyihZwH+UmctVUAMGF2Qzm3
mNfacyq25VqftCJC2K44eAT2qHkGoBOToByTa0l2kX2ccr9PhJaxP36rRxI/e06C
Wk6FD/8IThZKHOn0dFiQhRSG9nh96jRykzoqqQVWQ8n/JOYoj7gwKl7T9cHw73a3
78X1pxmEkFK05kNwrIjHUo2/Qcr2YGhBFgoeCXiwvMdygQhNKkZkndDw05hw/eut
pZ26epItZpQQTFmKn32PboYN2sDhSMgKqcPjZIvv26+s8+NSohdckSLsFQTnJKHM
B2zQxLA6HaPmuo5ek6pnneCCWprezVgpALJipRsqkjBQEOwL1SJvm2obIhIj0l8=
=fi+d
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--
