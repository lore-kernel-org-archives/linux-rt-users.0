From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 5/3] tracing: Add smi counting to HWLAT
Date: Tue, 9 Aug 2016 14:05:43 -0400
Message-ID: <20160809140543.2e5c83b5@gandalf.local.home>
References: <20160804145708.158968389@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:33834 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932207AbcHISFs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2016 14:05:48 -0400
In-Reply-To: <20160804145708.158968389@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


If an arch supports counting of SMIs (like newer intel chips do), then it
can implement arch_smi_count() to return the number of SMIs that were
triggered. The hwlat detector will call this function to get the current
number of SMIs, and then after a period, it will read that function again,
and if there's a difference, it will record that into the sample.

For example:

 [99] inner:13 outer:16 ts:1470352534.886878855
 [100] inner:14 outer:18747 ts:1470352538.917966818 smi-count:2
 [101] inner:0 outer:19162 ts:1470352539.920988709 smi-count:6
 [102] inner:19376 outer:19276 ts:1470352540.923010578 smi-count:6
 [103] inner:19650 outer:20665 ts:1470352541.926032469 smi-count:6
 [104] inner:20526 outer:20680 ts:1470352542.973055312 smi-count:6
 [105] inner:17 outer:17 ts:1470352543.990077507

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/events/msr.c        | 12 ++++++++++++
 kernel/trace/trace_entries.h |  1 +
 kernel/trace/trace_hwlat.c   | 11 +++++++++++
 kernel/trace/trace_output.c  |  4 ++++
 4 files changed, 28 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 85ef3c2e80e0..ff0c6e6351b0 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -27,6 +27,18 @@ static bool test_irperf(int idx)
 	return boot_cpu_has(X86_FEATURE_IRPERF);
 }
 
+int arch_smi_count(void)
+{
+	unsigned long long count;
+	int err;
+
+	err = rdmsrl_safe(MSR_SMI_COUNT, &count);
+	if (err)
+		return 0;
+
+	return count;
+}
+
 static bool test_intel(int idx)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index d1cc37e78f99..207faa837d3d 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -335,6 +335,7 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field_desc(	long,	timestamp,	tv_sec		)
 		__field_desc(	long,	timestamp,	tv_nsec		)
 		__field(	unsigned int,		nmi_count	)
+		__field(	unsigned int,		smi_count	)
 		__field(	unsigned int,		seqnum		)
 	),
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2a668e55dcc6..1d60ef5c404f 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -69,6 +69,7 @@ static u64 nmi_ts_start;
 static u64 nmi_total_ts;
 static int nmi_count;
 static int nmi_cpu;
+static int smi_count;
 
 /* Tells NMIs to call back to the hwlat tracer to record timestamps */
 bool trace_hwlat_callback_enabled;
@@ -84,6 +85,7 @@ struct hwlat_sample {
 	u64		nmi_total_ts;	/* Total time spent in NMIs */
 	struct timespec	timestamp;	/* wall time */
 	int		nmi_count;	/* # NMIs during this sample */
+	int		smi_count;	/* # SMIs during sampling (if arch supported) */
 };
 
 /* keep the global state somewhere. */
@@ -125,6 +127,7 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 	entry->timestamp		= sample->timestamp;
 	entry->nmi_total_ts		= sample->nmi_total_ts;
 	entry->nmi_count		= sample->nmi_count;
+	entry->smi_count		= sample->smi_count;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
@@ -138,6 +141,11 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 #define init_time(a, b)	(a = b)
 #define time_u64(a)	a
 
+__weak unsigned long long arch_smi_count(void)
+{
+	return 0;
+}
+
 void trace_hwlat_callback(bool enter)
 {
 	if (smp_processor_id() != nmi_cpu)
@@ -180,6 +188,7 @@ static int get_sample(void)
 	nmi_cpu = smp_processor_id();
 	nmi_total_ts = 0;
 	nmi_count = 0;
+	smi_count = arch_smi_count();
 	/* Make sure NMIs see this first */
 	barrier();
 
@@ -231,6 +240,7 @@ static int get_sample(void)
 
 	barrier(); /* finish the above in the view for NMIs */
 	trace_hwlat_callback_enabled = false;
+	smi_count = arch_smi_count() - smi_count;
 	barrier(); /* Make sure nmi_total_ts is no longer updated */
 
 	ret = 0;
@@ -252,6 +262,7 @@ static int get_sample(void)
 		s.timestamp = CURRENT_TIME;
 		s.nmi_total_ts = nmi_total_ts;
 		s.nmi_count = nmi_count;
+		s.smi_count = smi_count;
 		trace_hwlat_sample(&s);
 
 		/* Keep a running maximum ever recorded hardware latency */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 5478a97e8db3..498eb7363e05 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1128,6 +1128,10 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
 				 field->nmi_count);
 	}
 
+	if (field->smi_count)
+		trace_seq_printf(s, " smi-count:%u",
+			 field->smi_count);
+
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
-- 
1.9.3

