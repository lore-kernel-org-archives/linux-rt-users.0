Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9998FC25B0E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbiHSJZG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348138AbiHSJY7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830BF2CB0;
        Fri, 19 Aug 2022 02:24:58 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB1MmC8vRIGx4fM6SJdhXc8tdXilOqI0p2EkymU4Lyk=;
        b=SDoy5OTd9Jw0M8TaCudqfLXGsIxLSWbcP82VisdRcGDFE9Q5RhzXxzQNvzN5Dx1Q3bmBrq
        LdF1gSzRHCqSE8mFMKS/Txt4zvp4/02B9or7SxED+kZBC4EfbKd8Rkh6F+aOJ7KG77CWkW
        kr5i77KkARLl2B41nysBfkzzNhzfJ1GBflArfMuEPsYrXO5Zf2AHl37Gdv5RLF5Y4Gg0uE
        8v+vMh+2RpGJF0DnukzyjztEx3lEc888cM2AXVw/b8TxjF+DUViCGvWtGdEHg7lQbqvfRi
        96pjqq7qSl9CVODYp/cJV/Il9vzj65jIx5zKAQfmcNX3rfdvhFFxloAJddwGDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB1MmC8vRIGx4fM6SJdhXc8tdXilOqI0p2EkymU4Lyk=;
        b=ZVAhDKqebxARhYfJ5TYPwLmJSB69R7y9QnMwPjh3s3rQ3JLpeRJbwugdz+1FhfgKuY+YSo
        If26LdKfIf+6r+CQ==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 7/9] rcu: Intrdroduce rcuwait.
Date:   Fri, 19 Aug 2022 11:24:44 +0200
Message-Id: <20220819092446.980320-8-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an all in one commit backporting rcuwait:
- update.c, rcuwait.h as of commit
   58d4292bd037b ("rcu: Uninline multi-use function: finish_rcuwait()")
- exit.c as of commit
   9d9a6ebfea329 ("rcuwait: Let rcuwait_wake_up() return whether or not a t=
ask was awoken")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rcuwait.h | 76 +++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c           | 30 ++++++++++++++++
 kernel/rcu/update.c     |  8 +++++
 3 files changed, 114 insertions(+)
 create mode 100644 include/linux/rcuwait.h

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
new file mode 100644
index 0000000000000..12a9d1ad01ccb
--- /dev/null
+++ b/include/linux/rcuwait.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RCUWAIT_H_
+#define _LINUX_RCUWAIT_H_
+
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+/*
+ * rcuwait provides a way of blocking and waking up a single
+ * task in an rcu-safe manner.
+ *
+ * The only time @task is non-nil is when a user is blocked (or
+ * checking if it needs to) on a condition, and reset as soon as we
+ * know that the condition has succeeded and are awoken.
+ */
+struct rcuwait {
+	struct task_struct __rcu *task;
+};
+
+#define __RCUWAIT_INITIALIZER(name)		\
+	{ .task =3D NULL, }
+
+static inline void rcuwait_init(struct rcuwait *w)
+{
+	w->task =3D NULL;
+}
+
+/*
+ * Note: this provides no serialization and, just as with waitqueues,
+ * requires care to estimate as to whether or not the wait is active.
+ */
+static inline int rcuwait_active(struct rcuwait *w)
+{
+	return !!rcu_access_pointer(w->task);
+}
+
+extern int rcuwait_wake_up(struct rcuwait *w);
+
+/*
+ * The caller is responsible for locking around rcuwait_wait_event(),
+ * and [prepare_to/finish]_rcuwait() such that writes to @task are
+ * properly serialized.
+ */
+
+static inline void prepare_to_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, current);
+}
+
+extern void finish_rcuwait(struct rcuwait *w);
+
+#define rcuwait_wait_event(w, condition, state)				\
+({									\
+	int __ret =3D 0;							\
+	prepare_to_rcuwait(w);						\
+	for (;;) {							\
+		/*							\
+		 * Implicit barrier (A) pairs with (B) in		\
+		 * rcuwait_wake_up().					\
+		 */							\
+		set_current_state(state);				\
+		if (condition)						\
+			break;						\
+									\
+		if (signal_pending_state(state, current)) {		\
+			__ret =3D -EINTR;					\
+			break;						\
+		}							\
+									\
+		schedule();						\
+	}								\
+	finish_rcuwait(w);						\
+	__ret;								\
+})
+
+#endif /* _LINUX_RCUWAIT_H_ */
diff --git a/kernel/exit.c b/kernel/exit.c
index 89e38e5929a9c..6cfbde6a83629 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -54,6 +54,7 @@
 #include <linux/writeback.h>
 #include <linux/shm.h>
 #include <linux/kcov.h>
+#include <linux/rcuwait.h>
=20
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -286,6 +287,35 @@ struct task_struct *try_get_task_struct(struct task_st=
ruct **ptask)
 	return task;
 }
=20
+int rcuwait_wake_up(struct rcuwait *w)
+{
+	int ret =3D 0;
+	struct task_struct *task;
+
+	rcu_read_lock();
+
+	/*
+	 * Order condition vs @task, such that everything prior to the load
+	 * of @task is visible. This is the condition as to why the user called
+	 * rcuwait_wake() in the first place. Pairs with set_current_state()
+	 * barrier (A) in rcuwait_wait_event().
+	 *
+	 *    WAIT                WAKE
+	 *    [S] tsk =3D current   [S] cond =3D true
+	 *        MB (A)              MB (B)
+	 *    [L] cond            [L] tsk
+	 */
+	smp_mb(); /* (B) */
+
+	task =3D rcu_dereference(w->task);
+	if (task)
+		ret =3D wake_up_process(task);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcuwait_wake_up);
+
 /*
  * Determine if a process group is "orphaned", according to the POSIX
  * definition in 2.2.2.52.  Orphaned process groups are not to be affected
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ee02e1e1b3e57..c4ffd7ead78e2 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -49,6 +49,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kthread.h>
 #include <linux/tick.h>
+#include <linux/rcuwait.h>
=20
 #define CREATE_TRACE_POINTS
=20
@@ -372,6 +373,13 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_fun=
c_t *crcu_array,
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
=20
+void finish_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, NULL);
+	__set_current_state(TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(finish_rcuwait);
+
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 void init_rcu_head(struct rcu_head *head)
 {
--=20
2.37.2

