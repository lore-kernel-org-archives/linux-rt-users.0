Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED1C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9E361165
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbhKIIkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 03:40:47 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbhKIIkq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 03:40:46 -0500
Received: from [192.168.6.149] ([212.159.46.162]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.115]) with ESMTPSA (Nemesis) id
 1M2wbS-1mjHFD3HWW-003P4T for <linux-rt-users@vger.kernel.org>; Tue, 09 Nov
 2021 09:37:59 +0100
Subject: Re: Questions to CI Testing the RT-Kernel
To:     linux-rt-users@vger.kernel.org
References: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
From:   Michael Everitt <gentoo@veremit.xyz>
Message-ID: <f654d361-af27-db92-e6be-6f519505b05d@veremit.xyz>
Date:   Tue, 9 Nov 2021 08:37:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AOITtQEaqkA9HysxzCHiYk1YDsqEWagwW"
X-Provags-ID: V03:K1:GDNfLxS4ku+O/KNIDq6KX7lDTXbh4edqg8O8ZXgU/UfxI2Fp5gm
 qgqpUfzSpHAsHm/2+9uIbsXTCiIOG1j6Imy4zkcUHsFrs2POzhTDMdytJku04yXPlYzVI/r
 dD0PhEul/584BzHpWB+6TqcePTzLT6TD/SXAH7a15svpDZXCMXdfkn9EK2V7JhkSyGqFcCl
 LSzwLZakboN++si1ZnTrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TvlvOcFeD18=:vGXbPw+akLt5Xw+15T5GA6
 XUps6aU/LQzi+bLWYP9zjJxr4GjOMNlcAMRiWzNNKoRB15WZypO5n+oScNKfNBHIPiVkRVytd
 9tk80aIeG0Jlom4ls9azjtqAQwQdb9Ojy1GpUcywb2sBb/Zd2espKaaIjkWxe3U2Cagf9KSaQ
 Z/Y1wvOXUCmx3s3/aGSQweHfkMphncJNC+0sV1FhUEXOlemrlupbfsnW/k4UkmnpI2JmBBOrv
 CVv3T5ISnBpi3MIFXgSy+YSwHQ2W9zhakg7wqby3PBDWha4zydDpCNBpcSEL6j6VLHZokYgdB
 0kuLnCiGlHBIubmDD1zfM7f6hKtEPhrAZillilv4vGmUJafR9l9Ye1AYkkc8gqQs7PCSZA6PB
 g88oQU9uMimWbq6JY8knACBS/SQqkZlQMnQqoTBcYSUJU9imZ8hvIYCHqna+Ew62DPpZ0/9PJ
 VzMfL8Okp6YyBluSuJc5BBX7kXyZu7XoYAxAyCpxM634HizLyVJslLmSEK+m/E8yad0e+FLXf
 7x4Bo+Fwb2Ei9tg1LIjOb1ITT0clZ6NIJCjU6zxRY94s61ciCzZ8O9xN5RVI7tUSlWVughWc2
 wOMAshksVC6kVSzeJ6tbf/sbAv5S+HL1WVvKRVf+9hjMlnEwHkC+SJXidoSSbt26lddyD4GFE
 rtPVhlXVFilUwENl4DEoVWVua94LcUUbK77XEqIZi4oFg1so7g43E/R9bTD0uz11DM0w=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AOITtQEaqkA9HysxzCHiYk1YDsqEWagwW
Content-Type: multipart/mixed; boundary="i66PP0pJuVifkEKrWwGfkhsZMVzoma1xL";
 protected-headers="v1"
From: Michael Everitt <gentoo@veremit.xyz>
To: linux-rt-users@vger.kernel.org
Message-ID: <f654d361-af27-db92-e6be-6f519505b05d@veremit.xyz>
Subject: Re: Questions to CI Testing the RT-Kernel
References: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
In-Reply-To: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>

--i66PP0pJuVifkEKrWwGfkhsZMVzoma1xL
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/11/2021 10:28, Gylstorff Quirin wrote:
> Dear all,
>=20
> we are currently looking to setup a test lab based on LAVA[1] for CI-te=
sting the
> RT-Kernel.
>=20
> Kernelci executes the combination cyclictest with hackbench in the back=
ground[2].
>=20
> Our questions are:
>=20
> From what I found the RT-Project also uses the combination of cyclictes=
t with
> hackbench for testing or are there currently any other tests specifical=
ly for
> real-time executed?
>=20
> Are there recommended tests that should be added to the CI testing of a=
 RT-Kernel?
>=20
> [1]: https://docs.lavasoftware.org/lava/index.html
> [2]:
> https://github.com/kernelci/kernelci-core/blob/main/config/lava/preempt=
-rt/preempt-rt.jinja2
>=20
>=20
Probably worthwhile contacting the KernelCI project
(https://foundation.kernelci.org/) who I see are quite active (I shadow t=
he IRC
channel as I know two members personally).

I believe they have a central 'dashboard' where you can submit your test =
results,
which may prove valuable to other users (either via KCIDB or other method=
s, see below).

https://foundation.kernelci.org/blog/2020/11/05/notes-from-oss-elc-europe=
-2020/ is
quite an interesting article on the roadmap of the project.


--i66PP0pJuVifkEKrWwGfkhsZMVzoma1xL--

--AOITtQEaqkA9HysxzCHiYk1YDsqEWagwW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEERR5DB4J2baXtk4AVu81GK0wzHTUFAmGKM2YFAwAAAAAACgkQu81GK0wzHTXm
YQ/7Bo8AJNC13P/OxefVoNYu41rsTlYLObuvC2tgb+BMaELpgAV4uxCZpsxijd8eub/PCJt34ByB
df0oTXQvIRQmFrQJkZcD/tLDYJsnnExpirJzXWDL9GjvyyczUa2tZrLUHVyQ0P+AHh1kWB6TxgGk
5CjPPFGkH5fUUzVy1SlK8Jv94ojRIT1uPjvYuzSlbbscUQ1H2IFzLih5xc9OeF7iQVQwXhAhRa/n
vFVkEvHIQun4EcGx4Fr25YIo9HZOxSblIoCr5LBtx8Gobud/yDZlcdsA3DE8nlsSolEqYz437uD7
+xhVAPMaFGItx0oCaGhhTn74b2d/Al2RMG5o4Y9I738EJO3G5AVPp94DEYo+VPn56eZmtNa3unba
CBwhRdWLRgbhcbSQC0C3QgUzc7wjsrDz6GmBenyg5ZMb5dleoRWepKTC3yOZLy0F5bHlqNQSMx7D
+2Kbb5IAXzz9EbiYqXCBnlHJApGlajP5V6EBGDm8GzkNxpYyYJj8ciuEewBS01Ka8th45UoN8P/Y
Q8c/1ruFFSqVxjMCF3a8zDGgNRBIB0xnygetg0b6g2o9sJ88Y0H2BzxIvDOyW43msrcbRXEyk1yG
hLSaeGdfy5m9zX1h0v82sVf0onDtRGltZ1YBJeJGJrEhGav3tqPFtXhzgO0ScONaNL0XHO/RBfZk
k2Y=
=awOG
-----END PGP SIGNATURE-----

--AOITtQEaqkA9HysxzCHiYk1YDsqEWagwW--
