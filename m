From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: Full RT kernel problem on arm
Date: Wed, 27 May 2015 21:34:50 +0200
Message-ID: <55661C5A.2060705@autostatic.com>
References: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>	<55656DEA.4040006@monom.org>	<CAOn_9a7_Dkq10nTcA6_GguzU-xt=XGztFBd1+=87GO7FCXqV_Q@mail.gmail.com>	<5565A814.1090208@monom.org> <CAOn_9a4_CSEZb_fVVFRev+n4cT2CQKNLrgqaguMaRVaPSZ7zLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="29mJLvRv1HT7VPDksiigVdRbpRIDc03F1"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from autostatic1.autostatic.cyso.net ([93.94.224.100]:37417 "EHLO
	smtp.autostatic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbE0Te6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 15:34:58 -0400
Received: from [192.168.1.33] (53515650.cm-6-2b.dynamic.ziggo.nl [83.81.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.autostatic.com (Postfix) with ESMTPSA id 15911DFD
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 21:34:50 +0200 (CEST)
In-Reply-To: <CAOn_9a4_CSEZb_fVVFRev+n4cT2CQKNLrgqaguMaRVaPSZ7zLQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--29mJLvRv1HT7VPDksiigVdRbpRIDc03F1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/27/2015 07:25 PM, Warter wrote:
> It is interesting because if I use "Basic RT", there is no problem.

Then why not stick with that? A real-time kernel doesn't sound better as
far as I know ;)

Jeremy


--29mJLvRv1HT7VPDksiigVdRbpRIDc03F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVZhxaAAoJEF63J34m6LiU5sUP/3zplWF6NCvWQvZ7iYeww5Dc
o3wg230DNTZEgAWk2PmvJkL+7lSoUgQuFsN6A783FAqVGlYL48AP3/jv54vXlAkO
MobG1WLHaOO2NOgmVxB0fuiyAQjD7OQvR0faDSk30oro8W4ErecgduduO3m/9tIF
mZLMGCX3So7m+02rwByrk7rEHh3wfM8gnPiJZDd4mgEy5UenzJ3NRhAiIWj6OU6D
8RXSwlsAy6uYmNrx9imAXsKNAfvVnP7dStZMtB0H0zstcKnJkLBOaCXbFGCSaZTv
xdQ3XZmm2tQGXoSQnv/ytTzYZTxkO6RcNabqzAuteNUcTVFH77GIeSK97f9qbThP
fu/LvaclSVRznTs5K3AFyED2k9qQlqHPBAf7FH4I/3Vj1XevlpRet/YKsJA7x78P
8RXsF7J5+UZVCQ+Gv0e//t1kED+R3Vn7IroLGGuduZWH3u8JmOaXsFz83wPFocPw
XqnkcK1sPjXu/findSMiwSWQjlMa5Axa8g1d4HW+xFrrBZPFrhNGr19qApp8XsVo
C/FEWVRxmXLPfO9ZPJ52f1yhHiqYXh/O/lczD/ARLHxVpiTmYd8dUyRIKv2Kpksx
Itk5JCKxeUH8CICQ8s8R6UFjZiNOyw7kixHGs/9sNJbu4hPSo2v57eRpocojmULS
Rj/fFE08Vi5X+sCg1BlQ
=YvPu
-----END PGP SIGNATURE-----

--29mJLvRv1HT7VPDksiigVdRbpRIDc03F1--
