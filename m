From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/6] softirq: Export in_serving_softirq()
Date: Mon, 21 Nov 2011 16:44:21 -0500
Message-ID: <20111121214750.578132339@goodmis.org>
References: <20111121214420.124907956@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-softirq-Export-in_serving_softirq.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: John Kacur <jkacur@redhat.com>

ERROR: "in_serving_softirq" [net/sched/cls_cgroup.ko] undefined!

The above can be fixed by exporting in_serving_softirq

Link: http://lkml.kernel.org/r/1321235083-21756-2-git-send-email-jkacur@red=
hat.com

Cc: stable-rt@vger.kernel.org
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/softirq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index e8756aa..026a283 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -447,6 +447,7 @@ int in_serving_softirq(void)
 	preempt_enable();
 	return res;
 }
+EXPORT_SYMBOL(in_serving_softirq);
=20
 /*
  * Called with bh and local interrupts disabled. For full RT cpu must
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOyscGAAoJEIy3vGnGbaoAqxYP/1oCb+5ITLrCBpwzH6/o38yl
CZQ6IK/FB4dHxaDVGgbe+jlyJaMb6E5BRrd/z113DOtMBcTvgiOXMkXFWCPqOMRX
pLw4lKWkh2d84RVebl71WA76GDuLOpwDw6vhMOUwpssDR/rJHuztBbR4WGygCFUM
J9b29tad4jv96SQz6xlIlcvkKg7v4NaT6ZLQvEhIBHmy5CrGjVPlh5Wmuw3zOPe0
My4DzQjl6XmISlFFWzZ0lmWiURRWRNlpkxj7lMtZgF1ytZH0gWhDGBrf4XxS8Ch2
GU9T2fzbNzKnV+SOnfth44M56JlnEn7yy0YD9/ed8V9fXTIOIdihTTOb7kJyJeXX
I/JjMAgVrAZBWkM133yNRhfmYjyLvbjDuRhJsRXxmnuC60HoeWdFcLhaNoNWfIxB
FvOiElDAoeR8SZq0BP9L/MvvQ56QUpMUO6ASi2e6mJJ8vW7tPgkuhpo+ryi3kd78
X5dmzHnPHCV97hq8h1vYaknP0wwAWkHLivmP+A0+21OPvNhygFh5gkW3avNC/fN3
1AHghbUVXjqEEOKCbzlEyKNhdxaW6frGzc+F6JLC1Z2P/BwvT4j+xzAMIo/uOKMX
5XOAXG3RARkAhls5U2A9HYPMlvEorIZJSbnFNN510J7CSKJPzUtnE8Dpju10mAYO
/5UQWR4eMXrzmXuyc6HE
=57Al
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
