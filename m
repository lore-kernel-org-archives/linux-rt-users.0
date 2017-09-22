From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v3 33/33] tracing: Add inter-event blurb to HIST_TRIGGERS config option
Date: Fri, 22 Sep 2017 15:00:13 -0500
Message-ID: <644b319598413128c8d85bf8f132123f96b124e1.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58917 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdIVUGG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Sep 2017 16:06:06 -0400
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

So that users know that inter-event tracing is supported as part of
the HIST_TRIGGERS option, include text to that effect in the help
text.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 434c840..ad55dde 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -585,6 +585,9 @@ config HIST_TRIGGERS
 	  event activity as an initial guide for further investigation
 	  using more advanced tools.
 
+	  Inter-event tracing of quantities such as latencies is also
+	  supported using hist triggers under this option.
+
 	  See Documentation/trace/events.txt.
 	  If in doubt, say N.
 
-- 
1.9.3

