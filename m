Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA573C4332F
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Nov 2022 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiKUUMI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKUUMG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Nov 2022 15:12:06 -0500
Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96C8FF89
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Nov 2022 12:12:01 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:11:45 +0100
From:   David Runge <dave@sleepmap.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>
Subject: Re: Mixing upstreams
Message-ID: <Y3vbilrOjO4H5hXj@hmbx>
References: <Y3PFg2FlGMaVb2zd@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="av8kzm0gWGIwQZKQ"
Content-Disposition: inline
In-Reply-To: <Y3PFg2FlGMaVb2zd@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--av8kzm0gWGIwQZKQ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Nov 2022 21:11:45 +0100
From: David Runge <dave@sleepmap.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>
Subject: Re: Mixing upstreams

On 2022-11-15 17:59:36 (+0100), David Runge wrote:
> I package the latest stable and the development version of linux-rt for
> Arch Linux.
>=20
> For this I follow the tags created in linux-stable-rt [1] and
> linux-rt-devel [2] to rebase commits relevant for the distribution on
> top of non-prerelease tags in those repositories.
>=20
> Yesterday I noticed, that tags from linux-rt-devel (e.g. v6.0.5-rt14
> [3]) started showing up in the linux-stable-rt repository.
>=20
> Was this an oversight on your end or are you starting to migrate all
> work on the patchset into one repository (which would also be easier for
> me to mirror and track downstream)?
>=20
> Best,
> David
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.gi=
t/tag/?h=3Dv6.0.5-rt14

To follow up on my own message above, I would like to mention that
mixing upstreams makes it much harder to properly track the releases of
the realtime kernels, as I can no longer rely on tags in those
repositories without ignore a list of arbitrary strings (which may grow
over time if someone with push access keeps pushing tags from the other
repository).

It would be really great to get a reply about this.

Best,
David

--=20
https://sleepmap.de

--av8kzm0gWGIwQZKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQXk9rV2AOo/9dFFpe7mS+YZPrRaAUCY3vbgQAKCRC7mS+YZPrR
aBwJAP0UGBr3+KlJYADnvKWJtUHwX6t+AJdPU3waIu2YamFVJQEA1XDUz4EapYOf
/XIfJyqhM2vg5kkfoZVklKuOo3s/cAM=
=jh4B
-----END PGP SIGNATURE-----

--av8kzm0gWGIwQZKQ--
