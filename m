From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/34] perf probe: Cut off the version suffix from event name
Date: Thu, 14 Dec 2017 14:42:35 -0300
Message-ID: <20171214174247.16841-23-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>, linux-rt-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from automatic
generated event name. This fixes wildcard event adding like below case;

  =====
  # perf probe -x /lib64/libc-2.25.so malloc*
  Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
    Error: Failed to add events.
  =====

This failure was caused by a versioned suffix symbol.

With this fix, perf probe automatically cuts the suffix after @ as
below.

  =====
  # ./perf probe -x /lib64/libc-2.25.so malloc*
  Added new events:
    probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_set_state -aR sleep 1

  =====

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: bhargavb <bhargavaramudu@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/None
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 262d5da86623..7e582547ac07 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2584,8 +2584,8 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	if (!nbase)
 		return -ENOMEM;
 
-	/* Cut off the dot suffixes (e.g. .const, .isra)*/
-	p = strchr(nbase, '.');
+	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
+	p = strpbrk(nbase, ".@");
 	if (p && p != nbase)
 		*p = '\0';
 
-- 
2.13.6
