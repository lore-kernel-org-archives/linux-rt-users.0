From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH -rt] harirq.h: Define softirq_count() as OUL to kill build
 warning
Date: Thu, 13 Oct 2011 17:19:09 +0800
Message-ID: <20111013091909.GA32739@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58649 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1JMJTV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Oct 2011 05:19:21 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kernel/lockdep.c: In function =E2=80=98print_bad_irq_dependency=E2=80=99=
:
kernel/lockdep.c:1476:3: warning: format =E2=80=98%lu=E2=80=99 expects =
type =E2=80=98long unsigned int=E2=80=99, but argument 7 has type =E2=80=
=98unsigned int=E2=80=99
kernel/lockdep.c: In function =E2=80=98print_usage_bug=E2=80=99:
kernel/lockdep.c:2193:3: warning: format =E2=80=98%lu=E2=80=99 expects =
type =E2=80=98long unsigned int=E2=80=99, but argument 7 has type =E2=80=
=98unsigned int=E2=80=99

kernel/lockdep.i show this:
 printk("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n"=
,
  curr->comm, task_pid_nr(curr),
  curr->hardirq_context, ((current_thread_info()->preempt_count) & (((1=
UL << (10))-1) << ((0 + 8) + 8))) >> ((0 + 8) + 8),
  curr->softirq_context, (0U) >> (0 + 8),
  curr->hardirqs_enabled,
  curr->softirqs_enabled);

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 include/linux/hardirq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index a3892c2..2711055 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -84,7 +84,7 @@
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 # define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
 #else
-# define softirq_count()	(0U)
+# define softirq_count()	(0UL)
 extern int in_serving_softirq(void);
 #endif
=20
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
