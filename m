From: Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.4.1-rt6
Date: Mon, 15 Feb 2016 22:53:58 -0600
Message-ID: <20160215225358.135e9227@sluggy.hsv.redhat.com>
References: <20160212234708.GB7694@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/zUc3O0XLEhNcRVrs_dVNe/8"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160212234708.GB7694@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/zUc3O0XLEhNcRVrs_dVNe/8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Feb 2016 00:47:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> - There is a useless rcu_bh thread which has been deactivated.
>=20

For some strange reason I had RCU_TORTURE_TEST defined in my config. This c=
aused my compile to blow up because kernel/rcu/rcutorture.c wanted to test =
the (now ifdef'ed out) rcu_bh routines. This fixes the compile issue but is=
 untested for actually *running* rcutorture. I'll try that on a test box to=
morrow.=20

Clark

=46rom a835ff3aad772520d34548dc336925788a649b17 Mon Sep 17 00:00:00 2001
From: Clark Williams <williams@redhat.com>
Date: Mon, 15 Feb 2016 22:48:04 -0600
Subject: [PATCH] rcutorture: comment out rcu_bh ops on PREEMPT_RT_FULL

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


--Sig_/zUc3O0XLEhNcRVrs_dVNe/8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWwqtmAAoJEOI5asVwYXLrV7YQALahQmyJcEMVDKl1AHBnasp2
+n+upu9GCK48ZdYtOJ+gSgPPMislXwL5Q0vZ1lrENKhpnD3GxtpZrAuK64dO/YDf
38aLpfPsQacd4vpbl/KQ4Z0tHX5eqacBcKNaecd2zlF6eLdpCn2PY2G8x73YI60L
+I1tJ2OmxEMyYKl0vf+ppjcapaUQMtKfANA4IjmtVfOyVk4wuUobt9vYHnxruzUN
mOgeGLpQ+PeeKWI+MpQ+uNxtrKpfBKH4HACtszl9rs4FKlNQs5qgjcGxTDN1SE0A
4SKqK1t8wJarVbptsda0gECX/sUzqJiA7b7xmendJFMiOmy2M/+0opgb4w5ECu7/
JRpLUdrNg5Szaka12CCGLPQ0g07G2G/DW6dctufnYWNj1bNqvXPHtMxJe6sbeEt9
8ib3j8DJZAgc6GEek9pJgnE5uRhoWa9rn0qtiP1Rsj0Qev3ZD4ZcCNWZIM45tF0m
1FFtClIHfi4pdLEwLsCnaIlP9fe1i9tmCkhmdBrG/gJ2Tu+nx2nRnb6ffV8UMtmi
Ji0+p6s+vDXf+VZocPPAsUbOttV90YM/GTAT+3uwm0+JOJt879oekqwO5wh+31m5
5raTje11twgDwRr9oCvfdpi/LzByuR1/vqsmYCEedFJPfYu04B9HqZxtKzwgCKrv
b/VY+ZreD7SfoUHgi/ow
=uFva
-----END PGP SIGNATURE-----

--Sig_/zUc3O0XLEhNcRVrs_dVNe/8--
