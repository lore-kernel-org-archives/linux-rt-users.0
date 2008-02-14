From: Shi Weihua <shiwh@cn.fujitsu.com>
Subject: [PATCH 2.6.24-rt1] timer:fix build warning in timer.c
Date: Thu, 14 Feb 2008 18:02:14 +0800
Message-ID: <47B411A6.9030007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, khilman@mvista.com,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61098 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758082AbYBNKED (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Feb 2008 05:04:03 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46ix the following compile warning without CONFIG_PREEMPT_RT:
kernel/timer.c:937: warning: =E2=80=98count_active_rt_tasks=E2=80=99 de=
fined but not used

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>=20

---
diff -urpN linux-2.6.24-rt1.orig/kernel/timer.c linux-2.6.24-rt1/kernel=
/timer.c
--- linux-2.6.24-rt1.orig/kernel/timer.c	2008-02-14 17:01:49.000000000 =
+0800
+++ linux-2.6.24-rt1/kernel/timer.c	2008-02-14 17:31:10.000000000 +0800
@@ -930,20 +930,18 @@ static unsigned long count_active_tasks(
 #endif
 }
=20
+#ifdef CONFIG_PREEMPT_RT
 /*
  * Nr of active tasks - counted in fixed-point numbers
  */
 static unsigned long count_active_rt_tasks(void)
 {
-#ifdef CONFIG_PREEMPT_RT
 	extern unsigned long rt_nr_running(void);
 	extern unsigned long rt_nr_uninterruptible(void);
=20
 	return (rt_nr_running() + rt_nr_uninterruptible()) * FIXED_1;
-#else
-	return 0;
-#endif
 }
+#endif
=20
 /*
  * Hmm.. Changed this, as the GNU make sources (load.c) seems to
