From: Eric W Anderson <Eric.Anderson@Colorado.EDU>
Subject: Re: At a loss: Kernel 2.6.19-rt15 with ixp425
Date: Tue, 8 Jun 2010 13:32:05 -0600
Message-ID: <20100608193204.GA13883@colorado.edu>
References: <20100608181752.GA19521@colorado.edu>
 <1276022232.9420.17.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ipmx2.colorado.edu ([128.138.128.232]:20525 "EHLO
	ipmx2.colorado.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0FHTcH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jun 2010 15:32:07 -0400
Content-Disposition: inline
In-Reply-To: <1276022232.9420.17.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven,

The device manufacturer has made some kernel modifications to support their
board, and those are specific to 2.6.19.  (In fact, they're specific to
2.6.19.2 OpenWRT patches).  There's also a large driver which is appropriate
for an old kernel but would need some re-engineering to deal with API chang=
es
in 2.6.20 or 2.6.21, I believe.

So, if getting high-resolution timing with this kernel is going to be a
nightmare, I can try taking on a newer kernel.  But it'll be an ordeal.

-Eric


Thus spake Sven-Thorsten Dietrich (thebigcorporation@gmail.com):

> On Tue, 2010-06-08 at 12:17 -0600, Eric W Anderson wrote:
> > Hello All,
>=20
> Hi Eric,
>=20
> 2.6.19 is very very old.
>=20
> What is preventing you from a Kernel upgrade?
>=20
> Sven
>=20
>=20
> >=20
> > I can't figure out (or haven't figured out) how to get actual high-reso=
lution
> > timers on the above platform.  I'm kind of stuck with 2.6.19, unfortuna=
tely.
> > I've applied the -rt patch to stock 2.6.19, merged in some random patch=
es to
> > support my hardware, and gotten it to boot. But, here's what confuses m=
e:  I
> > have the hrtimer API, but my actual clock resolution is still shown as =
 10ms.
> >=20
> >   root@patty:/# cat /proc/timer_list=20
> >   Timer List Version: v0.1
> >   HRTIMER_MAX_CLOCK_BASES: 2
> >   now at 2766685920305 nsecs
> >  =20
> >   cpu: 0
> >    clock 0:
> >     .index:      0
> >     .resolution: 10000000 nsecs
> >     .get_time:   ktime_get_real
> >   active timers:
> >    clock 1:
> >     .index:      1
> >     .resolution: 10000000 nsecs
> >     .get_time:   ktime_get
> >   active timers:
> >    #0: <c4615ec8>, hrtimer_wakeup
> >    # expires at 2766802147358 nsecs [in 116227053 nsecs]
> >    #1: <c4615ec8>, it_real_fn
> >    # expires at 2767494816966 nsecs [in 808896661 nsecs]
> >    #2: <c4615ec8>, it_real_fn
> >    # expires at 3642163204498 nsecs [in 875477284193 nsecs]
> >    #3: <c4615ec8>, it_real_fn
> >    # expires at 3643403169278 nsecs [in 876717248973 nsecs]
> >=20
> > Additionally, I don't see CONFIG_HIGH_RES_TIMERS anywhere in my kernel
> > menuconfig.  I've added a patch from Kevin Hilman and Milan Svoboda
> > (http://lkml.indiana.edu/hypermail/linux/kernel/0607.1/2343.html) which
> > purports to enable a high-resolution clock event source for this board,=
 but
> > that doesn't seem to change anything.=20
> >=20
> > I think I don't properly understand the preempt_rt / hrtimers /
> > board-specific-bits ecosystem here.  What are the bits and pieces I nee=
d in
> > order to have high-resolution timers on this platform?
> >=20
> > Many, many thanks,
> > Eric Anderson
> >=20
> >=20
>=20
>=20

--=20
Eric W. Anderson                                   University of Colorado
eric.anderson@colorado.edu                      Dept. of Computer Science
phone: +1-720-984-8864                   Systems Research Lab - ECCR 1B54

                         PGP key fingerprints:
       personal: 1BD4 CFCE 8B59 8D6E EA3E  EBD5 4DC9 3E61 656C 462B
       academic: D3C5 D6FF EDED 9F1F C36D  53A3 74B7 53A6 3C74 5F12

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwOmrQACgkQdLdTpjx0XxLRAACgs1xJg9gyJmHYNGZiL1d/u3tQ
6VYAn04LclWltO7/xjChxoSjw27ll8nB
=dF1X
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
