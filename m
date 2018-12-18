From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/7] tracing: Remove unnecessary hist trigger struct field
Date: Tue, 18 Dec 2018 14:33:20 -0600
Message-ID: <d4e066c0f509f5f13ad3babc8c33ca6e7ddc439a.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

hist_field.var_idx is completely unused, so remove it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82e72c48a5a9..d29bf8a8e1dd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -61,7 +61,6 @@ struct hist_field {
 	char				*system;
 	char				*event_name;
 	char				*name;
-	unsigned int			var_idx;
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
-- 
2.14.1
