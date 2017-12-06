From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/5] perf-probe: Add __return suffix for return events
Date: Wed,  6 Dec 2017 12:07:47 +0900
Message-ID: <151252966696.12861.2029938184115662263.stgit@devbox>
References: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754350AbdLFDIK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 22:08:10 -0500
In-Reply-To: <151252958056.12861.954203514347167563.stgit@devbox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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
 tools/perf/util/probe-event.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

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
 

