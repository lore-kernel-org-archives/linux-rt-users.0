From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: 2.6.24-rc7-rt2
Date: Wed, 16 Jan 2008 12:11:22 +0200
Message-ID: <200801161211.25948.caglar@pardus.org.tr>
References: <1200336080.318.8.camel@localhost.localdomain> <Pine.LNX.4.58.0801152259200.19680@gandalf.stny.rr.com> <200801160912.37814.caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1250007.Tpx8Tf5gVB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:55499 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751655AbYAPKLh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 05:11:37 -0500
In-Reply-To: <200801160912.37814.caglar@pardus.org.tr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--nextPart1250007.Tpx8Tf5gVB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Again;

16 Oca 2008 =C3=87ar tarihinde, S.=C3=87a=C4=9Flar Onur =C5=9Funlar=C4=B1 y=
azm=C4=B1=C5=9Ft=C4=B1:=20
> 16 Oca 2008 =C3=87ar tarihinde, Steven Rostedt =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:
> > On Tue, 15 Jan 2008, [utf-8] S.=C3=83^Ga=C3=84^_lar Onur wrote:
> > > 2.6.24-rc7-rt2 (-rt2 patchset on top of Linus's current git commit
> > > 031f2dcd7075e218e74dd7f942ad015cf82dffab) starts to complain like
> > > following (full dmesg can be found @ [1]) when try to login from
> > > console (the other acpi related errors also existed in 2.6.24-rc5-rt1)
> > > and FYI, plain 2.6.24-rc7 (again commit
> > > 031f2dcd7075e218e74dd7f942ad015cf82dffab) has no issues.
> >
> > Do you get the same issues if you add to -rc7 and not git.
>
> I'll try after trying -rt3.

=2Drt3 on top of 2.6.24-rc8 works fine without that sysfs problem (acpi war=
nings=20
still there and full dmesg can be found from [1]), whatever causes this see=
ms=20
solved :)

[1] http://cekirdek.pardus.org.tr/~caglar/dmesg.rt3

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1250007.Tpx8Tf5gVB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBHjdhNy7E6i0LKo6YRAv/qAJsHGsreK/PdGvlfUQt1jMLDzfmCqwCeLeXZ
g1cFCJRYp5jqgkVR4ovAtU0=
=9jNO
-----END PGP SIGNATURE-----

--nextPart1250007.Tpx8Tf5gVB--
