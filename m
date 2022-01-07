Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC16C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Jan 2022 02:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbiAGCPN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345311AbiAGCPK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jan 2022 21:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641521710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzgW/hMAkaYmE/PCpGJg/xJsF2e9MkiTeEf2jdbYL6Q=;
        b=TzT/WDT0eAQNAPJledVDV3mDR0quYc0aHknMIid+C/2/wN0ksVa9VcfKX6zkqrfHicTau0
        o3GdDxp/oCYKCEvU9+J7no05AfPBLj9+NYCsbiT0oVppsvPKdfQ50Q3lK/8/pCXRYOy34R
        apfUoyMkNaCETKt4ZyLsK2UwM9GS1zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-KoIaiob8O7mf4Zlk4lcPCA-1; Thu, 06 Jan 2022 21:15:07 -0500
X-MC-Unique: KoIaiob8O7mf4Zlk4lcPCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 542DB8042E2;
        Fri,  7 Jan 2022 02:15:05 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 486C599D6;
        Fri,  7 Jan 2022 02:15:04 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A17633C0025; Thu,  6 Jan 2022 23:15:02 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH RT 1/3] eventfd: Make signal recursion protection a task bit
Date:   Thu,  6 Jan 2022 23:15:00 -0300
Message-Id: <20220107021502.1121597-2-lgoncalv@redhat.com>
In-Reply-To: <20220107021502.1121597-1-lgoncalv@redhat.com>
References: <20220107021502.1121597-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v5.10.90-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit b542e383d8c005f06a131e2b40d5889b812f19c6

The recursion protection for eventfd_signal() is based on a per CPU
variable and relies on the !RT semantics of spin_lock_irqsave() for
protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
disables preemption nor interrupts which allows the spin lock held section
to be preempted. If the preempting task invokes eventfd_signal() as well,
then the recursion warning triggers.

Paolo suggested to protect the per CPU variable with a local lock, but
that's heavyweight and actually not necessary. The goal of this protection
is to prevent the task stack from overflowing, which can be achieved with a
per task recursion protection as well.

Replace the per CPU variable with a per task bit similar to other recursion
protection bits like task_struct::in_page_owner. This works on both !RT and
RT kernels and removes as a side effect the extra per CPU storage.

No functional change for !RT kernels.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/87wnp9idso.ffs@tglx
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/aio.c                |  2 +-
 fs/eventfd.c            | 12 +++++-------
 include/linux/eventfd.h | 11 +++++------
 include/linux/sched.h   |  4 ++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c72b2c51b446c..f7d47c9ff6deb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1761,7 +1761,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81dddf..9035ca60bfcf3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,8 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -67,21 +65,21 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * Deadlock or stack overflow issues can happen if we recurse here
 	 * through waitqueue wakeup handlers. If the caller users potentially
 	 * nested waitqueues with custom wakeup handlers, then it should
-	 * check eventfd_signal_count() before calling this function. If
-	 * it returns true, the eventfd_signal() call should be deferred to a
+	 * check eventfd_signal_allowed() before calling this function. If
+	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(current->in_eventfd_signal))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644dd..836b4c021a0a4 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -42,11 +43,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
 
 #else /* CONFIG_EVENTFD */
@@ -77,9 +76,9 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
 
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 409a24036952c..29e6ff1af1df9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -852,6 +852,10 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
-- 
2.33.1

