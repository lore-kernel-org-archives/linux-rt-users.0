From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFD 1/5] tracing: 'hist' triggers
Date: Thu, 30 Apr 2015 12:06:21 +0200
Message-ID: <1430388385-29558-2-git-send-email-daniel.wagner@bmw-carit.de>
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

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi Daniel,

On Mon, 2015-04-20 at 14:52 +0200, Daniel Wagner wrote:
> Hi Tom,
>
> On 04/10/2015 06:05 PM, Tom Zanussi wrote:
> > This is v4 of the 'hist triggers' patchset, following feedback from
> > v3.
> >
> > This version fixes the race in tracing_map_insert() noted in v3, where
> > map.val.key could be checked even if map.val wasn't yet set.  The
> > simple fix for that in tracing_map_insert() introduces the possibility
> > of duplicates in the map, which though rare, need to be accounted for
> > in the output.  To address that, duplicate-merging code was added to
> > the map-printing code.
>
> Note: I might be abusing your patch. So this could be a completely
> bogus question/feedback.
>
> Most important information here is that I placed additional tracepoints
> during state transitions. I needed to disable the rcu_dereference
> consistency checks to be able to get it working (not claiming that this
> is the right thing to do)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c728513..f194324 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -125,7 +125,7 @@ extern void syscall_unregfunc(void);
>                         return;                                         \
>                 prercu;                                                 \
>                 rcu_read_lock_sched_notrace();                          \
> -               it_func_ptr = rcu_dereference_sched((tp)->funcs);       \
> +               it_func_ptr = rcu_dereference_raw_notrace((tp)->funcs); \
>                 if (it_func_ptr) {                                      \
>                         do {                                            \
>                                 it_func = (it_func_ptr)->func;          \
> @@ -175,7 +175,7 @@ extern void syscall_unregfunc(void);
>                                 TP_CONDITION(cond),,);                  \
>                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>                         rcu_read_lock_sched_notrace();                  \
> -                       rcu_dereference_sched(__tracepoint_##name.funcs);\
> +                       rcu_dereference_raw_notrace(__tracepoint_##name.funcs);\
>                         rcu_read_unlock_sched_notrace();                \
>                 }                                                       \
>         }                                                               \
>
>
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index 8523ea3..03f42b9 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
>
> +#include <trace/events/sched.h>
> +
>  #include "trace.h"
>
>  static struct trace_array              *irqsoff_trace __read_mostly;
> @@ -433,11 +435,13 @@ void start_critical_timings(void)
>  {
>         if (preempt_trace() || irq_trace())
>                 start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
> +       trace_sched_latency_critical_timing(1);
>  }
>  EXPORT_SYMBOL_GPL(start_critical_timings);
>
>  void stop_critical_timings(void)
>  {
> +       trace_sched_latency_critical_timing(0);
>         if (preempt_trace() || irq_trace())
>                 stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
>  }
> @@ -447,6 +451,7 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
>  #ifdef CONFIG_PROVE_LOCKING
>  void time_hardirqs_on(unsigned long a0, unsigned long a1)
>  {
> +       trace_sched_latency_irqs(0);
>         if (!preempt_trace() && irq_trace())
>                 stop_critical_timing(a0, a1);
>  }
> @@ -455,6 +460,7 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
>  {
>         if (!preempt_trace() && irq_trace())
>                 start_critical_timing(a0, a1);
> +       trace_sched_latency_irqs(1);
>  }
>
> When activating now the hist trigger by
>
>   echo 'hist:key=common_pid:val=enabled' > \
>     /sys/kernel/debug/tracing/events/sched/sched_latency_preempt/trigger
>
> the system crashes reliable after a very short time. Those tracepoints
> do work normally, so I see them in /sys/kernel/debug/tracing/trace.
>
> After some investigation I found out that event_hist_trigger() gets
> called with rec=NULL. This is handed over to hist_field_s32() and
> that function derefences the argument event (=NULL).
>
> #19 event_hist_trigger (data=0xffff88007934c780, rec=0x0 <irq_stack_union>) at kernel/trace/trace_events_hist.c:885
> #20 0xffffffff8113771b in event_triggers_call (file=<optimized out>, rec=0x0 <irq_stack_union>) at kernel/trace/trace_events_trigger.c:78
> #21 0xffffffff81079def in ftrace_trigger_soft_disabled (file=<optimized out>) at include/linux/ftrace_event.h:453
> #22 ftrace_raw_event_sched_latency_template (__data=0xffff88007c895aa8, enabled=0) at include/trace/events/sched.h:557
> #23 0xffffffff8112cbec in trace_sched_latency_preempt (enabled=<optimized out>) at include/trace/events/sched.h:587
> #24 trace_preempt_off (a0=18446744071579483412, a1=18446744071579485792) at kernel/trace/trace_irqsoff.c:532
> #25 0xffffffff8107f449 in preempt_count_add (val=1) at kernel/sched/core.c:2554
> #26 0xffffffff8109bd14 in get_lock_stats (class=0xffffffff82e235d0 <lock_classes+273296>) at kernel/locking/lockdep.c:249
> #27 0xffffffff8109c660 in lock_release_holdtime (hlock=0xffff880079c8ee50) at kernel/locking/lockdep.c:267
> #28 0xffffffff810a2cc9 in lock_release_holdtime (hlock=<optimized out>) at kernel/locking/lockdep.c:3464
> #29 lock_release_nested (ip=<optimized out>, lock=<optimized out>, curr=<optimized out>) at kernel/locking/lockdep.c:3481
> #30 __lock_release (ip=<optimized out>, nested=<optimized out>, lock=<optimized out>) at kernel/locking/lockdep.c:3507
> #31 lock_release (lock=0xffffffff8226e5f0 <kernfs_mutex+112>, nested=<optimized out>, ip=18446744071590106190) at kernel/locking/lockdep.c:3628
> #32 0xffffffff81abd306 in __mutex_unlock_common_slowpath (nested=<optimized out>, lock=<optimized out>) at kernel/locking/mutex.c:744
> #33 __mutex_unlock_slowpath (lock_count=0xffff88007934c780) at kernel/locking/mutex.c:769
> #34 0xffffffff81abd44e in mutex_unlock (lock=<optimized out>) at kernel/locking/mutex.c:446
> #35 0xffffffff81238e84 in kernfs_dop_revalidate (dentry=0xffff88007acede00, flags=<optimized out>) at fs/kernfs/dir.c:470
> #36 0xffffffff811c9813 in d_revalidate (flags=<optimized out>, dentry=<optimized out>) at fs/namei.c:607
> #37 lookup_fast (nd=0xffff8800790e3e48, path=0xffff8800790e3ca8, inode=0xffff8800790e3cb8) at fs/namei.c:1465
> #38 0xffffffff811cc05f in walk_component (follow=<optimized out>, path=<optimized out>, nd=<optimized out>) at fs/namei.c:1577
> #39 link_path_walk (name=0xffff880079fa602d "virtual/block/loop6/subsystem", nd=0xffff8800790e3e48) at fs/namei.c:1836
> #40 0xffffffff811cd327 in path_init (dfd=<optimized out>, name=0xffff880079fa6020 "/sys/devices/virtual/block/loop6/subsystem", flags=2051493056, nd=0xffff8800790e3e48)
>     at fs/namei.c:1952
> #41 0xffffffff811cda90 in path_lookupat (dfd=<optimized out>, name=<optimized out>, flags=16448, nd=0xffff8800790e3e48) at fs/namei.c:1995
> #42 0xffffffff811cec1a in filename_lookup (dfd=-100, name=0xffff880079fa6000, flags=16384, nd=0xffff8800790e3e48) at fs/namei.c:2030
> #43 0xffffffff811d0d34 in user_path_at_empty (dfd=-100, name=<optimized out>, flags=16384, path=0xffff8800790e3f38, empty=<optimized out>) at fs/namei.c:2197
> #44 0xffffffff811c285c in SYSC_readlinkat (bufsiz=<optimized out>, buf=<optimized out>, pathname=<optimized out>, dfd=<optimized out>) at fs/stat.c:327
> #45 SyS_readlinkat (bufsiz=<optimized out>, buf=<optimized out>, pathname=<optimized out>, dfd=<optimized out>) at fs/stat.c:315
> #46 SYSC_readlink (bufsiz=<optimized out>, buf=<optimized out>, path=<optimized out>) at fs/stat.c:352
> #47 SyS_readlink (path=-131939361831040, buf=0, bufsiz=<optimized out>) at fs/stat.c:349
>
> So I am wondering if the path from ftrace_trigger_soft_disabled()
> to event_triggers_call() is supposed never to happen? The comment
> on ftrace_trigger_soft_disabled() indicate this might happen on
> normal operation:
>

So I looked at this on the plane and you're right, this is a path that
should never be taken in this case, since the hist trigger does set the
post_trigger flag and should therefore TRIGGER_COND would be true and
that block should never be entered.

However, the code that registers the trigger first enables the event,
then sets the cond flag, which would allow this to happen - a trigger
expecting data would be passed a NULL rec.

Can you try the patch below and see if it fixes the problem? (untested
and I haven't even had a chance to compile-test it..)

Tom

[PATCH] tracing: Update cond flag before enabling or disabling a trigger

Before a trigger is enabled, the cond flag should be set beforehand,
otherwise an trigger that's expecting to process a trace record
(e.g. one with post_trigger set) could be invoked without one.

Likewise a trigger's cond flag should be reset after it's disabled,
not before.

[dw: added a couple of more update_cond_flag()]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 kernel/trace/trace_events_hist.c    |  3 ++-
 kernel/trace/trace_events_trigger.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 200f0ad..9a7a675 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1471,11 +1471,12 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	list_add_rcu(&data->list, &file->triggers);
 	ret++;
 
+	update_cond_flag(file);
 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
 		list_del_rcu(&data->list);
+		update_cond_flag(file);
 		ret--;
 	}
-	update_cond_flag(file);
  out:
 	return ret;
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 7105f15..39aabaa 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -546,11 +546,12 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
 	list_add_rcu(&data->list, &file->triggers);
 	ret++;
 
+	update_cond_flag(file);
 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
 		list_del_rcu(&data->list);
+		update_cond_flag(file);
 		ret--;
 	}
