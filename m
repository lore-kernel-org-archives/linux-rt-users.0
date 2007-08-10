From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 2/2] Some stacks show up untracable,
	so fall back to old method in this case
Date: Fri, 10 Aug 2007 08:14:18 -0600
Message-ID: <20070810141418.12966.28540.stgit@lsg>
References: <20070810140745.12966.8464.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ghaskins@novell.com
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:16746 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934842AbXHJOOT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 10:14:19 -0400
In-Reply-To: <20070810140745.12966.8464.stgit@lsg>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 arch/x86_64/kernel/stacktrace.c |   10 ++++++++--
 include/linux/stacktrace.h      |    1 +
 kernel/latency_trace.c          |   12 ++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/stacktrace.c b/arch/x86_64/kernel/stacktrace.c
index cb91091..054f627 100644
--- a/arch/x86_64/kernel/stacktrace.c
+++ b/arch/x86_64/kernel/stacktrace.c
@@ -24,7 +24,7 @@ static int save_stack_stack(void *data, char *name)
 	return -1;
 }
 
-static void save_stack_address(void *data, unsigned long addr)
+static void _save_stack_address(void *data, unsigned long addr)
 {
 	struct stack_trace *trace = (struct stack_trace *)data;
 	if (trace->skip > 0) {
@@ -39,7 +39,7 @@ static struct stacktrace_ops save_stack_ops = {
 	.warning = save_stack_warning,
 	.warning_symbol = save_stack_warning_symbol,
 	.stack = save_stack_stack,
-	.address = save_stack_address,
+	.address = _save_stack_address,
 };
 
 /*
@@ -52,3 +52,9 @@ void save_stack_trace(struct stack_trace *trace)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL(save_stack_trace);
+
+void save_stack_address(struct stack_trace *trace, unsigned long addr)
+{
+	_save_stack_address(trace, addr);
+}
+EXPORT_SYMBOL(save_stack_address);
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index e7fa657..5acad27 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -9,6 +9,7 @@ struct stack_trace {
 };
 
 extern void save_stack_trace(struct stack_trace *trace);
+extern void save_stack_address(struct stack_trace *trace, unsigned long addr);
 
 extern void print_stack_trace(struct stack_trace *trace, int spaces);
 #else
diff --git a/kernel/latency_trace.c b/kernel/latency_trace.c
index 9b83262..82c04ac 100644
--- a/kernel/latency_trace.c
+++ b/kernel/latency_trace.c
@@ -2058,6 +2058,18 @@ void notrace add_preempt_count(unsigned int val)
 			trace->entries = current->preempt_trace[idx].data;
 
 			save_stack_trace(trace);
+
+			/*
+			 * If we couldnt get our trace, the first entry will
+			 * have the ULONG_MAX marker.  In that case, we
+			 * rewind and save our simple two level stack
+			 */
+			if ((trace->nr_entries == 1)
+			    && (trace->entries[0] == ULONG_MAX)) {
+				trace->nr_entries = 0;
+				save_stack_address(trace, eip);
+				save_stack_address(trace, parent_eip);
+			}
 		}
 	}
 #endif
