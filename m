From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/34] perf probe: Add __return suffix for return events
Date: Thu, 14 Dec 2017 14:42:36 -0300
Message-ID: <20171214174247.16841-24-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add __return suffix for function return events automatically. Without
this, user have to give --force option and will see the number suffix
for each event like "function_1", which is not easy to recognize.
Instead, this adds __return suffix to it automatically.  E.g.

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

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275046418.24652.6696011972866498489.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-probe.txt | 2 +-
 tools/perf/util/probe-event.c           | 9 +++++----
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
index 7e582547ac07..a68141d360b0 100644
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
 
-- 
2.13.6
