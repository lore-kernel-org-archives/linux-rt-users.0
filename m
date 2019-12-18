Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1087C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D2C2467E
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576682884;
	bh=CDSNPdcnj1yrbqrYFentaJgRdtEWkjMEMrqDj3pv+AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=JXEbigi4rc5F1iBvpLevBur65LtmLnNDPcpjES0GjWzZr3kbwFvbjTnTjMLaSCziM
	 jBEhOkRL/pSmz3y4hGMiBejHs70+5Ie/siOEONw5XG/0v7Kgi44+dYtWo7R+iwh1+5
	 A3JWePyhS4J40MMETYfVI6DrAIr+KEA2gu39dwHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfLRP2B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfLRP17 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:59 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC0D24676;
        Wed, 18 Dec 2019 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576682878;
        bh=CDSNPdcnj1yrbqrYFentaJgRdtEWkjMEMrqDj3pv+AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=rNcGJ44YOII4KPp+ApkGNNrY0IOfQ/A6JcYVnwOGysejZaImz/oqQtE64FXsX7KnH
         qzRtXlP0ZZ0Qqgrun3wyoPUqyNzTc/hZgl9FDLf+3KjjgoBO8uN8w3elGyMBr9oiV9
         tUd5vzvr2jpiHQWdqZVdA/xmDyPxZhNEPmZ3wLeM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 6/7] tracing: Add synth event generation test module
Date:   Wed, 18 Dec 2019 09:27:42 -0600
Message-Id: <474bd36bbec97f0b42a3f40f985f5275502290c9.1576679206.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
In-Reply-To: <cover.1576679206.git.zanussi@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a test module that checks the basic functionality of the in-kernel
synthetic event generation API by creating and generating synthetic
events from a module.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/Kconfig                |  13 ++
 kernel/trace/Makefile               |   1 +
 kernel/trace/synth_event_gen_test.c | 330 ++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 kernel/trace/synth_event_gen_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 29a9c5058b62..0597d60158b4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -775,6 +775,19 @@ config PREEMPTIRQ_DELAY_TEST
 
 	  If unsure, say N
 
