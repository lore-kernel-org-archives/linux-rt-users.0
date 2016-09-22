From: Claudius Heine <ch@denx.de>
Subject: Re: Got stacktrace "irq 17: nobody cared" on Intel GalileoGen2 with
 4.6.7-rt13
Date: Thu, 22 Sep 2016 16:16:19 +0200
Message-ID: <1474553779.10922.87.camel@denx.de>
References: <1474532371.10922.50.camel@denx.de>
         <b8c6cd44-4a29-fe84-af0d-747584c04ad0@siemens.com>
         <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Fm9IfEuakHm1SH8J7vrN"
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42517 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756223AbcIVOQb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 10:16:31 -0400
In-Reply-To: <20160922134912.6ttkfpphn2ga4z22@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-Fm9IfEuakHm1SH8J7vrN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2016-09-22 at 15:49 +0200, Sebastian Andrzej Siewior wrote:
> On 2016-09-22 10:24:26 [+0200], Jan Kiszka wrote:
> >=20
> > One theory I was thinking about: Could - for whatever reason -
> > disabling
> > of the interrupt line from the primary handler be broken / work
> > unreliably and cause this storm?
>=20
> It seems so. If you look at the complete boot log then the core code
> attempts multiple times to disable IRQ #17 with zero success.
> I would assume that booting an unpatched kernel with the threadirqs
> option would give the same result.

Thanks for your help, but I am sorry to disappoint:

Full bootlog:=C2=A0http://pastebin.com/8dHz0LLq
Kernel config:=C2=A0http://pastebin.com/itPLjpjS
ps:=C2=A0http://pastebin.com/D4N0DXae

Claudius

--=20
DENX Software Engineering GmbH,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Managing Dire=
ctor: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email:=C2=A0ch@denx.de
--=-Fm9IfEuakHm1SH8J7vrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX4+ezAAoJEBFzyxmYCLFTN+QP/AxrSbqzxatmnAFy5qiJRbjR
mjZqaRdf6XJzIVFZPjtw1+ihNcSC48WM9ean6y3SzFlYsVOhA5I4qBYWtJkz6JPn
OL7sdvz6hKVOGZhW57aioViO/z5GGvjaTg/vhB/SPYL+wraXGnQsTiXjXbQBOjW6
mSp0ZJrK4/e6PY0Rc4ZHzNZ2BzMD9LQT2rv9KDxwPq/fUNGgGTcR5whA0Oy0IuTM
EfBIWlDiPu7pvzIkDhOICsZqopG31mEdHeYsS3Nyd/FhRQII93dsBDB3KVroYYC8
VdrfzMbVUKqRvt1UF1bWvrAXxq2yiCaob1W9cgMwkoED4/vPhnfH6c0Tkolwqxo6
DGD5xeERK8XBul1YBgHMpJTZGrhqygiyyrrnGGd+5yFwvkPZYPibg+Zcz9MFeCo3
L8A+m/3LczUTFAi/oaCatT82JG5y0yshxL+LKuRPSpILt1zvM5AQywgerA5YyJdT
+djdcW0pAWuBV6wXQr/ktpwqjAuCiRl8eztYJDBpbezQ2PtvGE1pZM4Xsji4EjTa
6nOwneYsngwbXb1sYR4hC2iMmekPV2CGfQBHgUCWt4b241OaEsWxtlp/jU6D7eTk
y5AkIh4yZIzZ8DY9/OEgYaiRWWU6PXp/vd27zRDsGVCB5/Nm8UlNdcVq7AdkI36q
8ISkFs28vnzSoqblB9ig
=cA5U
-----END PGP SIGNATURE-----

--=-Fm9IfEuakHm1SH8J7vrN--

