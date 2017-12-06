From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 36/37] tracing: Add inter-event blurb to HIST_TRIGGERS config option
Date: Wed,  6 Dec 2017 16:38:17 -0600
Message-ID: <4acf04b6c3f8ed0b05e0be24f3b3795f51b2f70a.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
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
index b8395a0..bb7cb8d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -596,7 +596,10 @@ config HIST_TRIGGERS
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