+config SYNTH_EVENT_GEN_TEST
+	tristate "Test module for in-kernel synthetic event generation"
+	depends on HIST_TRIGGERS
+	help
+          This option creates a test module to check the base
+          functionality of in-kernel synthetic event definition and
+          generation.
+
+          To test, insert the module, and then check the trace buffer
+	  for the generated sample events.
+
+	  If unsure, say N.
+
 config TRACE_EVAL_MAP_FILE
        bool "Show eval mappings for trace events"
        depends on TRACING
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 0e63db62225f..99de699c6062 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
+obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
new file mode 100644
index 000000000000..f6a008cad489
--- /dev/null
+++ b/kernel/trace/synth_event_gen_test.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test module for in-kernel sythetic event creation and generation.
+ *
+ * Copyright (C) 2019 Tom Zanussi <zanussi@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/trace_events.h>
+#include "trace.h"
+
+/*
+ * This module is a simple test of basic functionality for in-kernel
+ * synthetic event creation and generation, the first test using
+ * create_synth_event() with a static field array and a version that
+ * builds the same thing dynamically using create_empty_synth_event(),
+ * add_synth_field(s), and finalize_synth_event().
+ *
+ * To test, select CONFIG_SYNTH_EVENT_GEN_TEST and build the module.
+ * Then:
+ *
+ * # insmod kernel/trace/synth_event_gen_test.ko
+ * # cat /sys/kernel/debug/tracing/trace
+ *
+ * You should see two events in the trace buffer - "synthtest" and
+ * "dyn_synthtest".
+ *
+ * To remove the events, remove the module:
+ *
+ * # rmmod synth_event_gen_test
+ *
+ */
+
+static struct synth_field_desc synthtest_fields[] = {
+	{ .type = "pid_t",		.name = "next_pid_field" },
+	{ .type = "char[16]",		.name = "next_comm_field" },
+	{ .type = "u64",		.name = "ts_ns" },
+	{ .type = "u64",		.name = "ts_ms" },
+	{ .type = "unsigned int",	.name = "cpu" },
+	{ .type = "char[64]",		.name = "my_string_field" },
+	{ .type = "int",		.name = "my_int_field" },
+};
+
+static struct trace_event_file *synthtest_event_file;
+static struct trace_event_file *dyn_synthtest_event_file;
+
+static int __init test_synth_event(void)
+{
+	u64 vals[7];
+	int ret;
+
+	/* Create the synthtest synthetic event with the fields above */
+	ret = create_synth_event("synthtest", synthtest_fields,
+				 ARRAY_SIZE(synthtest_fields), THIS_MODULE);
+	if (ret)
+		goto out;
+
+	/*
+	 * Now get the synthtest event file.  We need to prevent the
+	 * instance and event from disappearing from underneath us,
+	 * which get_event_file() does (though in this case we're
+	 * using the top-level instance which never goes away).
+	 */
+	synthtest_event_file = get_event_file(NULL, "synthetic", "synthtest");
+	if (IS_ERR(synthtest_event_file)) {
+		ret = PTR_ERR(synthtest_event_file);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(synthtest_event_file->tr,
+					"synthetic", "synthtest", true);
+	if (ret) {
+		put_event_file(synthtest_event_file);
+		goto delete;
+	}
+
+	/* Create some bogus values just for testing */
+
+	vals[0] = 777;			/* next_pid_field */
+	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[2] = 1000000;		/* ts_ns */
+	vals[3] = 1000;			/* ts_ms */
+	vals[4] = smp_processor_id();	/* cpu */
+	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[6] = 398;			/* my_int_field */
+
+	/* Now generate the event */
+	ret = generate_synth_event(synthtest_event_file, vals,
+				   ARRAY_SIZE(vals));
+ out:
+	return ret;
+ delete:
+	ret = delete_synth_event("synthtest");
+
+	goto out;
+}
+
+static int __init test_dynamic_synth_event(void)
+{
+	struct synth_event *se = NULL;
+	u64 vals[7];
+	int ret;
+
+	/* Create the empty synthtest synthetic event */
+	se = create_empty_synth_event("dyn_synthtest", THIS_MODULE);
+	if (IS_ERR(se)) {
+		ret = PTR_ERR(se);
+		goto free;
+	}
+
+	/* Use add_synth_fields to add the first 4 synthtest fields */
+	ret = add_synth_fields(se, synthtest_fields, 4);
+	if (ret)
+		goto out;
+
+	/* Use add_synth_field to add the rest of the fields */
+
+	ret = add_synth_field(se, "unsigned int", "cpu");
+	if (ret)
+		goto free;
+
+	ret = add_synth_field(se, "char[64]", "my_string_field");
+	if (ret)
+		goto free;
+
+	ret = add_synth_field(se, "int", "my_int_field");
+	if (ret)
+		goto free;
+
+	/* All fields have been added, close and register the synth event */
+	ret = finalize_synth_event(se);
+	if (ret)
+		goto free;
+
+	/*
+	 * Now get the dyn_synthtest event file.  We need to prevent
+	 * the instance and event from disappearing from underneath
+	 * us, which get_event_file() does (though in this case we're
+	 * using the top-level instance which never goes away).
+	 */
+	dyn_synthtest_event_file = get_event_file(NULL, "synthetic",
+						  "dyn_synthtest");
+	if (IS_ERR(dyn_synthtest_event_file)) {
+		ret = PTR_ERR(dyn_synthtest_event_file);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(dyn_synthtest_event_file->tr,
+					"synthetic", "dyn_synthtest", true);
+	if (ret) {
+		put_event_file(dyn_synthtest_event_file);
+		goto delete;
+	}
+
+	/* Create some bogus values just for testing */
+
+	vals[0] = 777;			/* next_pid_field */
+	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[2] = 1000000;		/* ts_ns */
+	vals[3] = 1000;			/* ts_ms */
+	vals[4] = smp_processor_id();	/* cpu */
+	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
+	vals[6] = 399;			/* my_int_field */
+
+	/* Now generate the event */
+	ret = generate_synth_event(dyn_synthtest_event_file, vals,
+				   ARRAY_SIZE(vals));
+ out:
+	return ret;
+ free: /* If not finalized, just free */
+	free_synth_event(se);
+	goto out;
+ delete: /* Event was finalized, delete */
+	delete_synth_event("dyn_synthtest");
+	goto out;
+}
+
+static int __init test_add_next_synth_val(void)
+{
+	struct synth_gen_state gen_state;
+	int ret;
+
+	ret = generate_synth_event_start(synthtest_event_file, &gen_state);
+	if (ret)
+		return ret;
+
+	/* Add some bogus values just for testing */
+
+	/* next_pid_field */
+	ret = add_next_synth_val(777, &gen_state);
+	if (ret)
+		goto out;
+
+	/* next_comm_field */
+	ret = add_next_synth_val((u64)"slinky", &gen_state);
+	if (ret)
+		goto out;
+
+	/* ts_ns */
+	ret = add_next_synth_val(1000000, &gen_state);
+	if (ret)
+		goto out;
+
+	/* ts_ms */
+	ret = add_next_synth_val(1000, &gen_state);
+	if (ret)
+		goto out;
+
+	/* cpu */
+	ret = add_next_synth_val(smp_processor_id(), &gen_state);
+	if (ret)
+		goto out;
+
+	/* my_string_field */
+	ret = add_next_synth_val((u64)"thneed_2.01", &gen_state);
+	if (ret)
+		goto out;
+
+	/* my_int_field */
+	ret = add_next_synth_val(395, &gen_state);
+ out:
+	/* Now generate or at least finalize the event */
+	ret = generate_synth_event_end(&gen_state);
+
+	return ret;
+}
+
+static int __init test_add_synth_val(void)
+{
+	struct synth_gen_state gen_state;
+	int ret;
+
+	ret = generate_synth_event_start(synthtest_event_file, &gen_state);
+	if (ret)
+		return ret;
+
+	/* Add some bogus values just for testing */
+
+	ret = add_synth_val("next_pid_field", 777, &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("next_comm_field", (u64)"silly putty", &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("ts_ns", 1000000, &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("ts_ms", 1000, &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("cpu", smp_processor_id(), &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("my_string_field", (u64)"thneed_9", &gen_state);
+	if (ret)
+		goto out;
+
+	ret = add_synth_val("my_int_field", 3999, &gen_state);
+ out:
+	/* Now generate or at least finalize the event */
+	ret = generate_synth_event_end(&gen_state);
+
+	return ret;
+}
+
+static int __init synth_event_gen_test_init(void)
+{
+	int ret;
+
+	ret = test_synth_event();
+	if (ret)
+		return ret;
+
+	ret = test_dynamic_synth_event();
+	if (ret) {
+		WARN_ON(trace_array_set_clr_event(synthtest_event_file->tr,
+						  "synthetic",
+						  "synthtest", false));
+		put_event_file(synthtest_event_file);
+		WARN_ON(delete_synth_event("synthtest"));
+		goto out;
+	}
+
+	ret = test_add_next_synth_val();
+	WARN_ON(ret);
+
+	ret = test_add_synth_val();
+	WARN_ON(ret);
+ out:
+	return ret;
+}
+
+static void __exit synth_event_gen_test_exit(void)
+{
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(dyn_synthtest_event_file->tr,
+					  "synthetic",
+					  "dyn_synthtest", false));
+
+	/* Now give the file and instance back */
+	put_event_file(dyn_synthtest_event_file);
+
+	/* Now unregister and free the synthetic event */
+	WARN_ON(delete_synth_event("dyn_synthtest"));
+
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(synthtest_event_file->tr,
+					  "synthetic",
+					  "synthtest", false));
+
+	/* Now give the file and instance back */
+	put_event_file(synthtest_event_file);
+
+	/* Now unregister and free the synthetic event */
+	WARN_ON(delete_synth_event("synthtest"));
+}
+
+module_init(synth_event_gen_test_init)
+module_exit(synth_event_gen_test_exit)
+
+MODULE_AUTHOR("Tom Zanussi");
+MODULE_DESCRIPTION("synthetic event generation test");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1

