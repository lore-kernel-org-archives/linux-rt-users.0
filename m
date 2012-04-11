From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rcutree: Fix v3.4-rc2-rt2 build break
Date: Wed, 11 Apr 2012 16:42:59 +0200
Message-ID: <1334155379-18088-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab2DKOnV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Apr 2012 10:43:21 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46ix build break of the following types.

linux-rt/kernel/rcutree_plugin.h: In function =E2=80=98print_cpu_stall_=
fast_no_hz=E2=80=99:
linux-rt/kernel/rcutree_plugin.h:2195: error: =E2=80=98rcu_idle_gp_time=
r=E2=80=99 undeclared (first use in this function)
linux-rt/kernel/rcutree_plugin.h:2195: error: (Each undeclared identifi=
er is reported only once
linux-rt/kernel/rcutree_plugin.h:2195: error: for each function it appe=
ars in.)

The build break only occurs with the PREEMPT_RT_FULL patch applied, how=
ever
the patch is meant to go upstream and be applied to v3.4-rc2 as well be=
cause
it makes the code more legible there, and will reduce the number of pla=
ces
where #ifdef PREEMPT_RT_FULL is required should that go upstream someda=
y.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 kernel/rcutree_plugin.h |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 14acafc..1db9471 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -1938,6 +1938,12 @@ static void rcu_prepare_for_idle(int cpu)
 {
 }
=20
+#ifdef CONFIG_RCU_CPU_STALL_INFO
+static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
+{
+}
+#endif /* #ifdef CONFIG_RCU_CPU_STALL_INFO */
+
 #else /* #if !defined(CONFIG_RCU_FAST_NO_HZ) */
=20
 /*
@@ -2184,12 +2190,8 @@ static void rcu_prepare_for_idle(int cpu)
 		trace_rcu_prep_idle("Callbacks drained");
 }
=20
-#endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
=20
 #ifdef CONFIG_RCU_CPU_STALL_INFO
-
-#ifdef CONFIG_RCU_FAST_NO_HZ
-
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
 	struct hrtimer *hrtp =3D &per_cpu(rcu_idle_gp_timer, cpu);
@@ -2201,14 +2203,11 @@ static void print_cpu_stall_fast_no_hz(char *cp=
, int cpu)
 			? ktime_to_us(hrtimer_get_remaining(hrtp))
 			: -1);
 }
+#endif /* #ifdef CONFIG_RCU_CPU_STALL_INFO */
=20
-#else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
