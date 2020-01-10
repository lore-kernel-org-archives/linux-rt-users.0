Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0E0C33CA4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815B2205F4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688554;
	bh=Bix0dUf7a7fsuKuY6E6H+bdNW+apm7NX4GXgPTHh/wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ceDQhskP8boDniU3CZgDtePizG/GnhUcYdbP4wmCihZ/pL31TgLJU0PSIj2uE1S4L
	 Y7KQsr++kqJvDd2vReXUuZ+w0bmlF71O08gbZ8MSehXyZ0k36inYszf9UKImsGNpWU
	 lHtJE7HaNJYht6IVrSmr3OdsNayiQqBqMfSqk6ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgAJUfx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbgAJUfl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:35:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9582187F;
        Fri, 10 Jan 2020 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578688540;
        bh=Bix0dUf7a7fsuKuY6E6H+bdNW+apm7NX4GXgPTHh/wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=y/FzATzJtiwpDxYfyM3djDisjdh2HrznDtj9QQfBVqi+C9mN6ax/0PjVHxrD6YNmJ
         QFdQUpz44/2iQ7QFMX8KYKOKAGqAmc0zQJyLLltPAQH552iJaYvuvfUA++47LAxKxe
         jY/tN8CvcWV32KNVPgBvi+dA2+mGl6qA0IzqMzjU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 11/12] tracing: Add kprobe event command generation test module
Date:   Fri, 10 Jan 2020 14:35:17 -0600
Message-Id: <de2d73f0fa4d4f2de23c4da08c1fa4dcf70fd6d9.1578688120.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
In-Reply-To: <cover.1578688120.git.zanussi@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a test module that checks the basic functionality of the in-kernel
kprobe event command generation API by creating kprobe events from a
module.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/Kconfig                 |  12 ++
 kernel/trace/Makefile                |   1 +
 kernel/trace/kprobe_event_gen_test.c | 223 +++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 kernel/trace/kprobe_event_gen_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0597d60158b4..3e1b34ada52a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -788,6 +788,18 @@ config SYNTH_EVENT_GEN_TEST
 
 	  If unsure, say N.
 
