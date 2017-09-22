From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 4/9] tracing: Remove lookups from tracing_map hitcount
Date: Fri, 22 Sep 2017 14:58:18 -0500
Message-ID: <c8d9dc39d269a8abf88bf4102d0dfc65deb0fc7f.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105045.git.tom.zanussi@linux.intel.com>
References: <cover.1506105045.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Lookups inflate the hitcount, making it essentially useless.  Only
inserts and updates should really affect the hitcount anyway, so
explicitly filter lookups out.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/tracing_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 305039b..07e7534 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -428,7 +428,8 @@ static inline bool keys_match(void *key, void *test_key, unsigned key_size)
 
 		if (test_key && test_key == key_hash && entry->val &&
 		    keys_match(key, entry->val->key, map->key_size)) {
-			atomic64_inc(&map->hits);
+			if (!lookup_only)
+				atomic64_inc(&map->hits);
 			return entry->val;
 		}
 
-- 
1.9.3
