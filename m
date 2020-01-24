Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B1C35244
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3024673
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906607;
	bh=233GHUnq0JkAmFswOjKGikkLGsDS+FGoX32dm1QzKwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=aAxASWN7NyDR/IrvtWBUfQqUVaPs8qnTEgaH4G8JXIjzatDwese9/bZur9R3xKYYr
	 ySn730tM/9vWXrp3Ij4viVJqTtUzPv/pvepx/kbkyaM0yfYGLWVBNF8EStRZhOVfJW
	 2u8w/Iv4H46NC7rVhWlz2MrVR8KYOaWe0zxXZriA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgAXW4p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgAXW4o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:44 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4400214AF;
        Fri, 24 Jan 2020 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906602;
        bh=233GHUnq0JkAmFswOjKGikkLGsDS+FGoX32dm1QzKwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WVFXp0iSgm2/j8no53UuQBSfplAx/A+VJz02eMC5mgvZ5Q+jt2VtEmHGJgq44DIfc
         n5bf/ZhyEsUfsRaZA1u8pgfPu+n4XtjHon60PFpbUOMM3mYRjMw3Dy8e6DFeKRBnq4
         PLa7UA069rXuSsR5nJGjYwxa03PI3+VBS/SSGSi8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 08/12] tracing: Add synth event generation test module
