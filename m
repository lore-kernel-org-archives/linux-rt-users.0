From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Tue, 19 Aug 2008 10:10:21 -0400
Message-ID: <48AAD44D.8050000@novell.com>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9DBB976533D7826988E5E73F"
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: Gilles Carry <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:36253 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYHSOMn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 10:12:43 -0400
In-Reply-To: <1219070552-30783-2-git-send-email-gilles.carry@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DBB976533D7826988E5E73F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

Gilles Carry wrote:
> This patch makes hrtimers initialized with hrtimer_init_sleeper
> to use another mode and then not be stuck in waitqueues when
> hrtimer_interrupt is very busy.
>  =20

Not sure if this is related, but I just posted a patch to fix a=20
condition where hrtimer_interrupt could get artificially busy for *very* =

long periods of time (I observed 500ms).

http://article.gmane.org/gmane.linux.rt.user/3357

This bug was specific to 26-rt1.  Did you investigate the cause of the=20
busy hrtimer_interrupt?  If not, its possible that your issue would be=20
indirectly fixed now that the HRT subsystem doesn't spike-out like=20
that.  Or do you believe these are orthogonal issues and we should still =

protect against non-pathological cases of hrtimer_interrupt running hot?

Regards,
-Greg




--------------enig9DBB976533D7826988E5E73F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiq1E0ACgkQlOSOBdgZUxmOXQCfb8yOHd4a9ryIWJ0IfVZVT2s2
3TkAn3Du5AkbtUHQjPLWFlKbmh6/SNoA
=53km
-----END PGP SIGNATURE-----

--------------enig9DBB976533D7826988E5E73F--
