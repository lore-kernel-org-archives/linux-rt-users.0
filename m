From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Rework kmap_high_get after kmap locking is gone
Date: Mon, 25 Jan 2010 11:44:02 +0100
Message-ID: <1264416242-1219-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100125103341.GA3712@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41982 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab0AYKoL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 05:44:11 -0500
In-Reply-To: <20100125103341.GA3712@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This obsoletes ARCH_NEEDS_KMAP_HIGH_GET without introducing a big
overhead for the archs not having defined that symbol and removes some
duplicated code previously found in kmap_high_get and kmap_high.

Before this patch three ARM defconfigs (namely cm_x300, mv78xx0 and
stmp378x) failed to compile as the part protected by
ARCH_NEEDS_KMAP_HIGH_GET wasn't adapted by commit

	b38cb5a (mm: remove kmap_lock)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/include/asm/highmem.h |    3 +-
 arch/arm/mm/dma-mapping.c      |    2 +-
 mm/highmem.c                   |   89 ++++++++++++++++----------------=
--------
 3 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/high=
mem.h
index 7f36d00..2082ed8 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -15,10 +15,9 @@
=20
 extern pte_t *pkmap_page_table;
=20
-#define ARCH_NEEDS_KMAP_HIGH_GET
-
 extern void *kmap_high(struct page *page);
 extern void *kmap_high_get(struct page *page);
+extern void kmap_high_put(struct page *page);
 extern void kunmap_high(struct page *page);
=20
 extern void *kmap(struct page *page);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1576176..4a166d9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -551,7 +551,7 @@ static void dma_cache_maint_contiguous(struct page =
*page, unsigned long offset,
 		if (vaddr) {
 			vaddr +=3D offset;
 			inner_op(vaddr, vaddr + size);
-			kunmap_high(page);
+			kmap_high_put(page);
 		}
 	}
=20
diff --git a/mm/highmem.c b/mm/highmem.c
index 446b75c..a3dd375 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -75,26 +75,6 @@ pte_t * pkmap_page_table;
=20
 static DECLARE_WAIT_QUEUE_HEAD(pkmap_wait);
=20
-
-/*
- * Most architectures have no use for kmap_high_get(), so let's abstra=
ct
- * the disabling of IRQ out of the locking in that case to save on a
- * potential useless overhead.
- */
-#ifdef ARCH_NEEDS_KMAP_HIGH_GET
-#define lock_kmap()             spin_lock_irq(&kmap_lock)
-#define unlock_kmap()           spin_unlock_irq(&kmap_lock)
-#define lock_kmap_any(flags)    spin_lock_irqsave(&kmap_lock, flags)
-#define unlock_kmap_any(flags)  spin_unlock_irqrestore(&kmap_lock, fla=
gs)
-#else
-#define lock_kmap()             spin_lock(&kmap_lock)
-#define unlock_kmap()           spin_unlock(&kmap_lock)
-#define lock_kmap_any(flags)    \
-		do { spin_lock(&kmap_lock); (void)(flags); } while (0)
-#define unlock_kmap_any(flags)  \
-		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
-#endif
-
 /*
  * Try to free a given kmap slot.
  *
@@ -313,12 +293,20 @@ static void kunmap_account(void)
 	wake_up(&pkmap_wait);
 }
=20
-void *kmap_high(struct page *page)
+/**
+ * kmap_high_get - pin a highmem page into memory
+ * @page: &struct page to pin
+ *
+ * Returns the page's current virtual memory address, or NULL if no ma=
pping
+ * exists.  When and only when a non null address is returned then a
+ * matching call to kmap_high_put() is necessary.
+ *
+ * This can be called from any context.
+ */
+void *kmap_high_get(struct page *page)
 {
 	unsigned long vaddr;
=20
-
-	kmap_account();
 again:
 	vaddr =3D (unsigned long)page_address(page);
 	if (vaddr) {
@@ -345,6 +333,29 @@ again:
 		}
 	}
=20
+	return NULL;
+}
+EXPORT_SYMBOL(kmap_high_get);
+
+void kmap_high_put(struct page *page)
+{
+	unsigned long vaddr =3D (unsigned long)page_address(page);
+
+	BUG_ON(!vaddr);
+	pkmap_put(&pkmap_count[PKMAP_NR(vaddr)]);
+}
+EXPORT_SYMBOL(kmap_high_put);
+
+void *kmap_high(struct page *page)
+{
+	unsigned long vaddr;
+
+	kmap_account();
+again:
+	vaddr =3D (unsigned long)kmap_high_get(page);
+	if (vaddr)
+		return (void *)vaddr;
+
 	vaddr =3D pkmap_insert(page);
 	if (!vaddr)
 		goto again;
@@ -354,37 +365,9 @@ again:
=20
 EXPORT_SYMBOL(kmap_high);
=20
-#ifdef ARCH_NEEDS_KMAP_HIGH_GET
-/**
- * kmap_high_get - pin a highmem page into memory
- * @page: &struct page to pin
- *
- * Returns the page's current virtual memory address, or NULL if no ma=
pping
- * exists.  When and only when a non null address is returned then a
- * matching call to kunmap_high() is necessary.
- *
- * This can be called from any context.
- */
-void *kmap_high_get(struct page *page)
-{
-	unsigned long vaddr, flags;
-
-	lock_kmap_any(flags);
-	vaddr =3D (unsigned long)page_address(page);
-	if (vaddr) {
-		BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 1);
-		pkmap_count[PKMAP_NR(vaddr)]++;
-	}
-	unlock_kmap_any(flags);
-	return (void*) vaddr;
-}
-#endif
