From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 06/21] tracing: Increase tracing map KEYS_MAX size
Date: Wed,  8 Feb 2017 11:25:02 -0600
Message-ID: <9a82cda5e8011b5013a8ab59d58a566b050f1f72.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current default for the number of subkeys in a compound key is 2,
which is too restrictive.  Increase it to a more realistic value of 3.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/tracing_map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 618838f..f097511 100644
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
