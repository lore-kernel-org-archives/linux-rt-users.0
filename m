From: Clark Williams <williams@redhat.com>
Subject: Re: rt kernel, pro-audio use
Date: Thu, 20 Dec 2012 11:00:52 -0600
Message-ID: <20121220110052.5f709692@redhat.com>
References: <50D231F5.4060604@gentoostudio.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/QNXaxTJoD9HxDfvxg3aTFHw"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Damien Moody <webmaster@gentoostudio.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab2LTRBA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 12:01:00 -0500
In-Reply-To: <50D231F5.4060604@gentoostudio.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/QNXaxTJoD9HxDfvxg3aTFHw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Dec 2012 21:30:29 +0000
Damien Moody <webmaster@gentoostudio.org> wrote:

> Hi,
>=20
> I have a couple of questions.
>=20
> 1. I'd like to keep informed when the rt kernel gets updated, so I can=20
> put up a new Gentoo ebuild on my site (gentoostudio.org). Is this the=20
> list for that? If not, what is?
>=20
> 2. I use the rt patches a la rt-sources on Gentoo. I'm a musician and=20
> audio engineer. What advantages does the rt patch set provide over other=
=20
> patch sets like ck-sources and pf-sources, where latency can be=20
> configured to be very low? I'd like to document this on my site.
>

I use an RT-patched kernel with Fedora to record drum tracks with
Ardour3+jack+ffado. I can record 16-channels of 24-bit samples at
48000Hz through a pair of Presonus FP10s attached to a Lenovo W510
laptop and I honestly can't remember the last time I had an xrun.=20

I'm sure plenty of people can do this with a standard kernel that's
been tuned but no matter how much they tune it, there's always the
possibility of running into a priority-inversion situation. The RT
patchset converts most of the spinlocks in the kernel to an
rt_mutext_t. The rt_mutex_t lock has a priority-inheritance chain that
allows for a temporary priority boost of a thread holding a lock when a
higher priority thread tries to claim the lock. This prevents
intermediate priority threads from preventng the lock-holder thread
from running, delaying the high priority thread indefinitely.=20

Clark


--Sig_/QNXaxTJoD9HxDfvxg3aTFHw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDTREQACgkQHyuj/+TTEp3cxgCfRlSAV5JzUd+dlFYSgIwwnzpG
HxIAn0JnuF+rKmID8Q54Z+lWBIG9k8qG
=xZRm
-----END PGP SIGNATURE-----

--Sig_/QNXaxTJoD9HxDfvxg3aTFHw--
