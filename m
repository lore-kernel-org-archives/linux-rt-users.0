From: Julia Cartwright <julia@ni.com>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 6 Mar 2017 13:07:07 -0600
Message-ID: <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        <linux-rt-users@vger.kernel.org>
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43003 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753160AbdCFVYh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 16:24:37 -0500
Content-Disposition: inline
In-Reply-To: <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 06:59:26PM +0100, Wargreen wrote:
> Here a new try, with a process name more explicit, but without X crash
> this time.
> So it's the graphic's ressources demanding process.
>
> [  497.053562] 2 locks held by Xorg/2154:
> [  497.053563]  #0: (&rdev->exclusive_lock){++++.+}, at: [<ffffffffa90f37=
10>] rt_down_read+0x10/0x20
> [  497.053571]  #1: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f3710=
>] rt_down_read+0x10/0x20
> [  497.053589] 2 locks held by gnome-shell/2344:
> [  497.053590]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f3710=
>] rt_down_read+0x10/0x20
> [  497.053597]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc=
0af47b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]

Unfortunately, this doesn't get us any more data than we already had.
For some reason, a thread (G.Main in the prior trace, gnome-shell here)
in this state fails to make progress.

We need to better understand what this thread is doing.  Is it
Runnable/spinning?  Is it itself waiting on a lock?  Dumping the stack
=66rom it in this state might be revealing.  The contents of
/proc/<pid>/stack might be of interest.

   Julia

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli9s1cACgkQjNrC4UVN
dG+0QAf+PteL5Tved6h640re7SQG8ucPvwER8HxNUefTApkqII9pN+twsGe2Vb8u
Kj/ZBz6qJj31MYJnjS7wSIRCNwkSFg+pgY8vXkeLguNEQcYwe5Us6pyGqN2IK7f9
9sZ0XVTReruVXZtzGMtZwdxdrY0VN+X+VuNv348pVLrQY7GlvfKY2KtEahRPRTKn
WKQPcFn3w64fOWKKYrU8J58ckLF7NHtI/JokH81VWZdTnzXBEsIj6GuNCm0pHAg9
1TYswBgNj+hQF46Sx1wM/XELxdOfyhVKv3QVlW11bi/lXgBcnXSjutw4DUJfU1x+
+wmLIpYg/z2y3pJ8/M81yoCjSe8TTg==
=V9Qt
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--
