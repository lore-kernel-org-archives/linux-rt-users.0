From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/4] tracing: Add __print_ns_to_secs() and __print_ns_without_secs() helpers
Date: Mon, 22 Feb 2016 14:08:19 -0300
Message-ID: <b0b61a3a94c5df04b999b77ed357e269d8aac091.1456157869.git.bristot@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456157869.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

To have nanosecond output displayed in a more human readable format, its
nicer to convert it to a seconds format (XXX.YYYYYYYYY). The problem is that
to do so, the numbers must be divided by NSEC_PER_SEC, and moded too. But as
these numbers are 64 bit, this can not be done simply with '/' and '%'
operators, but must use do_div() instead.

Instead of performing the expensive do_div() in the hot path of the
tracepoint, it is more efficient to perform it during the output phase. But
passing in do_div() can confuse the parser, and do_div() doesn't work
exactly like a normal C function. It modifies the number in place, and we
don't want to modify the actual values in the ring buffer.

Two helper functions are now created:

  __print_ns_to_secs() and __print_ns_without_secs()

They both take a value of nanoseconds, and the former will return that
number divided by NSEC_PER_SEC, and the latter will mod it with NSEC_PER_SEC
giving a way to print a nice human readable format:

 __print_fmt("time=%llu.%09u",
	__print_ns_to_secs(REC->nsec_val),
	__print_ns_without_secs(REC->nsec_val))

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 170c93b..23a5822 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -283,6 +283,21 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_symbols_seq(p, value, symbols);		\
 	})
 
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(value)			\
+	({						\
+		u64 ____val = (u64)value;		\
+		do_div(____val, NSEC_PER_SEC);		\
+		____val;				\
+	})
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(value)			\
+	({						\
+		u64 ____val = (u64)value;		\
+		do_div(____val, NSEC_PER_SEC);		\
+	})
+
 #undef __print_symbolic_u64
 #if BITS_PER_LONG == 32
 #define __print_symbolic_u64(value, symbol_array...)			\
@@ -720,6 +735,16 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_bitmask
 #undef __print_array
 
+/*
+ * The below is not executed in the kernel. It is only what is
+ * displayed in the print format for userspace to parse.
+ */
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(val) val / 1000000000UL
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(val) val % 1000000000UL
+
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
 
-- 
2.5.0
