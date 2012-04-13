From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RT] rcu: Fix build break
Date: Fri, 13 Apr 2012 12:54:21 +0200
Message-ID: <1334314461-8937-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64125 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2DMKy0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 06:54:26 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A build break can occur with the following config options enabled

CONFIG_PREEMPT_RT_FULL
CONFIG_RCU_FAST_NO_HZ
CONFIG_RCU_CPU_STALL_INFO

This occurs because symbols in print_cpu_stall_fast_no_hz() such as
rcu_idle_gp_timer are not accessible with CONFIG_PREEMPT_RT_FULL
and results in the following type of build errors:

kernel/rcutree_plugin.h: In function =E2=80=98print_cpu_stall_fast_no_h=
z=E2=80=99:
kernel/rcutree_plugin.h:2195: error: =E2=80=98rcu_idle_gp_timer=E2=80=99=
 undeclared (first use in this function)

This patch fixes the build break by limiting the
to the function rcu_needs_cpu() instead of to the entire
!defined(CONFIG_RCU_FAST_NO_NZ) section

as was intended in the original rcu: Make ksoftirqd do RCU quiescent st=
ates
patch.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 kernel/rcutree_plugin.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 14acafc..2844d7d 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -1914,6 +1914,9 @@ int rcu_needs_cpu(int cpu)
 {
 	return rcu_cpu_has_callbacks(cpu);
 }
+#endif	/* !defined(CONFIG_RCU_FAST_NO_HZ) || defined(CONFIG_PREEMPT_RT=
_FULL) */
+
+#if !defined(CONFIG_RCU_FAST_NO_HZ)
=20
 /*
  * Because we do not have RCU_FAST_NO_HZ, don't bother initializing fo=
r it.
@@ -1984,6 +1987,7 @@ static DEFINE_PER_CPU(struct hrtimer, rcu_idle_gp=
_timer);
 static ktime_t rcu_idle_gp_wait;	/* If some non-lazy callbacks. */
 static ktime_t rcu_idle_lazy_gp_wait;	/* If only lazy callbacks. */
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Allow the CPU to enter dyntick-idle mode if either: (1) There are n=
o
  * callbacks on this CPU, (2) this CPU has not yet attempted to enter
@@ -2001,6 +2005,7 @@ int rcu_needs_cpu(int cpu)
 	/* Otherwise, RCU needs the CPU only if it recently tried and failed.=
 */
 	return per_cpu(rcu_dyntick_holdoff, cpu) =3D=3D jiffies;
 }
+#endif	/* #ifndef CONFIG_PREEMPT_RT_FULL */
=20
 /*
  * Does the specified flavor of RCU have non-lazy callbacks pending on
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
