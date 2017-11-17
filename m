From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v6 35/37] tracing: Increase trace_recursive_lock() limit for synthetic events
Date: Fri, 17 Nov 2017 14:33:14 -0600
Message-ID: <b1f42c5434a321884027364b0c23bfca3b861c14.1510948725.git.tom.zanussi@linux.intel.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1510948725.git.tom.zanussi@linux.intel.com>
References: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Synthetic event generation needs to happen while the current event is
still in progress, so add 1 to the trace_recursive_lock() recursion
limit to account for that.

Because we also want to allow for the possibility of a synthetic event
being generated from another synthetic event, add an additional
increment for that as well.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/ring_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 763b3fb..8c862ea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2589,16 +2589,16 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
  *  IRQ context
  *  NMI context
  *
- * If for some reason the ring buffer starts to recurse, we
- * only allow that to happen at most 4 times (one for each
- * context). If it happens 5 times, then we consider this a
- * recusive loop and do not let it go further.
+ * If for some reason the ring buffer starts to recurse, we only allow
+ * that to happen at most 6 times (one for each context, plus possibly
+ * two levels of synthetic event generation). If it happens 7 times,
+ * then we consider this a recusive loop and do not let it go further.
  */
 
 static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	if (cpu_buffer->current_context >= 4)
+	if (cpu_buffer->current_context >= 6)
 		return 1;
 
 	cpu_buffer->current_context++;
-- 
1.9.3
