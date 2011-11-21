From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/6] rcu: Fix macro substitution for synchronize_rcu_bh() on RT
Date: Mon, 21 Nov 2011 16:44:22 -0500
Message-ID: <20111121214752.916778529@goodmis.org>
References: <20111121214420.124907956@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-rcu-Fix-macro-substitution-for-synchronize_rcu_bh-on.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: John Kacur <jkacur@redhat.com>

kernel/rcutorture.c:492: error: =E2=80=98synchronize_rcu_bh=E2=80=99 undecl=
ared here (not in a function)

synchronize_rcu_bh() is not just called as a normal function, but can
also be referenced as a function pointer. When CONFIG_PREEMPT_RT_FULL
is enabled, synchronize_rcu_bh() is defined as synchronize_rcu(), but
needs to be defined without the parenthesis because the compiler will
complain when synchronize_rcu_bh is referenced as a function pointer
and not a function.

Link: http://lkml.kernel.org/r/1321235083-21756-1-git-send-email-jkacur@red=
hat.com

Cc: stable-rt@vger.kernel.org
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/rcutree.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7a25aea..3bf47dc 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -60,7 +60,7 @@ static inline void exit_rcu(void)
 #ifndef CONFIG_PREEMPT_RT_FULL
 extern void synchronize_rcu_bh(void);
 #else
-# define synchronize_rcu_bh()	synchronize_rcu()
+# define synchronize_rcu_bh	synchronize_rcu
 #endif
 extern void synchronize_sched_expedited(void);
 extern void synchronize_rcu_expedited(void);
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOyscJAAoJEIy3vGnGbaoAl7AP/3IdHRkPQfwow35ViDmFSdv1
UqJE6HEEN2K4IjJNlwwdYkTc4l/16m3Yqd7C2m2+ahXc4A+6SFhI0Kxjcr6PEgxc
Ena7oGItiALeW5QP7uH/EmDtlhaO6f89W3HnGii3+DTzSPdS0gcs94lR+08l5hFj
qHXzcPytsWSA4P1ZHdWEa6A3WMqZaeQlHmr5x9p+LKvdSNKtuPSCgeomaEIu7fGe
lerUxipSOcQnaWc/0bbB/a54nqdR2mWXMkGQcxCy8EKWZyi/djbJBtPGcbkuz/LO
b72tqVFc5kdqBDhZE6hyeJU0x85HwHcMju9lHqxIrYd6Js7jk6tFIDRdqj/MpCv1
XdLoAXMq7kAkDBLckEs8rY4mxJgzaTph49hP4nNz1daFDojAUHVE4g44IxG7cdiF
N/PrwPEf2Tr6pxB5/CylJ29qBcEdrl3i0X/ER39X+d1fM2JXGR1WOlPG8H+B9CWY
rNS3OUysvnfJXf9O2uWYd9ADlzVwRpQQzlbKjPYtF3ycOo8iENCN4xJOkifLueWS
QpZhBVdp8ERIBuyGZZ3MPYL1B7H++tTOE57yzbz522Dqk7e81jVHqBY3HSugoAST
HYoNVMMMnQgjqD4m7jAtxpV1oW02KQfD1n2NVUOQ8U5Zo46FnFqjRqzjke9ErVB/
iZyIAV+Fb0nQ5rQgZfop
=bil1
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
