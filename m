Return-Path: <SRS0=Nlir=4F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38413C7619F
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CB220726
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581933162;
	bh=hMLoC6QzHCRXCxJEwykZ7vmvCfjXRqdLtr4hB3K11bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bHvHJfvVXZfldI398PWlkLNnU5jgq8tIaodhYs6wDNtH1x0OO2J3nkOs2xKVRk0i1
	 Ja1PaJ8e4Ru7+DxazGg4k2N6twMhMUIHaA00fzI9WgbhSx/9+k8SGmp33oApj+Txvk
	 4sZwJXeRHIcnD3z2+s/NJy1yFbVt4uFYlfAUFUJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBQJwe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQJwe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Feb 2020 04:52:34 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194B920725;
        Mon, 17 Feb 2020 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581933153;
        bh=hMLoC6QzHCRXCxJEwykZ7vmvCfjXRqdLtr4hB3K11bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEk7gTBh1BtbCJTuEsYUaKDXn5dlLYcxm9hIhMuwRg79M6WTF2jxEauSMzhHIVqD4
         nNP7IXQ0AVd29Ed8+rZJ2JZiCZAnOeVqWywYI6yOFcWhy2hYtwGqwQS2r+fdkZ4pxY
         VBFD2ADiW56IA+FDE3t3CGKxONBIShKglP3q+CVE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] tracing: Fix synth event test to avoid using smp_processor_id()
Date:   Mon, 17 Feb 2020 18:52:29 +0900
Message-Id: <158193314931.8868.11386672578933699881.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158193313870.8868.10793333111731425487.stgit@devnote2>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Since smp_processor_id() requires irq-disabled or preempt-disabled,
synth event generation test module made some warnings. To prevent
that, use get_cpu()/put_cpu() instead of smp_processor_id().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 4aefe003cb7c..b7775fd6baf5 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -114,12 +114,13 @@ static int __init test_gen_synth_cmd(void)
 	vals[1] = (u64)"hula hoops";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = get_cpu();	/* cpu */
 	vals[5] = (u64)"thneed";	/* my_string_field */
 	vals[6] = 598;			/* my_int_field */
 
 	/* Now generate a gen_synth_test event */
 	ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
+	put_cpu();
  out:
 	return ret;
  delete:
@@ -221,12 +222,13 @@ static int __init test_empty_synth_event(void)
 	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = get_cpu();		/* cpu */
 	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
 	vals[6] = 399;			/* my_int_field */
 
 	/* Now trace an empty_synth_test event */
 	ret = synth_event_trace_array(empty_synth_test, vals, ARRAY_SIZE(vals));
+	put_cpu();
  out:
 	return ret;
  delete:
@@ -293,12 +295,13 @@ static int __init test_create_synth_event(void)
 	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
-	vals[4] = smp_processor_id();	/* cpu */
+	vals[4] = get_cpu();		/* cpu */
 	vals[5] = (u64)"thneed";	/* my_string_field */
 	vals[6] = 398;			/* my_int_field */
 
 	/* Now generate a create_synth_test event */
 	ret = synth_event_trace_array(create_synth_test, vals, ARRAY_SIZE(vals));
+	put_cpu();
  out:
 	return ret;
  delete:
@@ -315,6 +318,7 @@ static int __init test_create_synth_event(void)
 static int __init test_add_next_synth_val(void)
 {
 	struct synth_event_trace_state trace_state;
+	unsigned int cpu;
 	int ret;
 
 	/* Start by reserving space in the trace buffer */
@@ -322,6 +326,8 @@ static int __init test_add_next_synth_val(void)
 	if (ret)
 		return ret;
 
+	cpu = get_cpu();
+
 	/* Write some bogus values into the trace buffer, one after another */
 
 	/* next_pid_field */
@@ -345,7 +351,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* cpu */
-	ret = synth_event_add_next_val(smp_processor_id(), &trace_state);
+	ret = synth_event_add_next_val(cpu, &trace_state);
 	if (ret)
 		goto out;
 
@@ -357,6 +363,7 @@ static int __init test_add_next_synth_val(void)
 	/* my_int_field */
 	ret = synth_event_add_next_val(395, &trace_state);
  out:
+	put_cpu();
 	/* Finally, commit the event */
 	ret = synth_event_trace_end(&trace_state);
 
@@ -371,6 +378,7 @@ static int __init test_add_next_synth_val(void)
 static int __init test_add_synth_val(void)
 {
 	struct synth_event_trace_state trace_state;
+	unsigned int cpu;
 	int ret;
 
 	/* Start by reserving space in the trace buffer */
@@ -378,6 +386,7 @@ static int __init test_add_synth_val(void)
 	if (ret)
 		return ret;
 
+	cpu = get_cpu();
 	/* Write some bogus values into the trace buffer, using field names */
 
 	ret = synth_event_add_val("ts_ns", 1000000, &trace_state);
@@ -388,7 +397,7 @@ static int __init test_add_synth_val(void)
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("cpu", smp_processor_id(), &trace_state);
+	ret = synth_event_add_val("cpu", cpu, &trace_state);
 	if (ret)
 		goto out;
 
@@ -408,6 +417,7 @@ static int __init test_add_synth_val(void)
 
 	ret = synth_event_add_val("my_int_field", 3999, &trace_state);
  out:
+	put_cpu();
 	/* Finally, commit the event */
 	ret = synth_event_trace_end(&trace_state);
 
@@ -427,9 +437,10 @@ static int __init test_trace_synth_event(void)
 				(u64)"clackers",	/* next_comm_field */
 				1000000,		/* ts_ns */
 				1000,			/* ts_ms */
-				smp_processor_id(),	/* cpu */
+				get_cpu(),		/* cpu */
 				(u64)"Thneed",		/* my_string_field */
 				999);			/* my_int_field */
+	put_cpu();
 	return ret;
 }
 

