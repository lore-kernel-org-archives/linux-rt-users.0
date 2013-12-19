From: Henrik Austad <henrik@austad.us>
Subject: Re: Applying rt-patches
Date: Thu, 19 Dec 2013 10:05:38 +0100
Message-ID: <20131219090538.GA7167@austad.us>
References: <15AE5A936F5E3A42A9144E66875A0A8938ADEC@server1-derijp.CLB-Benelux.lokaal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: linux-rt-users@vger.kernel.org
To: Ruud Commandeur <RCommandeur@clb.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34554 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3LSJGs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Dec 2013 04:06:48 -0500
Received: by mail-ee0-f46.google.com with SMTP id d49so315460eek.33
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Dec 2013 01:06:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15AE5A936F5E3A42A9144E66875A0A8938ADEC@server1-derijp.CLB-Benelux.lokaal>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 09:35:33AM +0100, Ruud Commandeur wrote:
> Hi Everyone,

Hi Ruud,

> I'm using the Linux 3.10.x kernel for a while in an ARM9 embedded
> system. I keep this kernel up-to-date by using incremental patches, with
> 3.10.24 being the last version. I'm thinking of switching to the
> RT-kernel for better real-time behavior, but I have a few questions how
> to do that:
> =20
> On a clean 3.10.24 kernel, I assume I should use the
> "patch-3.10.24-rt22.patch" archive (or the "patches-3.10.24-rt22" for a
> collection of single patch files).

Yes, that is correct.

> But what if a 3.10.25 kernel is released? Should I first apply the
> incremental patch for the kernel and then the incremental patch for the
> rt-part? Or should the 3.10.24-rt patch be reverted before applying the
> kernel patch to prevent conflicts?

Hmm, _personally_ I just use git and check out a new stable-branch and then=
=20
apply the corresponding -rtX patch on top of that. It=CD=84's a pretty big=
=20
hammer, but it removes a lot of potentional snags (me being butterfingered=
=20
an' all :)

If you have a set of local commits you want to carry with you, using the=20
broken out rt-patches and 'git quiltimport' lets you quickly get everything=
=20
into a branch.  Then you can cherry-pick the changes you want to add on top=
=20
of that.

At least, this is -my- approach to the matter.

I also know that ro(a)sted keeps a git-repo which he moves forward, so you=
=20
could add your own, local changes to it and just track using 'git pull=20
--rebase' or some variant thereof. YMMW and all.
=20
> Sorry if the answer to my questions would be somewhere in the Wiki, I
> was not able to find it myself up till now.

I think this is pretty much down to what works best for you, applying the=
=20
incremental patches should probably work too, but I've never tried that=20
approach myself. I just use the increments to track changes from one -rtX=
=20
to the next.


--=20
Henrik Austad

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlKytuIACgkQ6k5VT6v45lm/UACfdb0eaRw1sNoST78UkA3bb7fN
ujEAoOUITcS/0sRmD92/vuczGuQswQ10
=SFNT
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