+config KPROBE_EVENT_GEN_TEST
+	tristate "Test module for in-kernel kprobe event generation"
+	depends on KPROBE_EVENTS
+	help
+          This option creates a test module to check the base
+          functionality of in-kernel kprobe event definition.
+
+          To test, insert the module, and then check the trace buffer
+	  for the generated kprobe events.
+
+	  If unsure, say N.
+
 config TRACE_EVAL_MAP_FILE
        bool "Show eval mappings for trace events"
        depends on TRACING
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 99de699c6062..0da59827babd 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
+obj-$(CONFIG_KPROBE_EVENT_GEN_TEST) += kprobe_event_gen_test.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
new file mode 100644
index 000000000000..06d99c62b29b
--- /dev/null
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test module for in-kernel kprobe event creation and generation.
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
+ * kprobe/kretprobe event creation.  The first test uses
+ * gen_kprobe_event(), add_probe_fields() and create_dynevent() to
+ * create a kprobe event, which is then enabled in order to generate
+ * trace output.  The second creates a kretprobe event using
+ * gen_kretprobe_event() and create_dynevent, and is also then
+ * enabled.
+ *
+ * To test, select CONFIG_KPROBE_EVENT_GEN_TEST and build the module.
+ * Then:
+ *
+ * # insmod kernel/trace/kprobe_event_gen_test.ko
+ * # cat /sys/kernel/debug/tracing/trace
+ *
+ * You should see many instances of the "gen_kprobe_test" and
+ * "gen_kretprobe_test" events in the trace buffer.
+ *
+ * To remove the events, remove the module:
+ *
+ * # rmmod kprobe_event_gen_test
+ *
+ */
+
+static struct trace_event_file *gen_kprobe_test;
+static struct trace_event_file *gen_kretprobe_test;
+
+/*
+ * Test to make sure we can create a kprobe event, then add more
+ * fields.
+ */
+static int __init test_gen_kprobe_cmd(void)
+{
+	struct dynevent_cmd cmd;
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	kprobe_dynevent_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Define the gen_kprobe_test event with the first 2 kprobe
+	 * fields.
+	 */
+	ret = gen_kprobe_cmd(&cmd, "gen_kprobe_test", "do_sys_open",
+			     "dfd=%ax", "filename=%dx");
+	if (ret)
+		goto free;
+
+	/* Use add_probe_fields to add the rest of the fields */
+
+	ret = add_probe_fields(&cmd, "flags=%cx", "mode=+4($stack)");
+	if (ret)
+		goto free;
+
+	/*
+	 * This actually creates the event.
+	 */
+	ret = create_dynevent(&cmd);
+	if (ret)
+		goto free;
+
+	/*
+	 * Now get the gen_kprobe_test event file.  We need to prevent
+	 * the instance and event from disappearing from underneath
+	 * us, which get_event_file() does (though in this case we're
+	 * using the top-level instance which never goes away).
+	 */
+	gen_kprobe_test = get_event_file(NULL, "kprobes",
+					 "gen_kprobe_test");
+	if (IS_ERR(gen_kprobe_test)) {
+		ret = PTR_ERR(gen_kprobe_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(gen_kprobe_test->tr,
+					"kprobes", "gen_kprobe_test", true);
+	if (ret) {
+		put_event_file(gen_kprobe_test);
+		goto delete;
+	}
+ out:
+	return ret;
+ delete:
+	/* We got an error after creating the event, delete it */
+	ret = delete_kprobe_event("gen_kprobe_test");
+ free:
+	kfree(buf);
+
+	goto out;
+}
+
+/*
+ * Test to make sure we can create a kretprobe event.
+ */
+static int __init test_gen_kretprobe_cmd(void)
+{
+	struct dynevent_cmd cmd;
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	kprobe_dynevent_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Define the kretprobe event.
+	 */
+	ret = gen_kretprobe_cmd(&cmd, "gen_kretprobe_test", "do_sys_open",
+				"$retval");
+	if (ret)
+		goto free;
+
+	/*
+	 * This actually creates the event.
+	 */
+	ret = create_dynevent(&cmd);
+	if (ret)
+		goto free;
+
+	/*
+	 * Now get the gen_kretprobe_test event file.  We need to prevent
+	 * the instance and event from disappearing from underneath
+	 * us, which get_event_file() does (though in this case we're
+	 * using the top-level instance which never goes away).
+	 */
+	gen_kretprobe_test = get_event_file(NULL, "kprobes",
+					    "gen_kretprobe_test");
+	if (IS_ERR(gen_kretprobe_test)) {
+		ret = PTR_ERR(gen_kretprobe_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(gen_kretprobe_test->tr,
+					"kprobes", "gen_kretprobe_test", true);
+	if (ret) {
+		put_event_file(gen_kretprobe_test);
+		goto delete;
+	}
+ out:
+	return ret;
+ delete:
+	/* We got an error after creating the event, delete it */
+	ret = delete_kprobe_event("gen_kretprobe_test");
+ free:
+	kfree(buf);
+
+	goto out;
+}
+
+static int __init kprobe_event_gen_test_init(void)
+{
+	int ret;
+
+	ret = test_gen_kprobe_cmd();
+	if (ret)
+		return ret;
+
+	ret = test_gen_kretprobe_cmd();
+	if (ret) {
+		WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+						  "kprobes",
+						  "gen_kretprobe_test", false));
+		put_event_file(gen_kretprobe_test);
+		WARN_ON(delete_kprobe_event("gen_kretprobe_test"));
+	}
+
+	return ret;
+}
+
+static void __exit kprobe_event_gen_test_exit(void)
+{
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+					  "kprobes",
+					  "gen_kprobe_test", false));
+
+	/* Now give the file and instance back */
+	put_event_file(gen_kprobe_test);
+
+	/* Now unregister and free the event */
+	WARN_ON(delete_kprobe_event("gen_kprobe_test"));
+
+	/* Disable the event or you can't remove it */
+	WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+					  "kprobes",
+					  "gen_kretprobe_test", false));
+
+	/* Now give the file and instance back */
+	put_event_file(gen_kretprobe_test);
+
+	/* Now unregister and free the event */
+	WARN_ON(delete_kprobe_event("gen_kretprobe_test"));
+}
+
+module_init(kprobe_event_gen_test_init)
+module_exit(kprobe_event_gen_test_exit)
+
+MODULE_AUTHOR("Tom Zanussi");
+MODULE_DESCRIPTION("kprobe event generation test");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1

