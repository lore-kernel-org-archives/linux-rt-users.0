From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 07/32] tracing: Increase tracing map KEYS_MAX size
Date: Mon, 26 Jun 2017 17:49:08 -0500
Message-ID: <be0909b12fb219c27b868ca0c3ad7ebbe286a947.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52739 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdFZWuK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:50:10 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

