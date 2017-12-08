From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/5] perf-probe: Cut off the version suffix from event name
Date: Sat,  9 Dec 2017 01:27:15 +0900
Message-ID: <151275043529.24652.13913613297362711909.stgit@devbox>
References: <151275037752.24652.5169845651138876257.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <151275037752.24652.5169845651138876257.stgit@devbox>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from
automatic generated event name. This fixes wildcard event
adding like below case;

  =====
  # perf probe -x /lib64/libc-2.25.so malloc*
  Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
    Error: Failed to add events.
  =====

This failure was caused by a versioned suffix symbol.
With this fix, perf probe automatically cuts the
suffix after @ as below.

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: bhargavb <bhargavaramudu@gmail.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c |    4 ++--
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
 
