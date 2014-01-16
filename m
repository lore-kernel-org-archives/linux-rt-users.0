From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 1/2] preempt: Add CONFIG_DEBUG_PREEMPT_COUNT to consolidate ifdef logic
Date: Thu, 16 Jan 2014 12:18:25 -0500
Message-ID: <20140116172007.688569267@goodmis.org>
References: <20140116171824.748919700@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-preempt-Add-CONFIG_DEBUG_PREEMPT_COUNT-to-consolidat.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Add a Kconfig bool DEBUG_PREEMPT_COUNT that gets enabled by both
DEBUG_PREEMPT and PREEMPT_TRACER, where they both enable the
full add_preempt_count() function call to debug preempt count logic.

This cleans up the code and lets other users of add_preempt_count()
without messing up the code as well.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/preempt.h | 2 +-
 kernel/sched/core.c     | 3 +--
 kernel/trace/Kconfig    | 1 +
 lib/Kconfig.debug       | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index a3d9dc8..cd48ecc 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,7 +17,7 @@
 
 #include <asm/preempt.h>
 
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
+#ifdef CONFIG_DEBUG_PREEMPT_COUNT
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
 #define preempt_count_dec_and_test() ({ preempt_count_sub(1); should_resched(); })
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a88f4a4..68b0c1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2339,8 +2339,7 @@ notrace unsigned long get_parent_ip(unsigned long addr)
 	return addr;
 }
 
-#if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_PREEMPT_TRACER))
+#ifdef CONFIG_DEBUG_PREEMPT_COUNT
 
 void __kprobes preempt_count_add(int val)
 {
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 015f85a..3fb0331 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -202,6 +202,7 @@ config PREEMPT_TRACER
 	select RING_BUFFER_ALLOW_SWAP
 	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
+	select DEBUG_PREEMPT_COUNT
 	help
 	  This option measures the time spent in preemption-off critical
 	  sections, with microsecond accuracy.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index db25707..8cf7819 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -796,9 +796,13 @@ config TIMER_STATS
 	  (it defaults to deactivated on bootup and will only be activated
 	  if some application like powertop activates it explicitly).
 
+config DEBUG_PREEMPT_COUNT
+       bool
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
+	select DEBUG_PREEMPT_COUNT
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
-- 
1.8.4.3
