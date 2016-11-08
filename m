From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.27-rt38
Date: Tue, 8 Nov 2016 17:59:21 -0500
Message-ID: <20161108175921.2f18413e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.27-rt38 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: ebb6cff1499826c1d786d3865f9331644c2ac6b8


Or to build 4.4.27-rt38 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.27.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.27-rt38.patch.xz



You can also build from 4.4.27-rt37 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.27-rt37-rt38.patch.xz



Enjoy,

-- Steve


Changes from v4.4.27-rt37:

---

Mike Galbraith (1):
      ftrace: Fix trace header alignment

Sebastian Andrzej Siewior (4):
      kernel/futex: don't deboost too early
      zsmalloc: turn that get_cpu_light() into a local_lock()
      x86/apic: get rid of "warning: 'acpi_ioapic_lock' defined but not used"
      kbuild: add -fno-PIE

Steven Rostedt (Red Hat) (1):
      Linux 4.4.27-rt38

----
 Makefile                    |  2 +-
 arch/x86/kernel/acpi/boot.c |  2 ++
 include/linux/spinlock.h    |  6 +++++
 include/linux/spinlock_rt.h |  2 ++
 kernel/futex.c              |  2 +-
 kernel/locking/rtmutex.c    | 53 +++++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c        | 32 +++++++++++++--------------
 localversion-rt             |  2 +-
 mm/zsmalloc.c               |  6 +++--
 9 files changed, 79 insertions(+), 28 deletions(-)
---------------------------
diff --git a/Makefile b/Makefile
index 3b2614a0fa1b..e2c9fdc9d22f 100644
--- a/Makefile
+++ b/Makefile
@@ -394,7 +394,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e75907601a41..a29fc4f84fc4 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -87,7 +87,9 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
  *		->ioapic_mutex
  *			->ioapic_lock
  */
+#ifdef CONFIG_X86_IO_APIC
 static DEFINE_MUTEX(acpi_ioapic_lock);
+#endif
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b241cc044bd3..02928fa5499d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -355,6 +355,12 @@ static __always_inline void spin_unlock(spinlock_t *lock)
 	raw_spin_unlock(&lock->rlock);
 }
 
