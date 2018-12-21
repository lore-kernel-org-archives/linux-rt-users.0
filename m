From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.19.10-rt8
Date: Fri, 21 Dec 2018 18:41:40 +0100
Message-ID: <20181221174140.kni7sk4nlmgrmu7g@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.19.10-rt8 patch set. 

Changes since v4.19.10-rt7:

  - Additional trace points in i915 could fail to compile due to the
    NOTRACE in statement since last release.

  - Make a rwlock in kmemleak raw to avoid scheduling in wrong context.
    Report and patch by He Zhe.

  - Delay memory deallocation in perf on intel/x86. Reported by He Zhe,
    patch by Peter Zijlstra.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.19.10-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.10-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.10-rt8

The RT patch against v4.19.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.10-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patches-4.19.10-rt8.tar.xz

Sebastian

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 155fa4b53c56b..d0b1862649419 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3439,6 +3439,11 @@ static void free_excl_cntrs(int cpu)
 }
 
 static void intel_pmu_cpu_dying(int cpu)
+{
+	fini_debug_store_on_cpu(cpu);
+}
+
+static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
@@ -3451,8 +3456,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3541,6 +3544,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3581,6 +3585,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };
diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index cc54ec0ef75c1..33028d8f470e5 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -683,7 +683,7 @@ DEFINE_EVENT(i915_request, i915_request_add,
 	    TP_ARGS(rq)
 );
 
-#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS)
+#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS) && !defined(NOTRACE)
 DEFINE_EVENT(i915_request, i915_request_submit,
 	     TP_PROTO(struct i915_request *rq),
 	     TP_ARGS(rq)
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 17dd883198aea..b68a3d0d075f7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -26,7 +26,7 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (rwlock): protects the object_list modifications and
+ * - kmemleak_lock (raw spinlock): protects the object_list modifications and
  *   accesses to the object_tree_root. The object_list is the main list
  *   holding the metadata (struct kmemleak_object) for the allocated memory
  *   blocks. The object_tree_root is a red black tree used to look-up
@@ -197,7 +197,7 @@ static LIST_HEAD(gray_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
 /* rw_lock protecting the access to object_list and object_tree_root */
-static DEFINE_RWLOCK(kmemleak_lock);
+static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
 static struct kmem_cache *object_cache;
@@ -491,9 +491,9 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
 	if (object && !get_object(object))
@@ -513,13 +513,13 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
 	if (object) {
 		rb_erase(&object->rb_node, &object_tree_root);
 		list_del_rcu(&object->object_list);
 	}
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
 }
@@ -593,7 +593,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	/* kernel backtrace */
 	object->trace_len = __save_stack_trace(object->trace);
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
 	min_addr = min(min_addr, ptr);
 	max_addr = max(max_addr, ptr + size);
@@ -624,7 +624,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	return object;
 }
 
@@ -1310,7 +1310,7 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
 
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
 		struct kmemleak_object *object;
 		unsigned long pointer;
@@ -1367,7 +1367,7 @@ static void scan_block(void *_start, void *_end,
 			spin_unlock(&object->lock);
 		}
 	}
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
 /*
