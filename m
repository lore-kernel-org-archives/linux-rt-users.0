From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: KVM and Prempt?
Date: Tue, 23 Oct 2007 08:31:47 -0400
Message-ID: <1193142707.8343.2.camel@ghaskins-t60p.haskins.net>
References: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net>
	 <1193076845.5738.23.camel@sven.thebigcorporation.com>
	 <471DB250.3030301@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ur4AHpc4Ub8GBXZ527RP"
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	"Back, Michael (ext)" <michael.back.ext@siemens.com>,
	linux-rt-users@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:46724 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbXJWMee (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 08:34:34 -0400
In-Reply-To: <471DB250.3030301@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-ur4AHpc4Ub8GBXZ527RP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-23 at 10:35 +0200, Jan Kiszka wrote:
> Sven-Thorsten Dietrich wrote:
> > On Mon, 2007-10-22 at 09:01 +0200, Back, Michael (ext) wrote:
> >> Hallo,
> >> I tried to run Windows XP with KVM on Linux 2.6.31.1 on a=20
> >=20
> > You mean .21.1 ?=20
>=20
> Classic typo I interestingly also did several times the last week. :)
>=20
> >=20
> >> AMD Opteron and on a Intel Xeon, on both it works fine!
> >=20
> >> After this test I patch the kernel with the current prempt-patch and o=
n
> >> both it doesn't works!=20
> >=20
> > Did you try against 2.6.23-rt1.
>=20
> kvm in -rt1 is not usable. It's too old, lacking PREEMPT_NOTIFIER
> support, thus quickly triggering lockdep.
>=20
> >=20
> > If you must stay on .21, you might have some other issues with the AMD
> > and NUMA.
> >=20
> > At the very least, you will need to apply the attached patch from git
> > somehow, although this patch is against a new scheduler post 2.6.22, so
> > good luck :)
>=20
> <--snip-->
>=20
> Those patches are already mainline... :->
>=20
> What you rather need are latest kvm patches, or - if building the kvm
> distribution out of tree - a patch to enabled CONFIG_PREEMPT_NOTIFIERS
> unconditionally:
>=20
> --- linux-2.6.23.1-rt/kernel/Kconfig.preempt.orig
> +++ linux-2.6.23.1-rt/kernel/Kconfig.preempt
> @@ -136,6 +136,7 @@
>=20
>  config PREEMPT_NOTIFIERS
>  	bool
> +	default y
>=20
>  config PREEMPT_BKL
>  	bool
>=20
>=20
> Still, I'm seeing oopses here (more precisely, lock validator
> complaints), but I need to re-test, better using kvm from git instead of
> kvm-48.
>=20
> Beyond this, I'm struggling to understand 300-400 us vm-exit latencies
> (over Intel VMX), which appear to be independent of the underlying
> system. See kvm-devel. Such latencies would limit the RT usability of
> kvm - unless you spent dedicated CPUs.

Some work is still left to be done in this area.  Until then you will
see problems like you are describing.

At one point I had a patch series that allowed KVM to actually work in
-rt without crashes, and with decent latencies (both host, and guest).
Some point soon I will revive the series and port it to the latest
kvm.git.

HTH

Regards,
-Greg



--=-ur4AHpc4Ub8GBXZ527RP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBHHemzSW61Ku6jJPkRAkjEAJ478RESwol9cM8Dncd0S3E4EzTvlACeL/iJ
vxy4tHxr9ecvyonY81Ki5J4=
=KaKc
-----END PGP SIGNATURE-----

--=-ur4AHpc4Ub8GBXZ527RP--
