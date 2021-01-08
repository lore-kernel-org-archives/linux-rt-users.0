Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C80C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D090D23A9B
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 19:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbhAHTbn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:31:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbhAHTbm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 14:31:42 -0500
Date:   Fri, 8 Jan 2021 20:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610134259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CJub4RA2jnxbn5q3A5lvk9VilZhDnmhVEgX5vaVtob8=;
        b=FeKS8mHXbXyPv/E+IkyVTpfIN5QQW/2HalZB8h7wZ2UaEXdg8lXciRFn9SpdB1yZip7cwC
        WHBm1wrCQtJKUgOdxjX7OHbAX4fVL8WP5Hin3Db/OuzZjf9TU9Euc7k/JnJHxzYtsB5cNG
        woRtOHRbXCDvk4OZEnekg8ogu2hEWtbR5Or0Nz4pIDqSs1D7ICXdVp2zj3v3782z51zOLb
        rPStKvYksf6b4/cDp9w9dm7wX0dAAIlBWBTUnsF2R34uzrzGK/ntcSj1iN5Lm4YZF/pJVq
        zNC2u8vE6WI0PfdKHNDu6QTGiAFvt2B0fFk6oYiypQ206/aJ3cXVX0PVxIIVAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610134259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CJub4RA2jnxbn5q3A5lvk9VilZhDnmhVEgX5vaVtob8=;
        b=UVj5aaQCv/dwhXsYQWRPt+WPuwenudDBDI2E30E2yA7zxgKXNmbBLEQPbRRevXTy7KdnA9
        cYsqsDos/uUw3YAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.4-rt22
Message-ID: <20210108193057.nt7og4urkbzkp7bx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.4-rt22 patch set. 

Changes since v5.10.4-rt21:

  - Avoid "set but not used" warnings in the irq-off tracer.

  - The local-lock patch for powerpc64/pseries/iommu didn't get update
    and failed to compile.

  - Powerpc64/pseries didn't compile due to recursive header include.

Known issues
     - None.

The delta patch against v5.10.4-rt21 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.4-rt21-rt22.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.4-rt22

The RT patch against v5.10.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.4-rt22.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.4-rt22.tar.xz

Sebastian

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index cf091c4c22e53..7371f7e23c357 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -5,7 +5,7 @@
 #ifdef __KERNEL__
 #include <linux/compiler.h>
 #include <asm/synch.h>
-#include <linux/bug.h>
+#include <linux/bits.h>
 
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/include/asm/simple_spinlock_types.h
index 0f3cdd8faa959..d45561e9e6bab 100644
--- a/arch/powerpc/include/asm/simple_spinlock_types.h
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__LINUX_RT_MUTEX_H)
 # error "please don't include this file directly"
 #endif
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 30441ffef5e7b..62bd38cd80d19 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -191,8 +191,13 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
 	return ret;
 }
 
-static DEFINE_PER_CPU(__be64 *, tce_page);
-static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
+struct tce_page {
+	__be64 * page;
+	local_lock_t lock;
+};
+static DEFINE_PER_CPU(struct tce_page, tce_page) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -215,9 +220,9 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	}
 
 	/* to protect tcep and the page behind it */
-	local_lock_irqsave(tcp_page_lock, flags);
+	local_lock_irqsave(&tce_page.lock, flags);
 
-	tcep = __this_cpu_read(tce_page);
+	tcep = __this_cpu_read(tce_page.page);
 
 	/* This is safe to do since interrupts are off when we're called
 	 * from iommu_alloc{,_sg}()
@@ -226,12 +231,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_unlock_irqrestore(tcp_page_lock, flags);
+			local_unlock_irqrestore(&tce_page.lock, flags);
 			return tce_build_pSeriesLP(tbl->it_index, tcenum,
 					tbl->it_page_shift,
 					npages, uaddr, direction, attrs);
 		}
-		__this_cpu_write(tce_page, tcep);
+		__this_cpu_write(tce_page.page, tcep);
 	}
 
 	rpn = __pa(uaddr) >> TCE_SHIFT;
@@ -261,7 +266,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_unlock_irqrestore(tcp_page_lock, flags);
+	local_unlock_irqrestore(&tce_page.lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -433,16 +438,16 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	}
 
 	/* to protect tcep and the page behind it */
-	local_lock_irq(tcp_page_lock);
-	tcep = __this_cpu_read(tce_page);
+	local_lock_irq(&tce_page.lock);
+	tcep = __this_cpu_read(tce_page.page);
 
 	if (!tcep) {
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
-			local_unlock_irq(tcp_page_lock);
+			local_unlock_irq(&tce_page.lock);
 			return -ENOMEM;
 		}
-		__this_cpu_write(tce_page, tcep);
+		__this_cpu_write(tce_page.page, tcep);
 	}
 
 	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
@@ -485,7 +490,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_unlock_irq(tcp_page_lock);
+	local_unlock_irq(&tce_page.lock);
 	return rc;
 }
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 95736a3bf2860..94219730dda2b 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -436,9 +436,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 /* start and stop critical timings used to for stoppage (in idle) */
 void start_critical_timings(void)
 {
-	int pc = preempt_count();
-
-	if (preempt_trace(pc) || irq_trace())
+	if (preempt_trace(preempt_count()) || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
@@ -446,9 +444,7 @@ NOKPROBE_SYMBOL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	int pc = preempt_count();
-
-	if (preempt_trace(pc) || irq_trace())
+	if (preempt_trace(preempt_count()) || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
@@ -607,18 +603,14 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
  */
 void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	unsigned int pc = preempt_count();
-
-	if (!preempt_trace(pc) && irq_trace())
+	if (!preempt_trace(preempt_count()) && irq_trace())
 		stop_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_on);
 
 void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
-	unsigned int pc = preempt_count();
-
-	if (!preempt_trace(pc) && irq_trace())
+	if (!preempt_trace(preempt_count()) && irq_trace())
 		start_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_off);
@@ -659,17 +651,13 @@ static struct tracer irqsoff_tracer __read_mostly =
 #ifdef CONFIG_PREEMPT_TRACER
 void tracer_preempt_on(unsigned long a0, unsigned long a1)
 {
-	int pc = preempt_count();
-
-	if (preempt_trace(pc) && !irq_trace())
+	if (preempt_trace(preempt_count()) && !irq_trace())
 		stop_critical_timing(a0, a1);
 }
 
 void tracer_preempt_off(unsigned long a0, unsigned long a1)
 {
-	int pc = preempt_count();
-
-	if (preempt_trace(pc) && !irq_trace())
+	if (preempt_trace(preempt_count()) && !irq_trace())
 		start_critical_timing(a0, a1);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 6c6cde1c29e3d..c29508d21914d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt21
+-rt22
