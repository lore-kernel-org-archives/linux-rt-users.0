From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: [PATCH] Fix Bug messages
Date: Wed, 30 Jul 2008 22:48:42 +0530
Message-ID: <20080730171842.GB3420@linux.vnet.ibm.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de> <200807301101.32417.j.mell@t-online.de>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Triplett <josht@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>
To: J?rgen Mell <j.mell@t-online.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7]:36067 "EHLO
	e28esmtp07.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752322AbYG3RSs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jul 2008 13:18:48 -0400
Content-Disposition: inline
In-Reply-To: <200807301101.32417.j.mell@t-online.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* J?rgen Mell <j.mell@t-online.de> [2008-07-30 11:01:32]:

> Hello Thomas,
>=20
> On Wednesday, 30. July 2008, Thomas Gleixner wrote:
> > We are pleased to announce the 2.6.26-rt1 tree, which can be
> > downloaded from the location:
>=20
> I have tried the new kernel and have some good news and some bad news=
:
>=20
> The good news: The machine boots and seems to run without major probl=
ems.
>=20
> The bad news: It produces continuously lots of bug messages in the er=
ror=20
> logs (cf. attached dmesg.tgz). The error at rtmutex.c:743 was already=
=20
> present in 2.6.25-rt* when ACPI was enabled. The 'using smp_processor=
_id=20
> ()  in preemptible code' is new here with 2.6.26.
>=20
> Machine is an old Athlon XP (single core) on an EPOX mainboard with V=
IA=20
> chipset.
>=20
> If I can help with testing, please let me know.
>=20
> Bye,
>          J=FCrgen
>=20
>=20
This patch should solve some of the bug messages.
It does two things:
1. Change rt_runtime_lock to be a raw spinlock as the comment above it
says: it is nested inside the rq lock.

2. Change mnt_writers to be a per_cpu locked variable.
This eliminates the need for the codepath to disable preemption and
then potentially sleep, leading to the BUG messages

Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>



Index: linux-2.6.26-rt1/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.26-rt1.orig/kernel/sched.c	2008-07-30 22:37:19.000000000 =
+0530
+++ linux-2.6.26-rt1/kernel/sched.c	2008-07-30 22:37:24.000000000 +0530
@@ -208,7 +208,7 @@
=20
 struct rt_bandwidth {
 	/* nests inside the rq lock: */
-	spinlock_t		rt_runtime_lock;
+	raw_spinlock_t		rt_runtime_lock;
 	ktime_t			rt_period;
 	u64			rt_runtime;
 	struct hrtimer		rt_period_timer;
@@ -472,7 +472,7 @@
 	u64 rt_time;
 	u64 rt_runtime;
 	/* Nests inside the rq lock: */
-	spinlock_t rt_runtime_lock;
+	raw_spinlock_t rt_runtime_lock;
=20
 #ifdef CONFIG_RT_GROUP_SCHED
 	unsigned long rt_nr_boosted;
Index: linux-2.6.26-rt1/fs/namespace.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.26-rt1.orig/fs/namespace.c	2008-07-30 22:39:30.000000000 =
+0530
+++ linux-2.6.26-rt1/fs/namespace.c	2008-07-30 22:39:36.000000000 +0530
@@ -178,13 +178,13 @@
 	unsigned long count;
 	struct vfsmount *mnt;
 } ____cacheline_aligned_in_smp;
-static DEFINE_PER_CPU(struct mnt_writer, mnt_writers);
+static DEFINE_PER_CPU_LOCKED(struct mnt_writer, mnt_writers);
=20
 static int __init init_mnt_writers(void)
 {
 	int cpu;
 	for_each_possible_cpu(cpu) {
-		struct mnt_writer *writer =3D &per_cpu(mnt_writers, cpu);
+		struct mnt_writer *writer =3D &per_cpu_var_locked(mnt_writers, cpu);
 		spin_lock_init(&writer->lock);
 		lockdep_set_class(&writer->lock, &writer->lock_class);
 		writer->count =3D 0;
@@ -199,7 +199,7 @@
 	struct mnt_writer *cpu_writer;
=20
 	for_each_possible_cpu(cpu) {
-		cpu_writer =3D &per_cpu(mnt_writers, cpu);
+		cpu_writer =3D &per_cpu_var_locked(mnt_writers, cpu);
 		spin_unlock(&cpu_writer->lock);
 	}
 }
@@ -251,8 +251,8 @@
 {
 	int ret =3D 0;
 	struct mnt_writer *cpu_writer;
-
-	cpu_writer =3D &get_cpu_var(mnt_writers);
+	int cpu =3D 0;
+	cpu_writer =3D &get_cpu_var_locked(mnt_writers, &cpu);
 	spin_lock(&cpu_writer->lock);
 	if (__mnt_is_readonly(mnt)) {
 		ret =3D -EROFS;
@@ -262,7 +262,7 @@
 	cpu_writer->count++;
 out:
 	spin_unlock(&cpu_writer->lock);
-	put_cpu_var(mnt_writers);
+	put_cpu_var_locked(mnt_writers, cpu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mnt_want_write);
@@ -273,7 +273,7 @@
 	struct mnt_writer *cpu_writer;
=20
 	for_each_possible_cpu(cpu) {
-		cpu_writer =3D &per_cpu(mnt_writers, cpu);
+		cpu_writer =3D &per_cpu_var_locked(mnt_writers, cpu);
 		spin_lock(&cpu_writer->lock);
 		__clear_mnt_count(cpu_writer);
 		cpu_writer->mnt =3D NULL;
@@ -332,8 +332,8 @@
 {
 	int must_check_underflow =3D 0;
 	struct mnt_writer *cpu_writer;
-
-	cpu_writer =3D &get_cpu_var(mnt_writers);
+	int cpu =3D 0;
+	cpu_writer =3D &get_cpu_var_locked(mnt_writers, &cpu);
 	spin_lock(&cpu_writer->lock);
=20
 	use_cpu_writer_for_mount(cpu_writer, mnt);
@@ -360,7 +360,7 @@
 	 * __mnt_writers can underflow.  Without it,
 	 * we could theoretically wrap __mnt_writers.
 	 */
-	put_cpu_var(mnt_writers);
+	put_cpu_var_locked(mnt_writers, cpu);
 }
 EXPORT_SYMBOL_GPL(mnt_drop_write);
=20
@@ -612,7 +612,7 @@
 	 * can come in.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct mnt_writer *cpu_writer =3D &per_cpu(mnt_writers, cpu);
+		struct mnt_writer *cpu_writer =3D &per_cpu_var_locked(mnt_writers, c=
pu);
 		if (cpu_writer->mnt !=3D mnt)
 			continue;
 		spin_lock(&cpu_writer->lock);


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
