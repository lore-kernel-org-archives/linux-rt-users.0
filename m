Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592FCC433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Nov 2022 17:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiKORIV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiKORIQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2022 12:08:16 -0500
Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085515FC2
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Nov 2022 09:08:15 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:59:36 +0100
From:   David Runge <dave@sleepmap.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Mixing upstreams
Message-ID: <Y3PFg2FlGMaVb2zd@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tPUdAMFfu/cCKAho"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--tPUdAMFfu/cCKAho
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Nov 2022 17:59:36 +0100
From: David Runge <dave@sleepmap.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Mixing upstreams

Hi!

I package the latest stable and the development version of linux-rt for
Arch Linux.

For this I follow the tags created in linux-stable-rt [1] and
linux-rt-devel [2] to rebase commits relevant for the distribution on
top of non-prerelease tags in those repositories.

Yesterday I noticed, that tags from linux-rt-devel (e.g. v6.0.5-rt14
[3]) started showing up in the linux-stable-rt repository.

Was this an oversight on your end or are you starting to migrate all
work on the patchset into one repository (which would also be easier for
me to mirror and track downstream)?

Best,
David

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
tag/?h=3Dv6.0.5-rt14

--=20
https://sleepmap.de

--tPUdAMFfu/cCKAho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQXk9rV2AOo/9dFFpe7mS+YZPrRaAUCY3PFeQAKCRC7mS+YZPrR
aCMnAP4rVAxwPQFEL+plKCBKmw7XxCEqMpzeTk9WRCAaWMAtXgD7BZNsIuLFi8X1
G+Ob4wcPpE4pUuVgE/Of/NHRNCeYXQs=
=V4WY
-----END PGP SIGNATURE-----

--tPUdAMFfu/cCKAho--
