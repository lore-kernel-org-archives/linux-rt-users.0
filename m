From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFD 4/5] tracing: Deference pointers without RCU checks
Date: Thu, 30 Apr 2015 12:06:24 +0200
Message-ID: <1430388385-29558-5-git-send-email-daniel.wagner@bmw-carit.de>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The tracepoint can't be used in code section where we are in the
middle of a state transition.

For example if we place a tracepoint inside start/stop_critical_section(),
lockdep complains with

[    0.035589] WARNING: CPU: 0 PID: 3 at kernel/locking/lockdep.c:3560 check_flags.part.36+0x1bc/0x210()
[    0.036000] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[    0.036000] Kernel panic - not syncing: panic_on_warn set ...
[    0.036000]
[    0.036000] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.0.0-rc7+ #460
[    0.036000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140709_153950- 04/01/2014
[    0.036000]  ffffffff81f2463a ffff88007c93bb98 ffffffff81afb317 0000000000000001
[    0.036000]  ffffffff81f212b3 ffff88007c93bc18 ffffffff81af7bc2 ffff88007c93bbb8
[    0.036000]  ffffffff00000008 ffff88007c93bc28 ffff88007c93bbc8 000000000093bbd8
[    0.036000] Call Trace:
[    0.036000]  [<ffffffff81afb317>] dump_stack+0x4f/0x7b
[    0.036000]  [<ffffffff81af7bc2>] panic+0xc0/0x1e9
[    0.036000]  [<ffffffff81b07188>] ? _raw_spin_unlock_irqrestore+0x38/0x80
[    0.036000]  [<ffffffff81052a60>] warn_slowpath_common+0xc0/0xc0
[    0.036000]  [<ffffffff81057116>] ? __local_bh_enable+0x36/0x70
[    0.036000]  [<ffffffff81052aa6>] warn_slowpath_fmt+0x46/0x50
[    0.036000]  [<ffffffff810a468c>] check_flags.part.36+0x1bc/0x210
[    0.036000]  [<ffffffff810a5168>] lock_is_held+0x78/0x90
[    0.036000]  [<ffffffff81057116>] ? __local_bh_enable+0x36/0x70
[    0.036000]  [<ffffffff810588ab>] ? __do_softirq+0x3db/0x500
[    0.036000]  [<ffffffff81134495>] trace_preempt_on+0x255/0x260
[    0.036000]  [<ffffffff81081c0b>] preempt_count_sub+0xab/0xf0
[    0.036000]  [<ffffffff81057116>] __local_bh_enable+0x36/0x70
[    0.036000]  [<ffffffff810588ab>] __do_softirq+0x3db/0x500
[    0.036000]  [<ffffffff810589ef>] run_ksoftirqd+0x1f/0x60
[    0.036000]  [<ffffffff81079653>] smpboot_thread_fn+0x193/0x2a0
[    0.036000]  [<ffffffff810794c0>] ? SyS_setgroups+0x150/0x150
[    0.036000]  [<ffffffff81075312>] kthread+0xf2/0x110
[    0.036000]  [<ffffffff81b026b3>] ? wait_for_completion+0xc3/0x120
[    0.036000]  [<ffffffff81081c0b>] ? preempt_count_sub+0xab/0xf0
[    0.036000]  [<ffffffff81075220>] ? kthread_create_on_node+0x240/0x240
[    0.036000]  [<ffffffff81b07cc8>] ret_from_fork+0x58/0x90
[    0.036000]  [<ffffffff81075220>] ? kthread_create_on_node+0x240/0x240
[    0.036000] ---[ end Kernel panic - not syncing: panic_on_warn set ...

PeterZ was so kind to explain it to me what is happening:

"__local_bh_enable() tests if this is the last SOFTIRQ_OFFSET, if so it
tells lockdep softirqs are enabled with trace_softirqs_on() after that
we go an actually modify the preempt_count with preempt_count_sub().
Then in preempt_count_sub() you call into trace_preempt_on() if this
was the last preempt_count increment but you do that _before_ you
actually change the preempt_count with __preempt_count_sub() at this
point lockdep and preempt_count think the world differs and *boom*"

So the simplest way to avoid this is by disabling the consistency
checks.

We also need to take care of the iterating in trace_events_trigger.c
to avoid a splatter in conjunction with the hist trigger.

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 include/linux/rculist.h             | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/tracepoint.h          |  4 ++--
 kernel/trace/trace_events_trigger.c |  6 +++---
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index a18b16f..2fae75e 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -253,6 +253,24 @@ static inline void list_splice_init_rcu(struct list_head *list,
 })
 
 /**
+ * list_entry_rcu_notrace - get the struct for this entry (for tracing)
+ * @ptr:        the &struct list_head pointer.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_head within the struct.
+ *
+ * This primitive may safely run concurrently with the _rcu list-mutation
+ * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+ *
+ * This is the same as list_entry_rcu() except that it does
+ * not do any RCU debugging or tracing.
+ */
+#define list_entry_rcu_notrace(ptr, type, member) \
+({ \
+	typeof(*ptr) __rcu *__ptr = (typeof(*ptr) __rcu __force *)ptr; \
+	container_of((typeof(ptr))rcu_dereference_raw_notrace(__ptr), type, member); \
+})
+
+/**
  * Where are list_empty_rcu() and list_first_entry_rcu()?
  *
  * Implementing those functions following their counterparts list_empty() and
@@ -308,6 +326,24 @@ static inline void list_splice_init_rcu(struct list_head *list,
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_rcu_notrace	-	iterate over rcu list of given type (for tracing)
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by rcu_read_lock().
+ *
+ * This is the same as list_for_each_entry_rcu() except that it does
+ * not do any RCU debugging or tracing.
+ */
+#define list_for_each_entry_rcu_notrace(pos, head, member) \
+	for (pos = list_entry_rcu_notrace((head)->next, typeof(*pos), member); \
+		&pos->member != (head); \
+		pos = list_entry_rcu_notrace(pos->member.next, typeof(*pos), member))
+
+/**
  * list_for_each_entry_continue_rcu - continue iteration over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c728513..f194324 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -125,7 +125,7 @@ extern void syscall_unregfunc(void);
 			return;						\
 		prercu;							\
 		rcu_read_lock_sched_notrace();				\
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+		it_func_ptr = rcu_dereference_raw_notrace((tp)->funcs);	\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -175,7 +175,7 @@ extern void syscall_unregfunc(void);
 				TP_CONDITION(cond),,);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			rcu_read_lock_sched_notrace();			\
-			rcu_dereference_sched(__tracepoint_##name.funcs);\
+			rcu_dereference_raw_notrace(__tracepoint_##name.funcs);\
 			rcu_read_unlock_sched_notrace();		\
 		}							\
 	}								\
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 39aabaa..e47a229 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -71,14 +71,14 @@ event_triggers_call(struct ftrace_event_file *file, void *rec)
 	if (list_empty(&file->triggers))
 		return tt;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	list_for_each_entry_rcu_notrace(data, &file->triggers, list) {
 		if (data->paused)
 			continue;
 		if (!rec) {
 			data->ops->func(data, rec);
 			continue;
 		}
-		filter = rcu_dereference_sched(data->filter);
+		filter = rcu_dereference_raw_notrace(data->filter);
 		if (filter && !filter_match_preds(filter, rec))
 			continue;
 		if (data->cmd_ops->post_trigger) {
@@ -110,7 +110,7 @@ event_triggers_post_call(struct ftrace_event_file *file,
 {
 	struct event_trigger_data *data;
 
-	list_for_each_entry_rcu(data, &file->triggers, list) {
+	list_for_each_entry_rcu_notrace(data, &file->triggers, list) {
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-- 
2.1.0
