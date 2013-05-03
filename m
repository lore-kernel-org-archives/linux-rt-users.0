From: Josh Cartwright <josh.cartwright@ni.com>
Subject: 3.2-rt build issue with CONFIG_DEBUG_ATOMIC_SLEEP
Date: Thu, 2 May 2013 22:30:20 -0500
Message-ID: <20130503033019.GB5011@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:56435 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab3ECECs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 00:02:48 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Steven-

It looks like commit 78563280521 ("sched: Check for idle task in
might_sleep()") in the v3.2-rt stable branch has a dependency on
is_idle_task() being defined, which doesn't exist in 3.2.

This causes build breakages with CONFIG_DEBUG_ATOMIC_SLEEP:

  kernel/sched.c: In function =E2=80=98__might_sleep=E2=80=99:
  kernel/sched.c:8942:7: error: implicit declaration of function =E2=80=98i=
s_idle_task=E2=80=99 [-Werror=3Dimplicit-function-declaration]

Fortunately, upstream commit c4f30608435 (shown below) is nice and
contained, and can be cherry-picked cleanly.

Thanks,

   Josh

--8<--
=46rom: "Paul E. McKenney" <paul.mckenney@linaro.org>
Subject: [PATCH] sched: Add is_idle_task() to handle invalidated uses of id=
le_cpu()

Commit 908a3283 (Fix idle_cpu()) invalidated some uses of idle_cpu(),
which used to say whether or not the CPU was running the idle task,
but now instead says whether or not the CPU is running the idle task
in the absence of pending wakeups.  Although this new implementation
gives a better answer to the question "is this CPU idle?", it also
invalidates other uses that were made of idle_cpu().

This commit therefore introduces a new is_idle_task() API member
that determines whether or not the specified task is one of the
idle tasks, allowing open-coded "->pid =3D=3D 0" sequences to be replaced
by something more meaningful.

Suggested-by: Josh Triplett <josh@joshtriplett.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/sched.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c4f3e9..4a7e4d3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2070,6 +2070,14 @@ extern int sched_setscheduler(struct task_struct *, =
int,
 extern int sched_setscheduler_nocheck(struct task_struct *, int,
 				      const struct sched_param *);
 extern struct task_struct *idle_task(int cpu);
+/**
+ * is_idle_task - is the specified task an idle task?
+ * @tsk: the task in question.
+ */
+static inline bool is_idle_task(struct task_struct *p)
+{
+	return p->pid =3D=3D 0;
+}
 extern struct task_struct *curr_task(int cpu);
 extern void set_curr_task(int cpu, struct task_struct *p);
=20
--=20
1.8.2.2

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgy9LAAoJEEef0niEbw+luNAP/1p4E4bTFH3lH2pXMyOnoBgT
/dTtVs6M+3SqjFYJC2OJjaoohUbgr2DgggLROq6a/4jSg+kOWx4xWCHZUiL3h4k1
wv7LDib1N+XuxrOrwXFZ7vI9xEtFo8THatZuxQrUCWywj35lOJXT0GZyJuTw5I7Q
QfCA5C9cFXJklGRKVndU4lCGojGhoJ7YO2y2BUkbn8u9RWAARxRRiDvhNmDNfSGU
gRoXbG3Lmp6+xng++w/w46870byL6Em7+x+i8DoH8RLZ8qOhEhO7Ll896/h9n/GZ
eletRK5aVMmi4jLrsq2piRh1CAzYaPlT/t4mXAYPiuuvQ5yRAMx0LNsTXJFKhI+s
/+XIEclejBi0YFomZDT65h4fKP38lfNx7iK21TA/0ji+LzStprz4rm6RjC1XvFWS
j4llbqtnz6mNw90evecMl4uPk00SfXjkgj1kvyKv2+DGPkM8LvbzfNJEsWxcKko5
6+L12boRD0oQgq3gmKpA+kbqNCJ5o/Py5Ju7jAvQuBIjmMH2QUCWHEFHq2MzZwpF
U0Oufp+zbRFXsgHruXCAMJHQem6bJ54xCXfIABXka5bGTaadi5/x4P83NCRgLlyC
5ZRgDDDsdKaG9OMUaYAz5QNT3CtArp6I4QR4/Bsbo88Sk2d9bilLntYY2SC1qR7G
thpsOcPxC+S6wRK4kS50
=6OYW
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
