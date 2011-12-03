From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 05/10] wait: Provide __wake_up_all_locked
Date: Fri, 02 Dec 2011 20:46:46 -0500
Message-ID: <20111203014748.449667971@goodmis.org>
References: <20111203014641.165123482@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:60789 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab1LCBrw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Dec 2011 20:47:52 -0500
Content-Disposition: inline; filename=0005-wait-Provide-__wake_up_all_locked.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

iQIcBAABAgAGBQJO2X/EAAoJEIy3vGnGbaoANToQAM6YpDk0qA5eygKyZFfJ/Wdq
CkIvt5lkHKbI89Auur8mIXYdd3MW8qCahZnQNNbMe4Mmn6XFiLVE6q0B6WbmyFwl
KKbBV9zfsmsm6KKFtk37SLhRY4I6L/mAhpnq0P6+qDwroAm1pqGnYhvM4t43SVdX
S2lKFfw8usXiKrVqtqPFYx4jxbJMdypBC8IlzNWBB9vGXSndsfhnZz/8qnDPTOfS
QZ1Lc/FeS0mWJEfXYiBUN3NFmDSx99SGgRdBeeg8SmzOX5J7Xl2yS6EwOG6yooGk
AQltXNiz/hlgNhL6ZH97E927d6FdP89gTUqU4ODWeCnwgS0ebGJTI2f0Lq2wQgiG
ZCSfJoei+iNLmKEGzZUlsQTirEMigEpMgHY/EOW0kDS643e/92eclQQz791dyIpW
5JKTzd8xQWxUrTApphcw9Onq1XvNuTGjdGvFcIG3SY7o1Mr6UME+ut1mIqo3P7Ah
hG0UvWu0D+6C7BDYVctzlC3dWmLiKcJE0oUtkS2XDVNvub4EofF0ln/WN/GCW8Zz
X6ecLoP8r0X6ILlD9TknLr70wXqjtdCSi3lOyTTiKsdDUOSVOsOHNvHNqvvd5/DF
BFuG2b7H8mI3ZIwa7D7Lc9EF8NRygOTGBx0sN2hfLmbQNhst3UCr0g49tCkWlkl0
YE9o2Fs25mG4CbXUePFZ
=d3ud
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
