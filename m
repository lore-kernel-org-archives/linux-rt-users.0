From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v5 36/37] tracing: Add inter-event blurb to HIST_TRIGGERS config option
Date: Thu,  9 Nov 2017 14:34:07 -0600
Message-ID: <d7ae7728ae20df635c9aa1a44e84df88e2ebc569.1510252666.git.tom.zanussi@linux.intel.com>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:35063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755248AbdKIUgK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Nov 2017 15:36:10 -0500
In-Reply-To: <cover.1510252666.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1510252666.git.tom.zanussi@linux.intel.com>
References: <cover.1510252666.git.tom.zanussi@linux.intel.com>
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

