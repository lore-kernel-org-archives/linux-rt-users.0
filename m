From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt14
Date: Fri, 22 Sep 2017 11:50:42 +0200
Message-ID: <20170922095041.ppiq7oyuekip7nrx@linutronix.de>
References: <20170922094832.mer4rlkwdw3dq7ic@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170922094832.mer4rlkwdw3dq7ic@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-09-22 11:48:33 [+0200], To Thomas Gleixner wrote:
> The delta patch against v4.11.12-rt13 will be send as response to this

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 20e4fd4fd367..9bd4b7f966b5 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -2177,7 +2177,7 @@ A note on inter-event timestamps: If $common_timestamp is used in a
 histogram, the trace buffer is automatically switched over to using
 absolute timestamps and the "global" trace clock, in order to avoid
 bogus timestamp differences with other clocks that aren't coherent
-across CPUs.  This can be overriden by specifying one of the other
+across CPUs.  This can be overridden by specifying one of the other
 trace clocks instead, using the "clock=XXX" hist trigger attribute,
 where XXX is any of the clocks listed in the tracing/trace_clock
 pseudo-file.
@@ -2210,14 +2210,15 @@ Either keys or values can be saved and retrieved in this way.  This
 creates a variable named 'ts0' for a histogram entry with the key
 'next_pid':
 
-  # echo 'hist:keys=next_pid:vals=ts0=$common_timestamp ... >> event/trigger
+  # echo 'hist:keys=next_pid:vals=$ts0:ts0=$common_timestamp ... >> \
+	event/trigger
 
 The ts0 variable can be accessed by any subsequent event having the
 same pid as 'next_pid'.
 
 Variable references are formed by prepending the variable name with
 the '$' sign.  Thus for example, the ts0 variable above would be
-referenced as '$ts0' in subsequent expressions.
+referenced as '$ts0' in expressions.
 
 Because 'vals=' is used, the $common_timestamp variable value above
 will also be summed as a normal histogram value would (though for a
@@ -2225,7 +2226,7 @@ timestamp it makes little sense).
 
 The below shows that a key value can also be saved in the same way:
 
-  # echo 'hist:key=timer_pid=common_pid ...' >> event/trigger
+  # echo 'hist:timer_pid=common_pid:key=timer_pid ...' >> event/trigger
 
 If a variable isn't a key variable or prefixed with 'vals=', the
 associated event field will be saved in a variable but won't be summed
@@ -2237,7 +2238,15 @@ Multiple variables can be assigned at the same time.  The below would
 result in both ts0 and b being created as variables, with both
 common_timestamp and field1 additionally being summed as values:
 
-  # echo 'hist:keys=pid:vals=ts0=$common_timestamp,b=field1 ... >> event/trigger
+  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=$common_timestamp,b=field1 ... >> \
+	event/trigger
+
+Note that variable assignments can appear either preceding or
+following their use.  The command below behaves identically to the
+command above:
+
+  # echo 'hist:keys=pid:ts0=$common_timestamp,b=field1:vals=$ts0,$b ... >> \
+	event/trigger
 
 Any number of variables not bound to a 'vals=' prefix can also be
 assigned by simply separating them with colons.  Below is the same
@@ -2379,7 +2388,7 @@ hist trigger specification.
     occurs, which because of the 'if comm == "cyclictest"' filter only
     happens when the executable is cyclictest:
 
-    # echo 'hist:keys=testpid=pid:onmatch(sched.sched_wakeup_new).\
+    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
             wakeup_new_test($testpid) if comm=="cyclictest"' >> \
             /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
@@ -2405,12 +2414,12 @@ hist trigger specification.
     # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
             /sys/kernel/debug/tracing/synthetic_events
 
-    Next, we specify that whenever we see a sched_wakeup event for a
+    Next, we specify that whenever we see a sched_waking event for a
     cyclictest thread, save the timestamp in a 'ts0' variable:
 
-    # echo 'hist:keys=saved_pid=pid:ts0=$common_timestamp.usecs \
+    # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=$common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+	    /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
     Then, when the corresponding thread is actually scheduled onto the
     CPU by a sched_switch event, calculate the latency and use that
@@ -2418,7 +2427,7 @@ hist trigger specification.
     wakeup_latency synthetic event:
 
     # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:\
-            onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,\
+            onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
 	            $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
 	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
 
@@ -2434,7 +2443,7 @@ hist trigger specification.
 
     # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
 
-  - onmax(var).save(field,...)
+  - onmax(var).save(field,..	.)
 
     The 'onmax(var).save(field,...)' hist trigger action is invoked
     whenever the value of 'var' associated with a histogram entry
@@ -2448,8 +2457,8 @@ hist trigger specification.
     displaying the saved values will be printed.
 
     As an example the below defines a couple of hist triggers, one for
-    sched_wakeup and another for sched_switch, keyed on pid.  Whenever
-    a sched_wakeup occurs, the timestamp is saved in the entry
+    sched_waking and another for sched_switch, keyed on pid.  Whenever
+    a sched_waking occurs, the timestamp is saved in the entry
     corresponding to the current pid, and when the scheduler switches
     back to that pid, the timestamp difference is calculated.  If the
     resulting latency, stored in wakeup_lat, exceeds the current
@@ -2458,7 +2467,7 @@ hist trigger specification.
 
     # echo 'hist:keys=pid:ts0=$common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
     # echo 'hist:keys=next_pid:\
             wakeup_lat=$common_timestamp.usecs-$ts0:\
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 908beb2aa5b8..fce70018124c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2289,7 +2289,7 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
-	queue = get_cpu_ptr(&flush_queue);
+	queue = raw_cpu_ptr(&flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
 	if (queue->next == FLUSH_QUEUE_SIZE)
@@ -2306,8 +2306,6 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 
 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) == 0)
 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
-
-	put_cpu_ptr(&flush_queue);
 }
 
 
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index eeb1a66df402..d658c2552601 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -61,6 +61,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
@@ -234,6 +237,12 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 static inline void local_irq_lock_init(int lvar) { }
 
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5a19eb77e614..da9ee6a79b41 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -309,7 +309,6 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE_BIT,
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
-	EVENT_FILE_FL_NO_DISCARD_BIT,
 };
 
 /*
@@ -324,7 +323,6 @@ enum {
  *  TRIGGER_MODE  - When set, invoke the triggers associated with the event
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
- *  NO_DISCARD    - When set, do not discard events, something needs them later
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -336,7 +334,6 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE	= (1 << EVENT_FILE_FL_TRIGGER_MODE_BIT),
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
-	EVENT_FILE_FL_NO_DISCARD	= (1 << EVENT_FILE_FL_NO_DISCARD_BIT),
 };
 
 struct trace_event_file {
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index a03192052066..bc22d54adc52 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -32,6 +32,7 @@ struct tracepoint {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
+	bool dynamic;
 };
 
 #endif
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 72438cbc92ad..f72fcfe0e66a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -37,12 +37,9 @@ extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
-			       int prio, bool dynamic);
-extern int dynamic_tracepoint_probe_register(struct tracepoint *tp,
-					     void *probe, void *data);
+			       int prio);
 extern int
-tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
-			    bool dynamic);
+tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
@@ -209,13 +206,13 @@ extern void syscall_unregfunc(void);
 				   int prio)				\
 	{								\
 		return tracepoint_probe_register_prio(&__tracepoint_##name, \
-				      (void *)probe, data, prio, false); \
+					      (void *)probe, data, prio); \
 	}								\
 	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
-					   (void *)probe, data, false); \
+						(void *)probe, data);	\
 	}								\
 	static inline void						\
 	check_trace_callback_type_##name(void (*cb)(data_proto))	\
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index f03876322d4a..79f49d73e4d0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2281,7 +2281,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	raw_spin_lock(&task->pi_lock);
 	if (task->pi_blocked_on) {
 		raw_spin_unlock(&task->pi_lock);
-		raw_spin_unlock_irq(&lock->wait_lock);
 		return -EAGAIN;
 	}
 	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c4da0de9efa1..29430b81c674 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -143,7 +143,7 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 
 enum {
 	RB_LEN_TIME_EXTEND = 8,
-	RB_LEN_TIME_STAMP = 16,
+	RB_LEN_TIME_STAMP =  8,
 };
 
 #define skip_time_extend(event) \
@@ -192,9 +192,11 @@ rb_event_length(struct ring_buffer_event *event)
 		return  event->array[0] + RB_EVNT_HDR_SIZE;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-	case RINGBUF_TYPE_TIME_STAMP:
 		return RB_LEN_TIME_EXTEND;
 
+	case RINGBUF_TYPE_TIME_STAMP:
+		return RB_LEN_TIME_STAMP;
+
 	case RINGBUF_TYPE_DATA:
 		return rb_event_data_length(event);
 	default:
@@ -2579,61 +2581,29 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * The lock and unlock are done within a preempt disable section.
  * The current_context per_cpu variable can only be modified
  * by the current task between lock and unlock. But it can
- * be modified more than once via an interrupt. To pass this
- * information from the lock to the unlock without having to
- * access the 'in_interrupt()' functions again (which do show
- * a bit of overhead in something as critical as function tracing,
- * we use a bitmask trick.
+ * be modified more than once via an interrupt. There are four
+ * different contexts that we need to consider.
  *
- *  bit 0 =  NMI context
- *  bit 1 =  IRQ context
- *  bit 2 =  SoftIRQ context
- *  bit 3 =  normal context.
+ *  Normal context.
+ *  SoftIRQ context
+ *  IRQ context
+ *  NMI context
  *
- * This works because this is the order of contexts that can
- * preempt other contexts. A SoftIRQ never preempts an IRQ
- * context.
- *
- * When the context is determined, the corresponding bit is
- * checked and set (if it was set, then a recursion of that context
- * happened).
- *
- * On unlock, we need to clear this bit. To do so, just subtract
- * 1 from the current_context and AND it to itself.
- *
- * (binary)
- *  101 - 1 = 100
- *  101 & 100 = 100 (clearing bit zero)
- *
- *  1010 - 1 = 1001
- *  1010 & 1001 = 1000 (clearing bit 1)
- *
- * The least significant bit can be cleared this way, and it
- * just so happens that it is the same bit corresponding to
- * the current context.
+ * If for some reason the ring buffer starts to recurse, we
+ * only allow that to happen at most 4 times (one for each
+ * context). If it happens 5 times, then we consider this a
+ * recusive loop and do not let it go further.
  */
 
 static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	unsigned int val = cpu_buffer->current_context;
-	int bit;
-
-	if (in_interrupt()) {
-		if (in_nmi())
-			bit = RB_CTX_NMI;
-		else if (in_irq())
-			bit = RB_CTX_IRQ;
-		else
-			bit = RB_CTX_SOFTIRQ;
-	} else
-		bit = RB_CTX_NORMAL;
-
-	if (unlikely(val & (1 << bit)))
+	if (cpu_buffer->current_context >= 4)
 		return 1;
 
-	val |= (1 << bit);
-	cpu_buffer->current_context = val;
+	cpu_buffer->current_context++;
+	/* Interrupts must see this update */
+	barrier();
 
 	return 0;
 }
@@ -2641,7 +2611,9 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 static __always_inline void
 trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	cpu_buffer->current_context &= cpu_buffer->current_context - 1;
