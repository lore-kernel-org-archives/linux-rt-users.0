From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2] rt-tests: Add option to force timeout to pmqtest
Date: Thu, 1 Apr 2010 12:41:40 -0500
Message-ID: <20100401124140.49f4cfa1@torg>
References: <4BB0C273.2040606@osadl.org>
	<4BB209ED.80602@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8c=1TweY0d+0l.B1gxKNtR/"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234Ab0DARlz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Apr 2010 13:41:55 -0400
In-Reply-To: <4BB209ED.80602@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/8c=1TweY0d+0l.B1gxKNtR/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Mar 2010 16:25:49 +0200
Carsten Emde <Carsten.Emde@osadl.org> wrote:

> On 03/29/2010 05:08 PM, Carsten Emde wrote:
> > This patch adds the program pmqtest to the rt-tests suite.
> > The test mechanism is the same as in ptsematest, svsematest
> > and friends, but it uses message queues to synchronize the
> > test threads. To test the - now hopefully fixed - kernel
> > problem that occurred when a timeout was specified, the
> > -T option is available.
> This patch adds the option -f to force a timeout condition of
> mq_timedreceive() to pmqtest - only meaningful along with -T.
>=20
> The call
> # pmqtest -Sp99 -i100 -d0 -T1 -f2
>=20
> will display
>=20
> #0: ID17791, P99, CPU0, I100; #1: ID17792, P99, CPU0, Cycles 8
> #2: ID17793, P99, CPU1, I100; #3: ID17794, P99, CPU1, Cycles 8
> #4: ID17795, P99, CPU2, I100; #5: ID17796, P99, CPU2, Cycles 8
> #6: ID17797, P99, CPU3, I100; #7: ID17798, P99, CPU3, Cycles 8
> #8: ID17799, P99, CPU4, I100; #9: ID17800, P99, CPU4, Cycles 8
> #10: ID17801, P99, CPU5, I100; #11: ID17802, P99, CPU5, Cycles 8
> #12: ID17803, P99, CPU6, I100; #13: ID17804, P99, CPU6, Cycles 8
> #14: ID17805, P99, CPU7, I100; #15: ID17806, P99, CPU7, Cycles 8
> #1 -> #0, Min   16, Cur   22, Avg   18, Max   24
> #3 -> #2, Min   13, Cur   14, Avg   14, Max   16
> #5 -> #4, Min   14, Cur   20, Avg   16, Max   20
> #7 -> #6, Min   13, Cur   14, Avg   14, Max   15
> #9 -> #8, Min   14, Cur   14, Avg   15, Max   19
> #11 -> #10, Min   13, Cur   13, Avg   16, Max   20
> #13 -> #12, Min   13, Cur   14, Avg   15, Max   19
> #15 -> #14, Min   13, Cur   14, Avg   15, Max   19
> etc.
>=20
> but the next cycle will only continue when the timeout of 2 seconds is
> elapsed.
>=20
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Carsten,=20

Not ignoring you, just took a while for your task to get scheduled (I'm
an old uni-processor :)).=20

I'll pull these in and spin a new rt-tests tonight.

Clark

--Sig_/8c=1TweY0d+0l.B1gxKNtR/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAku02tcACgkQHyuj/+TTEp2hKQCeIu3qB3xx++pG5VVA0tNzjHHX
VjgAoKZRZo59cSCRGNTfKzCh/qJ3MEeF
=KxSR
-----END PGP SIGNATURE-----

--Sig_/8c=1TweY0d+0l.B1gxKNtR/--
