From: Jonathon Fernyhough <jonathon@manjaro.org>
Subject: Security etc. status of -rt patches versus mainline
Date: Sun, 12 Nov 2017 15:32:02 +0000
Message-ID: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8RDoltiksISfqj3OlHbwPgXn3QpAcrLwm"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:56086 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdKLPwY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Nov 2017 10:52:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 27A6530C458C
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Nov 2017 16:32:09 +0100 (CET)
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6bGDiLTPwdfe for <linux-rt-users@vger.kernel.org>;
        Sun, 12 Nov 2017 16:32:07 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RDoltiksISfqj3OlHbwPgXn3QpAcrLwm
Content-Type: multipart/mixed; boundary="6EIEqBQi8eUJj84usDXAMVQmONhVfEAqe";
 protected-headers="v1"
From: Jonathon Fernyhough <jonathon@manjaro.org>
To: linux-rt-users@vger.kernel.org
Message-ID: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
Subject: Security etc. status of -rt patches versus mainline

--6EIEqBQi8eUJj84usDXAMVQmONhVfEAqe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi!

How do the -rt patches match up against mainline and any security fixes?
For example, mainline LTS 4.9 is version 4.9.61, but 4.9-rt is version
4.9.47.

Is mainline 4.9.47 with -rt37 secure (etc.), or should the 4.9.47-rt37
patch-set be applied against the latest mainline point-release?

Regards,

Jonathon


--6EIEqBQi8eUJj84usDXAMVQmONhVfEAqe--

--8RDoltiksISfqj3OlHbwPgXn3QpAcrLwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCAAzFiEEdsbkdwQr/phcwiC9nAiiVUQvr/AFAloIaXUVHGpvbmF0aG9u
QG1hbmphcm8ub3JnAAoJEJwIolVEL6/wj00QANAJrCXMnh92vV3L2Fong14bl5vI
ywysmG+67SKpw8eQKs1ouW2oyuPUJneUE5/tw10kbhrsaCqvboWZqe1kU6c40aMK
xBj2KEmPDcTarOQjSzc0ZDZy0f8VJIpOs/+UHdIGxdfXJwSVbz/IoZ5i/p3Mhz5Z
pNR8flLipSPkf9J+zoaLZVyVgTePtBmc4meOS4qlY+Gvc0HFzgbsWZUV4UqV2FeM
PexlQlxkQ5+r5Fbl7GRooqcumQ2uq9HANnoQ5NzzyMBS7a1SAId9gisVkK4pTWxe
B574d7eKalkw6Ea17x+3cOl+L6Ej40gT3e/ZMikusVZluxoHvIP/ac5atSf6pec9
Vk8S22AiOxTtj2uPpXWJkgOU4XWolY2m0GZ33ttGyH3fC/uisiTNsrGEUYmtLw7u
Zjkhd/MooVePWN5KcpR4MHY+5PGfu7CkW3JRdPQuCYcjYp+BK3iWZJsx5FYShSpX
6Rn+YJlKafQlS3pY3sldyq5tzHmuEx2A5+BAjP4oPFlo2JF3PUuu5yuGdopFdXUh
kZ5NAHrXnZj836rCOnnLlMve1J0Y3irVv1Tmg5t+6SsmU2YzwlVDRJezjRjF92D+
B1Thp1hnCeI28uOJ02jVh3MaUWv7PJC0wJhRVYj/OfCP9qbRmUel1I5FAK/b94u9
u/CR2U/WdAL5NwXk
=0kZO
-----END PGP SIGNATURE-----

--8RDoltiksISfqj3OlHbwPgXn3QpAcrLwm--
