Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA57C10DCE
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 09:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98DD2070A
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 09:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFJet (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:34:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFJet (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 04:34:49 -0500
Received: from [5.158.153.52] (helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1jA9NX-0007ZK-KB; Fri, 06 Mar 2020 10:34:47 +0100
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Michael 'veremitz' Everitt <gentoo@veremit.xyz>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: -rt sources/patch for LTS kernel 4.9 branch?
In-Reply-To: <0b44032f-2564-d2ac-f37f-4741e59aaff6@veremit.xyz>
References: <0b44032f-2564-d2ac-f37f-4741e59aaff6@veremit.xyz>
Date:   Fri, 06 Mar 2020 10:34:46 +0100
Message-ID: <87tv31ltc9.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

On Thu Mar 05 2020, Michael 'veremitz' Everitt wrote:
> Hello,
>
> I've been shadowing the list for a few months, and as a helper to the
> Gentoo Linux Kernel team, assisting with maintenance of various sources
> packages for the distro, and our relatively new CI system.
> My colleague Alice Ferrazzi (alicef) has updated our repository with
> ebuilds for 4.19 branch and 5.4 branch, but I was looking for the other LTS
> kernel branches to add in and update, but so far, can only find 4.4 and
> 4.14 branches but not 4.9.

True. It seems like Gentoo does only have 5.4-rt and v4.19-rt atm.

> Would someone be so kind as to bring to my
> attention the latest release/patches of this branch series, and we can
> prepare the missing ebuilds, and test all in our new CI process.
> Many thanks.

The development tree is here:

 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

All stable trees (including v4.9) are here:

 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/

The tarballs are located at

 https://kernel.org/pub/linux/kernel/projects/rt/

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl5iGTYACgkQeSpbgcuY
8KaTOhAAzCfbCCqeePWAB9D7Sf+mAIkaAz0XSPse7tzm0xZrrLvjOHXOPk8oRrd2
T/kTS31JMp8hXkHQFX4Gn1R1ZrLyiooSGHyfO8kGAyXTQk6Jt8R3oSVFT24x2faZ
1z0Ri3/iZqjd1c8ggGkty5RnizAaCLMby36xoKcca7iuFcxfAKJxfc9U95w4kdRd
R/L8+rtrf9SoufM7CDRyMe7Nyax7WTFpLzErQxD9mUEu2bSAIyAlqpJ9KwetmHjc
PN1DNMzqdrdNU7ITL+JAxF1CTzYhKnYa+HQAydgMapjjC27b/332+6rQ/oitg2ZA
W/l4QmbqXXJZ7M0UpjANR/3EkVrq6+0TGXg1EfzAZlwhrmibJaOq2SYsEfscimqp
yRd8kbMaFEFlt9+cP72MdeF6NpEVqUlkGtD7uOtli2EP9KdJ/KMtECNv2VL1zCkb
PB1DwklGsHypDPLPQrI2Gjc4n4LtaTcUDxpNgcF6uMylxT3+KvTiWEV3RoyeuGT7
g0G8N354tENoO7jS1/TLY1VDMQwHdTXT+EyydqzQcll0aOI4HAJpE3x+b3XnLVB/
uueii6bBNZuXqOjmV/y16s3r3NRgcIUXRLTaG/qYDoE3W7DjypLKx+PHsmkRHBfT
00BKGkukJYufr9L3eDY0fGp/SxCesOARRI6N/Yaj2uZb1LDy1y0=
=7C5j
-----END PGP SIGNATURE-----
--=-=-=--
