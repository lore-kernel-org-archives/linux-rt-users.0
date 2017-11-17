From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v6 36/37] tracing: Add inter-event blurb to HIST_TRIGGERS config option
Date: Fri, 17 Nov 2017 14:33:15 -0600
Message-ID: <7fd8c67013ed0ed1c7fced4ba6e161e76f421ab6.1510948725.git.tom.zanussi@linux.intel.com>
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

So that users know that inter-event tracing is supported as part of
the HIST_TRIGGERS option, include text to that effect in the help
text.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index b8395a0..b01536d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -596,6 +596,9 @@ config HIST_TRIGGERS
 	  event activity as an initial guide for further investigation
 	  using more advanced tools.
 
+	  Inter-event tracing of quantities such as latencies is also
+	  supported using hist triggers under this option.
+
 	  See Documentation/trace/events.txt.
 	  If in doubt, say N.
 
-- 
1.9.3
