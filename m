From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3.4-rt] hrtimer: fix compile failure for when HRT are disabled
Date: Thu, 28 Mar 2013 21:44:43 -0400
Message-ID: <1364521483-22071-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45307 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693Ab3C2BpA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Mar 2013 21:45:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With "# CONFIG_HIGH_RES_TIMERS is not set" in .config, one will see:

kernel/hrtimer.c: In function =E2=80=98__hrtimer_start_range_ns=E2=80=99=
:
kernel/hrtimer.c:1045:7: error: implicit declaration of function =E2=80=
=98hrtimer_rt_defer=E2=80=99 [-Werror=3Dimplicit-function-declaration]
kernel/hrtimer.c: At top level:
kernel/hrtimer.c:1416:12: error: static declaration of =E2=80=98hrtimer=
_rt_defer=E2=80=99 follows non-static declaration
kernel/hrtimer.c:1045:10: note: previous implicit declaration of =E2=80=
=98hrtimer_rt_defer=E2=80=99 was here
cc1: some warnings being treated as errors
make[2]: *** [kernel/hrtimer.o] Error 1

Move the prototype outside of the block of code which is conditional
on high res timers.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Not needed for 3.6-rt; 3.0-rt and 3.2-rt were not tested for this issu=
e.]

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 2328c04..1830c0f 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -625,7 +625,6 @@ static int hrtimer_reprogram(struct hrtimer *timer,
 }
=20
 static void __run_hrtimer(struct hrtimer *timer, ktime_t *now);
-static int hrtimer_rt_defer(struct hrtimer *timer);
=20
 /*
  * Initialize the high resolution related parts of cpu_base
@@ -740,6 +739,8 @@ static inline int hrtimer_reprogram(struct hrtimer =
*timer,
=20
 #endif /* CONFIG_HIGH_RES_TIMERS */
=20
+static int hrtimer_rt_defer(struct hrtimer *timer);
+
 /*
  * Clock realtime was set
  *
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