+	/* Don't let the dec leak out */
+	barrier();
+	cpu_buffer->current_context--;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0412b61174bb..eac626bfedfb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5921,7 +5921,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->trace_buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+	if (tr->max_buffer.buffer)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
@@ -5979,8 +5979,23 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 
 int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
 {
+	int ret = 0;
+
 	mutex_lock(&trace_types_lock);
 
+	if (abs && tr->time_stamp_abs_ref++)
+		goto out;
+
+	if (!abs) {
+		if (WARN_ON_ONCE(!tr->time_stamp_abs_ref)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (--tr->time_stamp_abs_ref)
+			goto out;
+	}
+
 	ring_buffer_set_time_stamp_abs(tr->trace_buffer.buffer, abs);
 
 	/*
@@ -5990,14 +6005,14 @@ int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
 	tracing_reset_online_cpus(&tr->trace_buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+	if (tr->max_buffer.buffer)
 		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
-
+ out:
 	mutex_unlock(&trace_types_lock);
 
-	return 0;
+	return ret;
 }
 
 struct ftrace_buffer_info {
@@ -7375,6 +7390,7 @@ static int instance_mkdir(const char *name)
 
 	INIT_LIST_HEAD(&tr->systems);
 	INIT_LIST_HEAD(&tr->events);
+	INIT_LIST_HEAD(&tr->hist_vars);
 
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
@@ -8107,6 +8123,7 @@ __init static int tracer_alloc_buffers(void)
 
 	INIT_LIST_HEAD(&global_trace.systems);
 	INIT_LIST_HEAD(&global_trace.events);
+	INIT_LIST_HEAD(&global_trace.hist_vars);
 	list_add(&global_trace.list, &ftrace_trace_arrays);
 
 	apply_trace_boot_options();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6f9411df00bc..0eb1c1fdcac2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -267,6 +267,8 @@ struct trace_array {
 	/* function tracing enabled */
 	int			function_enabled;
 #endif
+	int			time_stamp_abs_ref;
+	struct list_head	hist_vars;
 };
 
 enum {
@@ -1196,16 +1198,9 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
 		*tt = event_triggers_call(file, entry, event);
 
-	if (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	    !filter_match_preds(file->filter, entry)) {
-		__trace_event_discard_commit(buffer, event);
-		return true;
-	}
-
-	if (test_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags))
-		return false;
-
-	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags)) {
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
+	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	     !filter_match_preds(file->filter, entry))) {
 		__trace_event_discard_commit(buffer, event);
 		return true;
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e2a6b4399224..33d5e5ee2169 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -299,7 +299,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
-					    file, false);
+					    file);
 		return 0;
 
 #ifdef CONFIG_PERF_EVENTS
@@ -310,7 +310,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-					    call, false);
+					    call);
 		return 0;
 	case TRACE_REG_PERF_OPEN:
 	case TRACE_REG_PERF_CLOSE:
@@ -1368,8 +1368,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 
 	/* Make sure the system still exists */
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		list_for_each_entry(dir, &tr->systems, list) {
 			if (dir == inode->i_private) {
@@ -1383,8 +1383,8 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 		}
 	}
  exit_loop:
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	if (!system)
 		return -ENODEV;
@@ -2252,15 +2252,15 @@ static void __add_event_to_tracers(struct trace_event_call *call);
 int trace_add_event_call(struct trace_event_call *call)
 {
 	int ret;
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 
 	ret = __register_event(call, NULL);
 	if (ret >= 0)
 		__add_event_to_tracers(call);
 
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -2314,13 +2314,13 @@ int trace_remove_event_call(struct trace_event_call *call)
 {
 	int ret;
 
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	down_write(&trace_event_sem);
 	ret = probe_remove_event_call(call);
 	up_write(&trace_event_sem);
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return ret;
 }
@@ -2387,8 +2387,8 @@ static int trace_module_notify(struct notifier_block *self,
 {
 	struct module *mod = data;
 
-	mutex_lock(&trace_types_lock);
 	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_events(mod);
@@ -2397,8 +2397,8 @@ static int trace_module_notify(struct notifier_block *self,
 		trace_module_remove_events(mod);
 		break;
 	}
-	mutex_unlock(&event_mutex);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index af508a33d6b8..eb77eee93611 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -28,6 +28,8 @@
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	16
 
+#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
+
 struct hist_field;
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field,
@@ -228,6 +230,12 @@ enum hist_field_flags {
 	HIST_FIELD_FL_ALIAS		= 131072,
 };
 
+struct var_defs {
+	unsigned int	n_vars;
+	char		*name[TRACING_MAP_VARS_MAX];
+	char		*expr[TRACING_MAP_VARS_MAX];
+};
+
 struct hist_trigger_attrs {
 	char		*keys_str;
 	char		*vals_str;
@@ -245,6 +253,8 @@ struct hist_trigger_attrs {
 
 	char		*action_str[HIST_ACTIONS_MAX];
 	unsigned int	n_actions;
+
+	struct var_defs	var_defs;
 };
 
 struct field_var {
@@ -289,21 +299,23 @@ struct hist_trigger_data {
 	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_max_vars;
 	unsigned int			n_max_var_str;
-	char				*last_err;
 };
 
 struct synth_field {
 	char *type;
 	char *name;
-	unsigned int size;
+	size_t size;
 	bool is_signed;
+	bool is_string;
 };
 
 struct synth_event {
 	struct list_head			list;
+	int					ref;
 	char					*name;
 	struct synth_field			**fields;
 	unsigned int				n_fields;
+	unsigned int				n_u64;
 	struct trace_event_class		class;
 	struct trace_event_call			call;
 	struct tracepoint			*tp;
@@ -321,17 +333,23 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
-	unsigned int		var_ref_idx;
-	char			*match_event;
-	char			*match_event_system;
-	char			*synth_event_name;
-	struct synth_event	*synth_event;
+	union {
+		struct {
+			unsigned int		var_ref_idx;
+			char			*match_event;
+			char			*match_event_system;
+			char			*synth_event_name;
+			struct synth_event	*synth_event;
+		} onmatch;
 
-	char			*onmax_var_str;
-	char			*onmax_fn_name;
-	unsigned int		max_var_ref_idx;
-	struct hist_field	*max_var;
-	struct hist_field	*onmax_var;
+		struct {
+			char			*var_str;
+			char			*fn_name;
+			unsigned int		max_var_ref_idx;
+			struct hist_field	*max_var;
+			struct hist_field	*var;
+		} onmax;
+	};
 };
 
 
@@ -343,9 +361,14 @@ static int hist_err_alloc(void)
 	int ret = 0;
 
 	last_hist_cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!last_hist_cmd)
+		return -ENOMEM;
+
 	hist_err_str = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
-	if (!last_hist_cmd || !hist_err_str)
+	if (!hist_err_str) {
+		kfree(last_hist_cmd);
 		ret = -ENOMEM;
+	}
 
 	return ret;
 }
@@ -355,7 +378,7 @@ static void last_cmd_set(char *str)
 	if (!last_hist_cmd || !str)
 		return;
 
-	if (strlen(last_hist_cmd) > MAX_FILTER_STR_VAL - 1)
+	if (strlen(str) > MAX_FILTER_STR_VAL - 1)
 		return;
 
 	strcpy(last_hist_cmd, str);
@@ -365,10 +388,10 @@ static void hist_err(char *str, char *var)
 {
 	int maxlen = MAX_FILTER_STR_VAL - 1;
 
-	if (strlen(hist_err_str))
+	if (!hist_err_str || !str)
 		return;
 
-	if (!hist_err_str || !str)
+	if (strlen(hist_err_str))
 		return;
 
 	if (!var)
@@ -416,7 +439,6 @@ static DEFINE_MUTEX(synth_event_mutex);
 
 struct synth_trace_event {
 	struct trace_entry	ent;
-	int			n_fields;
 	u64			fields[];
 };
 
@@ -425,192 +447,35 @@ static int synth_event_define_fields(struct trace_event_call *call)
 	struct synth_trace_event trace;
 	int offset = offsetof(typeof(trace), fields);
 	struct synth_event *event = call->data;
-	unsigned int i, size;
+	unsigned int i, size, n_u64;
 	char *name, *type;
 	bool is_signed;
 	int ret = 0;
 
-	for (i = 0; i < event->n_fields; i++) {
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		size = event->fields[i]->size;
 		is_signed = event->fields[i]->is_signed;
 		type = event->fields[i]->type;
 		name = event->fields[i]->name;
 		ret = trace_define_field(call, type, name, offset, size,
 					 is_signed, FILTER_OTHER);
-		offset += sizeof(u64);
+		if (ret)
+			break;
+
+		if (event->fields[i]->is_string) {
+			offset += STR_VAR_LEN_MAX;
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			offset += sizeof(u64);
+			n_u64++;
+		}
 	}
 
+	event->n_u64 = n_u64;
+
 	return ret;
 }
 
-static enum print_line_t print_synth_event(struct trace_iterator *iter,
-					   int flags,
-					   struct trace_event *event)
-{
-	struct trace_array *tr = iter->tr;
-	struct trace_seq *s = &iter->seq;
-	struct synth_trace_event *entry;
-	struct synth_event *se;
-	unsigned int i;
-
-	entry = (struct synth_trace_event *)iter->ent;
-	se = container_of(event, struct synth_event, call.event);
-
-	trace_seq_printf(s, "%s: ", se->name);
-
-	for (i = 0; i < entry->n_fields; i++) {
-		if (trace_seq_has_overflowed(s))
-			goto end;
-
-		/* parameter types */
-		if (tr->trace_flags & TRACE_ITER_VERBOSE)
-			trace_seq_printf(s, "%s ", "u64");
-
-		/* parameter values */
-		trace_seq_printf(s, "%s=%llu%s", se->fields[i]->name,
-				 entry->fields[i],
-				 i == entry->n_fields - 1 ? "" : ", ");
-	}
-end:
-	trace_seq_putc(s, '\n');
-
-	return trace_handle_return(s);
-}
-
-static struct trace_event_functions synth_event_funcs = {
-	.trace		= print_synth_event
-};
-
-static notrace void trace_event_raw_event_synth(void *__data,
-						u64 *var_ref_vals,
-						unsigned int var_ref_idx)
-{
-	struct trace_event_file *trace_file = __data;
-	struct synth_trace_event *entry;
-	struct trace_event_buffer fbuffer;
-	int fields_size;
-	unsigned int i;
-
-	struct synth_event *event;
-
-	event = trace_file->event_call->data;
-
-	if (trace_trigger_soft_disabled(trace_file))
-		return;
-
-	fields_size = event->n_fields * sizeof(u64);
-
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
-					   sizeof(*entry) + fields_size);
-	if (!entry)
-		return;
-
-	entry->n_fields = event->n_fields;
-
-	for (i = 0; i < event->n_fields; i++)
-		entry->fields[i] = var_ref_vals[var_ref_idx + i];
-
-	trace_event_buffer_commit(&fbuffer);
-}
-
-static void free_synth_event_print_fmt(struct trace_event_call *call)
-{
-	if (call)
-		kfree(call->print_fmt);
-}
-
-static int __set_synth_event_print_fmt(struct synth_event *event,
-				       char *buf, int len)
-{
-	int pos = 0;
-	int i;
-
-	/* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
-
-	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
-	for (i = 0; i < event->n_fields; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx%s",
-				event->fields[i]->name, sizeof(u64),
-				i == event->n_fields - 1 ? "" : ", ");
-	}
-	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
-
-	for (i = 0; i < event->n_fields; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO,
-				", ((u64)(REC->%s))", event->fields[i]->name);
-	}
-
-#undef LEN_OR_ZERO
-
-	/* return the length of print_fmt */
-	return pos;
-}
-
-static int set_synth_event_print_fmt(struct trace_event_call *call)
-{
-	struct synth_event *event = call->data;
-	char *print_fmt;
-	int len;
-
-	/* First: called with 0 length to calculate the needed length */
-	len = __set_synth_event_print_fmt(event, NULL, 0);
-
-	print_fmt = kmalloc(len + 1, GFP_KERNEL);
-	if (!print_fmt)
-		return -ENOMEM;
-
-	/* Second: actually write the @print_fmt */
-	__set_synth_event_print_fmt(event, print_fmt, len + 1);
-	call->print_fmt = print_fmt;
-
-	return 0;
-}
-
-int dynamic_trace_event_reg(struct trace_event_call *call,
-			    enum trace_reg type, void *data)
-{
-	struct trace_event_file *file = data;
-
-	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
-	switch (type) {
-	case TRACE_REG_REGISTER:
-		return dynamic_tracepoint_probe_register(call->tp,
-							 call->class->probe,
-							 file);
-	case TRACE_REG_UNREGISTER:
-		tracepoint_probe_unregister(call->tp,
-					    call->class->probe,
-					    file, true);
-		return 0;
-
-#ifdef CONFIG_PERF_EVENTS
-	case TRACE_REG_PERF_REGISTER:
-		return dynamic_tracepoint_probe_register(call->tp,
-							 call->class->perf_probe,
-							 call);
-	case TRACE_REG_PERF_UNREGISTER:
-		tracepoint_probe_unregister(call->tp,
-					    call->class->perf_probe,
-					    call, true);
-		return 0;
-	case TRACE_REG_PERF_OPEN:
-	case TRACE_REG_PERF_CLOSE:
-	case TRACE_REG_PERF_ADD:
-	case TRACE_REG_PERF_DEL:
-		return 0;
-#endif
-	}
-	return 0;
-}
-
-static void free_synth_field(struct synth_field *field)
-{
-	kfree(field->type);
-	kfree(field->name);
-	kfree(field);
-}
-
 static bool synth_field_signed(char *type)
 {
 	if (strncmp(type, "u", 1) == 0)
@@ -619,9 +484,49 @@ static bool synth_field_signed(char *type)
 	return true;
 }
 
-static unsigned int synth_field_size(char *type)
+static int synth_field_is_string(char *type)
 {
-	unsigned int size = 0;
+	if (strstr(type, "char[") != NULL)
+		return true;
+
+	return false;
+}
+
+static int synth_field_string_size(char *type)
+{
+	char buf[4], *end, *start;
+	unsigned int len;
+	int size, err;
+
+	start = strstr(type, "char[");
+	if (start == NULL)
+		return -EINVAL;
+	start += strlen("char[");
+
+	end = strchr(type, ']');
+	if (!end || end < start)
+		return -EINVAL;
+
+	len = end - start;
+	if (len > 2)
+		return -EINVAL;
+
+	strncpy(buf, start, len);
+	buf[len] = '\0';
+
+	err = kstrtouint(buf, 0, &size);
+	if (err)
+		return err;
+
+	if (size > STR_VAR_LEN_MAX)
+		return -EINVAL;
+
+	return size;
+}
+
+static int synth_field_size(char *type)
+{
+	int size = 0;
 
 	if (strcmp(type, "s64") == 0)
 		size = sizeof(s64);
@@ -653,12 +558,206 @@ static unsigned int synth_field_size(char *type)
 		size = sizeof(unsigned long);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
-	else if (strstr(type, "[") == 0)
-		size = sizeof(u64);
+	else if (synth_field_is_string(type))
+		size = synth_field_string_size(type);
 
 	return size;
 }
 
+static const char *synth_field_fmt(char *type)
+{
+	const char *fmt = "%llu";
+
+	if (strcmp(type, "s64") == 0)
+		fmt = "%lld";
+	else if (strcmp(type, "u64") == 0)
+		fmt = "%llu";
+	else if (strcmp(type, "s32") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u32") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "s16") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u16") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "s8") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "u8") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "char") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "unsigned char") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "int") == 0)
+		fmt = "%d";
+	else if (strcmp(type, "unsigned int") == 0)
+		fmt = "%u";
+	else if (strcmp(type, "long") == 0)
+		fmt = "%ld";
+	else if (strcmp(type, "unsigned long") == 0)
+		fmt = "%lu";
+	else if (strcmp(type, "pid_t") == 0)
+		fmt = "%d";
+	else if (strstr(type, "[") == 0)
+		fmt = "%s";
+
+	return fmt;
+}
+
+static enum print_line_t print_synth_event(struct trace_iterator *iter,
+					   int flags,
+					   struct trace_event *event)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	struct synth_trace_event *entry;
+	struct synth_event *se;
+	unsigned int i, n_u64;
+	char print_fmt[32];
+	const char *fmt;
+
+	entry = (struct synth_trace_event *)iter->ent;
+	se = container_of(event, struct synth_event, call.event);
+
+	trace_seq_printf(s, "%s: ", se->name);
+
+	for (i = 0, n_u64 = 0; i < se->n_fields; i++) {
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		fmt = synth_field_fmt(se->fields[i]->type);
+
+		/* parameter types */
+		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+			trace_seq_printf(s, "%s ", fmt);
+
+		sprintf(print_fmt, "%%s=%s%%s", fmt);
+
+		/* parameter values */
+		if (se->fields[i]->is_string) {
+			trace_seq_printf(s, print_fmt, se->fields[i]->name,
+					 (char *)entry->fields[n_u64],
+					 i == se->n_fields - 1 ? "" : " ");
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			trace_seq_printf(s, print_fmt, se->fields[i]->name,
+					 entry->fields[n_u64],
+					 i == se->n_fields - 1 ? "" : " ");
+			n_u64++;
+		}
+	}
+end:
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions synth_event_funcs = {
+	.trace		= print_synth_event
+};
+
+static notrace void trace_event_raw_event_synth(void *__data,
+						u64 *var_ref_vals,
+						unsigned int var_ref_idx)
+{
+	struct trace_event_file *trace_file = __data;
+	struct synth_trace_event *entry;
+	struct trace_event_buffer fbuffer;
+	struct synth_event *event;
+	unsigned int i, n_u64;
+	int fields_size = 0;
+
+	event = trace_file->event_call->data;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	fields_size = event->n_u64 * sizeof(u64);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + fields_size);
+	if (!entry)
+		return;
+
+	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+		if (event->fields[i]->is_string) {
+			char *str_val = (char *)var_ref_vals[var_ref_idx + i];
+			char *str_field = (char *)&entry->fields[n_u64];
+
+			strncpy(str_field, str_val, STR_VAR_LEN_MAX);
+			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+		} else {
+			entry->fields[i] = var_ref_vals[var_ref_idx + i];
+			n_u64++;
+		}
+	}
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void free_synth_event_print_fmt(struct trace_event_call *call)
+{
+	if (call)
+		kfree(call->print_fmt);
+}
+
+static int __set_synth_event_print_fmt(struct synth_event *event,
+				       char *buf, int len)
+{
+	const char *fmt;
+	int pos = 0;
+	int i;
+
+	/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+	for (i = 0; i < event->n_fields; i++) {
+		fmt = synth_field_fmt(event->fields[i]->type);
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s%s",
+				event->fields[i]->name, fmt,
+				i == event->n_fields - 1 ? "" : ", ");
+	}
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", REC->%s", event->fields[i]->name);
+	}
+
+#undef LEN_OR_ZERO
+
+	/* return the length of print_fmt */
+	return pos;
+}
+
+static int set_synth_event_print_fmt(struct trace_event_call *call)
+{
+	struct synth_event *event = call->data;
+	char *print_fmt;
+	int len;
+
+	/* First: called with 0 length to calculate the needed length */
+	len = __set_synth_event_print_fmt(event, NULL, 0);
+
+	print_fmt = kmalloc(len + 1, GFP_KERNEL);
+	if (!print_fmt)
+		return -ENOMEM;
+
+	/* Second: actually write the @print_fmt */
+	__set_synth_event_print_fmt(event, print_fmt, len + 1);
+	call->print_fmt = print_fmt;
+
+	return 0;
+}
+
+static void free_synth_field(struct synth_field *field)
+{
+	kfree(field->type);
+	kfree(field->name);
+	kfree(field);
+}
+
 static struct synth_field *parse_synth_field(char *field_type,
 					     char *field_name)
 {
@@ -687,8 +786,10 @@ static struct synth_field *parse_synth_field(char *field_type,
 		goto free;
 	}
 	strcat(field->type, field_type);
-	if (array)
+	if (array) {
 		strcat(field->type, array);
+		*array = '\0';
+	}
 
 	field->size = synth_field_size(field->type);
 	if (!field->size) {
@@ -696,6 +797,9 @@ static struct synth_field *parse_synth_field(char *field_type,
 		goto free;
 	}
 
+	if (synth_field_is_string(field->type))
+		field->is_string = true;
+
 	field->is_signed = synth_field_signed(field->type);
 
 	field->name = kstrdup(field_name, GFP_KERNEL);
@@ -737,6 +841,8 @@ static struct tracepoint *alloc_synth_tracepoint(char *name)
 		goto free;
 	}
 
+	tp->dynamic = true;
+
 	return tp;
  free:
 	free_synth_tracepoint(tp);
@@ -744,26 +850,29 @@ static struct tracepoint *alloc_synth_tracepoint(char *name)
 	return ERR_PTR(ret);
 }
 
+typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
+				    unsigned int var_ref_idx);
+
 static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 			       unsigned int var_ref_idx)
 {
 	struct tracepoint *tp = event->tp;
 
 	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
-		struct tracepoint_func *it_func_ptr;
-		void *it_func;
+		struct tracepoint_func *probe_func_ptr;
+		synth_probe_func_t probe_func;
 		void *__data;
 
 		if (!(cpu_online(raw_smp_processor_id())))
 			return;
 
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);
-		if (it_func_ptr) {
+		probe_func_ptr = rcu_dereference_sched((tp)->funcs);
+		if (probe_func_ptr) {
 			do {
-				it_func = (it_func_ptr)->func;
-				__data = (it_func_ptr)->data;
-				((void(*)(void *__data, u64 *var_ref_vals, unsigned int var_ref_idx))(it_func))(__data, var_ref_vals, var_ref_idx);
-			} while ((++it_func_ptr)->func);
+				probe_func = (probe_func_ptr)->func;
+				__data = (probe_func_ptr)->data;
+				probe_func(__data, var_ref_vals, var_ref_idx);
+			} while ((++probe_func_ptr)->func);
 		}
 	}
 }
@@ -809,11 +918,14 @@ static int register_synth_event(struct synth_event *event)
 		goto out;
 	}
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = dynamic_trace_event_reg;
+	call->class->reg = trace_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
 	call->data = event;
 	call->tp = event->tp;
+
+	mutex_unlock(&synth_event_mutex);
 	ret = trace_add_event_call(call);
+	mutex_lock(&synth_event_mutex);
 	if (ret) {
 		pr_warn("Failed to register synthetic event: %s\n",
 			trace_event_name(call));
@@ -822,7 +934,9 @@ static int register_synth_event(struct synth_event *event)
 
 	ret = set_synth_event_print_fmt(call);
 	if (ret < 0) {
+		mutex_unlock(&synth_event_mutex);
 		trace_remove_event_call(call);
+		mutex_lock(&synth_event_mutex);
 		goto err;
 	}
  out:
@@ -837,7 +951,9 @@ static int unregister_synth_event(struct synth_event *event)
 	struct trace_event_call *call = &event->call;
 	int ret;
 
+	mutex_unlock(&synth_event_mutex);
 	ret = trace_remove_event_call(call);
+	mutex_lock(&synth_event_mutex);
 	if (ret) {
 		pr_warn("Failed to remove synthetic event: %s\n",
 			trace_event_name(call));
@@ -924,48 +1040,19 @@ static void action_trace(struct hist_trigger_data *hist_data,
 			 struct ring_buffer_event *rbe,
 			 struct action_data *data, u64 *var_ref_vals)
 {
-	struct synth_event *event = data->synth_event;
+	struct synth_event *event = data->onmatch.synth_event;
 
-	trace_synth(event, var_ref_vals, data->var_ref_idx);
+	trace_synth(event, var_ref_vals, data->onmatch.var_ref_idx);
 }
 
-static bool check_hist_action_refs(struct hist_trigger_data *hist_data,
-				   struct synth_event *event)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_actions; i++) {
-		struct action_data *data = hist_data->actions[i];
-
-		if (data->fn == action_trace && data->synth_event == event)
-			return true;
-	}
-
-	return false;
-}
-
-static LIST_HEAD(hist_action_list);
-static LIST_HEAD(hist_var_list);
-
 struct hist_var_data {
 	struct list_head list;
 	struct hist_trigger_data *hist_data;
 };
 
-static bool check_synth_action_refs(struct synth_event *event)
-{
-	struct hist_var_data *var_data;
-
-	list_for_each_entry(var_data, &hist_action_list, list)
-		if (check_hist_action_refs(var_data->hist_data, event))
-			return true;
-
-	return false;
-}
-
 static int create_synth_event(int argc, char **argv)
 {
-	struct synth_field *fields[SYNTH_FIELDS_MAX];
+	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
 	bool delete_event = false;
 	int i, n_fields = 0, ret = 0;
@@ -981,7 +1068,7 @@ static int create_synth_event(int argc, char **argv)
 	 */
 	if (argc < 1) {
 		ret = -EINVAL;
-		goto err;
+		goto out;
 	}
 
 	name = argv[0];
@@ -993,21 +1080,22 @@ static int create_synth_event(int argc, char **argv)
 	event = find_synth_event(name);
 	if (event) {
 		if (delete_event) {
-			if (check_synth_action_refs(event)) {
+			if (event->ref) {
 				ret = -EBUSY;
 				goto out;
 			}
 			remove_synth_event(event);
-			goto err;
-		} else
-			ret = -EEXIST;
+			free_synth_event(event);
+			goto out;
+		}
+		ret = -EEXIST;
 		goto out;
 	} else if (delete_event)
 		goto out;
 
 	if (argc < 2) {
 		ret = -EINVAL;
-		goto err;
+		goto out;
 	}
 
 	for (i = 1; i < argc - 1; i++) {
@@ -1015,16 +1103,21 @@ static int create_synth_event(int argc, char **argv)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
 			ret = -EINVAL;
-			goto out;
-		}
-		fields[n_fields] = parse_synth_field(argv[i], argv[i + 1]);
-		if (!fields[n_fields])
 			goto err;
+		}
+
+		field = parse_synth_field(argv[i], argv[i + 1]);
+		if (IS_ERR(field)) {
+			ret = PTR_ERR(field);
+			goto err;
+		}
+		fields[n_fields] = field;
 		i++; n_fields++;
 	}
