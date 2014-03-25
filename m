From: Clark Williams <clark.williams@gmail.com>
Subject: Re: Patches for cyclictest bug
Date: Tue, 25 Mar 2014 13:54:35 -0500
Message-ID: <20140325135435.5acebb2f@sluggy>
References: <CAF7YWnyL2_pAcJ+8mUh++_kvh_rCXT3GimarN6F3WWyP0HWseg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/lpWxg6hdSVcaSMxsii=OBi0"; protocol="application/pgp-signature"
Cc: Anders Roxell <anders.roxell@linaro.org>,
	Mike Holmes <mike.holmes@linaro.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Gary Robertson <gary.robertson@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:47074 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbaCYSyk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Mar 2014 14:54:40 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so1240987qcy.28
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Mar 2014 11:54:40 -0700 (PDT)
In-Reply-To: <CAF7YWnyL2_pAcJ+8mUh++_kvh_rCXT3GimarN6F3WWyP0HWseg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/lpWxg6hdSVcaSMxsii=OBi0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2014 13:30:35 -0500
Gary Robertson <gary.robertson@linaro.org> wrote:

> Mr. Williams,
>=20
> Linaro Networking Group have been using cyclictest in our kernel validati=
on
> test suites as part of an OpenEmbedded root filesystem build.  Between OE
> rt_tests build 0.86 and 0.87, our cyclictest lost its CPU affinity suppor=
t.
>=20
> I have created a patch set which resolves this issue but I am unsure as to
> the best forum or mailing list to use in submitting the patches for the
> cyclictest sources cloned from
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>=20
> If you will inform me as to the best place to email the patches I will se=
nd
> them for your consideration ASAP.
>=20
> Thanks,
>=20
> Gary Robertson
>=20
> Linaro Networking Group kernel tree maintainer

Gary,

Best place to discuss problems with the rt-tests group (which includes
cyclictest) is the linux-rt-users list (which I've CC'd).=20

We added a modification to affinity in the 0.87 version which allows
the user to specify an arbitrary set of cpus. It's entirely possible we
broke something in doing that.=20

What command line did you use that 0.87 broke?

Clark

--Sig_/lpWxg6hdSVcaSMxsii=OBi0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMdDrAAoJEEersVlSw9Nz7OcQAJKU+rfR8vuwCCAYf5CviKrA
FS79mI/S/F05l6KVS4mMIEuDzHfL6TfQOCJg3CSqhsnMRKK1YOmAr9XBCFIS/y4N
EuBAf/4CUjQ/NENHYIfKyDMAaL+hM3Zt9HL81HNqpyfXPcaxseZ9ELgGD6rfdfPa
d1kbqLLUruztRNciQuRUCCeI9E0BdjZa7JVuHXT4HLDPWlYZoGgPF8TvfHbhXjTj
1B0amqs3bVqL2UDBbj58PL9YNhsYGxpZAOsyOyk2yovFO5+jpYZHFdb12xr0j/lF
mKBiF60tPZ3Tw7kmFYT2RKOIB06w1j3BI4PPwJgOvb1A5BZtx1QG2TOZoCyeWYLe
HkZAz30sF5yK5g3qJYW+or5OuxXK2uhE6SXlZAvjHv0zeGpcqEF5NoYfvXKywVR0
4GSPHJiltvxjDR9Kj8F28FguCe9kryPoHTgSvtvQygCM1DJaj/gHqYD48ojis5sC
FHdr0JJm2G0RANMt4bgY4aY4bly/ewyL+7ZHfdKyCiftTvHY/JXiROss5PpkzZKP
+km4S4PEp7/QuA7NLtbb+ceCQogiv2O/kwHI40OeqW7n7UtBGyKPz1ug1Pv+CkHa
t6rBgwwJTjU0oSJ0pNpSOnEi8PFFmuzNNZNoIfLUTy8wde5GmL4CVZVNVgjGVqxO
5V4PtxuxDMjahjzyk4lN
=RoCx
-----END PGP SIGNATURE-----

--Sig_/lpWxg6hdSVcaSMxsii=OBi0--
