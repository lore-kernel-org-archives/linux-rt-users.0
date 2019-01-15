From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v12 01/16] tracing: Use str_has_prefix() in synth_event_create()
Date: Tue, 15 Jan 2019 16:05:45 -0600
Message-ID: <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547589128.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1547589128.git.tom.zanussi@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since we now have a str_has_prefix() that returns the length, we can
use that instead of explicitly calculating it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 449d90cfa151..625725ae262f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const char **argv)
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len = sizeof(SYNTH_SYSTEM "/") - 1;
-		if (strncmp(name, SYNTH_SYSTEM "/", len))
+		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) == 0)
 			return -EINVAL;
 		name += len;
 	}
-- 
2.14.1
