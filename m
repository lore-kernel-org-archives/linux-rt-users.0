Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23650C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 16:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbhKXQPn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbhKXQPm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 11:15:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC97C06173E;
        Wed, 24 Nov 2021 08:12:32 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKN/L/evIH8pd44wrAVkgZq5sxjgxZoyOnlYnKYCCYA=;
        b=XZ7EF4CRFiIZI2UeAAq6e6x9phusLKk0W96gOl54egnHzSTtJo/eYHwrnCVyiFKIzKS92l
        gZ3L4FOB1VlqJiclj+p0QRPMgbignWTxzRq9MYXyU8YF+TMAjIQGMU74SxZkshdxNqTuto
        bbX0c0UFJGAyz84WORE/ClVtli7IoGQjlpulVat9Z27gDeLeT+j/dlAIIOgScyAezy3uLl
        XpMGD28tsC6qQy8Wsl5IGDpiQRMclFtksm7zMz1D3jp3e4EyI+fpDMuLEhUwkE2veX/SUn
        MdKYMu772U/IdxBgIPeaOkB+6DWd5+YszdCfEW3UXIy7ssg5lfrcjhTq/HmvWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKN/L/evIH8pd44wrAVkgZq5sxjgxZoyOnlYnKYCCYA=;
        b=A7QUA7jAaDw25sXaRqIOJCr6IScUGaPwQT/lHRZY3Jjmh6A7DddmV/WPtGo8dIeEMH/ce7
        wQqLwjKVEvfyfgBw==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        bigeasy@linutronix.de
Subject: [PATCH RT 1/3] irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
Date:   Wed, 24 Nov 2021 17:12:19 +0100
Message-Id: <20211124161221.2224005-2-bigeasy@linutronix.de>
In-Reply-To: <20211124161221.2224005-1-bigeasy@linutronix.de>
References: <20211123103755.12d4b776@gandalf.local.home>
 <20211124161221.2224005-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

irq_work() triggers instantly an interrupt if supported by the
architecture. Otherwise the work will be processed on the next timer
tick. In worst case irq_work_sync() could spin up to a jiffy.

irq_work_sync() is usually used in tear down context which is fully
preemptible. Based on review irq_work_sync() is invoked from preemptible
context and there is one waiter at a time. This qualifies it to use
rcuwait for synchronisation.

Let irq_work_sync() synchronize with rcuwait if the architecture
processes irqwork via the timer tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-3-bigeasy@linutronix=
.de
---
 include/linux/irq_work.h | 10 +++++++++-
 kernel/irq_work.c        | 10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f941f2d7d71ce..3c6d3a96bca0f 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
=20
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
=20
 /*
  * An entry can be in one of four states:
@@ -22,6 +23,7 @@ struct irq_work {
 		};
 	};
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
=20
 static inline
@@ -29,13 +31,19 @@ void init_irq_work(struct irq_work *work, void (*func)(=
struct irq_work *))
 {
 	atomic_set(&work->flags, 0);
 	work->func =3D func;
+	rcuwait_init(&work->irqwait);
 }
=20
 #define DEFINE_IRQ_WORK(name, _f) struct irq_work name =3D {	\
 		.flags =3D ATOMIC_INIT(0),			\
-		.func  =3D (_f)					\
+		.func  =3D (_f),					\
+		.irqwait =3D __RCUWAIT_INITIALIZER(irqwait),	\
 }
=20
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
+}
=20
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 8183d30e1bb1c..8969aff790e21 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -165,6 +165,9 @@ void irq_work_single(void *arg)
 	 */
 	flags &=3D ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if (!arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
=20
 static void irq_work_run_list(struct llist_head *list)
@@ -231,6 +234,13 @@ void irq_work_tick_soft(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if (!arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
=20
 	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
 		cpu_relax();
--=20
2.34.0