+static __always_inline int spin_unlock_no_deboost(spinlock_t *lock)
+{
+	raw_spin_unlock(&lock->rlock);
+	return 0;
+}
+
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
 {
 	raw_spin_unlock_bh(&lock->rlock);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 3b2825537531..7eb87584e843 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -26,6 +26,7 @@ extern void __lockfunc rt_spin_lock(spinlock_t *lock);
 extern unsigned long __lockfunc rt_spin_lock_trace_flags(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
+extern int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock);
 extern void __lockfunc rt_spin_unlock_wait(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
@@ -112,6 +113,7 @@ static inline unsigned long spin_lock_trace_flags(spinlock_t *lock)
 #define spin_lock_nest_lock(lock, nest_lock) spin_lock_nested(lock, 0)
 
 #define spin_unlock(lock)			rt_spin_unlock(lock)
+#define spin_unlock_no_deboost(lock)		rt_spin_unlock_no_deboost(lock)
 
 #define spin_unlock_bh(lock)				\
 	do {						\
diff --git a/kernel/futex.c b/kernel/futex.c
index ad38af0bcff3..059623427b99 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1288,7 +1288,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
 	 * deboost first (and lose our higher priority), then the task might get
 	 * scheduled away before the wake up can take place.
 	 */
-	spin_unlock(&hb->lock);
+	deboost |= spin_unlock_no_deboost(&hb->lock);
 	wake_up_q(&wake_q);
 	wake_up_q_sleeper(&wake_sleeper_q);
 	if (deboost)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fde5e54f1096..6759a798c927 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -939,13 +939,14 @@ static inline void rt_spin_lock_fastlock(struct rt_mutex *lock,
 		slowfn(lock, do_mig_dis);
 }
 
-static inline void rt_spin_lock_fastunlock(struct rt_mutex *lock,
-					   void  (*slowfn)(struct rt_mutex *lock))
+static inline int rt_spin_lock_fastunlock(struct rt_mutex *lock,
+					   int  (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
 		rt_mutex_deadlock_account_unlock(current);
-	else
-		slowfn(lock);
+		return 0;
+	}
+	return slowfn(lock);
 }
 #ifdef CONFIG_SMP
 /*
@@ -1086,7 +1087,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 /*
  * Slow path to release a rt_mutex spin_lock style
  */
-static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
+static int noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 {
 	unsigned long flags;
 	WAKE_Q(wake_q);
@@ -1101,7 +1102,7 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return;
+		return 0;
 	}
 
 	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
@@ -1112,6 +1113,33 @@ static void  noinline __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
+	return 0;
+}
+
+static int noinline __sched rt_spin_lock_slowunlock_no_deboost(struct rt_mutex *lock)
+{
+	unsigned long flags;
+	WAKE_Q(wake_q);
+	WAKE_Q(wake_sleeper_q);
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	rt_mutex_deadlock_account_unlock(current);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner = NULL;
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+		return 0;
+	}
+
+	mark_wakeup_next_waiter(&wake_q, &wake_sleeper_q, lock);
+
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	wake_up_q(&wake_q);
+	wake_up_q_sleeper(&wake_sleeper_q);
+	return 1;
 }
 
 void __lockfunc rt_spin_lock__no_mg(spinlock_t *lock)
@@ -1166,6 +1194,17 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
+int __lockfunc rt_spin_unlock_no_deboost(spinlock_t *lock)
+{
+	int ret;
+
+	/* NOTE: we always pass in '1' for nested, for simplicity */
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	ret = rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock_no_deboost);
+	migrate_enable();
+	return ret;
+}
+
 void __lockfunc __rt_spin_unlock(struct rt_mutex *lock)
 {
 	rt_spin_lock_fastunlock(lock, rt_spin_lock_slowunlock);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aebdbff7d425..cad1a28bfbe2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2559,17 +2559,17 @@ get_total_entries(struct trace_buffer *buf,
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n"
-		    "#                  / _-------=> irqs-off          \n"
-		    "#                 | / _------=> need-resched      \n"
-		    "#                 || / _-----=> need-resched_lazy \n"
-		    "#                 ||| / _----=> hardirq/softirq   \n"
-		    "#                 |||| / _---=> preempt-depth     \n"
-		    "#                 ||||| / _--=> preempt-lazy-depth\n"
-		    "#                 |||||| / _-=> migrate-disable   \n"
-		    "#                 ||||||| /     delay             \n"
-		    "#  cmd     pid    |||||||| time  |   caller       \n"
-		    "#     \\   /      ||||||||  \\   |   /            \n");
+	seq_puts(m, "#                  _--------=> CPU#              \n"
+		    "#                 / _-------=> irqs-off          \n"
+		    "#                | / _------=> need-resched      \n"
+		    "#                || / _-----=> need-resched_lazy \n"
+		    "#                ||| / _----=> hardirq/softirq   \n"
+		    "#                |||| / _---=> preempt-depth     \n"
+		    "#                ||||| / _--=> preempt-lazy-depth\n"
+		    "#                |||||| / _-=> migrate-disable   \n"
+		    "#                ||||||| /     delay             \n"
+		    "# cmd     pid    |||||||| time   |  caller       \n"
+		    "#     \\   /      ||||||||   \\    |  /            \n");
 }
 
 static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
@@ -2598,11 +2598,11 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 		    "#                            |/  _-----=> need-resched_lazy\n"
 		    "#                            || / _---=> hardirq/softirq\n"
 		    "#                            ||| / _--=> preempt-depth\n"
-		    "#                            |||| /_--=> preempt-lazy-depth\n"
-		    "#                            |||||  _-=> migrate-disable   \n"
-		    "#                            ||||| /    delay\n"
-		    "#           TASK-PID   CPU#  ||||||    TIMESTAMP  FUNCTION\n"
-		    "#              | |       |   ||||||       |         |\n");
+		    "#                            |||| / _-=> preempt-lazy-depth\n"
+		    "#                            ||||| / _-=> migrate-disable   \n"
+		    "#                            |||||| /    delay\n"
+		    "#           TASK-PID   CPU#  |||||||   TIMESTAMP  FUNCTION\n"
+		    "#              | |       |   |||||||      |         |\n");
 }
 
 void
diff --git a/localversion-rt b/localversion-rt
index a3b2408c1da6..49bae8d6aa67 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt37
+-rt38
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b552fd607df8..529552c3716d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -64,6 +64,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
+#include <linux/locallock.h>
 
 /*
  * This must be power of 2 and greater than of equal to sizeof(link_free).
@@ -403,6 +404,7 @@ static unsigned int get_maxobj_per_zspage(int size, int pages_per_zspage)
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_LOCAL_IRQ_LOCK(zs_map_area_lock);
 
 static int is_first_page(struct page *page)
 {
@@ -1289,7 +1291,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+	area = &get_locked_var(zs_map_area_lock, zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1342,7 +1344,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_light();
+	put_locked_var(zs_map_area_lock, zs_map_area);
 	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
