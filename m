From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/16] hwlat-detect/trace: Export trace_clock_local for hwlat-detector
Date: Mon, 09 Sep 2013 10:35:29 -0400
Message-ID: <20130909143536.084762456@goodmis.org>
References: <20130909143517.641735717@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19599 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab3IIP0q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Sep 2013 11:26:46 -0400
Content-Disposition: inline; filename=0012-hwlat-detect-trace-Export-trace_clock_local-for-hwla.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The hwlat-detector needs a better clock than just ktime_get() as that
can induce its own latencies. The trace clock is perfect for it, but
it needs to be exported for use by modules.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_clock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 6302747..e5163ab 100644
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


