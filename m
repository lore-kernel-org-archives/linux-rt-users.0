From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Cyclictest usage
Date: Mon, 11 Aug 2008 08:48:23 -0400
Message-ID: <48A03517.40708@novell.com>
References: <ccb913ac0808110200m7a34b361j5a60e9ef31ebb0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig85FAC988E806F78324399EFB"
Cc: linux-rt-users@vger.kernel.org
To: Tobias Knutsson <tobias.knutsson@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:35507 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYHKMuk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 08:50:40 -0400
In-Reply-To: <ccb913ac0808110200m7a34b361j5a60e9ef31ebb0f4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85FAC988E806F78324399EFB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Tobias Knutsson wrote:
> Hello,
>
> I'm trying to do some initial benchmarking on a rt-kernel versus a
> vanilla kernel. On the rt the results are stable in between test runs
> using the following command:
>
> cyclictest -t 1 -p 80 -c 1 -n -i 10000 -l 10000
>
> However, using the same command while running the vanilla kernel, I
> get very varying results. And I would completely understand if it was
> due to increased jitter. The thing is, the jitter is very low (0%
> load) but the average times varies from 600 us to 6500 us depending on
> when the test is initiated.
>
> I imagine this might have something to do with not having high res
> timers in the vanilla kernel. If that is what's causing my problems.
> What is the best way of comparing the two kernels?
>
> I would be much greatful for a few pointers!
>
>  =20

Hi Tobias,
  What kernel versions are you testing out?


--------------enig85FAC988E806F78324399EFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkigNRcACgkQlOSOBdgZUxkEYgCfY1cHbS4qKXixEecKzFAx7N2u
uJUAn0Mbh1a0eF90DGROHjYjnPBWyEOI
=d6VV
-----END PGP SIGNATURE-----

--------------enig85FAC988E806F78324399EFB--
