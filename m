Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78AC388F9
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C18206DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 19:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6H5s8v/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uEQ7M1zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgKCT5f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCT5f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 14:57:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A1C0613D1;
        Tue,  3 Nov 2020 11:57:34 -0800 (PST)
Date:   Tue, 3 Nov 2020 20:57:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604433453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dEalSHIiJT1av3wBOCBoG8SJSmUAvhstXqjImLx7ddk=;
        b=a6H5s8v/nNMlcS3EXvXHiesxbENtLa5mMfPgKey4KUysi85Re5aPQ1XKLtAIPSpOwjqeXU
        OHqTS+NvGEH11BqHJFP9etCPCNjnKWXIXFT7ejImJ+nUu4yJrRKBzMtmtJqsJU2lSaHsHt
        6a3025tvdYpB11RWKKooZXD6S90UWFcrR+Nc2/ZiaC4t+HJ+Nud1IsAdsnS/dt0Gkfa1ZT
        Pj4LUsU6BEcajSX7mNxgZekTnK02+CU8lCmwn/sF+wqSeiKfU7hC/LN6A8dCsCHLObQV0w
        tffdLhpU9UNV3tVNn0iMeayX7X7O3ZDK+C8M8fc8WnQ5FTScXJ4OwpPo7SYc7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604433453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dEalSHIiJT1av3wBOCBoG8SJSmUAvhstXqjImLx7ddk=;
        b=uEQ7M1zpQ+3TQyTXn7ySyZHqPuqRn0NMn6/7vIGEWkr3Y7KXDh6hjglrVOGtnTiurHl9z/
        GbYoAHQYY6yaFyBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc2-rt4 patch set. 

Changes since v5.10-rc2-rt3:

  - Update Thomas Gleixner's "mm/highmem: Preemptible variant of
    kmap_atomic & friends" series from v2 to v3.

  - Compile fix PREEMPT_COUNT=n.

  - Luis Claudio R. Goncalve reported a ptrace related bug. Patch by
    Oleg Nesterov.

  - Canceling a "delayed workqueue" might lead to a warning. Reported by
    Mike Galbraith.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc2-rt4

The RT patch against v5.10-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc2-rt4.tar.xz

Sebastian

diff --git a/Documentation/driver-api/io-mapping.rst b/Documentation/driver-api/io-mapping.rst
index a966239f04e48..a7830c59481f6 100644
--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -20,78 +20,64 @@ as it would consume too much of the kernel address space.
 mappable, while 'size' indicates how large a mapping region to
 enable. Both are in bytes.
 
-This _wc variant provides a mapping which may only be used
-with the io_mapping_map_atomic_wc or io_mapping_map_wc.
+This _wc variant provides a mapping which may only be used with
+io_mapping_map_local_wc() or io_mapping_map_wc().
 
-With this mapping object, individual pages can be mapped either atomically
-or not, depending on the necessary scheduling environment. Of course, atomic
-maps are more efficient::
+With this mapping object, individual pages can be mapped either temporarily
+or long term, depending on the requirements. Of course, temporary maps are
+more efficient.
 
-	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
-				       unsigned long offset)
+	void *io_mapping_map_local_wc(struct io_mapping *mapping,
+				      unsigned long offset)
 
-'offset' is the offset within the defined mapping region.
-Accessing addresses beyond the region specified in the
-creation function yields undefined results. Using an offset
-which is not page aligned yields an undefined result. The
-return value points to a single page in CPU address space.
+'offset' is the offset within the defined mapping region.  Accessing
+addresses beyond the region specified in the creation function yields
+undefined results. Using an offset which is not page aligned yields an
+undefined result. The return value points to a single page in CPU address
+space.
 
-This _wc variant returns a write-combining map to the
-page and may only be used with mappings created by
-io_mapping_create_wc
+This _wc variant returns a write-combining map to the page and may only be
+used with mappings created by io_mapping_create_wc()
 
-Note that the task may not sleep while holding this page
-mapped.
+Temporary mappings are only valid in the context of the caller. The mapping
+is not guaranteed to be globaly visible.
 
-::
+io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
+migration to make the mapping code work. No caller can rely on this side
+effect.
 
-	void io_mapping_unmap_atomic(void *vaddr)
+Nested mappings need to be undone in reverse order because the mapping
+code uses a stack for keeping track of them::
 
-'vaddr' must be the value returned by the last
-io_mapping_map_atomic_wc call. This unmaps the specified
-page and allows the task to sleep once again.
+ addr1 = io_mapping_map_local_wc(map1, offset1);
+ addr2 = io_mapping_map_local_wc(map2, offset2);
+ ...
+ io_mapping_unmap_local(addr2);
+ io_mapping_unmap_local(addr1);
 
-If you need to sleep while holding the lock, you can use the non-atomic
-variant, although they may be significantly slower.
+The mappings are released with::
 
-::
+	void io_mapping_unmap_local(void *vaddr)
+
+'vaddr' must be the value returned by the last io_mapping_map_local_wc()
+call. This unmaps the specified mapping and undoes eventual side effects of
+the mapping function.
+
+If you need to sleep while holding a mapping, you can use the regular
+variant, although this may be significantly slower::
 
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic_wc except it allows
-the task to sleep while holding the page mapped.
+This works like io_mapping_map_local_wc() except it has no side effects and
+the pointer is globaly visible.
 
-
-::
+The mappings are released with::
 
 	void io_mapping_unmap(void *vaddr)
 
-This works like io_mapping_unmap_atomic, except it is used
-for pages mapped with io_mapping_map_wc.
+Use for pages mapped with io_mapping_map_wc().
 
 At driver close time, the io_mapping object must be freed::
 
 	void io_mapping_free(struct io_mapping *mapping)
-
-Current Implementation
-======================
-
-The initial implementation of these functions uses existing mapping
-mechanisms and so provides only an abstraction layer and no new
-functionality.
-
-On 64-bit processors, io_mapping_create_wc calls ioremap_wc for the whole
-range, creating a permanent kernel-visible mapping to the resource. The
-map_atomic and map functions add the requested offset to the base of the
-virtual address returned by ioremap_wc.
-
-On 32-bit processors with HIGHMEM defined, io_mapping_map_atomic_wc uses
-kmap_atomic_pfn to map the specified page in an atomic fashion;
-kmap_atomic_pfn isn't really supposed to be used with device pages, but it
-provides an efficient mapping for this usage.
-
-On 32-bit processors without HIGHMEM defined, io_mapping_map_atomic_wc and
-io_mapping_map_wc both use ioremap_wc, a terribly inefficient function which
-performs an IPI to inform all processors about the new mapping. This results
-in a significant performance penalty.
diff --git a/arch/alpha/include/asm/kmap_types.h b/arch/alpha/include/asm/kmap_types.h
deleted file mode 100644
index 651714b45729a..0000000000000
--- a/arch/alpha/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/arc/include/asm/highmem.h b/arch/arc/include/asm/highmem.h
index 6291890eaafaf..a6b8e2c352c44 100644
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -9,20 +9,29 @@
 #ifdef CONFIG_HIGHMEM
 
 #include <uapi/asm/page.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
+
+#define FIXMAP_SIZE		PGDIR_SIZE
+#define PKMAP_SIZE		PGDIR_SIZE
 
 /* start after vmalloc area */
 #define FIXMAP_BASE		(PAGE_OFFSET - FIXMAP_SIZE - PKMAP_SIZE)
-#define FIXMAP_SIZE		PGDIR_SIZE	/* only 1 PGD worth */
-#define KM_TYPE_NR		((FIXMAP_SIZE >> PAGE_SHIFT)/NR_CPUS)
 
-#define FIX_KMAP_BEGIN		(0)
-#define FIX_KMAP_END		((FIXMAP_SIZE >> PAGE_SHIFT) - 1)
-#define FIXADDR_TOP		(FIXMAP_BASE + FIXMAP_SIZE - PAGE_SIZE)
+#define FIX_KMAP_SLOTS		(KM_MAX_IDX * NR_CPUS)
+#define FIX_KMAP_BEGIN		(0UL)
+#define FIX_KMAP_END		((FIX_KMAP_BEGIN + FIX_KMAP_SLOTS) - 1)
+
+#define FIXADDR_TOP		(FIXMAP_BASE + (FIX_KMAP_END << PAGE_SHIFT))
+
+/*
+ * This should be converted to the asm-generic version, but of course this
+ * is needlessly different from all other architectures. Sigh - tglx
+ */
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	(((FIXADDR_TOP - ((x) & PAGE_MASK))) >> PAGE_SHIFT)
 
 /* start after fixmap area */
 #define PKMAP_BASE		(FIXMAP_BASE + FIXMAP_SIZE)
