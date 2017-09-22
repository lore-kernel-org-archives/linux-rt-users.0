From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v3 07/33] tracing: Break out hist trigger assignment parsing
Date: Fri, 22 Sep 2017 14:59:47 -0500
Message-ID: <5be3ded7669bcaa9c2d0fb98ece9b99e90c58713.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1506105131.git.tom.zanussi@linux.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This will make it easier to add variables, and makes the parsing code
cleaner regardless.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
---
 kernel/trace/trace_events_hist.c | 72 ++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9126be5..4935290 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -251,6 +251,51 @@ static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 	kfree(attrs);
 }
 
+static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = 0;
+
+	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
+	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+		attrs->keys_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->keys_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
+		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
+		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+		attrs->vals_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->vals_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
+		if (!attrs->sort_key_str) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+		attrs->name = kstrdup(str, GFP_KERNEL);
+		if (!attrs->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+		int map_bits = parse_map_size(str);
+
+		if (map_bits < 0) {
+			ret = map_bits;
+			goto out;
+		}
+		attrs->map_bits = map_bits;
+	} else
+		ret = -EINVAL;
+ out:
+	return ret;
+}
+
 static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 {
 	struct hist_trigger_attrs *attrs;
@@ -263,33 +308,18 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 	while (trigger_str) {
 		char *str = strsep(&trigger_str, ":");
 
-		if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-		    (strncmp(str, "keys=", strlen("keys=")) == 0))
-			attrs->keys_str = kstrdup(str, GFP_KERNEL);
-		else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-			 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-			 (strncmp(str, "values=", strlen("values=")) == 0))
-			attrs->vals_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "sort=", strlen("sort=")) == 0)
-			attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "name=", strlen("name=")) == 0)
-			attrs->name = kstrdup(str, GFP_KERNEL);
-		else if (strcmp(str, "pause") == 0)
+		if (strchr(str, '=')) {
+			ret = parse_assignment(str, attrs);
+			if (ret)
+				goto free;
+		} else if (strcmp(str, "pause") == 0)
 			attrs->pause = true;
 		else if ((strcmp(str, "cont") == 0) ||
 			 (strcmp(str, "continue") == 0))
 			attrs->cont = true;
 		else if (strcmp(str, "clear") == 0)
 			attrs->clear = true;
-		else if (strncmp(str, "size=", strlen("size=")) == 0) {
-			int map_bits = parse_map_size(str);
-
-			if (map_bits < 0) {
-				ret = map_bits;
-				goto free;
-			}
-			attrs->map_bits = map_bits;
-		} else {
+		else {
 			ret = -EINVAL;
 			goto free;
 		}
-- 
1.9.3
