From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest problem/bug as non-root
Date: Sat, 11 Feb 2012 09:45:59 -0600
Message-ID: <20120211094559.0a0edcb1@redhat.com>
References: <20120210115721.GA13313@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/jcVdcP=s.qYZp76dxklA_IB"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61626 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182Ab2BKPqI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 11 Feb 2012 10:46:08 -0500
In-Reply-To: <20120210115721.GA13313@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/jcVdcP=s.qYZp76dxklA_IB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Feb 2012 12:57:21 +0100
Nicholas Mc Guire <der.herr@hofr.at> wrote:

>=20
> HI !
>=20
>  minor bug in cyclictest but potential causing confusion on cyclictest=20
>  resuults when running as non-root user.
>=20
> Setup:
>  if one sets the rtprio in /etc/security/limits.conf to something below
>  prio max - like:
>=20
>  @hofrat          hard    rtprio          10
>  @hofrat          soft    rtprio          10
>=20
>  but then starts cylictest with -p 80 cyclictest will not fuss and also
>  display priority 80 (as it uses par->prio in print_stat) but effectively=
=20
>  runs with prio 0 as the return value of sched_setscheduler is not being
>  checked in timerthread), resulting in semingly bad scheduling jitter val=
ues.
>=20
>  So maybe cyclictest should take the effective maximum schduling priority
>  of the user and not the scheduling policy maximum. Not sur if the check
>  in timerthread is actually really needed - but it should not hurt ither.
>  patch below (against current git) at "works for me" quality.
>=20
> thx!
> hofrat
>=20
>=20

Thanks Nicholas, I'll apply it and run it through some tests. Looks
good at first glance though.

Clark

--Sig_/jcVdcP=s.qYZp76dxklA_IB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk82jTcACgkQHyuj/+TTEp11dACeKUKJUXdtHQgXqQC3IotmtAX5
DRAAoMlulwiQCO30z91IQYRdZoForA1N
=LaV+
-----END PGP SIGNATURE-----

--Sig_/jcVdcP=s.qYZp76dxklA_IB--
