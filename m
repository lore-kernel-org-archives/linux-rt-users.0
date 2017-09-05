From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 01/40] tracing: Exclude 'generic fields' from histograms
Date: Tue,  5 Sep 2017 16:57:13 -0500
Message-ID: <be41f465f512bbbaf30743c3287d73ffc9d82408.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:61833 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753474AbdIEV6D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 17:58:03 -0400
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1504642143.git.tom.zanussi@linux.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

There are a small number of 'generic fields' (comm/COMM/cpu/CPU) that
are found by trace_find_event_field() but are only meant for
filtering.  Specifically, they unlike normal fields, they have a size
of 0 and thus wreak havoc when used as a histogram key.

Exclude these (return -EINVAL) when used as histogram keys.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1c21d0e..7eb975a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -450,7 +450,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	}
 
 	field = trace_find_event_field(file->event_call, field_name);
-	if (!field) {
+	if (!field || !field->size) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -548,7 +548,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		field = trace_find_event_field(file->event_call, field_name);
-		if (!field) {
+		if (!field || !field->size) {
 			ret = -EINVAL;
 			goto out;
 		}
-- 
1.9.3

