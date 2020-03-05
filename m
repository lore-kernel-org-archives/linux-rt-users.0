Return-Path: <SRS0=I6ff=4W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6235C3F2D2
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 23:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A953F20717
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEXhg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:37:36 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXhf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Mar 2020 18:37:35 -0500
Received: from [192.168.6.147] ([212.159.46.162]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.99]) with ESMTPSA (Nemesis) id 1N2Dgk-1jMbY23igg-013g2r
 for <linux-rt-users@vger.kernel.org>; Fri, 06 Mar 2020 00:37:32 +0100
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Michael 'veremitz' Everitt <gentoo@veremit.xyz>
Subject: -rt sources/patch for LTS kernel 4.9 branch?
Openpgp: preference=signencrypt
Autocrypt: addr=gentoo@veremit.xyz; keydata=
 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
 rEbAnxvLsIsb5oE=
Message-ID: <0b44032f-2564-d2ac-f37f-4741e59aaff6@veremit.xyz>
Date:   Thu, 5 Mar 2020 23:37:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="75UHcdeQOOPxFqp3dnLAi8mE6lHgsBTpW"
X-Provags-ID: V03:K1:D1iI7l5nmvomnzw5z68v4/sRVwHUf87NwR0wN7y43GRzfRSr6Qa
 Owo2eqMWLIPPTAxM5TgxsVRZETrZLRd/0irN4BYBbhkeNYRIKUi0J5AS3ou56GEDUdul40z
 RqQFqffGgBKTIOw0sXd1fjuErfgykTDx5acMT9FR6uCwFrZWv25n6C2dFBxmDTStNC9A432
 5bMZteNU2KB7Tyd05wHIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:46uqBIBjZH4=:FFw2OUMMper/w1zGvDPNcK
 3PcIBkv/UZR4vpoe8GLZIPv8Bk2RtvXIliL83Dr0+23V9bfkqB8bieHt3DJSTs8Fd5MRmu50Y
 l/mguXlEzJxgggRlND9R1yDarEXRaa3Gez4q4c5nRc4ZQPzjxY5cKB4R0QuznTZTWpBruEgTq
 GYOtGej85E7xDUT+Gksrn6XXe5rFnNYMWJ0s+fZJCkOuFd9knrFDzAZZJb6i1PBj10quDAVF8
 MaEowWcXGgMtpjdJUcnV/WtWg7vc1Cnf45EF2CAxiaNC6aoctO+80WQSi7mfdQLuzZaKfrXmN
 kAs/EbIO/bX58VUqcymb1AQYmF1lRwUhVjZgAFnB/YP65g3Vk94YS4lIxjcILNtiwPkePbX2Q
 qDku+VJ6NLbAhXgCYD2KPpcZi6wgL+BzKeK9KzbDJ14m1dBAKa52/WrMXksw9hy+S0GMbhWnI
 bMkJ8+7uT4lb7unW2/uyQOBMX9H6En7EG/KzCEFybG5ryx3rp1uPchyBIFkgkqLzVqwVXOzNc
 5S1qdUoI/D01mGbcPOZi0c2yhIZrLq0DNe0WvOg9S+DPqDUXQb+Y9CosNKYpMnXtAGclb0jhI
 rX3gtliBOE14XvwJPEUI76nyz/Xojf7S+iMqcY+iB2zmdmZ3V3Je10uEhV2DNTkgBCrpTS9Js
 /lj3zUH57FrqlTO8XLuSBkcWtpHEEMIOeZVuo6W0MwMxEtcxi06rLoNKykl/CZr18Fp512Xtb
 nkpBx2F7z5UkvDyOEljWlV9ftELGZX1GMTTi7p8NJe5LgqnrTGHG9MWOZ29/2Pv6ZgP1pysGO
 iMDvioFuiQCpAVt652XpQ9jqegsScXbMiSpY918FTv/T9hlaCmt9UJDbSjUAce3wJzHGHb9
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75UHcdeQOOPxFqp3dnLAi8mE6lHgsBTpW
Content-Type: multipart/mixed; boundary="6EAMvkSd2Q7nnJ7v1l4tdhDdMpF7QbNMf";
 protected-headers="v1"
From: Michael 'veremitz' Everitt <gentoo@veremit.xyz>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <0b44032f-2564-d2ac-f37f-4741e59aaff6@veremit.xyz>
Subject: -rt sources/patch for LTS kernel 4.9 branch?

--6EAMvkSd2Q7nnJ7v1l4tdhDdMpF7QbNMf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Hello,

I've been shadowing the list for a few months, and as a helper to the
Gentoo Linux Kernel team, assisting with maintenance of various sources
packages for the distro, and our relatively new CI system.
My colleague Alice Ferrazzi (alicef) has updated our repository with
ebuilds for 4.19 branch and 5.4 branch, but I was looking for the other L=
TS
kernel branches to add in and update, but so far, can only find 4.4 and
4.14 branches but not 4.9. Would someone be so kind as to bring to my
attention the latest release/patches of this branch series, and we can
prepare the missing ebuilds, and test all in our new CI process.
Many thanks.

Regards,

Michael 'veremitz' Everitt.


--6EAMvkSd2Q7nnJ7v1l4tdhDdMpF7QbNMf--

--75UHcdeQOOPxFqp3dnLAi8mE6lHgsBTpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEApvNj3kNrz8X4ONuY+fGefTUMd0FAl5hjTkACgkQY+fGefTU
Md2aRBAAkcezNNkRWpb+zSb0xGAAK31j2w4mTERkLEm4+F8+OHrEz3qWn09fTM0d
VeP9WZ8mczLh6L7+rbEXg0P2WKdeI5nqITdFhnXMkc+rrmDtk/IxP5++YbDei0p+
joAIqwGFFGH/Z8MtXcPxEZ406Vwi0cFc6/1F/VXA/hNbQlQiSII+WlrkbScYFGK/
CmtHNkcj+xRqQKUjb7QYj5eHJ9e4lAGpnezSBKdaTzepTcOy250FrarRWIliYtcZ
DBP93GDPNAxTK29N+PmdXizX5/PcpyYCimN925hR2bMtSsEXWLJFeX8rkFD8UReH
tluRqetDOTRKOjeP6tOPd65CZkiFzR3M5EXWTbNZUEP7p8VMKtVPbM9RLY6aEGdv
so876TCXF4ZRxLheYO/Hjf3bbxVL495nYMFpanTsC4sYUEj8ucnTSggd8gl/Ao5J
xN9Q7b6qhy2CKPuqI2LbfNSHrE1VZuB65/wJzs+QTDgeC4HlHK7h3ZxQd4n7zy8M
i3k55aMTZgnbP8uk9mMaJP5G0ehzYvCOTx2WsBFFjdXlGXKV4MuuDJrcJvy3xRf1
of+JboZx5kAKTBbom1E+lsdJuDGNZB5M5EyKbcdp5nUWjYL1DL3KLsyLOhpk71hu
ojrozTyoFLx/PpO+DYRaYshDVRPl5IszTgF7DumjeNcglk7wH78=
=kViL
-----END PGP SIGNATURE-----

--75UHcdeQOOPxFqp3dnLAi8mE6lHgsBTpW--
