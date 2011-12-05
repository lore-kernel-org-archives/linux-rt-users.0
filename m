From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/12 rc3] wait: Provide __wake_up_all_locked
Date: Mon, 05 Dec 2011 18:00:52 -0500
Message-ID: <20111205230258.031501328@goodmis.org>
References: <20111205230046.736851081@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-wait-Provide-__wake_up_all_locked.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>

For code which protects the waitqueue itself with another lock it
makes no sense to acquire the waitqueue lock for wakeup all. Provide
__wake_up_all_locked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/wait.h |    5 +++--
 kernel/sched.c       |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3efc9f3..1e904b8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -157,7 +157,7 @@ void __wake_up(wait_queue_head_t *q, unsigned int mode,=
 int nr, void *key);
 void __wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *k=
ey);
 void __wake_up_sync_key(wait_queue_head_t *q, unsigned int mode, int nr,
 			void *key);
-void __wake_up_locked(wait_queue_head_t *q, unsigned int mode);
+void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr);
 void __wake_up_bit(wait_queue_head_t *, void *, int);
 int __wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, int (*)(vo=
id *), unsigned);
@@ -170,7 +170,8 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 #define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
-#define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL)
+#define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
+#define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
=20
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, n=
r, NULL)
diff --git a/kernel/sched.c b/kernel/sched.c
index 640f740..63aeba0 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4642,9 +4642,9 @@ EXPORT_SYMBOL(__wake_up);
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t hel=
d.
  */
-void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
+void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
 {
-	__wake_up_common(q, mode, 1, 0, NULL);
+	__wake_up_common(q, mode, nr, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(__wake_up_locked);
=20
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO3U2iAAoJEIy3vGnGbaoAAyIQALaIi2U0gSNaRPFsUrmFHAZM
AbsXQBWq7l/KcLGYOH9Z7V1a5F500JaDnUSt65u9wj5iMLFHkwJR+v352VRMc/7k
iZ16UvXeuDL/ar+XF84u6DiJd9guOtSGRPcpMY01Tr8GH39pQhcM/NKvfFtugR0K
au2/TcMekMq/ndCSNP0Md5+yYr8+Pq37BldMU2Oma0dt/MAyqwfBzSCk2p6Sv6Mz
nokYSVh+oPLDWzwdGcd+/i2fxTtL6AjN9/5Xsh0SoTgfQ/+nsZHIpDJf8v6A0AYr
Z0hNV8e52XHBnLEC28ZVOdHVg0ieAgTnPMLvQoyZn8bltPry+ESSieA78J0lHWsz
SmkMHAHIswBfKoJ/fY2YMU5nDjIInaZ4vBcESnLKyL09tBMMTUrx2tJH0zZzuKkG
7cDr35sVxSvCSAJ7KXOeSP70u+J38qusN1iSfVHI0AKLHkIOHFflTq2NcJXQ2vRx
5Tqe8d0lU6Vn8QNogB/q47ayYKw1mAjHPV6+03JsvFeQ3ts2++2yy8Qz8VdRVjfS
qduHzBb3cc3B4UVT0ccT34e5q65ovXRyKWxqjuc1Tc8+/wM4kxbZznUJdFpDwj+k
5sjm1660nmLbDVdoHLFF/Y4oQDLvMuj9u6uQvdz8RRc8SYDtEuu7rN+bTfl/WGtg
rRstVki+d5hEk+09tJrq
=APCr
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
