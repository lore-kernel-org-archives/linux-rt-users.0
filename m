Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D15BC433E3
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804452071A
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhmrEX8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgFPQPW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:15:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731536AbgFPQPV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 12:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592324120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OSwNhDSV5TnYx18lF2uPYeEESZRwZ+/5UV+Q6Hpoaj0=;
        b=IhmrEX8+zXNuGd8Vjk2uCCtG5+xjY4txKJ4VdW7DgDgArE/iEdoU8v92HrSLS5247cXQmj
        wKeHoRY0Cr+Zf4yvRfWWZbWvDECCpYqGgjEb/L8HqaSGjEn2c0KCkU3zVUUisbHaQEFlpn
        9hiiMg8aq/yCLf+NYFPUjYFwMVnATdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-GmpTMiWkNaaMGfpg334g5w-1; Tue, 16 Jun 2020 12:15:17 -0400
X-MC-Unique: GmpTMiWkNaaMGfpg334g5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F2E835B92;
        Tue, 16 Jun 2020 16:15:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD579100164C;
        Tue, 16 Jun 2020 16:15:12 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B90C8412EF44; Tue, 16 Jun 2020 13:14:49 -0300 (-03)
Message-ID: <20200616161409.234799799@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 16 Jun 2020 13:11:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] rt: add local_lock_on and local_lock_irqsave_on to locallock.h
References: <20200616161149.392213902@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Re-add local_lock_on type functions to locallock.h (from the 5.4-RT 
tree).

To be used by remote page draining.

The original commit message is:

Introduce locallock. For !RT this maps to preempt_disable()/
local_irq_disable() so there is not much that changes. For RT this will
map to a spinlock. This makes preemption possible and locked "ressource"
gets the lockdep anotation it wouldn't have otherwise. The locks are
recursive for owner == current. Also, all locks user migrate_disable()
which ensures that the task is not migrated to another CPU while the lock
is held and the owner is preempted.

From: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/locallock.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux-rt-devel/include/linux/locallock.h
===================================================================
--- linux-rt-devel.orig/include/linux/locallock.h
+++ linux-rt-devel/include/linux/locallock.h
@@ -51,6 +51,9 @@ static inline void __local_lock(struct l
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_on(lvar, cpu)				\
+	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current && spin_trylock(&lv->lock)) {
@@ -92,6 +95,9 @@ static inline void __local_unlock(struct
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_on(lvar, cpu)                       \
+	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
@@ -104,6 +110,9 @@ static inline void __local_lock_irq(stru
 #define local_lock_irq(lvar)						\
 	do { __local_lock_irq(&get_local_var(lvar)); } while (0)
 
+#define local_lock_irq_on(lvar, cpu)					\
+	do { __local_lock_irq(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_unlock_irq(struct local_irq_lock *lv)
 {
 	LL_WARN(!lv->nestcnt);
@@ -119,6 +128,11 @@ static inline void __local_unlock_irq(st
 		put_local_var(lvar);					\
 	} while (0)
 
+#define local_unlock_irq_on(lvar, cpu)					\
+	do {								\
+		__local_unlock_irq(&per_cpu(lvar, cpu));		\
+	} while (0)
+
 static inline int __local_lock_irqsave(struct local_irq_lock *lv)
 {
 	if (lv->owner != current) {
@@ -137,6 +151,12 @@ static inline int __local_lock_irqsave(s
 		_flags = __this_cpu_read(lvar.flags);			\
 	} while (0)
 
+#define local_lock_irqsave_on(lvar, _flags, cpu)			\
+	do {								\
+		__local_lock_irqsave(&per_cpu(lvar, cpu));		\
+		_flags = per_cpu(lvar, cpu).flags;			\
+	} while (0)
+
 static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 					    unsigned long flags)
 {
@@ -156,6 +176,11 @@ static inline int __local_unlock_irqrest
 			put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_irqrestore_on(lvar, flags, cpu)			\
+	do {								\
+		__local_unlock_irqrestore(&per_cpu(lvar, cpu), flags);	\
+	} while (0)
+
 #define local_spin_trylock_irq(lvar, lock)				\
 	({								\
 		int __locked;						\


