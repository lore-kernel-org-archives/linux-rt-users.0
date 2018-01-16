From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 36/37] tracing: Add inter-event blurb to HIST_TRIGGERS config option
Date: Mon, 15 Jan 2018 20:52:10 -0600
Message-ID: <a38e24231d8d980be636b56d35814570acfd167a.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1516069914.git.tom.zanussi@linux.intel.com>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

So that users know that inter-event tracing is supported as part of
the HIST_TRIGGERS option, include text to that effect in the help
text.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 904c952..4ec8cd2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -597,7 +597,10 @@ config HIST_TRIGGERS
 	  event activity as an initial guide for further investigation
 	  using more advanced tools.
 
-	  See Documentation/trace/events.txt.
+	  Inter-event tracing of quantities such as latencies is also
+	  supported using hist triggers under this option.
+
+	  See Documentation/trace/histogram.txt.
 	  If in doubt, say N.
 
 config MMIOTRACE_TEST
-- 
1.9.3
