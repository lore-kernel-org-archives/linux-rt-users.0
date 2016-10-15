From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v3] mm: vmalloc: Replace purge_lock spinlock with atomic refcount
Date: Sat, 15 Oct 2016 05:52:59 -0700
Message-ID: <1476535979-27467-1-git-send-email-joelaf@google.com>
Cc: linux-rt-users@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jisheng Zhang <jszhang@marvell.com>,
        John Dias <joaodias@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The purge_lock spinlock causes high latencies with non RT kernel. This has been
reported multiple times on lkml [1] [2] and affects applications like audio.

In this patch, I replace the spinlock with an atomic refcount so that
preemption is kept turned on during purge. This Ok to do since [3] builds the
lazy free list in advance and atomically retrieves the list so any instance of
purge will have its own list it is purging. Since the individual vmap area
frees are themselves protected by a lock, this is Ok.

The only thing left is the fact that previously it had trylock behavior, so
preserve that by using the refcount to keep track of in-progress purges and
abort like previously if there is an ongoing purge. Lastly, decrement
vmap_lazy_nr as the vmap areas are freed, and not in advance, so that the
vmap_lazy_nr is not reduced too soon as suggested in [2].

Tests:
x86_64 quad core machine on kernel 4.8, run: cyclictest -p 99 -n
Concurrently in a kernel module, run vmalloc and vfree 8K buffer in a loop.
Preemption configuration: CONFIG_PREEMPT__LL=y (low-latency desktop)

Without patch, cyclictest output:
policy: fifo: loadavg: 0.05 0.01 0.00 1/85 1272          Avg:  128 Max:    1177
policy: fifo: loadavg: 0.11 0.03 0.01 2/87 1447          Avg:  122 Max:    1897
policy: fifo: loadavg: 0.10 0.03 0.01 1/89 1656          Avg:   93 Max:    2886

With patch, cyclictest output:
policy: fifo: loadavg: 1.15 0.68 0.30 1/162 8399         Avg:   92 Max:     284
policy: fifo: loadavg: 1.21 0.71 0.32 2/164 9840         Avg:   94 Max:     296
policy: fifo: loadavg: 1.18 0.72 0.32 2/166 11253        Avg:  107 Max:     321

[1] http://lists.openwall.net/linux-kernel/2016/03/23/29
[2] https://lkml.org/lkml/2016/10/9/59
[3] https://lkml.org/lkml/2016/4/15/287

[thanks Chris for the cond_resched_lock ideas]
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: John Dias <joaodias@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
v3 changes:
Fixed ordering of va pointer access and __free_vmap_area

v2 changes:
Updated test description in commit message, and typos.

 mm/vmalloc.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 613d1d9..0270723 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -626,11 +626,11 @@ void set_iounmap_nonlazy(void)
 static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
 					int sync, int force_flush)
 {
-	static DEFINE_SPINLOCK(purge_lock);
+	static atomic_t purging;
 	struct llist_node *valist;
 	struct vmap_area *va;
 	struct vmap_area *n_va;
-	int nr = 0;
+	int dofree = 0;
 
 	/*
 	 * If sync is 0 but force_flush is 1, we'll go sync anyway but callers
@@ -638,10 +638,10 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
 	 * the case that isn't actually used at the moment anyway.
 	 */
 	if (!sync && !force_flush) {
-		if (!spin_trylock(&purge_lock))
+		if (atomic_cmpxchg(&purging, 0, 1))
 			return;
 	} else
-		spin_lock(&purge_lock);
+		atomic_inc(&purging);
 
 	if (sync)
 		purge_fragmented_blocks_allcpus();
@@ -652,22 +652,23 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
 			*start = va->va_start;
 		if (va->va_end > *end)
 			*end = va->va_end;
-		nr += (va->va_end - va->va_start) >> PAGE_SHIFT;
+		dofree = 1;
 	}
 
-	if (nr)
-		atomic_sub(nr, &vmap_lazy_nr);
-
-	if (nr || force_flush)
+	if (dofree || force_flush)
 		flush_tlb_kernel_range(*start, *end);
 
-	if (nr) {
+	if (dofree) {
 		spin_lock(&vmap_area_lock);
-		llist_for_each_entry_safe(va, n_va, valist, purge_list)
+		llist_for_each_entry_safe(va, n_va, valist, purge_list) {
+			int nrfree = ((va->va_end - va->va_start) >> PAGE_SHIFT);
 			__free_vmap_area(va);
+			atomic_sub(nrfree, &vmap_lazy_nr);
+			cond_resched_lock(&vmap_area_lock);
+		}
 		spin_unlock(&vmap_area_lock);
 	}
-	spin_unlock(&purge_lock);
+	atomic_dec(&purging);
 }
 
 /*
-- 
2.8.0.rc3.226.g39d4020
