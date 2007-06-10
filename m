From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.21.4-rt11
Date: Sun, 10 Jun 2007 16:41:26 +0200
Message-ID: <1181486486.384.18.camel@chaos>
References: <20070609210507.GA29194@elte.hu>
	 <loom.20070610T123332-722@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Oleksandr Natalenko <pfactum@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:58674 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751024AbXFJOl2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 10 Jun 2007 10:41:28 -0400
In-Reply-To: <loom.20070610T123332-722@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-06-10 at 10:34 +0000, Oleksandr Natalenko wrote:
> >     http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.4.tar.bz2
> >     http://people.redhat.com/mingo/realtime-preempt/patch-2.6.21.4-=
rt11
> kernel/built-in.o: In function `__schedule':
> (.sched.text+0xe0): undefined reference to `pick_next_task'
> make[1]: *** [.tmp_vmlinux1] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 1
> make[1]: Leaving directory `/usr/src/linux-2.6.21.4-rt11-cfs17-arseni=
c'
> make: *** [debian/stamp-build-kernel] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B0 2
>=20
> It seems that patch is broken.

Yup, for CONFIG_SMP=3Dn and for CONFIG_PREEMPT_RT=3Dn.

=46ix below

	tglx

Index: linux-2.6.21/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21.orig/kernel/sched.c	2007-06-10 16:00:58.000000000 +020=
0
+++ linux-2.6.21/kernel/sched.c	2007-06-10 16:46:23.000000000 +0200
@@ -827,6 +827,25 @@ unsigned long weighted_cpuload(const int
 	return cpu_rq(cpu)->raw_weighted_load;
 }
=20
+static inline struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev)
+{
+	struct sched_class *class =3D sched_class_highest;
+	u64 now =3D __rq_clock(rq);
+	struct task_struct *p;
+
+	prev->sched_class->put_prev_task(rq, prev, now);
+
+	do {
+		p =3D class->pick_next_task(rq, now);
+		if (p)
+			return p;
+		class =3D class->next;
+	} while (class);
+
+	return NULL;
+}
+
 #ifdef CONFIG_SMP
=20
 static inline void __set_task_cpu(struct task_struct *p, unsigned int =
cpu)
@@ -1093,25 +1112,6 @@ next_in_queue:
=20
 static int double_lock_balance(struct rq *this_rq, struct rq *busiest)=
;
=20
-static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev)
-{
-	struct sched_class *class =3D sched_class_highest;
-	u64 now =3D __rq_clock(rq);
-	struct task_struct *p;
-
-	prev->sched_class->put_prev_task(rq, prev, now);
-
-	do {
-		p =3D class->pick_next_task(rq, now);
-		if (p)
-			return p;
-		class =3D class->next;
-	} while (class);
-
-	return NULL;
-}
-
 /*
  * Pull RT tasks from other CPUs in the RT-overload
  * case. Interrupts are disabled, local rq is locked.
Index: linux-2.6.21/kernel/time/clockevents.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21.orig/kernel/time/clockevents.c	2007-06-10 16:00:57.000=
000000 +0200
+++ linux-2.6.21/kernel/time/clockevents.c	2007-06-10 16:45:40.00000000=
0 +0200
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/sysdev.h>
+#include <linux/sched.h>
=20
 /* The registered clock event devices */
 static LIST_HEAD(clockevent_devices);
