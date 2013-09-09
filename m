From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/16] hwlat-detect/trace: Export trace_clock_local for hwlat-detector
Date: Mon, 09 Sep 2013 08:45:43 -0400
Message-ID: <20130909124557.947056260@goodmis.org>
References: <20130909124531.445392664@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0012-hwlat-detect-trace-Export-trace_clock_local-for-hwla.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The hwlat-detector needs a better clock than just ktime_get() as that
can induce its own latencies. The trace clock is perfect for it, but
it needs to be exported for use by modules.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_clock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 3947835..1bbb1b2 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -44,6 +44,7 @@ u64 notrace trace_clock_local(void)
 
 	return clock;
 }
+EXPORT_SYMBOL_GPL(trace_clock_local);
 
 /*
  * trace_clock(): 'between' trace clock. Not completely serialized,
-- 
1.7.10.4
