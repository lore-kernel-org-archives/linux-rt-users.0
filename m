From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.10.84-rt92
Date: Mon, 10 Aug 2015 10:36:00 -0400
Message-ID: <20150810103600.42874928@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:41329 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932210AbbHJOgE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2015 10:36:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.10.84-rt92 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.10-rt
  Head SHA1: 5fba66d543ed031e3cb94088db58372ed92b5d51


Or to build 3.10.84-rt92 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.10.84.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/patch-3.10.84-rt92.patch.xz



You can also build from 3.10.84-rt91 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.10/incr/patch-3.10.84-rt91-rt92.patch.xz



Enjoy,

-- Steve


Changes from v3.10.84-rt91:

---

Bogdan Purcareata (1):
      powerpc/kvm: Disable in-kernel MPIC emulation for PREEMPT_RT_FULL

Frederic Weisbecker (1):
      x86-Tell-irq-work-about-self-IPI-support-3.14

Sebastian Andrzej Siewior (1):
      Revert "slub: delay ctor until the object is requested"

Steven Rostedt (1):
      xfs: Disable percpu SB on PREEMPT_RT_FULL

Steven Rostedt (Red Hat) (1):
      Linux 3.10.84-rt92

Thomas Gleixner (1):
      mm/slub: move slab initialization into irq enabled region

----
 arch/powerpc/kvm/Kconfig        |  1 +
 arch/x86/include/asm/Kbuild     |  1 -
 arch/x86/include/asm/irq_work.h | 11 ++++++
 arch/x86/kernel/irq_work.c      |  2 +-
 fs/xfs/xfs_linux.h              |  2 +-
 localversion-rt                 |  2 +-
 mm/slub.c                       | 86 +++++++++++++++++++----------------------
 7 files changed, 54 insertions(+), 51 deletions(-)
---------------------------
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index eb643f862579..2c3c4dff49b5 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -154,6 +154,7 @@ config KVM_E500MC
 config KVM_MPIC
 	bool "KVM in-kernel MPIC emulation"
 	depends on KVM && E500
+	depends on !PREEMPT_RT_FULL
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_MSI
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1eb77ac0613c..7f669853317a 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -5,4 +5,3 @@ genhdr-y += unistd_64.h
 genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
-generic-y += irq_work.h
diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_work.h
new file mode 100644
index 000000000000..78162f8e248b
--- /dev/null
+++ b/arch/x86/include/asm/irq_work.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_IRQ_WORK_H
+#define _ASM_IRQ_WORK_H
+
+#include <asm/processor.h>
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return cpu_has_apic;
+}
+
+#endif /* _ASM_IRQ_WORK_H */
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index ca8f703a1e70..b4325a6c67c3 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -21,7 +21,7 @@ void smp_irq_work_interrupt(struct pt_regs *regs)
 void arch_irq_work_raise(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (!cpu_has_apic)
+	if (!arch_irq_work_has_interrupt())
 		return;
 
 	apic->send_IPI_self(IRQ_WORK_VECTOR);
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 800f896a6cc4..6f07c0bcbed4 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -99,7 +99,7 @@
 /*
  * Feature macros (disable/enable)
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT_FULL)
 #define HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
 #else
 #undef  HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
diff --git a/localversion-rt b/localversion-rt
index e95e3382b7be..4905d52a4828 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt91
+-rt92
diff --git a/mm/slub.c b/mm/slub.c
index 8d8a3a641f0b..eec1443acb92 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1260,6 +1260,14 @@ struct slub_free_list {
 };
 static DEFINE_PER_CPU(struct slub_free_list, slub_free_list);
 
+static void setup_object(struct kmem_cache *s, struct page *page,
+				void *object)
+{
+	setup_object_debug(s, page, object);
+	if (unlikely(s->ctor))
+		s->ctor(object);
+}
+
 /*
  * Slab allocation and freeing
  */
@@ -1282,6 +1290,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
 	bool enableirqs;
+	void *start, *last, *p;
+	int idx, order;
 
 	flags &= gfp_allowed_mask;
 
@@ -1308,13 +1318,13 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Try a lower order alloc if possible
 		 */
 		page = alloc_slab_page(flags, node, oo);
-
-		if (page)
-			stat(s, ORDER_FALLBACK);
+		if (unlikely(!page))
+			goto out;
+		stat(s, ORDER_FALLBACK);
 	}
 
-	if (kmemcheck_enabled && page
-		&& !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
+	if (kmemcheck_enabled &&
+	    !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
 		int pages = 1 << oo_order(oo);
 
 		kmemcheck_alloc_shadow(page, oo_order(oo), flags, node);
@@ -1329,47 +1339,9 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 			kmemcheck_mark_unallocated_pages(page, pages);
 	}
 
-	if (enableirqs)
-		local_irq_disable();
-	if (!page)
-		return NULL;
-
 	page->objects = oo_objects(oo);
-	mod_zone_page_state(page_zone(page),
-		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
-		1 << oo_order(oo));
-
-	return page;
-}
-
-static void setup_object(struct kmem_cache *s, struct page *page,
-				void *object)
-{
-	setup_object_debug(s, page, object);
-#ifndef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor))
-		s->ctor(object);
-#endif
-}
-
-static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
-{
-	struct page *page;
-	void *start;
-	void *last;
-	void *p;
-	int order;
-
-	BUG_ON(flags & GFP_SLAB_BUG_MASK);
-
-	page = allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-	if (!page)
-		goto out;
 
 	order = compound_order(page);
-	inc_slabs_node(s, page_to_nid(page), page->objects);
 	memcg_bind_pages(s, order);
 	page->slab_cache = s;
 	__SetPageSlab(page);
@@ -1393,10 +1365,34 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->freelist = start;
 	page->inuse = page->objects;
 	page->frozen = 1;
+
 out:
+	if (enableirqs)
+		local_irq_disable();
+	if (!page)
+		return NULL;
+
+	mod_zone_page_state(page_zone(page),
+		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
+		1 << oo_order(oo));
+
+	inc_slabs_node(s, page_to_nid(page), page->objects);
+
 	return page;
 }
 
+static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+{
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
+		BUG();
+	}
+
+	return allocate_slab(s,
+		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+}
+
 static void __free_slab(struct kmem_cache *s, struct page *page)
 {
 	int order = compound_order(page);
@@ -2446,10 +2442,6 @@ redo:
 
 	if (unlikely(gfpflags & __GFP_ZERO) && object)
 		memset(object, 0, s->object_size);
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (unlikely(s->ctor) && object)
-		s->ctor(object);
-#endif
 
 	slab_post_alloc_hook(s, gfpflags, object);
 
