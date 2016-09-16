From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.6.7-rt13
Date: Fri, 16 Sep 2016 07:53:46 +0200
Message-ID: <20160916055346.ztjp6oayv2so7mtt@linutronix.de>
References: <20160915165225.73lr22kpn5coibxa@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160915165225.73lr22kpn5coibxa@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-09-15 18:52:26 [+0200], To Thomas Gleixner wrote:
> The delta patch against 4.6.7-rt12 is appended below and can be found here:

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 190af4271b5c..58fd4ff3f53a 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -89,6 +89,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return false;
@@ -101,8 +103,19 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 #ifdef CONFIG_PREEMPT_LAZY
-	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset ||
-			test_thread_flag(TIF_NEED_RESCHED_LAZY));
+	u32 tmp;
+
+	tmp = raw_cpu_read_4(__preempt_count);
+	if (tmp == preempt_offset)
+		return true;
+
+	/* preempt count == 0 ? */
+	tmp &= ~PREEMPT_NEED_RESCHED;
+	if (tmp)
+		return false;
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
+	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 #endif
diff --git a/fs/dcache.c b/fs/dcache.c
index aa418c1bdcb5..90b66896ccb2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -40,8 +40,6 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/kasan.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/deadline.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -795,10 +793,11 @@ void dput(struct dentry *dentry)
 		if (parent == dentry) {
 			/* the task with the highest priority won't schedule */
 			r = cond_resched();
-			if (!r && (rt_task(current) || dl_task(current)))
+			if (!r)
 				cpu_chill();
-		} else
+		} else {
 			dentry = parent;
+		}
 		goto repeat;
 	}
 }
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dea12a6e413b..72cb21071425 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -713,6 +713,7 @@ static inline void __ftrace_enabled_restore(int enabled)
 #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
 #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))
 
+#ifdef CONFIG_USING_GET_LOCK_PARENT_IP
 static inline unsigned long get_lock_parent_ip(void)
 {
 	unsigned long addr = CALLER_ADDR0;
@@ -724,6 +725,7 @@ static inline unsigned long get_lock_parent_ip(void)
 		return addr;
 	return CALLER_ADDR2;
 }
+#endif
 
 #ifdef CONFIG_IRQSOFF_TRACER
   extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
diff --git a/kernel/Makefile b/kernel/Makefile
index f0c40bf49d9f..c60cc9130374 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -11,6 +11,13 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o
 
+# Tracing may do some dangerous __builtin_return_address() operations
+# We know they are dangerous, we don't need gcc telling us that.
+ifdef CONFIG_USING_GET_LOCK_PARENT_IP
+FRAME_CFLAGS := $(call cc-disable-warning,frame-address)
+KBUILD_CFLAGS += $(FRAME_CFLAGS)
+endif
+
 obj-$(CONFIG_MULTIUSER) += groups.o
 
 ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 364ccd0eb57b..9aae45fae52a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -215,6 +215,7 @@ config PREEMPT_TRACER
 	select RING_BUFFER_ALLOW_SWAP
 	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
+	select USING_GET_LOCK_PARENT_IP
 	help
 	  This option measures the time spent in preemption-off critical
 	  sections, with microsecond accuracy.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1e9a607534ca..0adcc993f372 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -962,6 +962,7 @@ config TIMER_STATS
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
+	select USING_GET_LOCK_PARENT_IP
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
@@ -1144,8 +1145,17 @@ config LOCK_TORTURE_TEST
 
 endmenu # lock debugging
 
+config USING_GET_LOCK_PARENT_IP
+        bool
+	help
+	  Enables the use of the function get_lock_parent_ip() that
+	  will use __builtin_return_address(n) with n > 0 causing
+	  some gcc warnings. When this is selected, those warnings
+	  will be suppressed.
+
 config TRACE_IRQFLAGS
 	bool
+	select USING_GET_LOCK_PARENT_IP
 	help
 	  Enables hooks to interrupt enabling and disabling for
 	  either tracing or lock debugging.
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927..9f7d0bdbffb1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