-	update_cond_flag(file);
 out:
 	return ret;
 }
@@ -578,8 +579,8 @@ void unregister_trigger(char *glob, struct event_trigger_ops *ops,
 		if (data->cmd_ops->trigger_type == test->cmd_ops->trigger_type) {
 			unregistered = true;
 			list_del_rcu(&data->list);
-			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
+			update_cond_flag(file);
 			break;
 		}
 	}
@@ -1263,6 +1264,7 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
+	update_cond_flag(file);
 	ret = trace_event_enable_disable(event_enable_file, 1, 1);
 	if (ret < 0)
 		goto out_put;
@@ -1285,6 +1287,7 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
  out_put:
+	update_cond_flag(file);
 	module_put(event_enable_file->event_call->mod);
  out_free:
 	if (cmd_ops->set_filter)
@@ -1324,11 +1327,12 @@ int event_enable_register_trigger(char *glob,
 	list_add_rcu(&data->list, &file->triggers);
 	ret++;
 
+	update_cond_flag(file);
 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
 		list_del_rcu(&data->list);
+		update_cond_flag(file);
 		ret--;
 	}
-	update_cond_flag(file);
 out:
 	return ret;
 }
@@ -1351,8 +1355,8 @@ void event_enable_unregister_trigger(char *glob,
 		    (enable_data->file == test_enable_data->file)) {
 			unregistered = true;
 			list_del_rcu(&data->list);
-			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
+			update_cond_flag(file);
 			break;
 		}
 	}
-- 
2.1.0
