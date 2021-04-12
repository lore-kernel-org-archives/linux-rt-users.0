Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7FC433B4
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103F86135C
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhDLVrV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:47:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhDLVrU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Apr 2021 17:47:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618264020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3ghyb2W8BLIZ05yGXW2dF3hyTFm2kpNfuX26M7+CeU=;
        b=0JND/f36w2AlnIm7iCrU9za65squcC+wrt1Q3PvUa6fd/cgtTG6U+dk5ATJq2PwANl5VU0
        nCRl1q4YyzBri2+HCWXlYHhS7Ow9z1OobM6ynvLMup6SS6i0Icg4I8/BFmE5uNBH/xY5eH
        l5GyYhl7/i2Mswr/70UimbZgyBB5qnlcoEFW1MFS1KSk39tlHH2ILhSM5bsjC7uxzr2X0p
        EMgE1XQprhYKLymJqLHI4JNLbBwvLqLDlV/LMDNjgg6YpcabDdnobIcgIxnq4M9Uj2BhpW
        e4aGx6QWPmGXSr6ICJr1+B3KJSvQlGF4kW+oo6AoCImjMSR9jcN6ewKfszb0Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618264020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3ghyb2W8BLIZ05yGXW2dF3hyTFm2kpNfuX26M7+CeU=;
        b=rcxiLqbVMct+y7fFhu/BCqI6vDfyqvCDbScwZAws9tJ0530I3iXq+ap64VCpHHWyCDnewO
        M0+6US2qb8rZYBCQ==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 02/11] mm/page_alloc: Convert per-cpu list protection to local_lock
In-Reply-To: <20210412115612.GX3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net> <20210407202423.16022-3-mgorman@techsingularity.net> <YG7gV7yAEEjOcQZY@hirez.programming.kicks-ass.net> <20210408174244.GG3697@techsingularity.net> <YG/2scd9ADdrIyCM@hirez.programming.kicks-ass.net> <20210409075939.GJ3697@techsingularity.net> <YHAPOKPTgJcLuDJl@hirez.programming.kicks-ass.net> <20210409133256.GN3697@techsingularity.net> <YHCjK8OOhmxTbKu0@hirez.programming.kicks-ass.net> <20210412115612.GX3697@techsingularity.net>
Date:   Mon, 12 Apr 2021 23:47:00 +0200
Message-ID: <87lf9nyy3v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 12 2021 at 12:56, Mel Gorman wrote:
> On Fri, Apr 09, 2021 at 08:55:39PM +0200, Peter Zijlstra wrote:
> I'll update the changelog and comment accordingly. I'll decide later
> whether to leave it or move the location of the lock at the end of the
> series. If the patch is added, it'll either incur the double lookup (not
> that expensive, might be optimised by the compiler) or come up with a
> helper that takes the lock and returns the per-cpu structure. The double
> lookup probably makes more sense initially because there are multiple
> potential users of a helper that says "pin to CPU, lookup, lock and return
> a per-cpu structure" for both IRQ-safe and IRQ-unsafe variants with the
> associated expansion of the local_lock API. It might be better to introduce
> such a helper with multiple users converted at the same time and there are
> other local_lock users in preempt-rt that could do with upstreaming first.

We had such helpers in RT a while ago but it turned into an helper
explosion pretty fast. But that was one of the early versions of local
locks which could not be embedded into a per CPU data structure due to
raisins (my stupidity).

But with the more thought out approach of today we can have (+/- the
obligatory naming bikeshedding):

--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,35 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+/**
+ * local_lock_get_cpu_ptr - Acquire a per CPU local lock and return
+ *			    a pointer to the per CPU data which
+ *			    contains the local lock.
+ * @pcp:	Per CPU data structure
+ * @lock:	The local lock member of @pcp
+ */
+#define local_lock_get_cpu_ptr(pcp, lock)			\
+	__local_lock_get_cpu_ptr(pcp, typeof(*(pcp)), lock)
+
+/**
+ * local_lock_irq_get_cpu_ptr - Acquire a per CPU local lock, disable
+ *				interrupts and return a pointer to the
+ *				per CPU data which contains the local lock.
+ * @pcp:	Per CPU data structure
+ * @lock:	The local lock member of @pcp
+ */
+#define local_lock_irq_get_cpu_ptr(pcp, lock)			\
+	__local_lock_irq_get_cpu_ptr(pcp, typeof(*(pcp)), lock)
+
+/**
+ * local_lock_irqsave_get_cpu_ptr - Acquire a per CPU local lock, save and
+ *				    disable interrupts and return a pointer to
+ *				    the CPU data which contains the local lock.
+ * @pcp:	Per CPU data structure
+ * @lock:	The local lock member of @pcp
+ * @flags:	Storage for interrupt flags
+ */
+#define local_lock_irqsave_get_cpu_ptr(pcp, lock, flags)	\
+	__local_lock_irqsave_get_cpu_ptr(pcp, typeof(*(pcp)), lock, flags)
+
 #endif
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -91,3 +91,33 @@ static inline void local_lock_release(lo
 		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
+
+#define __local_lock_get_cpu_ptr(pcp, type, lock)		\
+	({							\
+		type *__pcp;					\
+								\
+		preempt_disable();				\
+		__pcp = this_cpu_ptr(pcp);			\
+		local_lock_acquire(&__pcp->lock);		\
+		__pcp;						\
+	})
+
+#define __local_lock_irq_get_cpu_ptr(pcp, type, lock)		\
+	({							\
+		type *__pcp;					\
+								\
+		local_irq_disable();				\
+		__pcp = this_cpu_ptr(pcp);			\
+		local_lock_acquire(&__pcp->lock);		\
+		__pcp;						\
+	})
+
+#define __local_lock_irqsave_get_cpu_ptr(pcp, type, lock, flags)\
+	({							\
+		type *__pcp;					\
+								\
+		local_irq_save(flags);				\
+		__pcp = this_cpu_ptr(pcp);			\
+		local_lock_acquire(&__pcp->lock);		\
+		__pcp;						\
+	})


and RT will then change that to:

--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -96,7 +96,7 @@ static inline void local_lock_release(lo
 	({							\
 		type *__pcp;					\
 								\
-		preempt_disable();				\
+		ll_preempt_disable();				\
 		__pcp = this_cpu_ptr(pcp);			\
 		local_lock_acquire(&__pcp->lock);		\
 		__pcp;						\
@@ -106,7 +106,7 @@ static inline void local_lock_release(lo
 	({							\
 		type *__pcp;					\
 								\
-		local_irq_disable();				\
+		ll_local_irq_disable();				\
 		__pcp = this_cpu_ptr(pcp);			\
 		local_lock_acquire(&__pcp->lock);		\
 		__pcp;						\
@@ -116,7 +116,7 @@ static inline void local_lock_release(lo
 	({							\
 		type *__pcp;					\
 								\
-		local_irq_save(flags);				\
+		ll_local_irq_save(flags);			\
 		__pcp = this_cpu_ptr(pcp);			\
 		local_lock_acquire(&__pcp->lock);		\
 		__pcp;						\


where ll_xxx is defined as xxx for non-RT and on RT all of them
get mapped to migrate_disable().

Thoughts?

Thanks,

        tglx
