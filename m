From: Clark Williams <williams@redhat.com>
Subject: [PATCH RT] rcutorture: comment out rcu_bh ops on PREEMPT_RT_FULL
Date: Fri, 26 Feb 2016 13:19:20 -0600
Message-ID: <20160226131920.66d9cf52@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/xg+PHeEn9DuoFPebPowxmKc"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56817 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcBZTUK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 14:20:10 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/xg+PHeEn9DuoFPebPowxmKc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


RT has dropped support of rcu_bh, comment out in rcutorture.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 kernel/rcu/rcutorture.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d89328e260df..5bb3364a6284 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -390,6 +390,7 @@ static struct rcu_torture_ops rcu_ops =3D {
 	.name		=3D "rcu"
 };
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Definitions for rcu_bh torture testing.
  */
@@ -429,6 +430,12 @@ static struct rcu_torture_ops rcu_bh_ops =3D {
 	.name		=3D "rcu_bh"
 };
=20
+#else
+static struct rcu_torture_ops rcu_bh_ops =3D {
+	.ttype		=3D INVALID_RCU_FLAVOR,
+};
+#endif
+
 /*
  * Don't even think about trying any of these in real life!!!
  * The names includes "busted", and they really means it!
--=20
2.5.0


--Sig_/xg+PHeEn9DuoFPebPowxmKc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJW0KU5AAoJEOI5asVwYXLrnmwQAKy34HJ3/h++jswo2uNeOriw
zRfk4IbOF1zljh636/vKdT4LrBv0n/M5YIRz8BGcaGhMLuDNAd5Qgoiq1EAOmf5Z
sS8rYtUQ6bqxUpzdPxgeYxsO/kUrPin6jhdtZ9qggtkaTT72zh/9catJSBMXu1VP
vglsJNbL1FxmCyWRA5gCDjKOfT7oHQWQ9R93Lf/jiyuX0NSZKGVhd9dKu3r1J2jz
5IDlUqLUZ1rC8NxJ7xRLktuTtA9fiMueVpiqEiCUbGnn6AmXP/rnGXOKfEX8nho0
0dzo0vw37la/YHwWMnIe8ZkGurREeQrElByqWrhGx8fX/ge69g1FB1s2e4wJWcSn
ymjtcjIKiFirYXBPckeImMt3yYRlvvLUM3rj+z6WLn480nYqXAkLQSDgndRk0FXE
XkrvY68reQH6WX+6DsYDdEF2iLR2Bkv/sbITLQg/Y10rNz56iBBRmeOaMFft9K94
NUUjnmM6laoecY8LIR+UBZBP8M+45vAOc+ZGblqNyUCnvVD3FcKXqj6jEHXdq96E
gqYj1Z1Q3h+uWk6e85TIUe6RrmdIyahEPixIHrVt5tnOUrBvDKcNfDsU2pSGkanK
t1hoP50una6HeQBDq02Nu0X9e3QFWsOByvvwBpGHXE4++V63UanJy8dpWlBEbbMU
bEGrHcXbwXENM/ZVbymn
=eG3j
-----END PGP SIGNATURE-----

--Sig_/xg+PHeEn9DuoFPebPowxmKc--