-#define PKMAP_SIZE		PGDIR_SIZE
 #define LAST_PKMAP		(PKMAP_SIZE >> PAGE_SHIFT)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
 #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
@@ -39,7 +48,6 @@ static inline void flush_cache_kmaps(void)
 {
 	flush_cache_all();
 }
-
 #endif
 
 #endif
diff --git a/arch/arc/include/asm/kmap_types.h b/arch/arc/include/asm/kmap_types.h
deleted file mode 100644
index fecf7851ec322..0000000000000
--- a/arch/arc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/*
- * We primarily need to define KM_TYPE_NR here but that in turn
- * is a function of PGDIR_SIZE etc.
- * To avoid circular deps issue, put everything in asm/highmem.h
- */
-#endif
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index b74ae42026016..c79912a6b1961 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -36,9 +36,8 @@
  *   This means each only has 1 PGDIR_SIZE worth of kvaddr mappings, which means
  *   2M of kvaddr space for typical config (8K page and 11:8:13 traversal split)
  *
- * - fixmap anyhow needs a limited number of mappings. So 2M kvaddr == 256 PTE
- *   slots across NR_CPUS would be more than sufficient (generic code defines
- *   KM_TYPE_NR as 20).
+ * - The fixed KMAP slots for kmap_local/atomic() require KM_MAX_IDX slots per
+ *   CPU. So the number of CPUs sharing a single PTE page is limited.
  *
  * - pkmap being preemptible, in theory could do with more than 256 concurrent
  *   mappings. However, generic pkmap code: map_new_virtual(), doesn't traverse
@@ -66,10 +65,9 @@ void __init kmap_init(void)
 {
 	/* Due to recursive include hell, we can't do this in processor.h */
 	BUILD_BUG_ON(PAGE_OFFSET < (VMALLOC_END + FIXMAP_SIZE + PKMAP_SIZE));
-
-	BUILD_BUG_ON(KM_TYPE_NR > PTRS_PER_PTE);
-	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
-
 	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
+	BUILD_BUG_ON(FIX_KMAP_SLOTS > PTRS_PER_PTE);
+
+	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
 	alloc_kmap_pgtable(FIXMAP_BASE);
 }
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index fc56fc3e19316..c279a8a463a2e 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -7,14 +7,14 @@
 #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_permanent_fixed_addresses,
 
 	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 
 	/* Support writing RO kernel text via kprobes, jump labels, etc. */
 	FIX_TEXT_POKE0,
diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 99a99862c4744..b22dffa8c7eb9 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_HIGHMEM_H
 #define _ASM_HIGHMEM_H
 
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
+#include <asm/fixmap.h>
 
 #define PKMAP_BASE		(PAGE_OFFSET - PMD_SIZE)
 #define LAST_PKMAP		PTRS_PER_PTE
diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
deleted file mode 100644
index 5590940ee43d7..0000000000000
--- a/arch/arm/include/asm/kmap_types.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ARM_KMAP_TYPES_H
-#define __ARM_KMAP_TYPES_H
-
-/*
- * This is the "bare minimum".  AIO seems to require this.
- */
-#define KM_TYPE_NR 16
-
-#endif
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af63..87328766e9102 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -49,9 +49,9 @@ static inline unsigned long l2_get_va(unsigned long paddr)
 	 * we simply install a virtual mapping for it only for the
 	 * TLB lookup to occur, hence no need to flush the untouched
 	 * memory mapping afterwards (note: a cache flush may happen
-	 * in some circumstances depending on the path taken in kunmap_atomic).
+	 * in some circumstances depending on the path taken in kunmap_local).
 	 */
-	void *vaddr = kmap_atomic_pfn(paddr >> PAGE_SHIFT);
+	void *vaddr = kmap_local_pfn(paddr >> PAGE_SHIFT);
 	return (unsigned long)vaddr + (paddr & ~PAGE_MASK);
 #else
 	return __phys_to_virt(paddr);
@@ -61,7 +61,7 @@ static inline unsigned long l2_get_va(unsigned long paddr)
 static inline void l2_put_va(unsigned long vaddr)
 {
 #ifdef CONFIG_HIGHMEM
-	kunmap_atomic((void *)vaddr);
+	kunmap_local((void *)vaddr);
 #endif
 }
 
diff --git a/arch/arm/mm/cache-xsc3l2.c b/arch/arm/mm/cache-xsc3l2.c
index d20d7af02d10f..0e0a3abd81743 100644
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -59,7 +59,7 @@ static inline void l2_unmap_va(unsigned long va)
 {
 #ifdef CONFIG_HIGHMEM
 	if (va != -1)
-		kunmap_atomic((void *)va);
+		kunmap_local((void *)va);
 #endif
 }
 
@@ -75,7 +75,7 @@ static inline unsigned long l2_map_va(unsigned long pa, unsigned long prev_va)
 		 * in place for it.
 		 */
 		l2_unmap_va(prev_va);
-		va = (unsigned long)kmap_atomic_pfn(pa >> PAGE_SHIFT);
+		va = (unsigned long)kmap_local_pfn(pa >> PAGE_SHIFT);
 	}
 	return va + (pa_offset >> (32 - PAGE_SHIFT));
 #else
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
index 81f9477d5330c..4b589cc209000 100644
--- a/arch/csky/include/asm/fixmap.h
+++ b/arch/csky/include/asm/fixmap.h
@@ -8,7 +8,7 @@
 #include <asm/memory.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -17,7 +17,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index d22f0db710346..1f4ed3f4c0d9b 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #include <asm/cache.h>
 
 /* undef for production */
diff --git a/arch/ia64/include/asm/kmap_types.h b/arch/ia64/include/asm/kmap_types.h
deleted file mode 100644
index 5c268cf7c2bd5..0000000000000
--- a/arch/ia64/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_KMAP_TYPES_H
-#define _ASM_IA64_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_IA64_KMAP_TYPES_H */
diff --git a/arch/microblaze/include/asm/fixmap.h b/arch/microblaze/include/asm/fixmap.h
index 0379ce5229e3a..e6e9288bff761 100644
--- a/arch/microblaze/include/asm/fixmap.h
+++ b/arch/microblaze/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
@@ -47,7 +47,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * num_possible_cpus()) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * num_possible_cpus()) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 743535be7528c..beea14761cef0 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -17,7 +17,7 @@
 #include <spaces.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -52,7 +52,7 @@ enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index cb2e0fb8483b8..19edf8e699712 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
 #include <asm/cpu-features.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
diff --git a/arch/mips/include/asm/kmap_types.h b/arch/mips/include/asm/kmap_types.h
deleted file mode 100644
index 16665dc2431b6..0000000000000
--- a/arch/mips/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define	 __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 01b2bd95ba1f7..9aba83e1eeb4e 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -5,8 +5,6 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
-static void *kdump_buf_page;
-
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -17,51 +15,25 @@ static void *kdump_buf_page;
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
+ * Copy a page from "oldmem". For this page, there might be no pte mapped
  * in the current kernel.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
 {
 	void  *vaddr;
 
 	if (!csize)
 		return 0;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = kmap_local_pfn(pfn);
 
 	if (!userbuf) {
-		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		memcpy(buf, vaddr + offset, csize);
 	} else {
-		if (!kdump_buf_page) {
-			pr_warn("Kdump: Kdump buffer page not allocated\n");
-
-			return -EFAULT;
-		}
-		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
-		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
-			return -EFAULT;
+		if (copy_to_user(buf, vaddr + offset, csize))
+			csize = -EFAULT;
 	}
 
 	return csize;
 }
