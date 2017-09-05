From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 11/40] tracing: Increase tracing map KEYS_MAX size
Date: Tue,  5 Sep 2017 16:57:23 -0500
Message-ID: <0b1bd436068a511a460f6e90580bed45d2872c92.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current default for the number of subkeys in a compound key is 2,
which is too restrictive.  Increase it to a more realistic value of 3.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/tracing_map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 4eabbcb..98ef6d6 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -5,7 +5,7 @@
 #define TRACING_MAP_BITS_MAX		17
 #define TRACING_MAP_BITS_MIN		7
 
-#define TRACING_MAP_KEYS_MAX		2
+#define TRACING_MAP_KEYS_MAX		3
 #define TRACING_MAP_VALS_MAX		3
 #define TRACING_MAP_FIELDS_MAX		(TRACING_MAP_KEYS_MAX + \
 					 TRACING_MAP_VALS_MAX)
-- 
1.9.3
