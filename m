From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH] net: iptables: rework the fix of xt_info locking
Date: Wed, 2 Mar 2011 17:14:14 -0300
Message-ID: <20110302201414.GE8384@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57520 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936Ab1CBUOW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2011 15:14:22 -0500
Received: by qwd7 with SMTP id 7so325231qwd.19
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Mar 2011 12:14:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Maybe PREEMPT_NONE is not really what we want to check against, maybe i=
t is=20
RT_MUTEXES... anyway, this patch works fine as is in kernels with
PREEMPT_NONE, PREEMPT_DESKTOP, PREEMPT_VOLUNTARY and PREEMPT_RT set.

---

net: iptables: rework the fix of xt_info locking

Commit 5bbbedc from tip/rt/2.6.33 fixed an annoying locking issue on
PREEMPT_RT enabled kernels. I have observed a similar issue when testin=
g a
kernel with PREEMPT_DESKTOP enabled. My test kernels would boot fine an=
d as
soon as I tried to ssh into the test box I would see messages like this=
 one:

	BUG: %Ps exited with wrong preemption count!
	=3D> enter: 00000101, exit: 00000100.
	BUG: %Ps exited with wrong preemption count!
	=3D> enter: 00000101, exit: 00000100.
	BUG: %Ps exited with wrong preemption count!
	=3D> enter: 00000102, exit: 00000101.

And soon after a flood of backtraces such as:

	WARNING: at kernel/sched.c:5571 sub_preempt_count+0x68/0x87()

This patch extends the changes made to the PREEMPT_RT case to all of th=
e cases
where PREEMPT_NONE is not enabled.

Signed-off-by: Luis Claudio R. Gon=E7alves <lgoncalv@redhat.com>

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilt=
er/x_tables.h
index f85b72b..0b61a0f 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -439,7 +439,7 @@ extern void xt_free_table_info(struct xt_table_info=
 *info);
  *  necessary for reading the counters.
  */
 struct xt_info_lock {
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 	spinlock_t lock;
 #else
 	rwlock_t lock;
@@ -471,7 +471,7 @@ static inline int xt_info_rdlock_bh(void)
 	cpu =3D smp_processor_id();
 	lock =3D &per_cpu(xt_info_locks, cpu);
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 	if (likely(!--lock->readers))
 		spin_unlock(&lock->lock);
 #else
@@ -485,7 +485,7 @@ static inline void xt_info_rdunlock_bh(int cpu)
 {
 	struct xt_info_lock *lock =3D &per_cpu(xt_info_locks, cpu);
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 	if (likely(!--lock->readers)) {
 		preempt_enable_rt();
 		spin_unlock(&lock->lock);
@@ -504,7 +504,7 @@ static inline void xt_info_rdunlock_bh(int cpu)
  */
 static inline void xt_info_wrlock(unsigned int cpu)
 {
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 	spin_lock(&per_cpu(xt_info_locks, cpu).lock);
 #else
 	write_lock(&per_cpu(xt_info_locks, cpu).lock);
@@ -513,7 +513,7 @@ static inline void xt_info_wrlock(unsigned int cpu)
=20
 static inline void xt_info_wrunlock(unsigned int cpu)
 {
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 	spin_unlock(&per_cpu(xt_info_locks, cpu).lock);
 #else
 	write_unlock(&per_cpu(xt_info_locks, cpu).lock);
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 3eae9d9..546e6a1 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1184,7 +1184,7 @@ static int __init xt_init(void)
 	for_each_possible_cpu(i) {
 		struct xt_info_lock *lock =3D &per_cpu(xt_info_locks, i);
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_NONE
 		spin_lock_init(&lock->lock);
 #else
 		rwlock_init(&lock->lock);

--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