Date:   Fri, 24 Jan 2020 16:56:19 -0600
Message-Id: <d5718681c1ad3baf263ff1d6d59491226eef2c0a.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a test module that checks the basic functionality of the in-kernel
synthetic event generation API by generating and tracing synthetic
events from a module.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/Kconfig                |  13 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/synth_event_gen_test.c | 523 ++++++++++++++++++++++++++++++++++++
 3 files changed, 537 insertions(+)
 create mode 100644 kernel/trace/synth_event_gen_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 75326d8ab1af..4f2041166a2f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,19 @@ config PREEMPTIRQ_DELAY_TEST
 
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
index 395e2db9c742..32012f50fb79 100644
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
index 000000000000..4aefe003cb7c
--- /dev/null
+++ b/kernel/trace/synth_event_gen_test.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test module for in-kernel sythetic event creation and generation.
+ *
+ * Copyright (C) 2019 Tom Zanussi <zanussi@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/trace_events.h>
+
+/*
+ * This module is a simple test of basic functionality for in-kernel
+ * synthetic event creation and generation, the first and second tests
+ * using synth_event_gen_cmd_start() and synth_event_add_field(), the
+ * third uses synth_event_create() to do it all at once with a static
+ * field array.
+ *
+ * Following that are a few examples using the created events to test
+ * various ways of tracing a synthetic event.
+ *
+ * To test, select CONFIG_SYNTH_EVENT_GEN_TEST and build the module.
+ * Then:
+ *
+ * # insmod kernel/trace/synth_event_gen_test.ko
+ * # cat /sys/kernel/debug/tracing/trace
+ *
+ * You should see several events in the trace buffer -
+ * "create_synth_test", "empty_synth_test", and several instances of
+ * "gen_synth_test".
+ *
+ * To remove the events, remove the module:
+ *
+ * # rmmod synth_event_gen_test
+ *
+ */
+
+static struct trace_event_file *create_synth_test;
+static struct trace_event_file *empty_synth_test;
+static struct trace_event_file *gen_synth_test;
+
+/*
+ * Test to make sure we can create a synthetic event, then add more
+ * fields.
+ */
+static int __init test_gen_synth_cmd(void)
+{
+	struct dynevent_cmd cmd;
+	u64 vals[7];
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	synth_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Create the empty gen_synth_test synthetic event with the
+	 * first 4 fields.
+	 */
+	ret = synth_event_gen_cmd_start(&cmd, "gen_synth_test", THIS_MODULE,
+					"pid_t", "next_pid_field",
+					"char[16]", "next_comm_field",
+					"u64", "ts_ns",
+					"u64", "ts_ms");
+	if (ret)
+		goto free;
+
+	/* Use synth_event_add_field to add the rest of the fields */
+
+	ret = synth_event_add_field(&cmd, "unsigned int", "cpu");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "char[64]", "my_string_field");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "int", "my_int_field");
+	if (ret)
+		goto free;
+
+	ret = synth_event_gen_cmd_end(&cmd);
+	if (ret)
+		goto free;
+
+	/*
+	 * Now get the gen_synth_test event file.  We need to prevent
+	 * the instance and event from disappearing from underneath
+	 * us, which trace_get_event_file() does (though in this case
+	 * we're using the top-level instance which never goes away).
+	 */
+	gen_synth_test = trace_get_event_file(NULL, "synthetic",
+					      "gen_synth_test");
+	if (IS_ERR(gen_synth_test)) {
+		ret = PTR_ERR(gen_synth_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(gen_synth_test->tr,
+					"synthetic", "gen_synth_test", true);
+	if (ret) {
+		trace_put_event_file(gen_synth_test);
+		goto delete;
+	}
+
+	/* Create some bogus values just for testing */
+
+	vals[0] = 777;			/* next_pid_field */
+	vals[1] = (u64)"hula hoops";	/* next_comm_field */
+	vals[2] = 1000000;		/* ts_ns */
+	vals[3] = 1000;			/* ts_ms */
+	vals[4] = smp_processor_id();	/* cpu */
+	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[6] = 598;			/* my_int_field */
+
+	/* Now generate a gen_synth_test event */
+	ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
+ out:
+	return ret;
+ delete:
+	/* We got an error after creating the event, delete it */
+	synth_event_delete("gen_synth_test");
+ free:
+	kfree(buf);
+
+	goto out;
+}
+
+/*
+ * Test to make sure we can create an initially empty synthetic event,
+ * then add all the fields.
+ */
+static int __init test_empty_synth_event(void)
+{
+	struct dynevent_cmd cmd;
+	u64 vals[7];
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	synth_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Create the empty_synth_test synthetic event with no fields.
+	 */
+	ret = synth_event_gen_cmd_start(&cmd, "empty_synth_test", THIS_MODULE);
+	if (ret)
+		goto free;
+
+	/* Use synth_event_add_field to add all of the fields */
+
+	ret = synth_event_add_field(&cmd, "pid_t", "next_pid_field");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "char[16]", "next_comm_field");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "u64", "ts_ns");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "u64", "ts_ms");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "unsigned int", "cpu");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "char[64]", "my_string_field");
+	if (ret)
+		goto free;
+
+	ret = synth_event_add_field(&cmd, "int", "my_int_field");
+	if (ret)
+		goto free;
+
+	/* All fields have been added, close and register the synth event */
+
+	ret = synth_event_gen_cmd_end(&cmd);
+	if (ret)
+		goto free;
+
+	/*
+	 * Now get the empty_synth_test event file.  We need to
+	 * prevent the instance and event from disappearing from
+	 * underneath us, which trace_get_event_file() does (though in
+	 * this case we're using the top-level instance which never
+	 * goes away).
+	 */
+	empty_synth_test = trace_get_event_file(NULL, "synthetic",
+						"empty_synth_test");
+	if (IS_ERR(empty_synth_test)) {
+		ret = PTR_ERR(empty_synth_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(empty_synth_test->tr,
+					"synthetic", "empty_synth_test", true);
+	if (ret) {
+		trace_put_event_file(empty_synth_test);
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
+	/* Now trace an empty_synth_test event */
+	ret = synth_event_trace_array(empty_synth_test, vals, ARRAY_SIZE(vals));
+ out:
+	return ret;
+ delete:
+	/* We got an error after creating the event, delete it */
+	synth_event_delete("empty_synth_test");
+ free:
+	kfree(buf);
+
+	goto out;
+}
+
+static struct synth_field_desc create_synth_test_fields[] = {
+	{ .type = "pid_t",		.name = "next_pid_field" },
+	{ .type = "char[16]",		.name = "next_comm_field" },
+	{ .type = "u64",		.name = "ts_ns" },
+	{ .type = "u64",		.name = "ts_ms" },
+	{ .type = "unsigned int",	.name = "cpu" },
+	{ .type = "char[64]",		.name = "my_string_field" },
+	{ .type = "int",		.name = "my_int_field" },
+};
+
+/*
+ * Test synthetic event creation all at once from array of field
+ * descriptors.
+ */
+static int __init test_create_synth_event(void)
+{
+	u64 vals[7];
+	int ret;
+
+	/* Create the create_synth_test event with the fields above */
+	ret = synth_event_create("create_synth_test",
+				 create_synth_test_fields,
+				 ARRAY_SIZE(create_synth_test_fields),
+				 THIS_MODULE);
+	if (ret)
+		goto out;
+
+	/*
+	 * Now get the create_synth_test event file.  We need to
+	 * prevent the instance and event from disappearing from
+	 * underneath us, which trace_get_event_file() does (though in
+	 * this case we're using the top-level instance which never
+	 * goes away).
+	 */
+	create_synth_test = trace_get_event_file(NULL, "synthetic",
+						 "create_synth_test");
+	if (IS_ERR(create_synth_test)) {
+		ret = PTR_ERR(create_synth_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(create_synth_test->tr,
+					"synthetic", "create_synth_test", true);
+	if (ret) {
+		trace_put_event_file(create_synth_test);
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
+	/* Now generate a create_synth_test event */
+	ret = synth_event_trace_array(create_synth_test, vals, ARRAY_SIZE(vals));
+ out:
+	return ret;
+ delete:
+	/* We got an error after creating the event, delete it */
+	ret = synth_event_delete("create_synth_test");
+
+	goto out;
+}
+
+/*
+ * Test tracing a synthetic event by reserving trace buffer space,
+ * then filling in fields one after another.
+ */
+static int __init test_add_next_synth_val(void)
+{
+	struct synth_event_trace_state trace_state;
+	int ret;
+
+	/* Start by reserving space in the trace buffer */
+	ret = synth_event_trace_start(gen_synth_test, &trace_state);
+	if (ret)
+		return ret;
+
+	/* Write some bogus values into the trace buffer, one after another */
+
+	/* next_pid_field */
+	ret = synth_event_add_next_val(777, &trace_state);
+	if (ret)
+		goto out;
+
+	/* next_comm_field */
+	ret = synth_event_add_next_val((u64)"slinky", &trace_state);
+	if (ret)
+		goto out;
+
+	/* ts_ns */
+	ret = synth_event_add_next_val(1000000, &trace_state);
+	if (ret)
+		goto out;
+
+	/* ts_ms */
+	ret = synth_event_add_next_val(1000, &trace_state);
+	if (ret)
+		goto out;
+
+	/* cpu */
+	ret = synth_event_add_next_val(smp_processor_id(), &trace_state);
+	if (ret)
+		goto out;
+
+	/* my_string_field */
+	ret = synth_event_add_next_val((u64)"thneed_2.01", &trace_state);
+	if (ret)
+		goto out;
+
+	/* my_int_field */
+	ret = synth_event_add_next_val(395, &trace_state);
+ out:
+	/* Finally, commit the event */
+	ret = synth_event_trace_end(&trace_state);
+
+	return ret;
+}
+
+/*
+ * Test tracing a synthetic event by reserving trace buffer space,
+ * then filling in fields using field names, which can be done in any
+ * order.
+ */
+static int __init test_add_synth_val(void)
+{
+	struct synth_event_trace_state trace_state;
+	int ret;
+
+	/* Start by reserving space in the trace buffer */
+	ret = synth_event_trace_start(gen_synth_test, &trace_state);
+	if (ret)
+		return ret;
+
+	/* Write some bogus values into the trace buffer, using field names */
+
+	ret = synth_event_add_val("ts_ns", 1000000, &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("ts_ms", 1000, &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("cpu", smp_processor_id(), &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("next_pid_field", 777, &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("next_comm_field", (u64)"silly putty",
+				  &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("my_string_field", (u64)"thneed_9",
+				  &trace_state);
+	if (ret)
+		goto out;
+
+	ret = synth_event_add_val("my_int_field", 3999, &trace_state);
+ out:
+	/* Finally, commit the event */
+	ret = synth_event_trace_end(&trace_state);
+
+	return ret;
+}
+
+/*
+ * Test tracing a synthetic event all at once from array of values.
+ */
+static int __init test_trace_synth_event(void)
+{
+	int ret;
+
+	/* Trace some bogus values just for testing */
+	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
+				444,			/* next_pid_field */
+				(u64)"clackers",	/* next_comm_field */
+				1000000,		/* ts_ns */
+				1000,			/* ts_ms */
+				smp_processor_id(),	/* cpu */
+				(u64)"Thneed",		/* my_string_field */
+				999);			/* my_int_field */
+	return ret;
+}
+
+static int __init synth_event_gen_test_init(void)
+{
+	int ret;
+
+	ret = test_gen_synth_cmd();
+	if (ret)
+		return ret;
+
+	ret = test_empty_synth_event();
+	if (ret) {
+		WARN_ON(trace_array_set_clr_event(gen_synth_test->tr,
+						  "synthetic",
+						  "gen_synth_test", false));
+		trace_put_event_file(gen_synth_test);
+		WARN_ON(synth_event_delete("gen_synth_test"));
+		goto out;
+	}
+
+	ret = test_create_synth_event();
+	if (ret) {
+		WARN_ON(trace_array_set_clr_event(gen_synth_test->tr,
+						  "synthetic",
+						  "gen_synth_test", false));
+		trace_put_event_file(gen_synth_test);
+		WARN_ON(synth_event_delete("gen_synth_test"));
+
+		WARN_ON(trace_array_set_clr_event(empty_synth_test->tr,
+						  "synthetic",
+						  "empty_synth_test", false));
+		trace_put_event_file(empty_synth_test);
+		WARN_ON(synth_event_delete("empty_synth_test"));
+		goto out;
+	}
+
+	ret = test_add_next_synth_val();
+	WARN_ON(ret);
+
+	ret = test_add_synth_val();
+	WARN_ON(ret);
+
+	ret = test_trace_synth_event();
+	WARN_ON(ret);
+ out:
+	return ret;
+}
+
+static void __exit synth_event_gen_test_exit(void)
+{
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(gen_synth_test->tr,
+					  "synthetic",
+					  "gen_synth_test", false));
+
+	/* Now give the file and instance back */
+	trace_put_event_file(gen_synth_test);
+
+	/* Now unregister and free the synthetic event */
+	WARN_ON(synth_event_delete("gen_synth_test"));
+
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(empty_synth_test->tr,
+					  "synthetic",
+					  "empty_synth_test", false));
+
+	/* Now give the file and instance back */
+	trace_put_event_file(empty_synth_test);
+
+	/* Now unregister and free the synthetic event */
+	WARN_ON(synth_event_delete("empty_synth_test"));
+
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(create_synth_test->tr,
+					  "synthetic",
+					  "create_synth_test", false));
+
+	/* Now give the file and instance back */
+	trace_put_event_file(create_synth_test);
+
+	/* Now unregister and free the synthetic event */
+	WARN_ON(synth_event_delete("create_synth_test"));
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

