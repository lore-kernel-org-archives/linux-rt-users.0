From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/2] tracing: Use str_has_prefix() in synth_event_create()
Date: Mon,  4 Feb 2019 15:07:23 -0600
Message-ID: <03418373fd1e80030e7394b8e3e081c5de28a710.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Joe Perches <joe@perches.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since we now have a str_has_prefix() that returns the length, we can
use that instead of explicitly calculating it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Joe Perches <joe@perches.com>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 449d90cfa151..c4a667503bf0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1200,8 +1200,8 @@ static int synth_event_create(int argc, const char **argv)
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len = sizeof(SYNTH_SYSTEM "/") - 1;
-		if (strncmp(name, SYNTH_SYSTEM "/", len))
+		len = str_has_prefix(name, SYNTH_SYSTEM "/");
+		if (len == 0)
 			return -EINVAL;
 		name += len;
 	}
-- 
2.14.1