-
-static int __init kdump_buf_page_init(void)
-{
-	int ret = 0;
-
-	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!kdump_buf_page) {
-		pr_warn("Kdump: Failed to allocate kdump buffer page\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-arch_initcall(kdump_buf_page_init);
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 7e159e93f7118..bc80893e5c0f8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -36,7 +36,6 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/kmap_types.h>
 #include <asm/maar.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 5a4bf11e58003..2fa09a2de4281 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -14,7 +14,7 @@ enum fixed_addresses {
 	FIX_KMAP_RESERVED,
 	FIX_KMAP_BEGIN,
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index d844c282c090c..16159a8716f22 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -5,7 +5,6 @@
 #define _ASM_HIGHMEM_H
 
 #include <asm/proc-fns.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 
 /*
@@ -57,7 +56,7 @@ extern void kmap_init(void);
 		__nds32__isb();					\
 	} while (0)
 
-#define arch_kmap_local_pre_unmap(vaddr, pte)			\
+#define arch_kmap_local_pre_unmap(vaddr)			\
 	do {							\
 		__nds32__tlbop_inv(vaddr);			\
 		__nds32__isb();					\
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 8348feaaf46e5..bf9b2310fc936 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index a978590d802d0..5aed97a18bac9 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/bug.h>
 #include <linux/sched.h>
diff --git a/arch/parisc/include/asm/kmap_types.h b/arch/parisc/include/asm/kmap_types.h
deleted file mode 100644
index 3e70b5cd11231..0000000000000
--- a/arch/parisc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 6bfc87915d5db..8d03c16a36635 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #ifdef CONFIG_KASAN
@@ -55,7 +55,7 @@ enum fixed_addresses {
 	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128K, PAGE_SIZE)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 #ifdef CONFIG_PPC_8xx
 	/* For IMMR we need an aligned 512K area */
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 64af53049e138..80a5ae771c653 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
diff --git a/arch/powerpc/include/asm/kmap_types.h b/arch/powerpc/include/asm/kmap_types.h
deleted file mode 100644
index c8fa182d48c8e..0000000000000
--- a/arch/powerpc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_KMAP_TYPES_H
-#define _ASM_POWERPC_KMAP_TYPES_H
-
-#ifdef __KERNEL__
-
-/*
- */
-
-#define KM_TYPE_NR 16
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_KMAP_TYPES_H */
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index f38adc189b832..b07fbc7f7bc6a 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -13,9 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <asm/page.h>
-#ifdef CONFIG_HIGHMEM
-#include <asm/kmap_types.h>
-#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -53,11 +50,6 @@ enum fixed_addresses {
 	FIX_CMAP_BEGIN,
 	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS) - 1,
 
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
-#endif
-
 #ifdef CONFIG_IOREMAP_FIXED
 	/*
 	 * FIX_IOREMAP entries are useful for mapping physical address
diff --git a/arch/sh/include/asm/kmap_types.h b/arch/sh/include/asm/kmap_types.h
deleted file mode 100644
index b78107f923dd3..0000000000000
--- a/arch/sh/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SH_KMAP_TYPES_H
-#define __SH_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 3348e0c4d7698..0db6919af8d32 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -362,9 +362,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	pr_info("virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
 		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB) (cached)\n"
 #ifdef CONFIG_UNCACHED_MAPPING
@@ -376,11 +373,6 @@ void __init mem_init(void)
 		FIXADDR_START, FIXADDR_TOP,
 		(FIXADDR_TOP - FIXADDR_START) >> 10,
 
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-#endif
-
 		(unsigned long)VMALLOC_START, VMALLOC_END,
 		(VMALLOC_END - VMALLOC_START) >> 20,
 
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index f84298a7100c5..875116209ec14 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/pgtable.h>
 #include <asm/vaddrs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtsrmmu.h>
 
 /* declarations for highmem.c */
diff --git a/arch/sparc/include/asm/kmap_types.h b/arch/sparc/include/asm/kmap_types.h
deleted file mode 100644
index 55a99b6bd91e0..0000000000000
--- a/arch/sparc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc.  -DaveM
- */
-
-#include <asm-generic/kmap_types.h>
-
-#endif
diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vaddrs.h
index 84d054b07a6ff..4fec0341e2a81 100644
--- a/arch/sparc/include/asm/vaddrs.h
+++ b/arch/sparc/include/asm/vaddrs.h
@@ -32,13 +32,13 @@
 #define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
 
 #ifndef __ASSEMBLY__
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = (KM_MAX_IDX * NR_CPUS),
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
index 2c697a145ac1b..2efac58271880 100644
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -3,7 +3,6 @@
 #define __UM_FIXMAP_H
 
 #include <asm/processor.h>
-#include <asm/kmap_types.h>
 #include <asm/archparam.h>
 #include <asm/page.h>
 #include <linux/threads.h>
diff --git a/arch/um/include/asm/kmap_types.h b/arch/um/include/asm/kmap_types.h
deleted file mode 100644
index b0bd12de1d23c..0000000000000
--- a/arch/um/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#ifndef __UM_KMAP_TYPES_H
-#define __UM_KMAP_TYPES_H
-
-/* No more #include "asm/arch/kmap_types.h" ! */
-
-#define KM_TYPE_NR 14
-
-#endif
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9de29ee55cb10..8eba66a33e397 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -31,7 +31,7 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -94,7 +94,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_X86_32
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index bf6ed26788de1..032e020853aa6 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -23,7 +23,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/include/asm/kmap_types.h b/arch/x86/include/asm/kmap_types.h
deleted file mode 100644
index 04ab8266e347c..0000000000000
--- a/arch/x86/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KMAP_TYPES_H
-#define _ASM_X86_KMAP_TYPES_H
-
-#if defined(CONFIG_X86_32) && defined(CONFIG_DEBUG_HIGHMEM)
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_X86_KMAP_TYPES_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0fad9f61c76ab..b6b02b7c19cc9 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -41,7 +41,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 33ee47670b993..5fcac46aaf6b1 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -13,8 +13,6 @@
 
 #include <linux/uaccess.h>
 
-static void *kdump_buf_page;
-
 static inline bool is_crashed_pfn_valid(unsigned long pfn)
 {
 #ifndef CONFIG_X86_PAE
@@ -41,15 +39,11 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
+ * Copy a page from "oldmem". For this page, there might be no pte mapped
+ * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
 {
 	void  *vaddr;
 
@@ -59,38 +53,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!is_crashed_pfn_valid(pfn))
 		return -EFAULT;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = kmap_local_pfn(pfn);
 
 	if (!userbuf) {
-		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		memcpy(buf, vaddr + offset, csize);
 	} else {
-		if (!kdump_buf_page) {
-			printk(KERN_WARNING "Kdump: Kdump buffer page not"
-				" allocated\n");
-			kunmap_atomic(vaddr);
-			return -EFAULT;
-		}
-		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
-		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
-			return -EFAULT;
+		if (copy_to_user(buf, vaddr + offset, csize))
+			csize = -EFAULT;
 	}
 
+	kunmap_local(vaddr);
+
 	return csize;
 }
-
-static int __init kdump_buf_page_init(void)
-{
-	int ret = 0;
-
-	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!kdump_buf_page) {
-		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
-			 " page\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-arch_initcall(kdump_buf_page_init);
diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index a06ffb0c61c77..92049b61c3511 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -16,7 +16,7 @@
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -39,7 +39,7 @@ enum fixed_addresses {
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN +
-		(KM_TYPE_NR * NR_CPUS * DCACHE_N_COLORS) - 1,
+		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index f8f24299acc19..0fc3b1cebc56a 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -16,9 +16,8 @@
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
-#include <asm/kmap_types.h>
 
-#define PKMAP_BASE		((FIXADDR_START - \
+#define PKMAP_BASE		((FIXADDR_START -			\
 				  (LAST_PKMAP + 1) * PAGE_SIZE) & PMD_MASK)
 #define LAST_PKMAP		(PTRS_PER_PTE * DCACHE_N_COLORS)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 69017f99e9b96..0735ca5e8f869 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -31,13 +31,13 @@ static inline void kmap_waitqueues_init(void)
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
-	return (type + KM_TYPE_NR * smp_processor_id()) * DCACHE_N_COLORS +
+	return (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS +
 		color;
 }
 
 enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
 {
-	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT);
+	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT));
 }
 
 enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 1904e6e5ea64b..59635ff118e75 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1081,7 +1081,7 @@ static void reloc_cache_reset(struct reloc_cache *cache, struct i915_execbuffer
 		struct i915_ggtt *ggtt = cache_to_ggtt(cache);
 
 		intel_gt_flush_ggtt_writes(ggtt->vm.gt);
-		io_mapping_unmap_atomic((void __iomem *)vaddr);
+		io_mapping_unmap_local((void __iomem *)vaddr);
 
 		if (drm_mm_node_allocated(&cache->node)) {
 			ggtt->vm.clear_range(&ggtt->vm,
@@ -1147,7 +1147,7 @@ static void *reloc_iomap(struct drm_i915_gem_object *obj,
 
 	if (cache->vaddr) {
 		intel_gt_flush_ggtt_writes(ggtt->vm.gt);
-		io_mapping_unmap_atomic((void __force __iomem *) unmask_page(cache->vaddr));
+		io_mapping_unmap_local((void __force __iomem *) unmask_page(cache->vaddr));
 	} else {
 		struct i915_vma *vma;
 		int err;
@@ -1195,8 +1195,7 @@ static void *reloc_iomap(struct drm_i915_gem_object *obj,
 		offset += page << PAGE_SHIFT;
 	}
 
-	vaddr = (void __force *)io_mapping_map_atomic_wc(&ggtt->iomap,
-							 offset);
+	vaddr = (void __force *)io_mapping_map_local_wc(&ggtt->iomap, offset);
 	cache->page = page;
 	cache->vaddr = (unsigned long)vaddr;
 
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index bb0c12975f38e..04808bf5efb63 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -379,22 +379,15 @@ gtt_user_read(struct io_mapping *mapping,
 	      char __user *user_data, int length)
 {
 	void __iomem *vaddr;
-	unsigned long unwritten;
+	bool fail = false;
 
 	/* We can use the cpu mem copy function because this is X86. */
-	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_to_user_inatomic(user_data,
-					    (void __force *)vaddr + offset,
-					    length);
-	io_mapping_unmap_atomic(vaddr);
-	if (unwritten) {
-		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_to_user(user_data,
-					 (void __force *)vaddr + offset,
-					 length);
-		io_mapping_unmap(vaddr);
-	}
-	return unwritten;
+	vaddr = io_mapping_map_local_wc(mapping, base);
+	if (copy_to_user(user_data, (void __force *)vaddr + offset, length))
+		fail = true;
+	io_mapping_unmap_local(vaddr);
+
+	return fail;
 }
 
 static int
@@ -557,21 +550,14 @@ ggtt_write(struct io_mapping *mapping,
 	   char __user *user_data, int length)
 {
 	void __iomem *vaddr;
-	unsigned long unwritten;
+	bool fail = false;
 
 	/* We can use the cpu mem copy function because this is X86. */
-	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_from_user_inatomic_nocache((void __force *)vaddr + offset,
-						      user_data, length);
-	io_mapping_unmap_atomic(vaddr);
-	if (unwritten) {
-		vaddr = io_mapping_map_wc(mapping, base, PAGE_SIZE);
-		unwritten = copy_from_user((void __force *)vaddr + offset,
-					   user_data, length);
-		io_mapping_unmap(vaddr);
-	}
-
-	return unwritten;
+	vaddr = io_mapping_map_local_wc(mapping, base);
+	if (copy_from_user((void __force *)vaddr + offset, user_data, length))
+		fail = true;
+	io_mapping_unmap_local(vaddr);
+	return fail;
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index 23a6132c5f4e8..b15eaf83500be 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -57,12 +57,12 @@ static void trash_stolen(struct drm_i915_private *i915)
 
 		ggtt->vm.insert_page(&ggtt->vm, dma, slot, I915_CACHE_NONE, 0);
 
-		s = io_mapping_map_atomic_wc(&ggtt->iomap, slot);
+		s = io_mapping_map_local_wc(&ggtt->iomap, slot);
 		for (x = 0; x < PAGE_SIZE / sizeof(u32); x++) {
 			prng = next_pseudo_random32(prng);
 			iowrite32(prng, &s[x]);
 		}
-		io_mapping_unmap_atomic(s);
+		io_mapping_unmap_local(s);
 	}
 
 	ggtt->vm.clear_range(&ggtt->vm, slot, PAGE_SIZE);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index c53a222e3dece..53226d460c693 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1200,9 +1200,9 @@ static int igt_ggtt_page(void *arg)
 		u64 offset = tmp.start + order[n] * PAGE_SIZE;
 		u32 __iomem *vaddr;
 
-		vaddr = io_mapping_map_atomic_wc(&ggtt->iomap, offset);
+		vaddr = io_mapping_map_local_wc(&ggtt->iomap, offset);
 		iowrite32(n, vaddr + n);
-		io_mapping_unmap_atomic(vaddr);
+		io_mapping_unmap_local(vaddr);
 	}
 	intel_gt_flush_ggtt_writes(ggtt->vm.gt);
 
@@ -1212,9 +1212,9 @@ static int igt_ggtt_page(void *arg)
 		u32 __iomem *vaddr;
 		u32 val;
 
-		vaddr = io_mapping_map_atomic_wc(&ggtt->iomap, offset);
+		vaddr = io_mapping_map_local_wc(&ggtt->iomap, offset);
 		val = ioread32(vaddr + n);
-		io_mapping_unmap_atomic(vaddr);
+		io_mapping_unmap_local(vaddr);
 
 		if (val != n) {
 			pr_err("insert page failed: found %d, expected %d\n",
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h
index 6c5bbff12eb49..411f91ee20fa6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h
@@ -60,19 +60,19 @@ fbmem_fini(struct io_mapping *fb)
 static inline u32
 fbmem_peek(struct io_mapping *fb, u32 off)
 {
-	u8 __iomem *p = io_mapping_map_atomic_wc(fb, off & PAGE_MASK);
+	u8 __iomem *p = io_mapping_map_local_wc(fb, off & PAGE_MASK);
 	u32 val = ioread32(p + (off & ~PAGE_MASK));
-	io_mapping_unmap_atomic(p);
+	io_mapping_unmap_local(p);
 	return val;
 }
 
 static inline void
 fbmem_poke(struct io_mapping *fb, u32 off, u32 val)
 {
-	u8 __iomem *p = io_mapping_map_atomic_wc(fb, off & PAGE_MASK);
+	u8 __iomem *p = io_mapping_map_local_wc(fb, off & PAGE_MASK);
 	iowrite32(val, p + (off & ~PAGE_MASK));
 	wmb();
-	io_mapping_unmap_atomic(p);
+	io_mapping_unmap_local(p);
 }
 
 static inline bool
diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 60ab7151b84dc..93f92ccd42e58 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -124,12 +124,12 @@ qxl_image_init_helper(struct qxl_device *qdev,
 				  wrong (check the bitmaps are sent correctly
 				  first) */
 
-	ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, 0);
+	ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, 0);
 	chunk = ptr;
 	chunk->data_size = height * chunk_stride;
 	chunk->prev_chunk = 0;
 	chunk->next_chunk = 0;
-	qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 
 	{
 		void *k_data, *i_data;
@@ -143,7 +143,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 			i_data = (void *)data;
 
 			while (remain > 0) {
-				ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, page << PAGE_SHIFT);
+				ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, page << PAGE_SHIFT);
 
 				if (page == 0) {
 					chunk = ptr;
@@ -157,7 +157,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 
 				memcpy(k_data, i_data, size);
 
-				qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+				qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 				i_data += size;
 				remain -= size;
 				page++;
@@ -175,10 +175,10 @@ qxl_image_init_helper(struct qxl_device *qdev,
 					page_offset = offset_in_page(out_offset);
 					size = min((int)(PAGE_SIZE - page_offset), remain);
 
-					ptr = qxl_bo_kmap_atomic_page(qdev, chunk_bo, page_base);
+					ptr = qxl_bo_kmap_local_page(qdev, chunk_bo, page_base);
 					k_data = ptr + page_offset;
 					memcpy(k_data, i_data, size);
-					qxl_bo_kunmap_atomic_page(qdev, chunk_bo, ptr);
+					qxl_bo_kunmap_local_page(qdev, chunk_bo, ptr);
 					remain -= size;
 					i_data += size;
 					out_offset += size;
@@ -189,7 +189,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 	qxl_bo_kunmap(chunk_bo);
 
 	image_bo = dimage->bo;
-	ptr = qxl_bo_kmap_atomic_page(qdev, image_bo, 0);
+	ptr = qxl_bo_kmap_local_page(qdev, image_bo, 0);
 	image = ptr;
 
 	image->descriptor.id = 0;
@@ -212,7 +212,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 		break;
 	default:
 		DRM_ERROR("unsupported image bit depth\n");
-		qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+		qxl_bo_kunmap_local_page(qdev, image_bo, ptr);
 		return -EINVAL;
 	}
 	image->u.bitmap.flags = QXL_BITMAP_TOP_DOWN;
@@ -222,7 +222,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 	image->u.bitmap.palette = 0;
 	image->u.bitmap.data = qxl_bo_physical_address(qdev, chunk_bo, 0);
 
-	qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, image_bo, ptr);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 5cea6eea72abb..785023081b795 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -89,11 +89,11 @@ apply_reloc(struct qxl_device *qdev, struct qxl_reloc_info *info)
 {
 	void *reloc_page;
 
-	reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
+	reloc_page = qxl_bo_kmap_local_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
 	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) = qxl_bo_physical_address(qdev,
 											      info->src_bo,
 											      info->src_offset);
-	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
+	qxl_bo_kunmap_local_page(qdev, info->dst_bo, reloc_page);
 }
 
 static void
@@ -105,9 +105,9 @@ apply_surf_reloc(struct qxl_device *qdev, struct qxl_reloc_info *info)
 	if (info->src_bo && !info->src_bo->is_primary)
 		id = info->src_bo->surface_id;
 
-	reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
+	reloc_page = qxl_bo_kmap_local_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
 	*(uint32_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) = id;
-	qxl_bo_kunmap_atomic_page(qdev, info->dst_bo, reloc_page);
+	qxl_bo_kunmap_local_page(qdev, info->dst_bo, reloc_page);
 }
 
 /* return holding the reference to this object */
@@ -149,7 +149,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
 	int i, ret, num_relocs;
-	int unwritten;
 
 	switch (cmd->type) {
 	case QXL_CMD_DRAW:
@@ -185,21 +184,21 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		goto out_free_reloc;
 
 	/* TODO copy slow path code from i915 */
-	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
-	unwritten = __copy_from_user_inatomic_nocache
-		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
-		 u64_to_user_ptr(cmd->command), cmd->command_size);
+	fb_cmd = qxl_bo_kmap_local_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
 
-	{
+	if (copy_from_user(fb_cmd + sizeof(union qxl_release_info) +
+			   (release->release_offset & ~PAGE_MASK),
+			   u64_to_user_ptr(cmd->command), cmd->command_size)) {
+		ret = -EFAULT;
+	} else {
 		struct qxl_drawable *draw = fb_cmd;
 
 		draw->mm_time = qdev->rom->mm_clock;
 	}
 
-	qxl_bo_kunmap_atomic_page(qdev, cmd_bo, fb_cmd);
-	if (unwritten) {
-		DRM_ERROR("got unwritten %d\n", unwritten);
-		ret = -EFAULT;
+	qxl_bo_kunmap_local_page(qdev, cmd_bo, fb_cmd);
+	if (ret) {
+		DRM_ERROR("copy from user failed %d\n", ret);
 		goto out_free_release;
 	}
 
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 2bc364412e8b8..9350d238ba545 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -172,8 +172,8 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
 	return 0;
 }
 
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
-			      struct qxl_bo *bo, int page_offset)
+void *qxl_bo_kmap_local_page(struct qxl_device *qdev,
+			     struct qxl_bo *bo, int page_offset)
 {
 	unsigned long offset;
 	void *rptr;
@@ -188,7 +188,7 @@ void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 		goto fallback;
 
 	offset = bo->tbo.mem.start << PAGE_SHIFT;
-	return io_mapping_map_atomic_wc(map, offset + page_offset);
+	return io_mapping_map_local_wc(map, offset + page_offset);
 fallback:
 	if (bo->kptr) {
 		rptr = bo->kptr + (page_offset * PAGE_SIZE);
@@ -214,14 +214,14 @@ void qxl_bo_kunmap(struct qxl_bo *bo)
 	ttm_bo_kunmap(&bo->kmap);
 }
 
-void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
-			       struct qxl_bo *bo, void *pmap)
+void qxl_bo_kunmap_local_page(struct qxl_device *qdev,
+			      struct qxl_bo *bo, void *pmap)
 {
 	if ((bo->tbo.mem.mem_type != TTM_PL_VRAM) &&
 	    (bo->tbo.mem.mem_type != TTM_PL_PRIV))
 		goto fallback;
 
-	io_mapping_unmap_atomic(pmap);
+	io_mapping_unmap_local(pmap);
 	return;
  fallback:
 	qxl_bo_kunmap(bo);
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 6b434e5ef795a..02f1e03742286 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -88,8 +88,8 @@ extern int qxl_bo_create(struct qxl_device *qdev,
 			 struct qxl_bo **bo_ptr);
 extern int qxl_bo_kmap(struct qxl_bo *bo, void **ptr);
 extern void qxl_bo_kunmap(struct qxl_bo *bo);
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
-void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
+void *qxl_bo_kmap_local_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
+void qxl_bo_kunmap_local_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
 extern void qxl_bo_unref(struct qxl_bo **bo);
 extern int qxl_bo_pin(struct qxl_bo *bo);
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 4fae3e393da14..9f37b51e61c6c 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -408,7 +408,7 @@ union qxl_release_info *qxl_release_map(struct qxl_device *qdev,
 	union qxl_release_info *info;
 	struct qxl_bo *bo = release->release_bo;
 
-	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_MASK);
+	ptr = qxl_bo_kmap_local_page(qdev, bo, release->release_offset & PAGE_MASK);
 	if (!ptr)
 		return NULL;
 	info = ptr + (release->release_offset & ~PAGE_MASK);
@@ -423,7 +423,7 @@ void qxl_release_unmap(struct qxl_device *qdev,
 	void *ptr;
 
 	ptr = ((void *)info) - (release->release_offset & ~PAGE_MASK);
-	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
+	qxl_bo_kunmap_local_page(qdev, bo, ptr);
 }
 
 void qxl_release_fence_buffer_objects(struct qxl_release *release)
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fb2a25f8408fc..164b9a015d32e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -181,13 +181,15 @@ static int ttm_copy_io_ttm_page(struct ttm_tt *ttm, void *src,
 		return -ENOMEM;
 
 	src = (void *)((unsigned long)src + (page << PAGE_SHIFT));
-	dst = kmap_atomic_prot(d, prot);
-	if (!dst)
-		return -ENOMEM;
+	/*
+	 * Ensure that a highmem page is mapped with the correct
+	 * pgprot. For non highmem the mapping is already there.
+	 */
+	dst = kmap_local_page_prot(d, prot);
 
 	memcpy_fromio(dst, src, PAGE_SIZE);
 
-	kunmap_atomic(dst);
+	kunmap_local(dst);
 
 	return 0;
 }
@@ -203,13 +205,15 @@ static int ttm_copy_ttm_io_page(struct ttm_tt *ttm, void *dst,
 		return -ENOMEM;
 
 	dst = (void *)((unsigned long)dst + (page << PAGE_SHIFT));
-	src = kmap_atomic_prot(s, prot);
-	if (!src)
-		return -ENOMEM;
+	/*
+	 * Ensure that a highmem page is mapped with the correct
+	 * pgprot. For non highmem the mapping is already there.
+	 */
+	src = kmap_local_page_prot(s, prot);
 
 	memcpy_toio(dst, src, PAGE_SIZE);
 
-	kunmap_atomic(src);
+	kunmap_local(src);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index e8d66182cd7b5..71dba228f68ef 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -375,12 +375,12 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
 		copy_size = min_t(u32, copy_size, PAGE_SIZE - src_page_offset);
 
 		if (unmap_src) {
-			kunmap_atomic(d->src_addr);
+			kunmap_local(d->src_addr);
 			d->src_addr = NULL;
 		}
 
 		if (unmap_dst) {
-			kunmap_atomic(d->dst_addr);
+			kunmap_local(d->dst_addr);
 			d->dst_addr = NULL;
 		}
 
@@ -388,12 +388,8 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
 			if (WARN_ON_ONCE(dst_page >= d->dst_num_pages))
 				return -EINVAL;
 
-			d->dst_addr =
-				kmap_atomic_prot(d->dst_pages[dst_page],
-						 d->dst_prot);
-			if (!d->dst_addr)
-				return -ENOMEM;
-
+			d->dst_addr = kmap_local_page_prot(d->dst_pages[dst_page],
+							   d->dst_prot);
 			d->mapped_dst = dst_page;
 		}
 
@@ -401,12 +397,8 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
 			if (WARN_ON_ONCE(src_page >= d->src_num_pages))
 				return -EINVAL;
 
-			d->src_addr =
-				kmap_atomic_prot(d->src_pages[src_page],
-						 d->src_prot);
-			if (!d->src_addr)
-				return -ENOMEM;
-
+			d->src_addr = kmap_local_page_prot(d->src_pages[src_page],
+							   d->src_prot);
 			d->mapped_src = src_page;
 		}
 		diff->do_cpy(diff, d->dst_addr + dst_page_offset,
@@ -436,8 +428,10 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
  *
  * Performs a CPU blit from one buffer object to another avoiding a full
  * bo vmap which may exhaust- or fragment vmalloc space.
- * On supported architectures (x86), we're using kmap_atomic which avoids
- * cross-processor TLB- and cache flushes and may, on non-HIGHMEM systems
+ *
+ * On supported architectures (x86), we're using kmap_local_prot() which
+ * avoids cross-processor TLB- and cache flushes. kmap_local_prot() will
+ * either map a highmem page with the proper pgprot on HIGHMEM=y systems or
  * reference already set-up mappings.
  *
  * Neither of the buffer objects may be placed in PCI memory
@@ -500,9 +494,9 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 	}
 out:
 	if (d.src_addr)
-		kunmap_atomic(d.src_addr);
+		kunmap_local(d.src_addr);
 	if (d.dst_addr)
-		kunmap_atomic(d.dst_addr);
+		kunmap_local(d.dst_addr);
 
 	return ret;
 }
diff --git a/fs/aio.c b/fs/aio.c
index c45c20d875388..0247daf559877 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,7 +43,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 
-#include <asm/kmap_types.h>
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0378933d163c6..01947f6033006 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -17,7 +17,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
-#include <asm/kmap_types.h>
 #include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index e78bbb9a07e90..4365b9aa3e3f6 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -30,7 +30,7 @@ mandatory-y += irq.h
 mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
-mandatory-y += kmap_types.h
+mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
diff --git a/include/asm-generic/kmap_size.h b/include/asm-generic/kmap_size.h
new file mode 100644
index 0000000000000..9d6c7786a645f
--- /dev/null
+++ b/include/asm-generic/kmap_size.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_KMAP_SIZE_H
+#define _ASM_GENERIC_KMAP_SIZE_H
+
+/* For debug this provides guard pages between the maps */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_MAX_IDX	33
+#else
+# define KM_MAX_IDX	16
+#endif
+
+#endif
diff --git a/include/asm-generic/kmap_types.h b/include/asm-generic/kmap_types.h
deleted file mode 100644
index 9f95b7b63d192..0000000000000
--- a/include/asm-generic/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_KMAP_TYPES_H
-#define _ASM_GENERIC_KMAP_TYPES_H
-
-#ifdef __WITH_KM_FENCE
-# define KM_TYPE_NR 41
-#else
-# define KM_TYPE_NR 20
-#endif
-
-#endif
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
new file mode 100644
index 0000000000000..f9bc6acd36798
--- /dev/null
+++ b/include/linux/highmem-internal.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HIGHMEM_INTERNAL_H
+#define _LINUX_HIGHMEM_INTERNAL_H
+
+/*
+ * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+ */
+#ifdef CONFIG_KMAP_LOCAL
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void kunmap_local_indexed(void *vaddr);
+void kmap_local_fork(struct task_struct *tsk);
+void __kmap_local_sched_out(void);
+void __kmap_local_sched_in(void);
+static inline void kmap_assert_nomap(void)
+{
+	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
+}
+#else
+static inline void kmap_local_fork(struct task_struct *tsk) { }
+static inline void kmap_assert_nomap(void) { }
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+
+#ifndef ARCH_HAS_KMAP_FLUSH_TLB
+static inline void kmap_flush_tlb(unsigned long addr) { }
+#endif
+
+#ifndef kmap_prot
+#define kmap_prot PAGE_KERNEL
+#endif
+
+void *kmap_high(struct page *page);
+void kunmap_high(struct page *page);
+void __kmap_flush_unused(void);
+struct page *__kmap_to_page(void *addr);
+
+static inline void *kmap(struct page *page)
+{
+	void *addr;
+
+	might_sleep();
+	if (!PageHighMem(page))
+		addr = page_address(page);
+	else
+		addr = kmap_high(page);
+	kmap_flush_tlb((unsigned long)addr);
+	return addr;
+}
+
+static inline void kunmap(struct page *page)
+{
+	might_sleep();
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return __kmap_to_page(addr);
+}
+
+static inline void kmap_flush_unused(void)
+{
+	__kmap_flush_unused();
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+	pagefault_disable();
+	return __kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+	kunmap_local_indexed(addr);
+	pagefault_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
+}
+
+unsigned int __nr_free_highpages(void);
+extern atomic_long_t _totalhigh_pages;
+
+static inline unsigned int nr_free_highpages(void)
+{
+	return __nr_free_highpages();
+}
+
+static inline unsigned long totalhigh_pages(void)
+{
+	return (unsigned long)atomic_long_read(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_inc(void)
+{
+	atomic_long_inc(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_add(long count)
+{
+	atomic_long_add(count, &_totalhigh_pages);
+}
+
+#else /* CONFIG_HIGHMEM */
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return virt_to_page(addr);
+}
+
+static inline void *kmap(struct page *page)
+{
+	might_sleep();
+	return page_address(page);
+}
+
+static inline void kunmap_high(struct page *page) { }
+static inline void kmap_flush_unused(void) { }
+
+static inline void kunmap(struct page *page)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(page_address(page));
+#endif
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_disable();
+	else
+		preempt_disable();
+	pagefault_disable();
+	return page_address(page);
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+	pagefault_enable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		migrate_enable();
+	else
+		preempt_enable();
+}
+
+static inline unsigned int nr_free_highpages(void) { return 0; }
+static inline unsigned long totalhigh_pages(void) { return 0UL; }
+
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * Prevent people trying to call kunmap_atomic() as if it were kunmap()
+ * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+ */
+#define kunmap_atomic(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_atomic(__addr);				\
+} while (0)
+
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+} while (0)
+
+#endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6ae7483c486af..f597830f26b40 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -11,6 +11,119 @@
 
 #include <asm/cacheflush.h>
 
+#include "highmem-internal.h"
+
+/**
+ * kmap - Map a page for long term usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can only be invoked from preemptible task context because on 32bit
+ * systems with CONFIG_HIGHMEM enabled this function might sleep.
+ *
+ * For systems with CONFIG_HIGHMEM=n and for pages in the low memory area
+ * this returns the virtual address of the direct kernel mapping.
+ *
+ * The returned virtual address is globally visible and valid up to the
+ * point where it is unmapped via kunmap(). The pointer can be handed to
+ * other contexts.
+ *
+ * For highmem pages on 32bit systems this can be slow as the mapping space
+ * is limited and protected by a global lock. In case that there is no
+ * mapping slot available the function blocks until a slot is released via
+ * kunmap().
+ */
+static inline void *kmap(struct page *page);
+
+/**
+ * kunmap - Unmap the virtual address mapped by kmap()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
+ * pages in the low memory area.
+ */
+static inline void kunmap(struct page *page);
+
+/**
+ * kmap_to_page - Get the page for a kmap'ed address
+ * @addr:	The address to look up
+ *
+ * Returns: The page which is mapped to @addr.
+ */
+static inline struct page *kmap_to_page(void *addr);
+
+/**
+ * kmap_flush_unused - Flush all unused kmap mappings in order to
+ *		       remove stray mappings
+ */
+static inline void kmap_flush_unused(void);
+
+/**
+ * kmap_local_page - Map a page for temporary usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can be invoked from any context.
+ *
+ * Requires careful handling when nesting multiple mappings because the map
+ * management is stack based. The unmap has to be in the reverse order of
+ * the map operation:
+ *
+ * addr1 = kmap_local_page(page1);
+ * addr2 = kmap_local_page(page2);
+ * ...
+ * kunmap_local(addr2);
+ * kunmap_local(addr1);
+ *
+ * Unmapping addr1 before addr2 is invalid and causes malfunction.
+ *
+ * Contrary to kmap() mappings the mapping is only valid in the context of
+ * the caller and cannot be handed to other contexts.
+ *
+ * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+ * virtual address of the direct mapping. Only real highmem pages are
+ * temporarily mapped.
+ *
+ * While it is significantly faster than kmap() for the higmem case it
+ * comes with restrictions about the pointer validity. Only use when really
+ * necessary.
+ *
+ * On HIGHMEM enabled systems mapping a highmem page has the side effect of
+ * disabling migration in order to keep the virtual address stable across
+ * preemption. No caller of kmap_local_page() can rely on this side effect.
+ */
+static inline void *kmap_local_page(struct page *page);
+
+/**
+ * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Effectively a wrapper around kmap_local_page() which disables pagefaults
+ * and preemption.
+ *
+ * Do not use in new code. Use kmap_local_page() instead.
+ */
+static inline void *kmap_atomic(struct page *page);
+
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap_atomic().
+ *
+ * Effectively a wrapper around kunmap_local() which additionally undoes
+ * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * preemption.
+ */
+
+/* Highmem related interfaces for management code */
+static inline unsigned int nr_free_highpages(void);
+static inline unsigned long totalhigh_pages(void);
+
 #ifndef ARCH_HAS_FLUSH_ANON_PAGE
 static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
@@ -29,300 +142,6 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 }
 #endif
 
-#include <asm/kmap_types.h>
-
-/*
- * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
- */
-#ifdef CONFIG_KMAP_LOCAL
-void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
-void kunmap_local_indexed(void *vaddr);
-void kmap_local_fork(struct task_struct *tsk);
-void __kmap_local_sched_out(void);
-void __kmap_local_sched_in(void);
-static inline void kmap_assert_nomap(void)
-{
-	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
-}
-#else
-static inline void kmap_local_fork(struct task_struct *tsk) { }
-static inline void kmap_assert_nomap(void) { }
-#endif
-
-#ifdef CONFIG_HIGHMEM
-#include <asm/highmem.h>
-
-#ifndef ARCH_HAS_KMAP_FLUSH_TLB
-static inline void kmap_flush_tlb(unsigned long addr) { }
-#endif
-
-#ifndef kmap_prot
-#define kmap_prot PAGE_KERNEL
-#endif
-
-void *kmap_high(struct page *page);
-static inline void *kmap(struct page *page)
-{
-	void *addr;
-
-	might_sleep();
-	if (!PageHighMem(page))
-		addr = page_address(page);
-	else
-		addr = kmap_high(page);
-	kmap_flush_tlb((unsigned long)addr);
-	return addr;
-}
-
-void kunmap_high(struct page *page);
-
-static inline void kunmap(struct page *page)
-{
-	might_sleep();
-	if (!PageHighMem(page))
-		return;
-	kunmap_high(page);
-}
-
-/*
- * For highmem systems it is required to temporarily map pages
- * which reside in the portion of memory which is not covered
- * by the permanent kernel mapping.
- *
- * This comes in three flavors:
- *
- * 1) kmap/kunmap:
- *
- *    An interface to acquire longer term mappings with no restrictions
- *    on preemption and migration. This comes with an overhead as the
- *    mapping space is restricted and protected by a global lock. It
- *    also requires global TLB invalidation when the kmap pool wraps.
- *
- *    kmap() might block when the mapping space is fully utilized until a
- *    slot becomes available. Only callable from preemptible thread
- *    context.
- *
- * 2) kmap_local.*()/kunmap_local.*()
- *
- *    An interface to acquire short term mappings. Can be invoked from any
- *    context including interrupts. The mapping is per thread, CPU local
- *    and not globaly visible. It can only be used in the context which
- *    acquried the mapping. Nesting kmap_local.*() and kmap_atomic.*()
- *    mappings is allowed to a certain extent (up to KMAP_TYPE_NR).
- *
- *    Nested kmap_local.*() and kunmap_local.*() invocations have to be
- *    strictly ordered because the map implementation is stack based.
- *
- *    kmap_local.*() disables migration, but keeps preemption enabled. It's
- *    valid to take pagefaults in a kmap_local region unless the context in
- *    which the local kmap is acquired does not allow it for other reasons.
- *
- *    If a task holding local kmaps is preempted, the maps are removed on
- *    context switch and restored when the task comes back on the CPU. As
- *    the maps are strictly CPU local it is guaranteed that the task stays
- *    on the CPU and the CPU cannot be unplugged until the local kmaps are
- *    released.
- *
- * 3) kmap_atomic.*()/kunmap_atomic.*()
- *
- *    Based on the same mechanism as kmap local. Atomic kmap disables
- *    preemption and pagefaults. Only use if absolutely required, use
- *    the corresponding kmap_local variant if possible.
- *
- * Local and atomic kmaps are faster than kmap/kunmap, but impose
- * restrictions. Only use them when required.
- *
- * For !HIGHMEM enabled systems the kmap flavours are not doing any mapping
- * operation and kmap() won't sleep, but the kmap local and atomic variants
- * still disable migration resp. pagefaults and preemption.
- */
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_disable();
-	else
-		preempt_disable();
-	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
-}
-
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_disable();
-	else
-		preempt_disable();
-	pagefault_disable();
-	return __kmap_local_pfn_prot(pfn, kmap_prot);
-}
-
-static inline void __kunmap_atomic(void *addr)
-{
-	kunmap_local_indexed(addr);
-}
-
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
-{
-	migrate_disable();
-	return __kmap_local_page_prot(page, prot);
-}
-
-static inline void *kmap_local_page(struct page *page)
-{
-	return kmap_local_page_prot(page, kmap_prot);
-}
-
-static inline void *kmap_local_pfn(unsigned long pfn)
-{
-	migrate_disable();
-	return __kmap_local_pfn_prot(pfn, kmap_prot);
-}
-
-static inline void __kunmap_local(void *vaddr)
-{
-	kunmap_local_indexed(vaddr);
-}
-
-/* declarations for linux/mm/highmem.c */
-unsigned int nr_free_highpages(void);
-extern atomic_long_t _totalhigh_pages;
-static inline unsigned long totalhigh_pages(void)
-{
-	return (unsigned long)atomic_long_read(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_inc(void)
-{
-	atomic_long_inc(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_dec(void)
-{
-	atomic_long_dec(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_add(long count)
-{
-	atomic_long_add(count, &_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_set(long val)
-{
-	atomic_long_set(&_totalhigh_pages, val);
-}
-
-void kmap_flush_unused(void);
-
-struct page *kmap_to_page(void *addr);
-
-#else /* CONFIG_HIGHMEM */
-
-static inline unsigned int nr_free_highpages(void) { return 0; }
-
-static inline struct page *kmap_to_page(void *addr)
-{
-	return virt_to_page(addr);
-}
-
-static inline unsigned long totalhigh_pages(void) { return 0UL; }
-
-static inline void *kmap(struct page *page)
-{
-	might_sleep();
-	return page_address(page);
-}
-
-static inline void kunmap_high(struct page *page)
-{
-}
-
-static inline void kunmap(struct page *page)
-{
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(page_address(page));
-#endif
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_disable();
-	else
-		preempt_disable();
-	pagefault_disable();
-	return page_address(page);
-}
-
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	return kmap_atomic(page);
-}
-
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic(pfn_to_page(pfn));
-}
-
-static inline void __kunmap_local(void *addr)
-{
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(addr);
-#endif
-}
-
-static inline void __kunmap_atomic(void *addr)
-{
-	__kunmap_local(addr);
-}
-
-static inline void *kmap_local_page(struct page *page)
-{
-	migrate_disable();
-	return page_address(page);
-}
-
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
-{
-	return kmap_local_page(page);
-}
-
-static inline void *kmap_local_pfn(unsigned long pfn)
-{
-	return kmap_local_page(pfn_to_page(pfn));
-}
-
-#define kmap_flush_unused()	do {} while(0)
-
-#endif /* CONFIG_HIGHMEM */
-
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
- */
-#define kunmap_atomic(__addr)					\
-do {								\
-	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
-	__kunmap_atomic(__addr);				\
-	pagefault_enable();					\
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
-		migrate_enable();				\
-	else							\
-		preempt_enable();				\
-} while (0)
-
-#define kunmap_local(__addr)					\
-do {								\
-	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
-	__kunmap_local(__addr);					\
-	migrate_enable();					\
-} while (0)
-
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 2b69e2e793a41..4bb8223f2f822 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -60,34 +60,7 @@ io_mapping_fini(struct io_mapping *mapping)
 	iomap_free(mapping->base, mapping->size);
 }
 
-/* Atomic map/unmap */
-static inline void __iomem *
-io_mapping_map_atomic_wc(struct io_mapping *mapping,
-			 unsigned long offset)
-{
-	resource_size_t phys_addr;
-
-	BUG_ON(offset >= mapping->size);
-	phys_addr = mapping->base + offset;
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_disable();
-	else
-		preempt_disable();
-	pagefault_disable();
-	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
-}
-
-static inline void
-io_mapping_unmap_atomic(void __iomem *vaddr)
-{
-	kunmap_local_indexed((void __force *)vaddr);
-	pagefault_enable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_enable();
-	else
-		preempt_enable();
-}
-
+/* Temporary mappings which are only valid in the current context */
 static inline void __iomem *
 io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
 {
@@ -95,14 +68,12 @@ io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	migrate_disable();
 	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void io_mapping_unmap_local(void __iomem *vaddr)
 {
 	kunmap_local_indexed((void __force *)vaddr);
-	migrate_enable();
 }
 
 static inline void __iomem *
@@ -171,41 +142,16 @@ io_mapping_unmap(void __iomem *vaddr)
 {
 }
 
-/* Atomic map/unmap */
-static inline void __iomem *
-io_mapping_map_atomic_wc(struct io_mapping *mapping,
-			 unsigned long offset)
-{
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_disable();
-	else
-		preempt_disable();
-	pagefault_disable();
-	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
-}
-
-static inline void
-io_mapping_unmap_atomic(void __iomem *vaddr)
-{
-	io_mapping_unmap(vaddr);
-	pagefault_enable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		migrate_enable();
-	else
-		preempt_enable();
-}
-
+/* Temporary mappings which are only valid in the current context */
 static inline void __iomem *
 io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
 {
-	migrate_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
 
 static inline void io_mapping_unmap_local(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
-	migrate_enable();
 }
 
 #endif /* !HAVE_ATOMIC_IOMAP */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 934b8e3cba872..83b34cb809155 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -302,6 +302,9 @@ do { \
 #define preempt_check_resched_rt()		barrier()
 #define preemptible()				0
 
+#define preempt_lazy_disable()			barrier()
+#define preempt_lazy_enable()			barrier()
+
 #endif /* CONFIG_PREEMPT_COUNT */
 
 #ifdef MODULE
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef4b5a270e2f4..30f4405dd3924 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,7 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -635,7 +635,7 @@ struct wake_q_node {
 struct kmap_ctrl {
 #ifdef CONFIG_KMAP_LOCAL
 	int				idx;
-	pte_t				pteval[KM_TYPE_NR];
+	pte_t				pteval[KM_MAX_IDX];
 #endif
 };
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3075006d720e6..3f7156f06b6ce 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,8 +197,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
-		return;
+	unsigned long flags;
+	bool frozen = true;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
@@ -207,12 +207,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			task->state = TASK_TRACED;
-	}
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	if (task->state == __TASK_TRACED)
+		task->state = TASK_TRACED;
+	else if (task->saved_state == __TASK_TRACED)
+		task->saved_state = TASK_TRACED;
+	else
+		frozen = false;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4aa84d0c421f8..7c4ac329711b4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1283,7 +1283,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1367,6 +1367,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/mm/highmem.c b/mm/highmem.c
index c62992c10d473..8db577e5290cc 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -30,7 +30,6 @@
 #include <linux/kgdb.h>
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
-#include <asm/fixmap.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -105,7 +104,7 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 atomic_long_t _totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(_totalhigh_pages);
 
-unsigned int nr_free_highpages (void)
+unsigned int __nr_free_highpages (void)
 {
 	struct zone *zone;
 	unsigned int pages = 0;
@@ -142,7 +141,7 @@ pte_t * pkmap_page_table;
 		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
 #endif
 
-struct page *kmap_to_page(void *vaddr)
+struct page *__kmap_to_page(void *vaddr)
 {
 	unsigned long addr = (unsigned long)vaddr;
 
@@ -153,7 +152,7 @@ struct page *kmap_to_page(void *vaddr)
 
 	return virt_to_page(addr);
 }
-EXPORT_SYMBOL(kmap_to_page);
+EXPORT_SYMBOL(__kmap_to_page);
 
 static void flush_all_zero_pkmaps(void)
 {
@@ -195,10 +194,7 @@ static void flush_all_zero_pkmaps(void)
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
-/**
- * kmap_flush_unused - flush all unused kmap mappings in order to remove stray mappings
- */
-void kmap_flush_unused(void)
+void __kmap_flush_unused(void)
 {
 	lock_kmap();
 	flush_all_zero_pkmaps();
@@ -367,13 +363,24 @@ EXPORT_SYMBOL(kunmap_high);
 
 #ifdef CONFIG_KMAP_LOCAL
 
+#include <asm/kmap_size.h>
+
+/*
+ * With DEBUG_HIGHMEM the stack depth is doubled and every second
+ * slot is unused which acts as a guard page
+ */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_INCR	2
+#else
+# define KM_INCR	1
+#endif
+
 static inline int kmap_local_idx_push(void)
 {
-	int idx = current->kmap_ctrl.idx++;
-
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-	return idx;
+	current->kmap_ctrl.idx += KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline int kmap_local_idx(void)
@@ -383,7 +390,7 @@ static inline int kmap_local_idx(void)
 
 static inline void kmap_local_idx_pop(void)
 {
-	current->kmap_ctrl.idx--;
+	current->kmap_ctrl.idx -= KM_INCR;
 	BUG_ON(current->kmap_ctrl.idx < 0);
 }
 
@@ -400,11 +407,11 @@ static inline void kmap_local_idx_pop(void)
 #endif
 
 #ifndef arch_kmap_local_map_idx
-#define arch_kmap_local_map_idx(type, pfn)	kmap_local_calc_idx(type)
+#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
 #endif
 
 #ifndef arch_kmap_local_unmap_idx
-#define arch_kmap_local_unmap_idx(type, vaddr)	kmap_local_calc_idx(type)
+#define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
 #endif
 
 #ifndef arch_kmap_local_high_get
@@ -423,9 +430,9 @@ static inline void kmap_high_unmap_local(unsigned long vaddr)
 #endif
 }
 
-static inline int kmap_local_calc_idx(int type)
+static inline int kmap_local_calc_idx(int idx)
 {
-	return type + KM_TYPE_NR * smp_processor_id();
+	return idx + KM_MAX_IDX * smp_processor_id();
 }
 
 static pte_t *__kmap_pte;
@@ -443,6 +450,11 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 	unsigned long vaddr;
 	int idx;
 
+	/*
+	 * Disable migration so resulting virtual address is stable
+	 * accross preemption.
+	 */
+	migrate_disable();
 	preempt_disable();
 	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
@@ -498,6 +510,7 @@ void kunmap_local_indexed(void *vaddr)
 	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
 	kmap_local_idx_pop();
 	preempt_enable();
+	migrate_enable();
 }
 EXPORT_SYMBOL(kunmap_local_indexed);
 
@@ -523,6 +536,11 @@ void __kmap_local_sched_out(void)
 		unsigned long addr;
 		int idx;
 
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
 		if (WARN_ON_ONCE(pte_none(pteval)))
 			continue;
 
@@ -554,6 +572,11 @@ void __kmap_local_sched_in(void)
 		unsigned long addr;
 		int idx;
 
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
 		if (WARN_ON_ONCE(pte_none(pteval)))
 			continue;
 
