From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 3/5] perf-probe: Add __return suffix for return events
Date: Thu,  7 Dec 2017 16:20:57 +0900
Message-ID: <151263125742.13843.3968865208376257511.stgit@devbox>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <151263115609.13843.6362262297053841418.stgit@devbox>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add __return suffix for function return events
automatically. Without this, user have to give --force
option and will see the number suffix for each event
like "function_1", which is not easy to recognize.
Instead, this adds __return suffix to it automatically.
E.g.

  =====
  # ./perf probe -x /lib64/libc-2.25.so 'malloc*%return'
  Added new events:
    probe_libc:malloc_printerr__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_consolidate__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_check__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_hook_ini__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_trim__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_usable_size__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_stats__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_info__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:mallochook__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_get_state__return (on malloc*%return in /usr/lib64/libc-2.25.so)
    probe_libc:malloc_set_state__return (on malloc*%return in /usr/lib64/libc-2.25.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_set_state__return -aR sleep 1

  =====

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
---
  Changes in v2:
   - Add a description in Documentation/perf-probe.txt.
---
 tools/perf/Documentation/perf-probe.txt |    2 +-
 tools/perf/util/probe-event.c           |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index d7e4869905f1..f96382692f42 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -170,7 +170,7 @@ Probe points are defined by following syntax.
      or,
      sdt_PROVIDER:SDTEVENT
 
-'EVENT' specifies the name of new event, if omitted, it will be set the name of the probed function. You can also specify a group name by 'GROUP', if omitted, set 'probe' is used for kprobe and 'probe_<bin>' is used for uprobe.
+'EVENT' specifies the name of new event, if omitted, it will be set the name of the probed function, and for return probes, a "\_\_return" suffix is automatically added to the function name. You can also specify a group name by 'GROUP', if omitted, set 'probe' is used for kprobe and 'probe_<bin>' is used for uprobe.
 Note that using existing group name can conflict with other events. Especially, using the group name reserved for kernel modules can hide embedded events in the
 modules.
 'FUNC' specifies a probed function name, and it may have one of the following options; '+OFFS' is the offset from function entry address in bytes, ':RLN' is the relative-line number from function entry line, and '%return' means that it probes function return. And ';PTN' means lazy matching pattern (see LAZY MATCHING). Note that ';PTN' must be the end of the probe point definition.  In addition, '@SRC' specifies a source file which has that function.
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 74435fb7ab7f..959c4d2ef455 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2573,7 +2573,8 @@ int show_perf_probe_events(struct strfilter *filter)
 }
 
 static int get_new_event_name(char *buf, size_t len, const char *base,
-			      struct strlist *namelist, bool allow_suffix)
+			      struct strlist *namelist, bool ret_event,
+			      bool allow_suffix)
 {
 	int i, ret;
 	char *p, *nbase;
@@ -2590,7 +2591,7 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 		*p = '\0';
 
 	/* Try no suffix number */
-	ret = e_snprintf(buf, len, "%s", nbase);
+	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
 	if (ret < 0) {
 		pr_debug("snprintf() failed: %d\n", ret);
 		goto out;
@@ -2689,8 +2690,8 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 		group = PERFPROBE_GROUP;
 
 	/* Get an unused new event name */
-	ret = get_new_event_name(buf, 64, event,
-				 namelist, allow_suffix);
+	ret = get_new_event_name(buf, 64, event, namelist,
+				 tev->point.retprobe, allow_suffix);
 	if (ret < 0)
 		return ret;
 