+
 	if (i < argc) {
 		ret = -EINVAL;
-		goto out;
+		goto err;
 	}
 
 	event = alloc_synth_event(name, n_fields, fields);
@@ -1055,7 +1148,7 @@ static int release_all_synth_events(void)
 	mutex_lock(&synth_event_mutex);
 
 	list_for_each_entry(event, &synth_event_list, list) {
-		if (check_synth_action_refs(event)) {
+		if (event->ref) {
 			ret = -EBUSY;
 			goto out;
 		}
@@ -1217,10 +1310,11 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 					   unsigned int var_idx)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_field *found = NULL;
 	struct hist_var_data *var_data;
 
-	list_for_each_entry(var_data, &hist_var_list, list) {
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
 		found = find_var_ref(var_data->hist_data, hist_data, var_idx);
 		if (found)
 			break;
@@ -1250,9 +1344,10 @@ static bool check_var_refs(struct hist_trigger_data *hist_data)
 
 static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_var_data *var_data, *found = NULL;
 
-	list_for_each_entry(var_data, &hist_var_list, list) {
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
 		if (var_data->hist_data == hist_data) {
 			found = var_data;
 			break;
@@ -1265,40 +1360,56 @@ static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
 static bool has_hist_vars(struct hist_trigger_data *hist_data)
 {
 	struct hist_field *hist_field;
-	bool found = false;
-	int i;
+	int i, j;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR) {
-			found = true;
-			break;
+		if (hist_field &&
+		    (hist_field->flags & HIST_FIELD_FL_VAR ||
+		     hist_field->flags & HIST_FIELD_FL_VAR_REF))
+			return true;
+
+		for (j = 0; j < HIST_FIELD_OPERANDS_MAX; j++) {
+			struct hist_field *operand;
+
+			operand = hist_field->operands[j];
+			if (operand &&
+			    (operand->flags & HIST_FIELD_FL_VAR ||
+			     operand->flags & HIST_FIELD_FL_VAR_REF))
+				return true;
 		}
 	}
 
-	return found;
+	return false;
 }
 
 static int save_hist_vars(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_var_data *var_data;
 
 	var_data = find_hist_vars(hist_data);
 	if (var_data)
 		return 0;
 
+	if (trace_array_get(tr) < 0)
+		return -ENODEV;
+
 	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
-	if (!var_data)
+	if (!var_data) {
+		trace_array_put(tr);
 		return -ENOMEM;
+	}
 
 	var_data->hist_data = hist_data;
-	list_add(&var_data->list, &hist_var_list);
+	list_add(&var_data->list, &tr->hist_vars);
 
 	return 0;
 }
 
 static void remove_hist_vars(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_var_data *var_data;
 
 	var_data = find_hist_vars(hist_data);
@@ -1311,6 +1422,8 @@ static void remove_hist_vars(struct hist_trigger_data *hist_data)
 	list_del(&var_data->list);
 
 	kfree(var_data);
+
+	trace_array_put(tr);
 }
 
 static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
@@ -1350,7 +1463,8 @@ static struct hist_field *find_var(struct trace_event_file *file,
 	return NULL;
 }
 
-static struct trace_event_file *find_var_file(const char *system,
+static struct trace_event_file *find_var_file(struct trace_array *tr,
+					      const char *system,
 					      const char *event_name,
 					      const char *var_name)
 {
@@ -1360,7 +1474,7 @@ static struct trace_event_file *find_var_file(const char *system,
 	struct trace_event_file *file;
 	const char *name;
 
-	list_for_each_entry(var_data, &hist_var_list, list) {
+	list_for_each_entry(var_data, &tr->hist_vars, list) {
 		var_hist_data = var_data->hist_data;
 		file = var_hist_data->event_file;
 		call = file->event_call;
@@ -1402,14 +1516,15 @@ static struct hist_field *find_file_var(struct trace_event_file *file,
 	return NULL;
 }
 
-static struct hist_field *find_event_var(const char *system,
+static struct hist_field *find_event_var(struct trace_array *tr,
+					 const char *system,
 					 const char *event_name,
 					 const char *var_name)
 {
 	struct hist_field *hist_field = NULL;
 	struct trace_event_file *file;
 
-	file = find_var_file(system, event_name, var_name);
+	file = find_var_file(tr, system, event_name, var_name);
 	if (!file)
 		return NULL;
 
@@ -1770,6 +1885,8 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 
 	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
 
+	size = STR_VAR_LEN_MAX;
+
 	for (i = 0; i < n_str; i++) {
 		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
 		if (!elt_data->field_var_str[i]) {
@@ -1781,18 +1898,6 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	return 0;
 }
 
-static void hist_trigger_elt_data_copy(struct tracing_map_elt *to,
-				       struct tracing_map_elt *from)
-{
-	struct hist_elt_data *from_data = from->private_data;
-	struct hist_elt_data *to_data = to->private_data;
-
-	memcpy(to_data, from_data, sizeof(*to));
-
-	if (from_data->comm)
-		memcpy(to_data->comm, from_data->comm, TASK_COMM_LEN + 1);
-}
-
 static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
 	struct hist_elt_data *private_data = elt->private_data;
@@ -1803,16 +1908,41 @@ static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 
 static const struct tracing_map_ops hist_trigger_elt_data_ops = {
 	.elt_alloc	= hist_trigger_elt_data_alloc,
-	.elt_copy	= hist_trigger_elt_data_copy,
 	.elt_free	= hist_trigger_elt_data_free,
 	.elt_init	= hist_trigger_elt_data_init,
 };
 
+static const char *get_hist_field_flags(struct hist_field *hist_field)
+{
+	const char *flags_str = NULL;
+
+	if (hist_field->flags & HIST_FIELD_FL_HEX)
+		flags_str = "hex";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM)
+		flags_str = "sym";
+	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
+		flags_str = "sym-offset";
+	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
+		flags_str = "execname";
+	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
+		flags_str = "syscall";
+	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
+		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
+
+	return flags_str;
+}
+
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
-	char *expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	char *expr;
 
-	if (!expr || level > 1)
+	if (level > 1)
+		return NULL;
+
+	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!expr)
 		return NULL;
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
@@ -1833,6 +1963,14 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (field->operands[0]->flags & HIST_FIELD_FL_VAR_REF)
 		strcat(expr, "$");
 	strcat(expr, hist_field_name(field->operands[0], 0));
+	if (field->operands[0]->flags) {
+		const char *flags_str = get_hist_field_flags(field->operands[0]);
+
+		if (flags_str) {
+			strcat(expr, ".");
+			strcat(expr, flags_str);
+		}
+	}
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
@@ -1849,6 +1987,14 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (field->operands[1]->flags & HIST_FIELD_FL_VAR_REF)
 		strcat(expr, "$");
 	strcat(expr, hist_field_name(field->operands[1], 0));
+	if (field->operands[1]->flags) {
+		const char *flags_str = get_hist_field_flags(field->operands[1]);
+
+		if (flags_str) {
+			strcat(expr, ".");
+			strcat(expr, flags_str);
+		}
+	}
 
 	return expr;
 }
@@ -1891,7 +2037,7 @@ static void destroy_hist_field(struct hist_field *hist_field,
 		return;
 
 	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
-		destroy_hist_field(hist_field->operands[i], ++level);
+		destroy_hist_field(hist_field->operands[i], level + 1);
 
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
@@ -1972,6 +2118,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	if (is_string_field(field)) {
 		flags |= HIST_FIELD_FL_STRING;
+
 		hist_field->size = MAX_FILTER_STR_VAL;
 		hist_field->type = kstrdup(field->type, GFP_KERNEL);
 		if (!hist_field->type)
@@ -2025,6 +2172,27 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 	}
 }
 
+static int init_var_ref(struct hist_field *ref_field,
+			struct hist_field *var_field)
+{
+	ref_field->var.idx = var_field->var.idx;
+	ref_field->var.hist_data = var_field->hist_data;
+	ref_field->size = var_field->size;
+	ref_field->is_signed = var_field->is_signed;
+
+	ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
+	if (!ref_field->name)
+		return -ENOMEM;
+
+	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	if (!ref_field->type) {
+		kfree(ref_field->name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct hist_field *create_var_ref(struct hist_field *var_field)
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
@@ -2032,15 +2200,7 @@ static struct hist_field *create_var_ref(struct hist_field *var_field)
 
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
-		ref_field->var.idx = var_field->var.idx;
-		ref_field->var.hist_data = var_field->hist_data;
-		ref_field->size = var_field->size;
-		ref_field->is_signed = var_field->is_signed;
-		ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
-		ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
-		if (!ref_field->name || !ref_field->type) {
-			kfree(ref_field->name);
-			kfree(ref_field->type);
+		if (init_var_ref(ref_field, var_field)) {
 			destroy_hist_field(ref_field, 0);
 			return NULL;
 		}
@@ -2057,18 +2217,58 @@ static bool is_common_field(char *var_name)
 	return false;
 }
 
-static struct hist_field *parse_var_ref(char *system, char *event_name,
-					char *var_name)
+static bool is_var_ref(char *var_name)
 {
-	struct hist_field *var_field = NULL, *ref_field = NULL;
-
 	if (!var_name || strlen(var_name) < 2 || var_name[0] != '$' ||
 	    is_common_field(var_name))
+		return false;
+
+	return true;
+}
+
+static char *field_name_from_var(struct hist_trigger_data *hist_data,
+				 char *var_name)
+{
+	char *name, *field;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->attrs->var_defs.n_vars; i++) {
+		name = hist_data->attrs->var_defs.name[i];
+
+		if (strcmp(var_name, name) == 0) {
+			field = hist_data->attrs->var_defs.expr[i];
+			if (contains_operator(field) || is_var_ref(field))
+				continue;
+			return field;
+		}
+	}
+
+	return NULL;
+}
+
+static char *local_field_var_ref(struct hist_trigger_data *hist_data,
+				 char *var_name)
+{
+	if (!is_var_ref(var_name))
 		return NULL;
 
 	var_name++;
 
-	var_field = find_event_var(system, event_name, var_name);
+	return field_name_from_var(hist_data, var_name);
+}
+
+static struct hist_field *parse_var_ref(struct trace_array *tr,
+					char *system, char *event_name,
+					char *var_name)
+{
+	struct hist_field *var_field = NULL, *ref_field = NULL;
+
+	if (!is_var_ref(var_name))
+		return NULL;
+
+	var_name++;
+
+	var_field = find_event_var(tr, system, event_name, var_name);
 	if (var_field)
 		ref_field = create_var_ref(var_field);
 
@@ -2084,27 +2284,33 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	    char *field_str, unsigned long *flags)
 {
 	struct ftrace_event_field *field = NULL;
-	char *field_name;
+	char *field_name, *modifier, *str;
 
-	field_name = strsep(&field_str, ".");
-	if (field_str) {
-		if (strcmp(field_str, "hex") == 0)
+	modifier = str = kstrdup(field_str, GFP_KERNEL);
+	if (!modifier)
+		return ERR_PTR(-ENOMEM);
+
+	field_name = strsep(&modifier, ".");
+	if (modifier) {
+		if (strcmp(modifier, "hex") == 0)
 			*flags |= HIST_FIELD_FL_HEX;
-		else if (strcmp(field_str, "sym") == 0)
+		else if (strcmp(modifier, "sym") == 0)
 			*flags |= HIST_FIELD_FL_SYM;
-		else if (strcmp(field_str, "sym-offset") == 0)
+		else if (strcmp(modifier, "sym-offset") == 0)
 			*flags |= HIST_FIELD_FL_SYM_OFFSET;
-		else if ((strcmp(field_str, "execname") == 0) &&
+		else if ((strcmp(modifier, "execname") == 0) &&
 			 (strcmp(field_name, "common_pid") == 0))
 			*flags |= HIST_FIELD_FL_EXECNAME;
-		else if (strcmp(field_str, "syscall") == 0)
+		else if (strcmp(modifier, "syscall") == 0)
 			*flags |= HIST_FIELD_FL_SYSCALL;
-		else if (strcmp(field_str, "log2") == 0)
+		else if (strcmp(modifier, "log2") == 0)
 			*flags |= HIST_FIELD_FL_LOG2;
-		else if (strcmp(field_str, "usecs") == 0)
+		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
-		else
-			return ERR_PTR(-EINVAL);
+		else {
+			field = ERR_PTR(-EINVAL);
+			goto out;
+		}
 	}
 
 	if (strcmp(field_name, "$common_timestamp") == 0) {
@@ -2116,9 +2322,13 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		*flags |= HIST_FIELD_FL_CPU;
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
-		if (!field)
-			return ERR_PTR(-EINVAL);
+		if (!field || !field->size) {
+			field = ERR_PTR(-EINVAL);
+			goto out;
+		}
 	}
+ out:
+	kfree(str);
 
 	return field;
 }
@@ -2137,13 +2347,8 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 
 	alias->fn = var_ref->fn;
 	alias->operands[0] = var_ref;
-	alias->var.idx = var_ref->var.idx;
-	alias->var.hist_data = var_ref->hist_data;
-	alias->size = var_ref->size;
-	alias->is_signed = var_ref->is_signed;
-	alias->type = kstrdup(var_ref->type, GFP_KERNEL);
-	if (!alias->type) {
-		kfree(alias->type);
+
+	if (init_var_ref(alias, var_ref)) {
 		destroy_hist_field(alias, 0);
 		return NULL;
 	}
@@ -2156,6 +2361,7 @@ struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 			      unsigned long *flags, char *var_name)
 {
 	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct ftrace_event_field *field = NULL;
 	struct hist_field *hist_field = NULL;
 	int ret = 0;
@@ -2170,19 +2376,23 @@ struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 		}
 	}
 
-	hist_field = parse_var_ref(ref_system, ref_event, ref_var);
-	if (hist_field) {
-		hist_data->var_refs[hist_data->n_var_refs] = hist_field;
-		hist_field->var_ref_idx = hist_data->n_var_refs++;
-		if (var_name) {
-			hist_field = create_alias(hist_data, hist_field, var_name);
-			if (!hist_field) {
-				ret = -ENOMEM;
-				goto out;
+	s = local_field_var_ref(hist_data, ref_var);
+	if (!s) {
+		hist_field = parse_var_ref(tr, ref_system, ref_event, ref_var);
+		if (hist_field) {
+			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
+			hist_field->var_ref_idx = hist_data->n_var_refs++;
+			if (var_name) {
+				hist_field = create_alias(hist_data, hist_field, var_name);
+				if (!hist_field) {
+					ret = -ENOMEM;
+					goto out;
+				}
 			}
+			return hist_field;
 		}
-		return hist_field;
-	}
+	} else
+		str = s;
 
 	field = parse_field(hist_data, file, str, flags);
 	if (IS_ERR(field)) {
@@ -2213,7 +2423,6 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 {
 	struct hist_field *operand1, *expr = NULL;
 	unsigned long operand_flags;
-	char *operand1_str;
 	int ret = 0;
 	char *s;
 
@@ -2242,8 +2451,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	operand1_str = strsep(&str, "(");
-	if (!operand1_str)
+	strsep(&str, "(");
+	if (!str)
 		goto free;
 
 	flags |= HIST_FIELD_FL_EXPR;
@@ -2260,16 +2469,6 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	if (operand1 == NULL) {
-		operand_flags = 0;
-		operand1 = parse_atom(hist_data, file, operand1_str,
-				      &operand_flags, NULL);
-		if (IS_ERR(operand1)) {
-			ret = PTR_ERR(operand1);
-			goto free;
-		}
-	}
-
 	expr->fn = hist_field_unary_minus;
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
@@ -2285,6 +2484,41 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	return ERR_PTR(ret);
 }
 
+static int check_expr_operands(struct hist_field *operand1,
+			       struct hist_field *operand2)
+{
+	unsigned long operand1_flags = operand1->flags;
+	unsigned long operand2_flags = operand2->flags;
+
+	if ((operand1_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand1_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand1->var.hist_data, operand1->name);
+		if (!var)
+			return -EINVAL;
+		operand1_flags = var->flags;
+	}
+
+	if ((operand2_flags & HIST_FIELD_FL_VAR_REF) ||
+	    (operand2_flags & HIST_FIELD_FL_ALIAS)) {
+		struct hist_field *var;
+
+		var = find_var_field(operand2->var.hist_data, operand2->name);
+		if (!var)
+			return -EINVAL;
+		operand2_flags = var->flags;
+	}
+
+	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
+	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS)) {
+		hist_err("Timestamp units in expression don't match", NULL);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 				     struct trace_event_file *file,
 				     char *str, unsigned long flags,
@@ -2296,11 +2530,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	char *sep, *operand1_str;
 
 	if (level > 2)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	field_op = contains_operator(str);
+
 	if (field_op == FIELD_OP_NONE)
-		return NULL;
+		return parse_atom(hist_data, file, str, &flags, var_name);
 
 	if (field_op == FIELD_OP_UNARY_MINUS)
 		return parse_unary(hist_data, file, str, flags, var_name, ++level);
@@ -2337,16 +2572,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand2 = NULL;
 		goto free;
 	}
-	if (!operand2) {
-		operand_flags = 0;
-		operand2 = parse_atom(hist_data, file, str,
-				      &operand_flags, NULL);
-		if (IS_ERR(operand2)) {
-			ret = PTR_ERR(operand2);
-			operand2 = NULL;
-			goto free;
-		}
-	}
+
+	ret = check_expr_operands(operand1, operand2);
+	if (ret)
+		goto free;
 
 	flags |= HIST_FIELD_FL_EXPR;
 	expr = create_hist_field(hist_data, NULL, flags, var_name);
@@ -2388,51 +2617,6 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	return ERR_PTR(ret);
 }
 
-static struct hist_var_data *find_actions(struct hist_trigger_data *hist_data)
-{
-	struct hist_var_data *var_data, *found = NULL;
-
-	list_for_each_entry(var_data, &hist_action_list, list) {
-		if (var_data->hist_data == hist_data) {
-			found = var_data;
-			break;
-		}
-	}
-
-	return found;
-}
-
-static int save_hist_actions(struct hist_trigger_data *hist_data)
-{
-	struct hist_var_data *var_data;
-
-	var_data = find_actions(hist_data);
-	if (var_data)
-		return 0;
-
-	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
-	if (!var_data)
-		return -ENOMEM;
-
-	var_data->hist_data = hist_data;
-	list_add(&var_data->list, &hist_action_list);
-
-	return 0;
-}
-
-static void remove_hist_actions(struct hist_trigger_data *hist_data)
-{
-	struct hist_var_data *var_data;
-
-	var_data = find_actions(hist_data);
-	if (!var_data)
-		return;
-
-	list_del(&var_data->list);
-
-	kfree(var_data);
-}
-
 static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 				 struct trace_event_file *file)
 {
@@ -2468,7 +2652,7 @@ static bool compatible_keys(struct hist_trigger_data *target_hist_data,
 
 	for (n = 0; n < n_keys; n++) {
 		hist_field = hist_data->fields[i + n];
-		target_hist_field = hist_data->fields[j + n];
+		target_hist_field = target_hist_data->fields[j + n];
 
 		if (strcmp(hist_field->type, target_hist_field->type) != 0)
 			return false;
@@ -2503,14 +2687,10 @@ find_compatible_hist(struct hist_trigger_data *target_hist_data,
 	return NULL;
 }
 
-static struct trace_event_file *event_file(char *system, char *event_name)
+static struct trace_event_file *event_file(struct trace_array *tr,
+					   char *system, char *event_name)
 {
 	struct trace_event_file *file;
-	struct trace_array *tr;
-
-	tr = top_trace_array();
-	if (!tr)
-		return ERR_PTR(-ENODEV);
 
 	file = find_event_file(tr, system, event_name);
 	if (!file)
@@ -2523,13 +2703,13 @@ static struct hist_field *
 create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		      char *system, char *event_name, char *field_name)
 {
+	struct trace_array *tr = target_hist_data->event_file->tr;
 	struct hist_field *event_var = ERR_PTR(-EINVAL);
 	struct hist_trigger_data *hist_data;
 	unsigned int i, n, first = true;
 	struct field_var_hist *var_hist;
 	struct trace_event_file *file;
 	struct hist_field *key_field;
-	struct trace_array *tr;
 	char *saved_filter;
 	char *cmd;
 	int ret;
@@ -2540,11 +2720,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-EINVAL);
 	}
 
-	tr = top_trace_array();
-	if (!tr)
-		return ERR_PTR(-ENODEV);
+	file = event_file(tr, system, event_name);
 
-	file = event_file(system, event_name);
 	if (IS_ERR(file)) {
 		hist_err_event("onmatch: Event file not found: ",
 			       system, event_name, field_name);
@@ -2613,7 +2790,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	strcpy(cmd, "synthetic_");
 	strcat(cmd, field_name);
 
-	event_var = find_event_var(system, event_name, cmd);
+	event_var = find_event_var(tr, system, event_name, cmd);
 	if (!event_var) {
 		kfree(cmd);
 		kfree(var_hist->cmd);
@@ -2678,9 +2855,9 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 
 		if (val->flags & HIST_FIELD_FL_STRING) {
 			char *str = elt_data->field_var_str[j++];
+			char *val_str = (char *)(uintptr_t)var_val;
 
-			memcpy(str, (char *)(uintptr_t)var_val,
-			       TASK_COMM_LEN + 1);
+			strncpy(str, val_str, STR_VAR_LEN_MAX);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
@@ -2822,7 +2999,7 @@ static void onmax_print(struct seq_file *m,
 			struct tracing_map_elt *elt,
 			struct action_data *data)
 {
-	unsigned int i, save_var_idx, max_idx = data->max_var->var.idx;
+	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
 
 	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
 
@@ -2836,7 +3013,7 @@ static void onmax_print(struct seq_file *m,
 		val = tracing_map_read_var(elt, save_var_idx);
 
 		if (save_val->flags & HIST_FIELD_FL_STRING) {
-			seq_printf(m, "  %s: %-50s", save_var->var.name,
+			seq_printf(m, "  %s: %-32s", save_var->var.name,
 				   (char *)(uintptr_t)(val));
 		} else
 			seq_printf(m, "  %s: %10llu", save_var->var.name, val);
@@ -2848,8 +3025,8 @@ static void onmax_save(struct hist_trigger_data *hist_data,
 		       struct ring_buffer_event *rbe,
 		       struct action_data *data, u64 *var_ref_vals)
 {
-	unsigned int max_idx = data->max_var->var.idx;
-	unsigned int max_var_ref_idx = data->max_var_ref_idx;
+	unsigned int max_idx = data->onmax.max_var->var.idx;
+	unsigned int max_var_ref_idx = data->onmax.max_var_ref_idx;
 
 	u64 var_val, max_val;
 
@@ -2868,11 +3045,11 @@ static void onmax_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	destroy_hist_field(data->max_var, 0);
-	destroy_hist_field(data->onmax_var, 0);
+	destroy_hist_field(data->onmax.max_var, 0);
+	destroy_hist_field(data->onmax.var, 0);
 
-	kfree(data->onmax_var_str);
-	kfree(data->onmax_fn_name);
+	kfree(data->onmax.var_str);
+	kfree(data->onmax.fn_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
@@ -2894,7 +3071,7 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	unsigned int i;
 	int ret = 0;
 
-	onmax_var_str = data->onmax_var_str;
+	onmax_var_str = data->onmax.var_str;
 	if (onmax_var_str[0] != '$') {
 		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
 		return -EINVAL;
@@ -2913,28 +3090,24 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	if (!ref_field)
 		return -ENOMEM;
 
-	ref_field->var.idx = var_field->var.idx;
-	ref_field->var.hist_data = hist_data;
-	ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
-	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
-	if (!ref_field->name || !ref_field->type) {
+	if (init_var_ref(ref_field, var_field)) {
 		destroy_hist_field(ref_field, 0);
 		ret = -ENOMEM;
 		goto out;
 	}
 	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
 	ref_field->var_ref_idx = hist_data->n_var_refs++;
-	data->onmax_var = ref_field;
+	data->onmax.var = ref_field;
 
 	data->fn = onmax_save;
-	data->max_var_ref_idx = var_ref_idx;
+	data->onmax.max_var_ref_idx = var_ref_idx;
 	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
 	if (IS_ERR(max_var)) {
 		hist_err("onmax: Couldn't create onmax variable: ", "max");
 		ret = PTR_ERR(max_var);
 		goto out;
 	}
-	data->max_var = max_var;
+	data->onmax.max_var = max_var;
 
 	for (i = 0; i < data->n_params; i++) {
 		param = kstrdup(data->params[i], GFP_KERNEL);
@@ -3006,7 +3179,11 @@ static struct action_data *onmax_parse(char *str)
 	onmax_var_str = strsep(&str, ")");
 	if (!onmax_var_str || !str)
 		return ERR_PTR(-EINVAL);
-	data->onmax_var_str = kstrdup(onmax_var_str, GFP_KERNEL);
+	data->onmax.var_str = kstrdup(onmax_var_str, GFP_KERNEL);
+	if (!data->onmax.var_str) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	strsep(&str, ".");
 	if (!str)
@@ -3025,10 +3202,11 @@ static struct action_data *onmax_parse(char *str)
 		ret = parse_action_params(params, data);
 		if (ret)
 			goto free;
-	}
-	data->onmax_fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
+	} else
+		goto free;
 
-	if (!data->onmax_var_str || !data->onmax_fn_name) {
+	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
+	if (!data->onmax.fn_name) {
 		ret = -ENOMEM;
 		goto free;
 	}
@@ -3044,14 +3222,21 @@ static void onmatch_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	kfree(data->match_event);
-	kfree(data->match_event_system);
-	kfree(data->synth_event_name);
+	mutex_lock(&synth_event_mutex);
+
+	kfree(data->onmatch.match_event);
+	kfree(data->onmatch.match_event_system);
+	kfree(data->onmatch.synth_event_name);
 
 	for (i = 0; i < data->n_params; i++)
 		kfree(data->params[i]);
 
 	kfree(data);
+
+	if (data->onmatch.synth_event)
+		data->onmatch.synth_event->ref--;
+
+	mutex_unlock(&synth_event_mutex);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3082,6 +3267,7 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 		hist_data->n_field_var_str++;
 }
 
+
 static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
 {
 	unsigned int i;
@@ -3120,6 +3306,7 @@ static struct hist_field *
 onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 		 char *system, char *event, char *var)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_field *hist_field;
 
 	var++; /* skip '$' */
@@ -3127,11 +3314,11 @@ onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
 	hist_field = find_target_event_var(hist_data, system, event, var);
 	if (!hist_field) {
 		if (!system) {
-			system = data->match_event_system;
-			event = data->match_event;
+			system = data->onmatch.match_event_system;
+			event = data->onmatch.match_event;
 		}
 
-		hist_field = find_event_var(system, event, var);
+		hist_field = find_event_var(tr, system, event, var);
 	}
 
 	if (!hist_field)
@@ -3157,8 +3344,8 @@ onmatch_create_field_var(struct hist_trigger_data *hist_data,
 		hist_field = field_var->var;
 	} else {
 		if (!system) {
-			system = data->match_event_system;
-			event = data->match_event;
+			system = data->onmatch.match_event_system;
+			event = data->onmatch.match_event;
 		}
 
 		hist_field = create_field_var_hist(hist_data, system, event, var);
@@ -3186,9 +3373,9 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 
 	mutex_lock(&synth_event_mutex);
 
-	event = find_synth_event(data->synth_event_name);
+	event = find_synth_event(data->onmatch.synth_event_name);
 	if (!event) {
-		hist_err("onmatch: Couldn't find synthetic event: ", data->synth_event_name);
+		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3257,17 +3444,17 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	}
 
 	data->fn = action_trace;
-	data->synth_event = event;
-	data->var_ref_idx = var_ref_idx;
+	data->onmatch.synth_event = event;
+	data->onmatch.var_ref_idx = var_ref_idx;
 	hist_data->actions[hist_data->n_actions++] = data;
-	save_hist_actions(hist_data);
+	event->ref++;
  out:
 	mutex_unlock(&synth_event_mutex);
 
 	return ret;
 }
 
-static struct action_data *onmatch_parse(char *str)
+static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 {
 	char *match_event, *match_event_system;
 	char *synth_event_name, *params;
@@ -3290,14 +3477,23 @@ static struct action_data *onmatch_parse(char *str)
 		goto free;
 	}
 
-	if (IS_ERR(event_file(match_event_system, match_event))) {
+	if (IS_ERR(event_file(tr, match_event_system, match_event))) {
 		hist_err_event("onmatch: Invalid subsystem or event name: ",
 			       match_event_system, match_event, NULL);
 		goto free;
 	}
 
-	data->match_event = kstrdup(match_event, GFP_KERNEL);
-	data->match_event_system = kstrdup(match_event_system, GFP_KERNEL);
+	data->onmatch.match_event = kstrdup(match_event, GFP_KERNEL);
+	if (!data->onmatch.match_event) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	data->onmatch.match_event_system = kstrdup(match_event_system, GFP_KERNEL);
+	if (!data->onmatch.match_event_system) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	strsep(&str, ".");
 	if (!str) {
@@ -3310,7 +3506,12 @@ static struct action_data *onmatch_parse(char *str)
 		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
 		goto free;
 	}
-	data->synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
+
+	data->onmatch.synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
+	if (!data->onmatch.synth_event_name) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	params = strsep(&str, ")");
 	if (!params || !str || (str && strlen(str))) {
@@ -3321,12 +3522,6 @@ static struct action_data *onmatch_parse(char *str)
 	ret = parse_action_params(params, data);
 	if (ret)
 		goto free;
-
-	if (!data->match_event_system || !data->match_event ||
-	    !data->synth_event_name) {
-		ret = -ENOMEM;
-		goto free;
-	}
  out:
 	return data;
  free:
@@ -3351,63 +3546,21 @@ static int create_hitcount_val(struct hist_trigger_data *hist_data)
 	return 0;
 }
 
-static int create_val_field(struct hist_trigger_data *hist_data,
-			    unsigned int val_idx,
-			    struct trace_event_file *file,
-			    char *field_str, bool var_only)
+static int __create_val_field(struct hist_trigger_data *hist_data,
+			      unsigned int val_idx,
+			      struct trace_event_file *file,
+			      char *var_name, char *field_str,
+			      unsigned long flags)
 {
 	struct hist_field *hist_field;
-	unsigned long flags = 0;
-	char *var_name;
 	int ret = 0;
 
-	if (WARN_ON(!var_only && val_idx >= TRACING_MAP_VALS_MAX))
-		return -EINVAL;
-
-	var_name = strsep(&field_str, "=");
-	if (field_str && var_name) {
-		if (find_var(file, var_name) &&
-		    !hist_data->remove) {
-			hist_err("Variable already defined: ", var_name);
-			ret = -EINVAL;
-			goto out;
-		}
-
-		flags |= HIST_FIELD_FL_VAR;
-		hist_data->n_vars++;
-		if (hist_data->n_vars > TRACING_MAP_VARS_MAX) {
-			hist_err("Too many variables defined: ", var_name);
-			ret = -EINVAL;
-			goto out;
-		}
-
-		if (var_only)
-			flags |= HIST_FIELD_FL_VAR_ONLY;
-	} else if (!var_only && var_name != NULL && field_str == NULL) {
-		field_str = var_name;
-		var_name = NULL;
-	} else {
-		hist_err("Malformed assignment: ", var_name);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	hist_field = parse_expr(hist_data, file, field_str, flags, var_name, 0);
 	if (IS_ERR(hist_field)) {
 		ret = PTR_ERR(hist_field);
 		goto out;
 	}
 
-	if (!hist_field) {
-		hist_field = parse_atom(hist_data, file, field_str,
-					&flags, var_name);
-		if (IS_ERR(hist_field)) {
-			hist_err("Unable to parse atom: ", field_str);
-			ret = PTR_ERR(hist_field);
-			goto out;
-		}
-	}
-
 	hist_data->fields[val_idx] = hist_field;
 
 	++hist_data->n_vals;
@@ -3422,6 +3575,44 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
+static int create_val_field(struct hist_trigger_data *hist_data,
+			    unsigned int val_idx,
+			    struct trace_event_file *file,
+			    char *field_str)
+{
+	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
+		return -EINVAL;
+
+	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
+}
+
+static int create_var_field(struct hist_trigger_data *hist_data,
+			    unsigned int val_idx,
+			    struct trace_event_file *file,
+			    char *var_name, char *expr_str)
+{
+	unsigned long flags = 0;
+
+	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
+		return -EINVAL;
+
+	if (find_var(file, var_name) && !hist_data->remove) {
+		hist_err("Variable already defined: ", var_name);
+		return -EINVAL;
+	}
+
+	flags |= HIST_FIELD_FL_VAR;
+	hist_data->n_vars++;
+	if (hist_data->n_vars > TRACING_MAP_VARS_MAX) {
+		hist_err("Too many variables defined: ", var_name);
+		return -EINVAL;
+	}
+
+	flags |= HIST_FIELD_FL_VAR_ONLY;
+
+	return __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
+}
+
 static int create_val_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
@@ -3450,7 +3641,7 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		if (strcmp(field_str, "hitcount") == 0)
 			continue;
 
-		ret = create_val_field(hist_data, j++, file, field_str, false);
+		ret = create_val_field(hist_data, j++, file, field_str);
 		if (ret)
 			goto out;
 	}
@@ -3471,7 +3662,6 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 
 	unsigned long flags = 0;
 	unsigned int key_size;
-	char *var_name;
 	int ret = 0;
 
 	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
@@ -3479,38 +3669,18 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 
 	flags |= HIST_FIELD_FL_KEY;
 
-	var_name = strsep(&field_str, "=");
-	if (field_str) {
-		if (find_var(file, var_name) &&
-		    !hist_data->remove)
-			return -EINVAL;
-		flags |= HIST_FIELD_FL_VAR;
-	} else {
-		field_str = var_name;
-		var_name = NULL;
-	}
-
 	if (strcmp(field_str, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
-		hist_field = create_hist_field(hist_data, NULL, flags, var_name);
+		hist_field = create_hist_field(hist_data, NULL, flags, NULL);
 	} else {
 		hist_field = parse_expr(hist_data, file, field_str, flags,
-					var_name, 0);
+					NULL, 0);
 		if (IS_ERR(hist_field)) {
 			ret = PTR_ERR(hist_field);
 			goto out;
 		}
 
-		if (!hist_field) {
-			hist_field = parse_atom(hist_data, file, field_str,
-						&flags, var_name);
-			if (IS_ERR(hist_field)) {
-				ret = PTR_ERR(hist_field);
-				goto out;
-			}
-		}
-
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
@@ -3581,23 +3751,80 @@ static int create_key_fields(struct hist_trigger_data *hist_data,
 static int create_var_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
-	unsigned int i, j, k = hist_data->n_vals;
-	char *str, *field_str;
+	unsigned int i, j = hist_data->n_vals;
+	int ret = 0;
+
+	unsigned int n_vars = hist_data->attrs->var_defs.n_vars;
+
+	for (i = 0; i < n_vars; i++) {
+		char *var_name = hist_data->attrs->var_defs.name[i];
+		char *expr = hist_data->attrs->var_defs.expr[i];
+
+		ret = create_var_field(hist_data, j++, file, var_name, expr);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+static void free_var_defs(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->attrs->var_defs.n_vars; i++) {
+		kfree(hist_data->attrs->var_defs.name[i]);
+		kfree(hist_data->attrs->var_defs.expr[i]);
+	}
+
+	hist_data->attrs->var_defs.n_vars = 0;
+}
+
+static int parse_var_defs(struct hist_trigger_data *hist_data)
+{
+	char *s, *str, *var_name, *field_str;
+	unsigned int i, j, n_vars = 0;
 	int ret = 0;
 
 	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
 		str = hist_data->attrs->assignment_str[i];
-
 		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
 			field_str = strsep(&str, ",");
 			if (!field_str)
 				break;
-			ret = create_val_field(hist_data, k++, file, field_str, true);
-			if (ret)
-				goto out;
+
+			var_name = strsep(&field_str, "=");
+			if (!var_name || !field_str) {
+				hist_err("Malformed assignment: ", var_name);
+				ret = -EINVAL;
+				goto free;
+			}
+
+			s = kstrdup(var_name, GFP_KERNEL);
+			if (!s) {
+				ret = -ENOMEM;
+				goto free;
+			}
+			hist_data->attrs->var_defs.name[n_vars] = s;
+
+			s = kstrdup(field_str, GFP_KERNEL);
+			if (!s) {
+				ret = -ENOMEM;
+				goto free;
+			}
+			hist_data->attrs->var_defs.expr[n_vars++] = s;
+
+			hist_data->attrs->var_defs.n_vars = n_vars;
+
+			if (n_vars == TRACING_MAP_VARS_MAX)
+				goto free;
 		}
 	}
- out:
+
+	return ret;
+ free:
+	free_var_defs(hist_data);
+
 	return ret;
 }
 
@@ -3606,6 +3833,10 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 {
 	int ret;
 
+	ret = parse_var_defs(hist_data);
+	if (ret)
+		goto out;
+
 	ret = create_val_fields(hist_data, file);
 	if (ret)
 		goto out;
@@ -3618,6 +3849,8 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 	if (ret)
 		goto out;
  out:
+	free_var_defs(hist_data);
+
 	return ret;
 }
 
@@ -3678,7 +3911,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			break;
 		}
 
-		if ((strcmp(field_name, "hitcount") == 0)) {
+		if (strcmp(field_name, "hitcount") == 0) {
 			descending = is_descending(field_str);
 			if (descending < 0) {
 				ret = descending;
@@ -3689,7 +3922,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 		}
 
 		for (j = 1, k = 1; j < hist_data->n_fields; j++) {
-			unsigned idx;
+			unsigned int idx;
 
 			hist_field = hist_data->fields[j];
 			if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
@@ -3699,8 +3932,6 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 
 			test_name = hist_field_name(hist_field, 0);
 
-			if (test_name == NULL)
-				continue;
 			if (strcmp(field_name, test_name) == 0) {
 				sort_key->field_idx = idx;
 				descending = is_descending(field_str);
@@ -3742,6 +3973,7 @@ static void destroy_actions(struct hist_trigger_data *hist_data)
 static int create_actions(struct hist_trigger_data *hist_data,
 			  struct trace_event_file *file)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct action_data *data;
 	unsigned int i;
 	int ret = 0;
@@ -3753,7 +3985,7 @@ static int create_actions(struct hist_trigger_data *hist_data,
 		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
 			char *action_str = str + strlen("onmatch(");
 
-			data = onmatch_parse(action_str);
+			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data))
 				return PTR_ERR(data);
 
@@ -3801,8 +4033,8 @@ static void print_onmax_spec(struct seq_file *m,
 	unsigned int i;
 
 	seq_puts(m, ":onmax(");
-	seq_printf(m, "%s", data->onmax_var_str);
-	seq_printf(m, ").%s(", data->onmax_fn_name);
+	seq_printf(m, "%s", data->onmax.var_str);
+	seq_printf(m, ").%s(", data->onmax.fn_name);
 
 	for (i = 0; i < hist_data->n_max_vars; i++) {
 		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
@@ -3818,10 +4050,10 @@ static void print_onmatch_spec(struct seq_file *m,
 {
 	unsigned int i;
 
-	seq_printf(m, ":onmatch(%s.%s).", data->match_event_system,
-		   data->match_event);
+	seq_printf(m, ":onmatch(%s.%s).", data->onmatch.match_event_system,
+		   data->onmatch.match_event);
 
-	seq_printf(m, "%s(", data->synth_event->name);
+	seq_printf(m, "%s(", data->onmatch.synth_event->name);
 
 	for (i = 0; i < data->n_params; i++) {
 		if (i)
@@ -3935,6 +4167,7 @@ create_hist_data(unsigned int map_bits,
 
 	hist_data->attrs = attrs;
 	hist_data->remove = remove;
+	hist_data->event_file = file;
 
 	ret = create_hist_fields(hist_data, file);
 	if (ret)
@@ -3957,8 +4190,6 @@ create_hist_data(unsigned int map_bits,
 	ret = create_tracing_map_fields(hist_data);
 	if (ret)
 		goto free;
-
-	hist_data->event_file = file;
  out:
 	return hist_data;
  free:
@@ -4225,8 +4456,7 @@ hist_trigger_entry_print(struct seq_file *m,
 }
 
 static int print_entries(struct seq_file *m,
-			 struct hist_trigger_data *hist_data,
-			 unsigned int *n_dups)
+			 struct hist_trigger_data *hist_data)
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
@@ -4234,7 +4464,7 @@ static int print_entries(struct seq_file *m,
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
-					     &sort_entries, n_dups);
+					     &sort_entries);
 	if (n_entries < 0)
 		return n_entries;
 
@@ -4253,7 +4483,6 @@ static void hist_trigger_show(struct seq_file *m,
 {
 	struct hist_trigger_data *hist_data;
 	int n_entries, ret = 0;
-	unsigned int n_dups;
 
 	if (n > 0)
 		seq_puts(m, "\n\n");
@@ -4263,15 +4492,15 @@ static void hist_trigger_show(struct seq_file *m,
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
-	n_entries = print_entries(m, hist_data, &n_dups);
+	n_entries = print_entries(m, hist_data);
 	if (n_entries < 0) {
 		ret = n_entries;
 		n_entries = 0;
 	}
 
-	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n    Duplicates: %u\n",
-		   (u64)atomic64_read(&hist_data->map->hits), n_entries,
-		   (u64)atomic64_read(&hist_data->map->drops), n_dups);
+	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
+		   (u64)atomic64_read(&hist_data->map->hits),
+		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
 }
 
 static int hist_show(struct seq_file *m, void *v)
@@ -4316,28 +4545,6 @@ const struct file_operations event_hist_fops = {
 	.release = single_release,
 };
 
-static const char *get_hist_field_flags(struct hist_field *hist_field)
-{
-	const char *flags_str = NULL;
-
-	if (hist_field->flags & HIST_FIELD_FL_HEX)
-		flags_str = "hex";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM)
-		flags_str = "sym";
-	else if (hist_field->flags & HIST_FIELD_FL_SYM_OFFSET)
-		flags_str = "sym-offset";
-	else if (hist_field->flags & HIST_FIELD_FL_EXECNAME)
-		flags_str = "execname";
-	else if (hist_field->flags & HIST_FIELD_FL_SYSCALL)
-		flags_str = "syscall";
-	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
-		flags_str = "log2";
-	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
-		flags_str = "usecs";
-
-	return flags_str;
-}
-
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
 	const char *field_name = hist_field_name(hist_field, 0);
@@ -4502,8 +4709,6 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 
 		remove_hist_vars(hist_data);
 
-		remove_hist_actions(hist_data);
-
 		destroy_hist_data(hist_data);
 	}
 }
@@ -4830,8 +5035,6 @@ static bool hist_file_check_refs(struct trace_event_file *file)
 	struct hist_trigger_data *hist_data;
 	struct event_trigger_data *test;
 
-	printk("func: %s\n", __func__);
-
 	list_for_each_entry_rcu(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
@@ -4849,7 +5052,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 
 	if (hist_file_check_refs(file))
-	    return;
+		return;
 
 	list_for_each_entry_safe(test, n, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
@@ -4872,6 +5075,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
+	struct synth_event *se;
+	const char *se_name;
 	bool remove = false;
 	char *trigger, *p;
 	int ret = 0;
@@ -4945,6 +5150,14 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		}
 
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+
+		mutex_lock(&synth_event_mutex);
+		se_name = trace_event_name(file->event_call);
+		se = find_synth_event(se_name);
+		if (se)
+			se->ref--;
+		mutex_unlock(&synth_event_mutex);
+
 		ret = 0;
 		goto out_free;
 	}
@@ -4963,6 +5176,13 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	} else if (ret < 0)
 		goto out_free;
 
+	mutex_lock(&synth_event_mutex);
+	se_name = trace_event_name(file->event_call);
+	se = find_synth_event(se_name);
+	if (se)
+		se->ref++;
+	mutex_unlock(&synth_event_mutex);
+
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
@@ -4996,8 +5216,6 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 
 	remove_hist_vars(hist_data);
 
-	remove_hist_actions(hist_data);
-
 	kfree(trigger_data);
 	destroy_hist_data(hist_data);
 
@@ -5007,7 +5225,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
-	.flags			= EVENT_CMD_FL_NEEDS_REC | EVENT_CMD_FL_POST_TRIGGER,
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
 	.func			= event_hist_trigger_func,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
@@ -5162,16 +5380,9 @@ __init int register_trigger_hist_enable_disable_cmds(void)
 static __init int trace_events_hist_init(void)
 {
 	struct dentry *entry = NULL;
-	struct trace_array *tr;
 	struct dentry *d_tracer;
 	int err = 0;
 
-	tr = top_trace_array();
-	if (!tr) {
-		err = -ENODEV;
-		goto err;
-	}
-
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer)) {
 		err = PTR_ERR(d_tracer);
@@ -5179,7 +5390,7 @@ static __init int trace_events_hist_init(void)
 	}
 
 	entry = tracefs_create_file("synthetic_events", 0644, d_tracer,
-				    tr, &synth_events_fops);
+				    NULL, &synth_events_fops);
 	if (!entry) {
 		err = -ENODEV;
 		goto err;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4aefacfc298c..a7a5bed9ce06 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -505,30 +505,20 @@ clear_event_triggers(struct trace_array *tr)
 void update_cond_flag(struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
-	bool set_cond = false, set_no_discard = false;
+	bool set_cond = false;
 
 	list_for_each_entry_rcu(data, &file->triggers, list) {
 		if (data->filter || event_command_post_trigger(data->cmd_ops) ||
-		    event_command_needs_rec(data->cmd_ops))
+		    event_command_needs_rec(data->cmd_ops)) {
 			set_cond = true;
-
-		if (event_command_post_trigger(data->cmd_ops) &&
-		    event_command_needs_rec(data->cmd_ops))
-			set_no_discard = true;
-
-		if (set_cond && set_no_discard)
 			break;
+		}
 	}
 
 	if (set_cond)
 		set_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
 	else
 		clear_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
-
-	if (set_no_discard)
-		set_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
-	else
-		clear_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
 }
 
 /**
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9ed04b61dc5b..08c38f4234f0 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -519,6 +519,7 @@ static inline struct tracing_map_elt *
 __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 {
 	u32 idx, key_hash, test_key;
+	int dup_try = 0;
 	struct tracing_map_entry *entry;
 
 	key_hash = jhash(key, map->key_size, 0);
@@ -531,10 +532,32 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 		entry = TRACING_MAP_ENTRY(map->map, idx);
 		test_key = entry->key;
 
-		if (test_key && test_key == key_hash && entry->val &&
-		    keys_match(key, entry->val->key, map->key_size)) {
-			atomic64_inc(&map->hits);
-			return entry->val;
+		if (test_key && test_key == key_hash) {
+			if (entry->val &&
+			    keys_match(key, entry->val->key, map->key_size)) {
+				if (!lookup_only)
+					atomic64_inc(&map->hits);
+				return entry->val;
+			} else if (unlikely(!entry->val)) {
+				/*
+				 * The key is present. But, val (pointer to elt
+				 * struct) is still NULL. which means some other
+				 * thread is in the process of inserting an
+				 * element.
+				 *
+				 * On top of that, it's key_hash is same as the
+				 * one being inserted right now. So, it's
+				 * possible that the element has the same
+				 * key as well.
+				 */
+
+				dup_try++;
+				if (dup_try > map->map_size) {
+					atomic64_inc(&map->drops);
+					break;
+				}
+				continue;
+			}
 		}
 
 		if (!test_key) {
@@ -556,6 +579,13 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				atomic64_inc(&map->hits);
 
 				return entry->val;
+			} else {
+				/*
+				 * cmpxchg() failed. Loop around once
+				 * more to check what key was inserted.
+				 */
+				dup_try++;
+				continue;
 			}
 		}
 
@@ -920,72 +950,15 @@ create_sort_entry(void *key, struct tracing_map_elt *elt)
 	return sort_entry;
 }
 
-static struct tracing_map_elt *copy_elt(struct tracing_map_elt *elt)
-{
-	struct tracing_map_elt *dup_elt;
-	unsigned int i;
-
-	dup_elt = tracing_map_elt_alloc(elt->map);
-	if (IS_ERR(dup_elt))
-		return NULL;
-
-	if (elt->map->ops && elt->map->ops->elt_copy)
-		elt->map->ops->elt_copy(dup_elt, elt);
-
-	dup_elt->private_data = elt->private_data;
-	memcpy(dup_elt->key, elt->key, elt->map->key_size);
-
-	for (i = 0; i < elt->map->n_fields; i++) {
-		atomic64_set(&dup_elt->fields[i].sum,
-			     atomic64_read(&elt->fields[i].sum));
-		dup_elt->fields[i].cmp_fn = elt->fields[i].cmp_fn;
-	}
-
-	for (i = 0; i < elt->map->n_vars; i++) {
-		atomic64_set(&dup_elt->vars[i], atomic64_read(&elt->vars[i]));
-		dup_elt->var_set[i] = elt->var_set[i];
-	}
-
-	return dup_elt;
-}
-
-static int merge_dup(struct tracing_map_sort_entry **sort_entries,
-		     unsigned int target, unsigned int dup)
-{
-	struct tracing_map_elt *target_elt, *elt;
-	bool first_dup = (target - dup) == 1;
-	int i;
-
-	if (first_dup) {
-		elt = sort_entries[target]->elt;
-		target_elt = copy_elt(elt);
-		if (!target_elt)
-			return -ENOMEM;
-		sort_entries[target]->elt = target_elt;
-		sort_entries[target]->elt_copied = true;
-	} else
-		target_elt = sort_entries[target]->elt;
-
-	elt = sort_entries[dup]->elt;
-
-	for (i = 0; i < elt->map->n_fields; i++)
-		atomic64_add(atomic64_read(&elt->fields[i].sum),
-			     &target_elt->fields[i].sum);
-
-	sort_entries[dup]->dup = true;
-
-	return 0;
-}
-
-static int merge_dups(struct tracing_map_sort_entry **sort_entries,
+static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 		      int n_entries, unsigned int key_size)
 {
 	unsigned int dups = 0, total_dups = 0;
-	int err, i, j;
+	int i;
 	void *key;
 
 	if (n_entries < 2)
-		return total_dups;
+		return;
 
 	sort(sort_entries, n_entries, sizeof(struct tracing_map_sort_entry *),
 	     (int (*)(const void *, const void *))cmp_entries_dup, NULL);
@@ -994,30 +967,14 @@ static int merge_dups(struct tracing_map_sort_entry **sort_entries,
 	for (i = 1; i < n_entries; i++) {
 		if (!memcmp(sort_entries[i]->key, key, key_size)) {
 			dups++; total_dups++;
-			err = merge_dup(sort_entries, i - dups, i);
-			if (err)
-				return err;
 			continue;
 		}
 		key = sort_entries[i]->key;
 		dups = 0;
 	}
 
-	if (!total_dups)
-		return total_dups;
-
-	for (i = 0, j = 0; i < n_entries; i++) {
-		if (!sort_entries[i]->dup) {
-			sort_entries[j] = sort_entries[i];
-			if (j++ != i)
-				sort_entries[i] = NULL;
-		} else {
-			destroy_sort_entry(sort_entries[i]);
-			sort_entries[i] = NULL;
-		}
-	}
-
-	return total_dups;
+	WARN_ONCE(total_dups > 0,
+		  "Duplicates detected: %d\n", total_dups);
 }
 
 static bool is_key(struct tracing_map *map, unsigned int field_idx)
@@ -1084,7 +1041,6 @@ static void sort_secondary(struct tracing_map *map,
  * @map: The tracing_map
  * @sort_key: The sort key to use for sorting
  * @sort_entries: outval: pointer to allocated and sorted array of entries
- * @n_dups: outval: pointer to variable receiving a count of duplicates found
  *
  * tracing_map_sort_entries() sorts the current set of entries in the
  * map and returns the list of tracing_map_sort_entries containing
@@ -1101,16 +1057,13 @@ static void sort_secondary(struct tracing_map *map,
  * The client should not hold on to the returned array but should use
  * it and call tracing_map_destroy_sort_entries() when done.
  *
- * Return: the number of sort_entries in the struct
- * tracing_map_sort_entry array, negative on error.  If n_dups is
- * non-NULL, it will receive the number of duplicate entries found
- * (and merged) during the sort.
+ * Return: the number of sort_entries in the struct tracing_map_sort_entry
+ * array, negative on error
  */
 int tracing_map_sort_entries(struct tracing_map *map,
 			     struct tracing_map_sort_key *sort_keys,
 			     unsigned int n_sort_keys,
-			     struct tracing_map_sort_entry ***sort_entries,
-			     unsigned int *n_dups)
+			     struct tracing_map_sort_entry ***sort_entries)
 {
 	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
 			      const struct tracing_map_sort_entry **);
@@ -1147,12 +1100,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 		return 1;
 	}
 
-	ret = merge_dups(entries, n_entries, map->key_size);
-	if (ret < 0)
-		goto free;
-	n_entries -= ret;
-	if (n_dups)
-		*n_dups = ret;
+	detect_dups(entries, n_entries, map->key_size);
 
 	if (is_key(map, sort_keys[0].field_idx))
 		cmp_entries_fn = cmp_entries_key;
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index a44cc0c298ee..2800a6b0742f 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -218,11 +218,6 @@ struct tracing_map {
  *	Element allocation occurs before tracing begins, when the
  *	tracing_map_init() call is made by client code.
  *
- * @elt_copy: At certain points in the lifetime of an element, it may
- *	need to be copied.  The copy should include a copy of the
- *	client-allocated data, which can be copied into the 'to'
- *	element from the 'from' element.
- *
  * @elt_free: When a tracing_map_elt is freed, this function is called
  *	and allows client-allocated per-element data to be freed.
  *
@@ -236,8 +231,6 @@ struct tracing_map {
  */
 struct tracing_map_ops {
 	int			(*elt_alloc)(struct tracing_map_elt *elt);
-	void			(*elt_copy)(struct tracing_map_elt *to,
-					    struct tracing_map_elt *from);
 	void			(*elt_free)(struct tracing_map_elt *elt);
 	void			(*elt_clear)(struct tracing_map_elt *elt);
 	void			(*elt_init)(struct tracing_map_elt *elt);
@@ -286,8 +279,7 @@ extern int
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
 			 unsigned int n_sort_keys,
-			 struct tracing_map_sort_entry ***sort_entries,
-			 unsigned int *n_dups);
+			 struct tracing_map_sort_entry ***sort_entries);
 
 extern void
 tracing_map_destroy_sort_entries(struct tracing_map_sort_entry **entries,
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 4068809223ea..1c5957f23b9a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -192,14 +192,13 @@ static void *func_remove(struct tracepoint_func **funcs,
  * Add the probe function to a tracepoint.
  */
 static int tracepoint_add_func(struct tracepoint *tp,
-			       struct tracepoint_func *func, int prio,
-			       bool dynamic)
+			       struct tracepoint_func *func, int prio)
 {
 	struct tracepoint_func *old, *tp_funcs;
 	int ret;
 
 	if (tp->regfunc &&
-	    ((dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
+	    ((tp->dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
 	     !static_key_enabled(&tp->key))) {
 		ret = tp->regfunc();
 		if (ret < 0)
@@ -222,9 +221,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * is used.
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	if (dynamic && !(atomic_read(&tp->key.enabled) > 0))
+	if (tp->dynamic && !(atomic_read(&tp->key.enabled) > 0))
 		atomic_inc(&tp->key.enabled);
-	else if (!dynamic && !static_key_enabled(&tp->key))
+	else if (!tp->dynamic && !static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
 	release_probes(old);
 	return 0;
@@ -237,7 +236,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
  * by preempt_disable around the call site.
  */
 static int tracepoint_remove_func(struct tracepoint *tp,
-				  struct tracepoint_func *func, bool dynamic)
+		struct tracepoint_func *func)
 {
 	struct tracepoint_func *old, *tp_funcs;
 
@@ -252,13 +251,13 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 	if (!tp_funcs) {
 		/* Removed last function */
 		if (tp->unregfunc &&
-		    ((dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
+		    ((tp->dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
 		     static_key_enabled(&tp->key)))
 			tp->unregfunc();
 
-		if (dynamic && (atomic_read(&tp->key.enabled) > 0))
+		if (tp->dynamic && (atomic_read(&tp->key.enabled) > 0))
 			atomic_dec(&tp->key.enabled);
-		else if (!dynamic && static_key_enabled(&tp->key))
+		else if (!tp->dynamic && static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
 	rcu_assign_pointer(tp->funcs, tp_funcs);
@@ -280,7 +279,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
  * within module exit functions.
  */
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
-				   void *data, int prio, bool dynamic)
+				   void *data, int prio)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -289,7 +288,7 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 	tp_func.func = probe;
 	tp_func.data = data;
 	tp_func.prio = prio;
-	ret = tracepoint_add_func(tp, &tp_func, prio, dynamic);
+	ret = tracepoint_add_func(tp, &tp_func, prio);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
@@ -310,18 +309,10 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  */
 int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
 {
-	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO, false);
+	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 
-int dynamic_tracepoint_probe_register(struct tracepoint *tp, void *probe,
-				      void *data)
-{
-	return tracepoint_probe_register_prio(tp, probe, data,
-					      TRACEPOINT_DEFAULT_PRIO, true);
-}
-EXPORT_SYMBOL_GPL(dynamic_tracepoint_probe_register);
-
 /**
  * tracepoint_probe_unregister -  Disconnect a probe from a tracepoint
  * @tp: tracepoint
@@ -330,8 +321,7 @@ EXPORT_SYMBOL_GPL(dynamic_tracepoint_probe_register);
  *
  * Returns 0 if ok, error value on error.
  */
-int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
-				bool dynamic)
+int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -339,7 +329,7 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
-	ret = tracepoint_remove_func(tp, &tp_func, dynamic);
+	ret = tracepoint_remove_func(tp, &tp_func);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb1..08b3e75841ad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 638bf0e1a2e3..f1ee820d871c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -251,15 +251,13 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 /* Send frame to sockets with specific channel */
-void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 int flag, struct sock *skip_sk)
+static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+				  int flag, struct sock *skip_sk)
 {
 	struct sock *sk;
 
 	BT_DBG("channel %u len %d", channel, skb->len);
 
-	read_lock(&hci_sk_list.lock);
-
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
@@ -285,6 +283,13 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			kfree_skb(nskb);
 	}
 
+}
+
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 int flag, struct sock *skip_sk)
+{
+	read_lock(&hci_sk_list.lock);
+	__hci_send_to_channel(channel, skb, flag, skip_sk);
 	read_unlock(&hci_sk_list.lock);
 }
 
@@ -388,8 +393,8 @@ void hci_send_monitor_ctrl_event(struct hci_dev *hdev, u16 event,
 		hdr->index = index;
 		hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
 
-		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-				    HCI_SOCK_TRUSTED, NULL);
+		__hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+				      HCI_SOCK_TRUSTED, NULL);
 		kfree_skb(skb);
 	}
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 8ea63314f196..169b27596bc7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -218,12 +218,16 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 {
 	struct sock *sk;
 
+	if (!local_trylock(icmp_sk_lock))
+		return NULL;
+
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
+		local_unlock(icmp_sk_lock);
 		return NULL;
 	}
 	return sk;
@@ -232,6 +236,7 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 static inline void icmp_xmit_unlock(struct sock *sk)
 {
 	spin_unlock(&sk->sk_lock.slock);
+	local_unlock(icmp_sk_lock);
 }
 
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
@@ -421,7 +426,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 
 	/* Needed by both icmp_global_allow and icmp_xmit_lock */
 	local_bh_disable();
-	local_lock(icmp_sk_lock);
 
 	/* global icmp_msgs_per_sec */
 	if (!icmpv4_global_allow(net, type, code))
@@ -466,7 +470,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 out_unlock:
 	icmp_xmit_unlock(sk);
 out_bh_enable:
-	local_unlock(icmp_sk_lock);
 	local_bh_enable();
 }
 
@@ -679,7 +682,6 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 
 	/* Needed by both icmp_global_allow and icmp_xmit_lock */
 	local_bh_disable();
-	local_lock(icmp_sk_lock);
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
 	 * incoming dev is loopback.  If outgoing dev change to not be
@@ -768,7 +770,6 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 out_unlock:
 	icmp_xmit_unlock(sk);
 out_bh_enable:
-	local_unlock(icmp_sk_lock);
 	local_bh_enable();
 out:;
 }

 Sebastian
