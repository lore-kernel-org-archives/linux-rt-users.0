From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
Date: Tue, 29 Mar 2016 12:18:49 -0400
Message-ID: <1459268329.6219.8.camel@redhat.com>
References: <20160318142052.0605524d@annuminas.surriel.com>
	 <20160329161346.GE13334@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8GSDLrGkKBUYsXsH4vbQ"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com,
	srostedt@redhat.com, pbonzini <pbonzini@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58353 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcC2QSy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:18:54 -0400
In-Reply-To: <20160329161346.GE13334@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-8GSDLrGkKBUYsXsH4vbQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-03-29 at 18:13 +0200, Sebastian Andrzej Siewior wrote:
> * Rik van Riel | 2016-03-18 14:20:52 [-0400]:
>=20
> >=20
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -36,6 +36,7 @@
> > #include <linux/kprobes.h>
> > #include <linux/debugfs.h>
> > #include <linux/nmi.h>
> > +#include <linux/wait-simple.h>
> This does not work since v4.4.4-rt11:
>=20
> >=20
> > arch/x86/kernel/kvm.c:39:31: fatal error: linux/wait-simple.h: No
> > such file or directory
> In -rt11 I pulled in the swait queue which was in the -tip tree and
> is
> now part of v4.6-rc1. So if you could please refresh the patch and
> resend it then I will be able pick it up for the next -RT release and
> the KVM maintainer will be able to pick it up, too.=C2=A0

I missed that swait went upstream, but I believe Paulo fixed
up the patch and has it in the KVM tree already.

--=20
All Rights Reversed.


--=-8GSDLrGkKBUYsXsH4vbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+qrqAAoJEM553pKExN6DtzAH/0V3UqM0iIYa60D9BjJ4GFRb
K1oJs+Lk43OPDIm7zIzStF1ZVVd2fM47pZ7ZgDvfC/5lQ8b3tACVTS4fOJCTKT7R
EL21v9mAxM8uO0d6fIhzmkUJMXZqndbJVFhnwkga6o3cE6afvhDLdBcoqK8Opq1l
MEfIeJ3OrkqR+tpIvPbweZzTw1xP498ZjfNnxAm/sWFZK2seexGsyICtaESRsj7j
+C3fv73R9o0EZAiwSYlvT9NdKiqqTab7u3s6Qn6mTgymN+d9Mu70/CMySrHLHBdG
vI5Ht5k2o6Q8WQ9GNTBx7Cs/CmDgwD/tgTFHwlfey4uC/ZgoS42mLh1V32VDaTM=
=S/jU
-----END PGP SIGNATURE-----

--=-8GSDLrGkKBUYsXsH4vbQ--

